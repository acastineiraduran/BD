
CREATE or replace procedure pequipos()
	LANGUAGE PLPGSQL
	AS
$$
DECLARE
  fila record;
  filax record;
  r varchar;
BEGIN
r=E'\n';
FOR fila IN select * from equipo LOOP 
r=r||fila.codequ||'   '||fila.nomequ||E'\n';
	FOR filax IN select * from xogador where codequ=fila.codequ LOOP
	if filax.salario is not null then
	r=r||E'\t'||filax.codx||'  , '||filax.nomx||' , '||filax.salario||	E'\n';
	else 
	r=r||E'\t'||filax.codx||'  , '||filax.nomx||' , sin salario'||E'\n';
	end if;
	END LOOP;
END LOOP;

raise notice '%',r;
END;
$$

