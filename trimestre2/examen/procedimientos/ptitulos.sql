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
