/*
PROCEDIMIENTO 1: plibros
1. nome todos os autores
2. para cada un deles, o titulo e editorial dos seus libros
3. total de libros que corresponden a un autor
4. se autor non ten libros:'non dispon de libros de ese autor'
*/
CREATE or replace procedure plibros()
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
r varchar;
fila record;
filay record;
x integer;

BEGIN
r = '';
x = 0;
FOR fila IN SELECT * FROM autor LOOP
	r = r || E'\n' || 'autor: ' || fila.nomea;
	FOR filay IN SELECT * FROM libro WHERE codautor=fila.codautor LOOP
		r = r || E'\n\t' || filay.titulo || '----' || filay.editorial;
		x = x + 1;
	END LOOP;
	IF x = 0 THEN
		r = r || E'\n\t'|| 'non dispon de libros este autor';
	ELSE
		r = r || E'\n\t' || 'total: ' || x;
		x = 0;
	END IF;
END LOOP;
raise notice '%',r;

END;
$$;


/*
PROCEDIMIENTO 2: ptitulos('apoloxia')
1. devolve codigo do libro
2. amose o codigo dos exemplares do mesmo
3. amose numero total de exemplares do mesmo
4. se o libro non existe debe amosar mensaxe
*/
CREATE or replace procedure ptitulos(titu varchar)
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
r varchar;
fila record;
code varchar;
x integer;

BEGIN
r = '';
code = '';
x = 0;
SELECT clibro INTO STRICT code FROM libro WHERE titulo=titu;
	r = r || E'\n' || 'codigo do libro: ' || code;
	FOR fila IN SELECT * FROM exemplar WHERE clibro=code LOOP
		r = r || E'\n\t' || fila.clibro || ', ' || fila.numeroe;
		x = x + 1;
	END LOOP;
IF x > 0 THEN
	 r = r || E'\n\t' || 'total: ' || x;
	 x = 0;
END IF;
raise notice '%',r;
	
EXCEPTION
	WHEN NO_DATA_FOUND THEN
	r = r || E'\n\t' || 'libro inexistente';
raise notice '%',r;

END;
$$;


/*
TRIGGER 1
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


/* 
TRIGGER 2
*/
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
