/*por cada fila lo meto en una variable r  y captuta el nomeq y el codeq, cuando acabe el bucle devuelve r (REVISAR, no fui a clase). || para concatenar
*/

CREATE or replace procedure pequipos()
	LANGUAGE PLPGSQL
	AS
$$
DECLARE
  fila record;
  r varchar;
BEGIN
r=E'\n';
FOR fila IN select * from equipo LOOP /*para cada fila coge todos los campos del xogador (esto significa todos los campos: *) y con esos datos hacer lo del la siguiente linea:*/
r=r||fila.codequ||'   '||fila.nomequ||E'\n'; /* coger todos los codequ y nomequ y meterlos en r, que es una cadena de caracteres*/
END LOOP;
raise notice '%',r;
END;
$$

