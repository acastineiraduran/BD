/*
trigger que deniega la insercion de jugadores con un salario mayor que el maximo salario de jugadores de su propio equipo

insert into xogador values ('x20','ana','e1',3000,0,null);
*/
DROP FUNCTION tsalmax() CASCADE;
CREATE FUNCTION tsalmax() RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
DECLARE
salmax integer;
BEGIN

select max(salario) into salmax from xogador where codequ=new.codequ;
if new.salario>salmax then
	raise exception 'insercion denegada, salario mas alto que los de su equipo';
	raise notice 'insercion aceptada';
end if;
return new;
END;
$$;

create trigger tsalmaxt before insert on xogador for each row execute procedure tsalmax();
