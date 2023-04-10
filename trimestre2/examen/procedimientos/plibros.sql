/*
PROCEDIMIENTO 1: plibros
1. nome todos os autores
2. para cada un deles, o titulo e editorial dos seus libros
3. total de libros que corresponden a un autor
4. se autor non ten libros: excepcion: 'non dispon de libros de ese autor'
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
