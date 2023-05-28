# Introduccion

```sql
sudo -i -u postgres
c\ postgres postgres
```

## USUARIOS
### INFORMACION

```SQL
select user; --usuario actual
```

### CREAR/ELIMINAR

```SQL
CREATE USER u1 WITH PASSWORD 'u1';
```

### PERMISOS

```SQL

```

----------------------------------------------

## BASES DE DATOS
### INFORMACION

```SQL
\l --lista de bases de datos, privilegios y propietarios
```

### CREAR/ELIMINAR

```SQL
CREATE DATABASE basex;
```

### PERMISOS

```SQL
--quitar permiso conectarse a public en base de datos. RECOMENDABLE al principio.
REVOKE CONNECT ON DATABASE basex FROM PUBLIC;
--permiso para conectarme con un usuario a una base de datos
GRANT CONNECT ON DATABASE basex TO u1;

```
---------------------------------------------

## ESQUEMAS
### INFORMACION

```SQL
\dn --lista de esquemas

```

### CREAR/ELIMINAR

```SQL
--crear schema por defecto de public
CREATE SCHEMA e2;
--crear esquema y asignarlo a un usuario en un solo paso
CREATE SCHEMA e1 AUTHORIZATION u1;
```

### PERMISOS

```SQL
--cambiar propietario del esquema

--revoca privilegio de creación de objetos en el esquema public para el rol public
REVOKE CREATE ON SCHEMA public FROM public;
--cambiar propietario del esquema
ALTER SCHEMA e2 OWNER TO u2;
--permite al usuario acceder y utilizar los objetos contenidos dentro del esquema PREVIO A DAR PERMISOS EN CUALQUIER TABLA
GRANT USAGE ON SCHEMA e1 TO u2;
```
----------------------------------------------------

## TABLAS
### INFORMACION

```SQL
\z e1.* --ver informacion de tablas de un esquema especifico
```

### CREAR/ELIMINAR

```SQL
--crear tabla en un esquema especifico
CREATE TABLE e1.basex_e1_u1_t1 (codigo INTEGER, nome VARCHAR(20));
INSERT INTO  e1.basex_e1_u1_t1 VALUES (1,'lila') ;
```


### PERMISOS

```SQL
--permiso para ver todos los datos de una tabla
GRANT SELECT ON e2.basex_e2_u2_t1 TO u1;
--para ver columnas especificas de una tabla
GRANT SELECT(nome) ON e2.basex_e2_u2_t1 TO u1;
--permiso para insertar valores dentro de una tabla
GRANT INSERT ON e1.basex_e1_u1_t1 TO u2;

```


