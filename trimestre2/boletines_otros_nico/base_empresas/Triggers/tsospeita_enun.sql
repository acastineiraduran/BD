/*
tsospeita
valor : 2.5 puntos
trigger que rexeite  entrevistar a unha persoa para un posto si o xestor de dito posto ten os mesmos apelidos que a persoa entrevistada 

ex: insert into entrevista values('p18',8,'f','f');
ERROR:  non podes entrevistar a esta persoa para dito posto pois o xestor do posto ten os seus apelidos

ex: insert into entrevista values('p9',23,'f','f');
NOTICE:   entrevista aceptada pois a persoa non ten os apelidos do xestor do posto
*/
DROP FUNCTION tsospeita() CASCADE;
CREATE FUNCTION tsospeita()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
 x record;
 z record;
 t record;
 w record;
BEGIN
  select cod_xestor into t from postos where cod_posto=new.cod_posto;
  select ap1_xestor, ap2_xestor into x from xestores where cod_xestor=t.cod_xestor;
  select ap1_persoa, ap2_persoa into z from persoas where num_persoa=new.num_persoa;  
  if x.ap1_xestor=z.ap1_persoa and x.ap2_xestor=z.ap2_persoa then
  	raise exception 'non podes entrevistar a esta persoa para dito posto pois o xestor do posto ten os seus apelidos';
  	else
  		raise notice 'entrevista aceptada pois a persoa non ten os apelidos do xestor do posto';
  end if;
  return new;
END;
$$;
CREATE TRIGGER tsospeitat before INSERT ON entrevista for each row EXECUTE PROCEDURE tsospeita();
