/*
18 procedemento pklingon  (base startrek).- achegase e/r, grafo, script creacin taboas
procedemento que devolva todos os titulos da peliculas e para cada una delas os nomes dos personaxes klingon que interveñen nela



titulo: wrath_of_khan
personaxe: yuta
personaxe: prak

titulo: search_spock

titulo: voyage_home
personaxe: jono

titulo: final_frontier
personaxe: jono

titulo: undiscovered

titulo: generations

titulo: first_contact

titulo: insurrection

titulo: nemesis
*/

/* 
esto solo me cogeria la el primer codpar de cada uno
el codigional es necesario ya que si no el resultado: <NULL>
*/

CREATE or replace procedure pklingon()
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
r text := '';
fila record;
filay record;

BEGIN
r = '';
FOR fila IN select * from peliculas LOOP
r = r || E'\n' || 'titulo: ' || fila.titulo;
	select codper into filay from interpretespel where codpel=fila.codpel;
	--FOR filay IN select * from interpretespel where codpel=fila.codpel LOOP
	IF filay IS NOT NULL THEN
		r = r || E'\n\t' || filay.codper;
	END IF;
	--END LOOP;
END LOOP;
raise notice '%',r;

END;
$$;

CREATE or replace procedure pklingon_v3()
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
r text := '';
fila record;
filay record;
filaz record;
filaj record;
BEGIN
r = '';
FOR fila IN select * from peliculas LOOP
r = r || E'\n' || 'titulo: ' || fila.titulo;
	FOR filay IN select * from interpretespel where codpel=fila.codpel LOOP
		FOR filaz IN SELECT codper from klingon WHERE codper=filay.codper LOOP
		SELECT nomper INTO filaj FROM personaxes WHERE codper=filaz.codper;
		r = r || E'\n' || 'personaxe: ' || filaj.nomper;
		END LOOP;
	END LOOP;
END LOOP;
raise notice '%',r;

END;
$$;


