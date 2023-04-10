--FMASTRESX.SQL
CREATE or replace FUNCTION mastresx (ce varchar)
RETURNS varchar
language plpgsql
AS
$$
declare
da integer;
respuesta varchar;

begin
select count(*) into da from xogador where codequ=ce;
--da = select count(*) into da from xogador where codequ=ce; // lo puedo poner asi
if da=3 then
	respuesta='ten 3 xogadores';
else if da>3 then
	respuesta='ten mais de 3 xogadores';
else
	respuesta='ten menos de 3 xogadores';
end if;
end if;

return respuesta;
end;
$$
;
