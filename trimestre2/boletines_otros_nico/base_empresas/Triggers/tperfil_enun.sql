/*
tperfil:
realizar un trigger  chamado tperfil que comprobe que cando se entrevista a unha persona para un posto , dita persoa ten o mesmo perfil que corresponde o puesto.
Cando o perfil do posto e persona coincidan debe realizarse a insercion lanzandose a mensaje : entrevista insertada perfiles coincidentes. Si o perfil de posto e persona non coinciden a mensaxe debe ser : perfiles de posto e persoa non coincidentes.
insert into entrevista values('p14',14,'f','f');
ERROR:  perfiles de posto e persoa non coincidentes

insert into entrevista values('p14',15,'f','f');
NOTICE:   entrevista insertada perfiles coincidentes

*/
DROP FUNCTION tperfil() CASCADE;
CREATE FUNCTION tperfil()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
 a varchar;
 b varchar;
BEGIN
  select cod_perfil into a from postos where cod_posto=new.cod_posto;
  select cod_perfil into b from persoas where num_persoa=new.num_persoa;
  if a=b then
  	raise notice 'entrevista insertada, perfiles coincidentes';
    else
  	raise exception 'perfiles de posto e persoa non coincidentes';
  end if;
  return new;
END;
$$;
CREATE TRIGGER tperfilt before INSERT ON entrevista for each row EXECUTE PROCEDURE tperfil();
