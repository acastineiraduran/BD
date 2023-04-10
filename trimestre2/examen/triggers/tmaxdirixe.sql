DROP FUNCTION tmaxdirixe() CASCADE;
CREATE FUNCTION tmaxdirixe()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
numd integer;

BEGIN
numd = 0;
select count(*) INTO numd from dirixe where nsocio=new.nsocio;
if numd > 1 then
	raise exception 'o profesor non debe dirixir mais de dous departamentos, rexeita insercion';
else	
	raise notice 'rexistro inserido';
end if;
return new;
END;
$$;
CREATE TRIGGER tmaxdirixet before INSERT ON dirixe for each row EXECUTE PROCEDURE tmaxdirixe();
