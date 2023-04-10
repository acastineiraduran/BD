/*procedimiento chamado pcolpartidos que amose para cada colexiado o nome e as datas dos partidos nos que interven*/
CREATE or replace procedure pcolpartidos()
	LANGUAGE PLPGSQL
	AS
$$
DECLARE
  fila record;
  filax record;
  filay record;
  r varchar;
  x integer;
  np varchar;
BEGIN
r='';
FOR fila IN select * from colexiado LOOP 	
r=r||E'\n'||'El colexiado '||fila.nomc||' interven en: '||E'\n';
	FOR filax IN select * from interven where codc=fila.codc LOOP
		FOR filay IN select * from partido where 	
		codpar=filax.codpar /* el ultimo ciclo 'for' mejor hacerlo 
		con un select into porque si no va a gastar muchos mas 
		recursos cuando no es necesario*/
		LOOP				
		r=r||E'\t'||'nompar de partido: '||filay.nompar||', '||
		filay.data||E'\n';
		x=x+1;
		END LOOP;
	END LOOP;
	if x=0 then
	r=r||E'\t'||'No intervino en ningun partido.'||E'\n';
	end if;
	x=0;
END LOOP;
raise notice '%',r;
END;
$$
