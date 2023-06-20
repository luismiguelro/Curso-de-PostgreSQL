-- CREAR BASE DE DATOS - para luego conectarla a la BD jardineria
CREATE DATABASE bd_remota
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- CRAR TABLA DE EJEMPLO
CREATE TABLE public.cliente_vp
(
    id_cliente_vp integer,
    fecha_vp date
);

ALTER TABLE IF EXISTS public.cliente_vp
    OWNER to postgres;

-- insertar
INSERT INTO public.cliente_vp(
	id_cliente_vp, fecha_vp)
	VALUES (1, '2009-01-01');


-- CREAR EXTENSION dblink
CREATE EXTENSION dblink;

-- acceder a esa BD atraves de la BD transporte
SELECT * FROM 
dblink ('dbname=bd_remota 
        port=5432 
        host=127.0.0.1 -- iria la ip
        user=postgres
        password=123456',
        'SELECT * FROM cliente_vp') -- dar formato a los datos
        AS datos_remotos(id_cliente_vp integer, fecha_vp date);
-- CRUZAR LA INFO CON LA TABLA de clientes en la BD jardineria

SELECT * FROM cliente
JOIN
(dblink ('dbname=bd_remota 
        port=5432 
        host=127.0.0.1 -- iria la ip
        user=postgres
        password=123456',
        'SELECT * FROM cliente_vp'))-- dar formato a los datos
        AS datos_remotos(id_cliente_vp integer, fecha_vp date);
ON (cliente.codigo_cliente = datos_remotos.id_cliente_vp)
USING(id_cliente_vp) --  ES LO MISMO DEL ON

-- Resultado
"""
codigo_cliente | nombre_cliente    | nombre_contacto | apellido_contacto | telefono   | fax           | linea_direccion1      | linea_direccion2 | ciudad         | region | pais | codigo_postal | codigo_empleado_rep_ventas | limite_credito | id_cliente_vp | fecha_vp   
1              | "GoldFish Garden" | "Daniel G"      | "GoldFish"        | "5556901745" | "5556901746" | "False Street 52 2 A" | NULL             | "San Francisco" | NULL   | "USA" | "24006"       | 19                          | 3000.0         | 1             | "2009-01-01"
"""