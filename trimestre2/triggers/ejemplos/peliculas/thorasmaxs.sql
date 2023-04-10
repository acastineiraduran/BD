/*
impedir que un mismo actor interprete mas de 500 horas en una misma serie

insert into interpretesser values('a18','p16','s3',1)

rexeitada insercion, ese actor non pode traballa mais de 500 horas na serie s3

insert into interpretesser values('a12','p16','s3',101)
rexeitada insercion, ese actor non pode traballa mais de 500 horas na serie s3

insert into interpretesser values('a12','p16','s3',100)
aceptada insercion
*/


DROP FUNCTION thorasmaxs() CASCADE;
CREATE FUNCTION thorasmaxs()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
horastot integer;

BEGIN
select sum(coalesce(horas,0))+coalesce(new.horas,0) into horastot from interpretesser where coda=new.coda and cods=new.cods; --cods necesario pq dice en una misma series
IF horastot <= 500 THEN
	raise notice 'aceptada insercion';
ELSE
	raise exception 'rexeitada insercion, ese actor non pode traballa mais de 500 horas na serie %',new.cods;
END IF;
return new;
END;
$$;
CREATE TRIGGER thorasmaxst before INSERT ON interpretesser for each row EXECUTE PROCEDURE thorasmaxs();

/*

DROP FUNCTION thorasmaxs() CASCADE;
CREATE FUNCTION thorasmaxs()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
 cuenta integer;
BEGIN
  select sum(coalesce(horas,0))+coalesce(new.horas,0) into cuenta from interpretesser where coda=new.coda and cods=new.cods;
  cuenta = cuenta + coalesce(new.horas,0);
  if cuenta <= 500 then
  	raise notice 'inserción añadida';
	else
	   raise exception 'inserción fallida, este actor no puede traballar máis de 500 horas en la serie %',new.cods;
  end if;
  return new;
END;
$$;
CREATE TRIGGER thorasmaxst before INSERT ON interpretesser for each row EXECUTE PROCEDURE thorasmaxs();
*/