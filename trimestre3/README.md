# CODIGO ADMINISTRACION DB

```sql
sudo -i -u postgres
c\ postgres postgres
```

## Usuarios

```SQL
# INFORMACION
--ver usuario actual
select user;
--describe usuarios, ver usuarios
\du

# CREAR/ELIMINAR
--crear un usuario
CREATE USER u1 WITH PASSWORD 'u1';

# PERMISOS
```

----------------------------------------------

## Bases de datos

```SQL
# INFORMACION
--lista de bases de datos, privilegios y propietarios
\l 

# CREAR/ELIMINAR
--crear una base de datos
CREATE DATABASE basex;

# PERMISOS
--permiso para conectarme con un usuario a una base de datos
GRANT CONNECT ON DATABASE basex TO u1;
--quitar permiso conectarse a public en base de datos. RECOMENDABLE al principio.
REVOKE CONNECT ON DATABASE basex FROM PUBLIC;

```
---------------------------------------------

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
--eliminar una base de datos
DROP DATABASE proba1;

# PERMISOS
--cambiar propietario del esquema

--revoca privilegio de creación de objetos en el esquema public para el rol public
REVOKE CREATE ON SCHEMA public FROM public;
--cambiar propietario del esquema
ALTER SCHEMA e2 OWNER TO u2;
--permite al usuario acceder y utilizar los objetos contenidos dentro del esquema-IMPORTANTE
GRANT USAGE ON SCHEMA e1 TO u2;
--cambiar ruta por defecto
ALTER USER u1 IN DATABASE basex SET SEARCH_PATH TO e1;
```
----------------------------------------------------

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
INSERT INTO  e1.basex_e1_u1_t1 VALUES (1,'lila') ;
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

```

----------------------------------------------------

## Otros
```SQL
--ruta de busqueda por defecto para la asignacion de tablas. Por defecto public
\SHOW SEARCH PATH
```


