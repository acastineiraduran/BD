/*
   nomed    | nsocio 
-------------+--------
 literatura  |      3
 matematicas |      6

*/

DROP FUNCTION ttrixe() CASCADE;
CREATE FUNCTION ttrixe()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
fila record;
x integer;
BEGIN
x = 0;
FOR fila IN SELECT * FROM profesor WHERE nomea in (select nomea from area where nomed=new.nomed) LOOP
	IF fila.nsocio=new.nsocio THEN
		x = 1;
	END IF;
END LOOP;

IF x = 1 THEN 
	RAISE NOTICE 'rexistro inserido';
ELSE 
	RAISE EXCEPTION 'O profesor non traballa en ningunha area do departamento';
END IF;

return new;
END;
$$;
CREATE TRIGGER ttrixet before INSERT ON dirixe for each row EXECUTE PROCEDURE ttrixe();

