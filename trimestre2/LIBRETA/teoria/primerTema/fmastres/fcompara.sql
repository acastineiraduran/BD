/*FCOMPARA:SQL
(le pone f delante para diferenciarlas despues)
CREAR UNA FUNCION QUE DADOS DOUS NUMEROS IMPRIMA UNHAS DAS SEGUIENTES MENSAXES:
- SI O PRIMEIRO NUMERO E MAIOR QUE O SEGUNDO:  PRIMEIRO MAIOR QUE O SEGUNDO
- SI O PRIMEIRO E MENOS QUE O SEGUNDO: PRIMEIRO MENOR QUE O SEGUNDO
- SE OS NUMEROS SON IGUAIS: IGUAIS

SELECT COMPARA(3,4)
	primero menor que el segundo
SELECT COMPARA(4,3)
	primero mayor que el segundo
SELECT COMPARA(4,4)
	EQUALS
*/

CREATE or replace FUNCTION fcompara(n1 integer, n2 integer)
	RETURNS varchar
	LANGUAGE PLPGSQL
  AS
$$  
DECLARE    
 r varchar;
BEGIN
	if n1=n2 then
		r='numeros iguales';
	elseif n1>n2 then
		r='numero 1 mayor que 2';
	elseif n1<n2 then
		r='numero 2 mayor que 1';
	end if;
RETURN r;
END;
$$;

/*
CREATE or replace FUNCTION COMPARA (NUMEROA INTEGER, NUMEROB INTEGER)
RETURNS varchar--DEVUELVE UN TEXTO
language plpgsql
AS
$$
declare
--DECLARO LAS LAS VARIALES EN ESTE BLOQUE
r varchar;
r2 varchar;--no se pone de color porque IDE no preparado
begin
--DECLARO LAS FUNCIONES
if NUMEROA=NUMEROB then--esto se podria hacer mejor con un if anidado
	r='iguales'; --r es dd guardo el resultado
else
	if NUMEROA>NUMEROB then
		r=NUMEROA||' mayor que '||NUMEROB;--eso: || para concatenar
		else 
	 	r='primero menor que el segundo';
	end if;
end if;

return r;--una funcion retorna siempre un resultado

end;
$$
;
*/
