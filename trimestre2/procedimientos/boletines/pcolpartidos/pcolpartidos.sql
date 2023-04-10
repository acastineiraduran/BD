/*
procedimiento chamado pcolpartidos que amose para cada colexiado (codigo e nome ) o nome e as datas dos partidos nos que interven. tamen amosar o total de partidos en que interven cda colexiado , si non interven en nungunpartido amosar a mensaxe -colexiado sen partidos arbitrados-

pasos posibles a seguir antes de chegar ao resultado final:

paso 1 : amosar codigo e nome de colexiado : for ..loop para colexiados
paso 2 : amosar codigos de partidos : for .. loop para tabla interven
paso 3 : amosar nome e data dos partidos : select into en table partidos
paso 4 : amosar numero de partidos arbitrados por cada colexiado e mensaxe en caso de non arbitrar ningun

call pcolpartidos()

c1 , cfelipe
cuspedrinoscroques 02/03/2010
croquesreboludos 02/06/2010
gambusinoscuspedrinos 12/06/2010
total : 3
c2 , cjuan
croquesreboludos 02/06/2010
total:1
c3 , cpedro
croquesreboludos 02/06/2010
cuspedrinoscroques 02/03/2010
total: 2
c4 , cluis
colexiado sen partidos arbitrados
c5 , cana
gambusinoscuspedrinos 12/06/2010
total: 1

SE PUEDE HACER MAS OPTIMAMENTE SIN 3 FOR, ¡mirar solucion profesor optimizada!

*/

CREATE or replace procedure pcolpartidos()
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
r varchar;
fila record;
filay record;
filaz record;
x integer;
BEGIN
r = '';
x = 0;
FOR fila IN select * from colexiado LOOP
r = r || E'\n' || fila.codc || ' , ' || fila.nomc; 
	FOR filay IN select * from interven where codc=fila.codc LOOP
	x = x+1;
		FOR filaz IN select * from partido where codpar=filay.codpar LOOP
		r = r || E'\n\t' || filaz.nompar || ' , ' || filaz.data;
		END LOOP;
	END LOOP;
	if x=0 then
	r = r || E'\n\t' || ' O colexiado non interviu en ningun partido';
	else
	r = r || E'\n\t' || ' total: ' || x ;
	end if;
	x = 0;
END LOOP;
raise notice '%',r;

END;
$$;

--SEGUNDO METODO
CREATE or replace procedure pcolpartidos_v2()
    LANGUAGE PLPGSQL
    AS
$$
DECLARE
  x varchar;
  fila record;
  filax record;
  filay record;
  cuenta integer;
BEGIN
   x='';
   for fila in select nomc,codc from colexiado LOOP
   cuenta = 0;
   x = x || E'\n' || fila.nomc || ', ' || fila.codc;
   	for filax in select codc, codpar from interven where codc=fila.codc LOOP
  	 	cuenta = cuenta +1;
  	 	select codpar, nompar, data into filay from partido where codpar=filax.codpar;
  	 	x = x || E'\n\t' || filay.nompar ||', ' || filay.data;
    	end LOOP;
    	x = x || E'\n     ';
   	if cuenta = 0 then
   		x = x || 'sin partidos arbitrados' || E'\n';
   	   else
   	   	x = x || cuenta || ' partidos arbitrados en total' || E'\n';
   	end if;
   end LOOP;   
   raise notice '%', x;
end;
$$;


