# CODIGO ADMINISTRACION DB

```sql
sudo -u postgres psql

psql futbol2 userfu -psql <bd> <usu>
```

Formato permisos
```SQL
GRANT <clausula> ON <type> <name> TO <grantee>
REVOKE <clausula> ON <type> <name> FROM <grantee>
```

`ON <type> <name>` --> no obligatoria

## Usuarios

```SQL
# INFORMACION
--ver usuario actual
select user;
--ver usuarios disponibles y sus atributos
\du
--añade la columna de descripcion de los usuarios
\du+

# CREAR/ELIMINAR
--crear un usuario
CREATE USER u1 WITH PASSWORD 'u1';

# PERMISOS
```

## Roles
1. unica diferencia con usuario es que no se puede logear
2. solo puede dar permisos de esquemas el propietario o creador
3. todos los usuarios que tengan el rol, tienen los permisos asignados a este rol
4. No existe una forma/vista especifica para ver las propiedades de un rol.???yocreo que si

```SQL
# INFORMACION

# CREAR/ELIMINAR
--crear rol
create role readonli;

# PERMISOS
--otorgar permisos de uso de un schema para el rol readonly.
GRANT USAGE ON SCHEMA sa TO readonly;
--asignar un rol a un usuario? creo que solo lo puede hacer postgres
GRANT readonly TO ub;
--ver privilegios sobre tablas que tienen un rol // creo que solo te estaria mostrando una parte???
SELECT * FROM information_schema.table_privileges WHERE GRANTEE='readonly'


```

## Bases de datos

```SQL
# INFORMACION
--lista de bases de datos, privilegios y propietarios
\l 

# CREAR/ELIMINAR
--crear una base de datos
CREATE database basex;
--borrar base de datos
DROP database dam1;
--borrar base de datos desde el usuario del sistema (despues de darle a \q)
DROP -U postgres futbol2 --postgres creo que siempre

# PERMISOS
--permiso para conectarme con un usuario a una base de datos
GRANT CONNECT ON database basex TO u1;
--quitar permiso conectarse a public en base de datos. RECOMENDABLE al principio.
REVOKE CONNECT ON database basex FROM public;

```

## Esquemas

```SQL
# INFORMACION
--lista de esquemas, ver esquemas
\dn
--lista detallada de todos los esquemas: privilegios esquemas etc
\dn+

# CREAR/ELIMINAR
--crear schema por defecto de public
CREATE SCHEMA e2;
--crear esquema y asignarlo a un usuario en un solo paso
CREATE SCHEMA e1 AUTHORIZATION u1;
--borrar un esquema???????????????

# PERMISOS
--revoca privilegio de creación de objetos en el esquema public para el rol public
REVOKE CREATE ON schema public FROM public;
--cambiar propietario del esquema
ALTER schema e2 OWNER TO u2;
--permite al usuario acceder y utilizar los objetos contenidos dentro del esquema-IMPORTANTE
GRANT USAGE ON schema e1 TO u2;
```

## Tablas
Si especificas se muestra el de por defecto (generalmente public)

```SQL
# INFORMACION
--informacion de tablas
\d
--ver informacion de tablas detallada: privilegios tablas etc
\z
--ver informacion de tablas detallada especificando el esquema
\z e1.*

# CREAR/ELIMINAR
--crear tabla en un esquema especifico
CREATE TABLE e1.basex_e1_u1_t1 (codigo INTEGER, nome VARCHAR(20));
--eliminar una tabla
DROP TABLE proba1;
--insertar valores en una tabla
INSERT INTO e1.basex_e1_u1_t1 VALUES (1,'lila') ;
--actualizar valores de una tabla
UPDATE e1.proba1 SET nome='pedro' WHERE codigo=2;
--añadir una columna a una tabla
ALTER TABLE e1.proba1 ADD COLUMNS nome VARCHAR(20);
--añadir una clave primaria (ningun campo puede ser nulo)
ALTER TABLE e1.proba1 ADD PRIMARY KEY(codigo);

# PERMISOS
--permiso para ver todos los datos de una tabla
GRANT SELECT ON e2.basex_e2_u2_t1 TO u1;
--para ver columnas especificas de una tabla
GRANT SELECT(nome) ON e2.basex_e2_u2_t1 TO u1;
--permiso para insertar valores dentro de una tabla
GRANT INSERT ON e1.basex_e1_u1_t1 TO u2;

# PERMISOS SOBRE COLUMNAS
--privilegios/permisos dentro de la base de datos
SELECT grantor, grantee, table_schema table_name column_name privilege_type --columnas que se muestran
FROM information_schema.column_privileges --tabla de ese esquema que contiene info sobre permisos sobre columnas otorgados por bd
WHERE grantee='u3';--permisos otorgados por u3
```

## Otros - **por defecto**
```SQL
--ruta de busqueda por defecto para la asignacion de tablas. Por defecto public
SHOW search_path;
--cambiar ruta de asignacion de un esquema a una tabla en una base especifica - asgincion con postres
ALTER USER u1 IN DATABASE basex SET search_path TO e1;
--cambiar que por defecto no me muestre las tablas del esquema public, si no que me muestre todas las que hay. sb y sa serían otros esquemas.
ALTER USER POSTGRES IN DATABASE basex SET search_path TO public,sa,sb;--NO ACTUALIZA hasta que cerramos y abrimos sesion de nuevo
```

------------

## Copias de seguridad
1. Simplemente lanzarimos el script de la copia de seguridad `\i ‘nombreScript_deLaCopiaSeguridad’`
2. `pg_dump` la copia de seguridad creado no copia usuarios
3. No puedo exportar cosas que no son mias

**se hacen FUERA del servicio POSTGRES, después de \q**
>`pg_dump -U [usu_recep] [-T/N/t/n] [--accion] [format] [base] > [copia_base.dump]`
>`pg_restore -U [usu_recep] [base_ref] [copia_base.dump] `
Generalmente se usa **postgres** como base de referencia (base_ref)

### Exportar a una copia de seguridad

```SQL
# TIPOS EXPORTACION DEPENDIENDO DEL FORMATO
--copia de seguridad (para regenerar bd) con todo incluso INSERTs...pero NO los usuarios
--hacer copia base de datos en texto plano
pg_dump -U postgres -Fp basex > basexplana.dump
--hacer copia comprimida de la base de datos
pg_dump -U postgres -Fc basex > basexcomprimida.dump

# CONDICIONES DE EXPORTACION
--exportar incluyendo (para excluir es con '-T') solo tablas específicas
pg_dump -U ua -t 'sa.probauat1' --inserts -Fp basex > uat1.dump
--exportar incluyendo (para excluir es con '-N') solo esquemas específicos
pg_dump -U ua -n 'sa.probauat1' --inserts -Fp basex > uat1.dump
--varias condiciones de exportacion (tanto con Fp como Fc)
pg_dump -U postgres -t 'fu.x*' -t 'fu.adestra' -t 'fu.interven' -Fp futbol2 > fup2.dump

# OTROS
--crear una base con un nombre distinto a partir de la base comprimida
createdb -U postgres -D basez basecomprimida.dump
--porque inserts????
pd_dump -U postgres --inserts -Fp basex > basexcomprimida.dump
```
Si no incluye `-t` o `-T` va a exportar lo que permise ese usuario

```SQL
--exportar incluyendo esquemas y tablas específicas
pg_dump -U ua -t 's*.p*' --inserts -Fp basex > uat1.dump
```
si quiero combinar tablas y esquemas específicos lo hago solo con `-t`**

### Restaurar a partir de copia de seguridad
A. Restaurar a partir de archivo en formato texto plano. Proceso:
```SQL
# PASO PREVIO copia en txt plano y borrado de bd
\q
pg_dump -U postgres -Fp futbol2 > f2.dump
dropdb -U postgres futbol2

# RECUPERACION
psql postgres postres
CREATE DATABASE futbol2
\c futbol2
\i '/home/oracle/f2.dump'
```

B. Restaurar a partir de archivo en formato comprimido. Proceso:
```SQL
# PASO PREVIO
\q
pg_dump -U postgres -Fc futbol2 > futbol2Comprimido.dump
drodb -U postgres futbol2

# RECUPERACION
--A. recuperacion de base de datos completa
pg_restore -U postgres -C -d postgres futbol2Comprimido.dump
--B. recuperar las base comprimida en una nueva base con otro nombre distinto
createdb -U postgres -T template0 baseZ 
pg_restore -U postgres -d futbol3 futbol2Comprimido.dump

# RECUPERACION a partir del resumen y la bd con formato comprimido
\q
--Va a hacer un listado en formato especial (legible) basado en lo que hay en basexcomprimida y lo va a meter en listado.txt
pg_restore -l basexcomprimida.dump > listado.txt
--elimino las lineas que no quiero que contenga la nueva bd
gedit lista.txt
--Restauro parte de la info del fichero comprimido (partiendo de que la base original no fue eliminada)
pg_restore -U postgres -d futbol2 -L lista.txt fuc2.dump

```

`-T`=template, indica que usa como ref la base template(). Es una plantilla que contiene las cosas necesarias para la tabla. **esto creo que solo lo puedo hacer porque el formato es -Fc**

## Clausulas
* `USAGE` permisos de acceso a un objeto pero no permisos de modificacion o ejecución
* `DROP` elimina estructura y contenido
* `DELETE` elimina solo el contendio



