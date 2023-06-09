/*
tmaxpostos
impedir que un mesmo xestor poda xestionar mais de 7 postos

exemplos:

insert into postos values ('p19', 'disenador web', 3000,365,'pe2','e8','x1');

 este xestor xa xestiona 7 postos

insert into postos values ('p19', 'disenador web', 3000,365,'pe2','e8','x2');

 insercion aceptada
*/
DROP FUNCTION tmaxpostos() CASCADE;
CREATE FUNCTION tmaxpostos()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
 a integer;
BEGIN
  select count(cod_posto) into a from postos where cod_xestor=new.cod_xestor;
  if a < 7 then
  	raise notice 'insercion aceptada';
    else
        raise exception 'este xestor xa xestiona 7 postos';
  end if;
  return new;
END;
$$;
CREATE TRIGGER tmaxpostost before INSERT ON postos for each row EXECUTE PROCEDURE tmaxpostos();
