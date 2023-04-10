CREATE or replace procedure psalarioxogador(codigo varchar)
/*no es una funcion, es una procedure. se llama con call, no con select*/
/*RETURNS varchar tampoco hay*/
language PLPGSQL
AS
$$

declare
salario integer;
nome varchar;

begin
select nomx,salario into STRICT nome,salario from xogador where codx=codigo;
raise notice 'o nome e o salario do xogador de codigo % son % e %',codigo,nome,salario;
exception
when no_data_found then
raise notice '¡Ese codigo de xogador non existe!';
/*return r;*/
end;
$$
;
