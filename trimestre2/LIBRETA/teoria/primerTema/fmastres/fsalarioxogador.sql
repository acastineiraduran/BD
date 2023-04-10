CREATE or replace FUNCTION fsalarioxogador(sal varchar)
RETURNS varchar
language PLPGSQL
AS
$$

declare
d integer;
r varchar;

begin
/*STRICT si no hay salta el error*/
select salario into STRICT d from xogador where codx=sal;
return d;

exception 
when no_data_found then
r='¡Ese codigo de xogador non existe!';
return r;
end;
$$
;
