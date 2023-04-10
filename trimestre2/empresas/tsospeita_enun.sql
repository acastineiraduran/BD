/*
tsospeita
valor : 2.5 puntos
trigger que rexeite  entrevistar a unha persoa para un posto si o xestor de dito posto ten os mesmos apelidos que a persoa entrevistada 

ex: insert into entrevista values('p18',8,'f','f');
ERROR:  non podes entrevistar a esta persoa para dito posto pois o xestor do posto ten os seus apelidos

ex: insert into entrevista values('p9',23,'f','f');
NOTICE:   entrevista aceptada pois a persoa non ten os apelidos do xestor do posto

*/

/*
DROP FUNCTION tsospeita() CASCADE;
CREATE FUNCTION tsospeita()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
fila record;

BEGIN
FOR fila IN SELECT * FROM persoas WHERE 
FOR filax IN SELECT * FROM xestores WHERE nom_xestor=new.nom_xestor LOOP
	FOR filay IN SELECT * FROM postos WHERE cod_xestor=fila.cod_xestor LOOP
	END LOOP;
	 
END LOOP;

return new;
END;
$$;
CREATE TRIGGER tsospeitat before INSERT ON persoa for each row EXECUTE PROCEDURE tsospeita();
*/

CREATE or replace procedure tsospeita(code_posto varchar)
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
fila record;
filax record;
filay record;
r varchar;
apel1 varchar;
apel2 varchar;
x record;
y varchar;
z record;

BEGIN
r = '';
FOR fila IN SELECT * FROM postos WHERE cod_posto=code_posto LOOP
	r = r || E'\n' || fila;
	SELECT ap1_xestor,ap2_xestor INTO filax FROM xestores WHERE cod_xestor=fila.cod_xestor;
		r = r || E'\n' || filax;
	r = r || E'\n' || filax;
	SELECT cod_perfil INTO y FROM perfil WHERE cod_perfil=fila.cod_perfil;
	r = r || E'\n' || y;
	SELECT ap1_persoa,ap2_persoa INTO filay FROM persoas WHERE cod_perfil=y;
	r = r || E'\n' || filay;
		
END LOOP;
raise notice '%',r;

END;
$$;