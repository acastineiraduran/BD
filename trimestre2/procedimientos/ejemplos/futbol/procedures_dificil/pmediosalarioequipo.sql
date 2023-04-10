/*procedimiento chamado pestadios que:
1) imprima os codigos e nomes de todos os estadios.
2) para cada estadio listan os partidos que se celebraron nel.
*/
CREATE or replace procedure pmediosalarioequipo()
	LANGUAGE PLPGSQL
	AS
$$
DECLARE
  fila record;
  filax record;
  r varchar;
  media numeric;/* para que acepte decimales*/
BEGIN
	r=E'\n';
	FOR fila IN select * from equipo LOOP	
	r=r||fila.codequ||'  , '||fila.nomequ||E'\n';
		select avg(salario) into media from xogador where 	
		codequ=fila.codequ;
		if media is not null then /* si no da nulo */
		r=r||media||E'\n';
		else 
		r=r||'o equipo non ten xogadores'||E'\n';
		end if;
	END LOOP;
raise notice '%',r;
END;
$$

