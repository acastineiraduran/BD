CREATE or replace FUNCTION fconx(minimo integer, maximo integer)
	RETURNS integer --eso es lo que devuelve--
	language plpgsql
	AS--es una palabra reservada que indica la zona de declaracion, es obligatoria (todas las que estan en MAYUS hay son palabras reservadas--
$$
declare
variable1 integer;
begin
select count (*) into variable1 from xogador where salario>=minimo and salario<=maximo;--antes del from hay que poner into--

return variabl1;
end;
$$
;
