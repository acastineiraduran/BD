/*
trexeita
valor : 2'5 puntos
trigger que impida entrevistar a unha persoa para un posto si dita persoa e rexeitada pola empresa a  que corresponde dito posto.

insert into entrevista values('p9',20,'f','f');
'non podes entrevistar a esta persoa para dito posto pois e rexeitada por a empresa que lle corresponde a dito posto'

insert into entrevista values('p90',7,'f','f');
 non existe a persoa ou o posto

insert into entrevista values('p9',70,'f','f');
 non existe a persoa ou o posto

insert into entrevista values('p9',6,'f','f');
entrevista aceptada
*/

DROP FUNCTION trexeita() CASCADE;
CREATE FUNCTION trexeita()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
  z record;
  y integer;
  t integer;
  w integer;
  cuenta integer;
BEGIN
   select count(cod_posto) into t from postos where cod_posto=new.cod_posto;
   select count(num_persoa) into w from persoas where num_persoa=new.num_persoa;
   if t=0 or w=0 then
   	raise exception 'non existe a persoa ou o posto';
   	else
   	   cuenta = 0;
	   for z in select cod_empresa from rexeita where num_persoa=new.num_persoa LOOP
   		select count(cod_posto) into y from postos where cod_empresa=z.cod_empresa and cod_posto=new.cod_posto;
   		cuenta = cuenta + y;
	   end LOOP;
	   
	   if cuenta=0 then
   		raise notice 'entrevista aceptada';
	   	else
   			raise exception 'non podes entrevistar a esta persoa para dito posto pois e rexeitada por a empresa que lle corresponde a dito posto';
   	   end if;
   end if;
  return new;
END;
$$;
CREATE TRIGGER trexeitat before INSERT ON entrevista for each row EXECUTE PROCEDURE trexeita();
