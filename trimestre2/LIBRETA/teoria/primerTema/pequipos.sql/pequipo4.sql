/* el salario de algunos equipos puede estar distinto al resto de la clase porque el salario de algunos jugadores lo tengo ditinto, por ejemplo el de Carlos lo tengo a 3000 cuando otros compañeros lo tienen a cero (porque lo habian modificado*/
CREATE or replace procedure pequipos()
	LANGUAGE PLPGSQL
	AS
$$
DECLARE
  fila record;
  filax record;
  c integer;
  r varchar;
  x integer;
BEGIN
/*c=0; // tengo que ponerlo para que no me de error, pero me va a volver dar error el resultado, por tanto lo pongo mas abajo: '*1' */
r=E'\n';
FOR fila IN select * from equipo LOOP 	
r=r||fila.codequ||'   '||fila.nomequ||E'\n';
c=0; /*se pone aqui *1, cada vez que entra en bucle vuelve a cero*/
x=0;
	FOR filax IN select * from xogador where codequ=fila.codequ LOOP
	if filax.salario is not null then
	r=r||'  , '||filax.salario||						
	E'\n';
	c=c+filax.salario;
	else 
	r=r||', sin salario'||E'\n';
	end if;
	x=x+1;/*numero xogadores de cada equipo*/
	END LOOP;
	if x=0 then /*cuando algo del LOOP es cd tengo la cuenta de los 		jugadores*/
		r=r||'equipo sin xogador'||E'\n';
	else
	r=r||'total salarios de este equipo= '||c||E'\t'||'Total de xogadores='||x||E'\n';
	end if;
END LOOP;
raise notice '%',r;
END;
$$

