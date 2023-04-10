/*
procedemento pklingon  (base startrek).
procedemento que devolva todos os titulos da peliculas e 
para cada una delas os nomes dos personaxes klingon que interveñen nela

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

1. titulos pelis
select titulo from peliculas;

2. Nombres personaxes klingon
select nomper from personaxes where codper in (select codper from klingon);

*/

CREATE OR REPLACE PROCEDURE pklingon()
LANGUAGE PLPGSQL
AS $$

DECLARE
  fila record;
  filax record;
  filay record;
  r varchar;
  x integer;
  np varchar;
BEGIN
r='';
FOR fila IN select codpel,titulo from peliculas LOOP 	
r=r||E'\n'||'Titulo: '||fila.titulo||E'\n';
	FOR filax IN select codpel from interpretespel where 
	codpel=fila.codpel LOOP
		FOR filay IN select codper from klingon LOOP
		select nomper into nome from personaxes where 	 
		codper=filay.codper;			
		r=r||E'\t'||'nome personaxe: '||codper.||E'\n';
		x=x+1;
		END LOOP;
	END LOOP;
END LOOP;
raise notice '%',r;
END;
$$
