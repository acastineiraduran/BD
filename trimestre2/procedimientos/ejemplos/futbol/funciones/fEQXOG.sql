CREATE or replace FUNCTION fEQXOG(codeq varchar)
RETURNS integer
language plpgsql
AS
$$
declare
d integer;
begin
select count (*) into d from xogador where codequ=codeq;

return d;
end;
$$
;

