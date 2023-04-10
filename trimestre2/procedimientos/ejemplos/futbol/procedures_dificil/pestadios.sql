/*procedimiento chamado pestadios que:
1) imprima os codigos e nomes de todos os estadios.
2) para cada estadio listan os partidos que se celebraron nel.
*/
CREATE or replace procedure pestadios()
	LANGUAGE PLPGSQL
	AS
$$
DECLARE
  fila record;
  filax record;
  r varchar;
BEGIN
	r='';
	FOR fila IN select * from estadio LOOP 	
	r=r||fila.codest||'   '||fila.nomest||E'\n';
		FOR filax IN select * from partido where codest=fila.codest LOOP
		r=r||'  , '||filax.codest||', '||filax.nomest||E'\n';
		END LOOP;
END LOOP;
raise notice '%',r;
END;
$$

