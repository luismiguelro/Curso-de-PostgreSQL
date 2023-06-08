-- Practica Trigger
CREATE TABLE IF NOT EXISTS public.practica_trigger
(
    codigo_cliente integer NOT NULL,
    nombre_cliente character varying COLLATE pg_catalog."default",
    nombre_contact character varying COLLATE pg_catalog."default",
    pais character varying COLLATE pg_catalog."default",
    CONSTRAINT practica_trigger_pkey PRIMARY KEY (codigo_cliente)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.practica_trigger
    OWNER to postgres;

-- Tabla en la que se migra al ejecutar el trigger
CREATE TABLE IF NOT EXISTS public.trigger_actualizar
(
    codigo_cliente integer,
    nombre_cliente character varying(50) COLLATE pg_catalog."default",
    nombre_contact character varying(50) COLLATE pg_catalog."default",
    pais character varying(50) COLLATE pg_catalog."default"
)

TABLESPACE pg_default;