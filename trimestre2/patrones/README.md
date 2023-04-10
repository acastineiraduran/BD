# Patrones

## Funiones
```sql
CREATE [or replace] FUNCTION function_name(param_list)
	RETURNS return_type --lo que returna
	LANGUAGE PLPGSQL
    AS 
$$  
DECLARE    
 --variable declaration       declaracion de la variable
BEGIN
 --logic   logica del programa, metodos etc, se pone la consulta de postgres anhadiendo ...into variable ...
 --ejemplo select count(*) into e from xogador where codequ=nombre; 
 /*tambien puedes hacer:
 e = (select count(*) from xogador where codequ=nombre);
 */ 
 
 RETURN x; --la variable que devuelve
END;
$$;
```

## Procedimientos
```sql
CREATE or replace procedure nomeProcedimiento()
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
x tipoDato;
BEGIN
--
raise notice '%',x;

END;
$$;
```

## Trigers
```sql
DROP FUNCTION t() CASCADE;
CREATE FUNCTION t()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
    AS 
$$  
DECLARE

BEGIN

return new;
END;
$$;
CREATE TRIGGER tt before INSERT ON tabla for each row EXECUTE PROCEDURE t();
```

## Excepciones