/*
phospitalp
procedimento que, pasandolle o nome dun hospital, imprima os nomes dos asegurados de 1ª categoria que foron hospitalizados nel .
 Se non ten asegurados de primeira categoria hospitalizados debe imprimirse a mensaxe 'este hospital non ten asegurados de 1º categoria hospitalizados'  
 Se o hospital non existe debe imprimirse a mensaxe adecuada (mediante tratamento de excepcions) .

call phospitalp ('povisa');
andrea
dorotea

call phospitalp ('sonic');
este hospital non ten asegurados de 1º categoria hospitalizados


execute phospital ('roma');
este hospital non existe

CONSULTA:
select * from asegurado where codp in (select codp from a1c where codp in (select codp from hosp1 where codh in (select codh from hospital where nomh='povisa')));

povisa:
dorotea
elisa?
andrea

*/


CREATE or replace procedure phospitalp(nome varchar)
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
r varchar;
fila record;
filay record;
filaz record;
filacode record;
filanome record;
code1c varchar;
x integer;

BEGIN
r = '';
x = 0;
SELECT codh INTO STRICT filacode FROM hospital WHERE nomh=nome;
FOR fila IN SELECT * FROM hosp1 WHERE codh=filacode.codh LOOP
	FOR filay IN SELECT codp FROM a1c WHERE codp=fila.codp LOOP
		SELECT nomas INTO filanome FROM asegurado WHERE codp=filay.codp; 
			IF filanome IS NULL THEN
				r = r || E'\n\t' || ' no tiene asegurados de primera categoria';
			ELSE
				r = r || E'\n\t' || filanome;
				x = 1;
			END IF;
	END LOOP;
END LOOP;
	IF x = 0 THEN 
		r = r || E'\n\t' || 'No tiene asegurados';
	END IF;
raise notice '%',r;
EXCEPTION
	WHEN NO_DATA_FOUND THEN 
	r = r || E'\n\t' || 'Hospital no existe';
raise notice '%',r;

END;
$$;

--OPCION MAS OPTIMA (*)
CREATE or replace procedure phospitalp_v2(nome varchar)
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
  x varchar;
  fila record;
  filay record;
  filaz varchar;
  z integer;
BEGIN
   x = '';
   select codh into STRICT fila from hospital where nomh=nome;
   x = x || E'\n' || nome;
   z = 0;
   for filay in select codp,numas from hosp1 where codh=fila.codh LOOP
   	z = 1;
   	select nomas into filaz from asegurado where codp=filay.codp and numas=filay.numas;--*a1c le pasa numas a hosp1, me ahorro un FOR
   		x = x || E'\n\t' || filaz;
   end LOOP;
   if z=0 then
   	x = x || E'\n\t' || 'no tiene asegurados';
   end if;
   raise notice '%',x;
   
   exception
      when no_data_found then
      x = x || 'este hospital no existe';
      raise notice '%',x;
      
end;
$$;
 

