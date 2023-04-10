/*
postgres=# select * from series;
 cods |     titulo      | anolanz | director
------+-----------------+---------+----------
 s1   | star_trek       |    1978 | carter
 s2   | next_generation |    1979 | adams
 s3   | deep_space_nine |    1980 | brown
 s4   | voyager         |    1981 | steward
 s5   | enterprise      |    1982 | bronson
 s6   | cosmos          |    1983 | thompson
(6 filas)

postgres=# select * from peliculas;
 codpel |     titulo     | anolanz | director
--------+----------------+---------+----------
 pel1   | wrath_of_khan  |    1980 | adams
 pel2   | search_spock   |    1985 | brand
 pel3   | voyage_home    |    1989 | gordon
 pel4   | final_frontier |    2000 | brown
 pel5   | undiscovered   |    2003 | george
 pel6   | generations    |    2005 | lucas
 pel7   | first_contact  |    2007 | lucas
 pel8   | insurrection   |    2008 | brand
 pel9   | nemesis        |    2009 | gordon
(9 filas)


tmesmotitulop

impedir que se rexistre una película de igual titulo que calquera das series existentes

insert into peliculas values ('pel10','cosmos',1980, 'adams');rexeitada insercion;

insert into peliculas values ('pel10','cosmas',1980, 'adams');
aceptada insercion
*/

DROP FUNCTION tmesmotitulop() CASCADE;
CREATE FUNCTION tmesmotitulop()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
fila record;
x integer;

BEGIN
x = 0;
FOR fila IN SELECT * FROM series LOOP
IF fila.titulo=new.titulo THEN
x = 1;
END IF;
END LOOP;
IF x=1 THEN
	RAISE EXCEPTION 'rexeitada insercion';
ELSE
	RAISE NOTICE 'aceptada insercion';
END IF;
return new;
END;
$$;
CREATE TRIGGER tmesmotitulopt before INSERT ON peliculas for each row EXECUTE PROCEDURE tmesmotitulop();