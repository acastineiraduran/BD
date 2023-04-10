
/*
procedemento postosnegados  que dado o dni dunha persoa devolte a lista dos postos de traballo para os que non  poderia  ser entrevistada debido a que algunhas empresas rexeitan a dita persoa.
execute postosnegados('36202020');
p2
p9
p13
p8
p14
p15
p16
p17
esta persoa e rexeitada para un total de 8 postos

execute postosnegados('36222222');
esta persoa e entrevistable para calquera posto de calqueira empresa
*/

/*
select cod_posto from postos where cod_empresa in (select cod_empresa from empresas where cod_empresa in (select cod_empresa from rexeita where num_persoa=7));
*/
CREATE or replace procedure postosnegados()
	LANGUAGE PLPGSQL
	AS
$$
DECLARE
  fila record;
  filax record;
  filay record;
  r varchar;
BEGIN
r='';
FOR fila IN select cod_empresa from rexeita LOOP 	
	FOR filax IN select cod_empresa from empresas LOOP
		FOR filay IN select cod_posto from postos LOOP
		r=r||E'\n'||'cod_posto: '||filay.cod_posto||E'\n';
		END LOOP;
	END LOOP;
END LOOP;
raise notice '%', r;
END;
$$

