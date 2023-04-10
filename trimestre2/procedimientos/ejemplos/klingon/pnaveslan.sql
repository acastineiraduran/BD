CREATE or replace procedure pnaveslan(nome varchar)
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
r varchar;
code varchar;
fila record;
tripulacion integer;
capacidad integer;
BEGIN
r = '';
capacidad = 0;
SELECT codn,tripul INTO code,tripulacion FROM naves where nomen=nome;
r = r ||  E'\n' || 'tripulacion: ' || tripulacion;
FOR fila IN SELECT * from lanzaderas where codn=code LOOP
r = r || E'\n' || 'lanzadera: ' || fila.numero || ' , capacidade: ' || fila.capacidade;
capacidad = capacidad + fila.capacidade;
END LOOP;
r = r || E'\n' || 'capacidade total: ' || capacidad;
	IF capacidad>=tripulacion then
	r = r || E'\n' ||' Ten capacidade suficiente';
	ELSE
	r = r || E'\n' ||' NON ten capacidade suficiente';
	END IF;
raise notice '%',r;

END;
$$;