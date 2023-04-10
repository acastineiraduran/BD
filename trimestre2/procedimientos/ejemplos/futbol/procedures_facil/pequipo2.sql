
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
FOR fila IN select * from equipo LOOP /*no puedo poner 3 for con mismo nombre*/
r=r||fila.codequ||'   '||fila.nomequ||E'\n';/*
	FOR filax IN select * from xogador LOOP para cada equipo les devuelve todos los jugadores porque se va a ejecutar esto en cada bucle
	r=r||filax.codx||'   '||filax.nomx||E'\n';
	END LOOP;*/
	FOR filax IN select * from xogador where codequ=fila.codequ LOOP/*para cada equipo les devuelve los jugadores de ese equipo*/
	r=r||E'\t'||filax.codx||'  , '||filax.nomx||E'\n';/*'E' es para poner caracteres especiales, el '\t' es para tabular*/
	END LOOP;
END LOOP;

raise notice '%',r;
END;
$$

