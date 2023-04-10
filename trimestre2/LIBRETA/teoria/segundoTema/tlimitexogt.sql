/*
impedir que un partido jueguen mas de 5 jugadores
para borrar:
delete from xoga where codx='x14' and codpar='p1';
para añadir:
insert into xoga values ('x14', 'p1', 4,0);
*/
DROP FUNCTION tlimitexog() CASCADE;
CREATE FUNCTION tlimitexog() RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
DECLARE
numxog integer;
BEGIN

select count(*) into numxog from xoga where codpar=new.codpar;
if numxog=5 then
	raise exception 'insercion denegada, hay mas de 5 xogadores';
	raise notice 'insercion aceptada';
end if;
return new;
END;
$$;

create trigger tlimitexogt before insert on xoga for each row execute procedure tlimitexog();
