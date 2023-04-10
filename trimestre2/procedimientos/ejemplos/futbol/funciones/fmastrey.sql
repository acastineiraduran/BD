--FMASTRESY.SQL
/*mirar gh de nico esta bien explicado y ademas este codigo me da mal
hay otra opcion  poniendo lo de strict y lo de exception (que no se como era
el codigo, copiar de nicolas). las 2 formas hacen lo mismo, de momento nos da igual utilizar cualquiera de ellas
*/
CREATE or replace FUNCTION mastresy (ne varchar)
RETURNS varchar
language plpgsql
AS
$$
declare
da integer;
r varchar;
ce varchar;

begin
select codequ into ce from equipo where nomequ=ne;
if not data found then --aunque esto no siempre sale
r='equipo no encontrado';
/*si no pongo el return va a seguir para abajo y se va a cambiar la 
variable r por lo tanto imprimira 'ten menos de 3 xogadores'*/
return r; --no deberia seguir la funcion para abajo? explicado arriba
end if;

select count(*) into ce from xogador where codequ=ce;--siempre que cogas algo hay que meterlo en un sitio, lo de into es para meter el valor a la variable

--select numx from equipo where nomequ=ne; --no se puede hacer asi?
if da=3 then
	r='ten 3 xogadores';
else if da>3 then
	r='ten mais de 3 xogadores';
else
	r='ten menos de 3 xogadores';
end if;
end if;

return r;
end;
$$
;
