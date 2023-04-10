/*
phospital2
procedemento que amose os nomes de todos os hospitais e para ca un deles os nomes dos medicos que prescribiron  hospitalizacions a asegurados de primeira categoria 
*/

CREATE or replace procedure phospital2()
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
r varchar;
fila record;
filay record;
filax record;

BEGIN
r = E'\n';
FOR fila IN SELECT * FROM hospital LOOP
	r = r || E'\n' || fila.nomh;
	FOR filax IN SELECT codh,codm FROM hosp1 WHERE codh=fila.codh group by codh,codm LOOP
		FOR filay IN SELECT * FROM medico where codm=filax.codm LOOP
		r = r || E'\n\t' || filay.nomm;
		END LOOP;
	END LOOP;
END LOOP;
raise notice '%',r;
END;
$$;

--FORMA DE NICO (YO CREO QUE LA MIA MEJOR YA QUE NO REPITE LOS NOMBRES)
CREATE or replace procedure phospital2_v2()
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
  fila record;
  filay record;
  filaz record;
  x varchar;
BEGIN
x = '';
   for fila in select nomh, codh from hospital LOOP
   	x = x || E'\n' || fila.nomh;
   	for filay in select codm from hosp1 where codh=fila.codh LOOP
   		select nomm into filaz from medico where codm=filay.codm;
   		x = x || E'\n\t' || filaz.nomm;
   	end LOOP;
   end LOOP;
   raise notice '%',x;

end;
$$;

