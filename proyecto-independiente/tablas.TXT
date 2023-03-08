-- ==========================================================================
-- Pasajeros
-- ==========================================================================
CREATE TABLE public.pasajeros
(
    id_pasajero serial NOT NULL,
    nombre character varying(50) NOT NULL,
    apellidos character varying(50) NOT NULL,
    direccion character varying(100) NOT NULL,
    actualiazada timestamp with time zone NOT NULL,
    CONSTRAINT pasajeros_pkey PRIMARY KEY (id_pasajero)
)
WITH (
    OIDS = FALSE
);

ALTER TABLE IF EXISTS public.pasajeros
    OWNER to postgres;

-- ==========================================================================
-- Viajes
-- ==========================================================================
CREATE TABLE public.viajes
(
    id_viaje serial NOT NULL,
    id_horario_trayecto serial NOT NULL,
    id_pasajero serial NOT NULL,
    actualiazada timestamp with time zone NOT NULL,
    CONSTRAINT viajes_pkey PRIMARY KEY (id_viaje)
)
WITH (
    OIDS = FALSE
);

ALTER TABLE IF EXISTS public.viajes
    OWNER to postgres;

-- ==========================================================================
-- Horarios Trayectos
-- ==========================================================================
CREATE TABLE public."horarios-trayectos"
(
    id_horario_trayecto serial NOT NULL,
    id_tren serial NOT NULL,
    fecha_trayecto date NOT NULL,
    actualiazada timestamp with time zone NOT NULL,
    CONSTRAINT "horarios-trayectos_pkey" PRIMARY KEY (id_horario_trayecto)
)
WITH (
    OIDS = FALSE
);

ALTER TABLE IF EXISTS public."horarios-trayectos"
    OWNER to postgres;

-- ==========================================================================
-- Trayectos
-- ==========================================================================
CREATE TABLE public.trayectos
(
    id_trayecto serial NOT NULL,
    nombre character varying(20) NOT NULL,
    estacion_llegada serial NOT NULL,
    estacion_salida serial NOT NULL,
    actualizada timestamp with time zone NOT NULL,
    CONSTRAINT trayectos_pkey PRIMARY KEY (id_trayecto)
)
WITH (
    OIDS = FALSE
);

ALTER TABLE IF EXISTS public.trayectos
    OWNER to postgres;

-- ==========================================================================
-- Estaciones
-- ==========================================================================
CREATE TABLE public.estaciones
(
    id_estacion serial NOT NULL,
    id_linea serial NOT NULL,
    nombre character varying(20) NOT NULL,
    direccion point NOT NULL,
    actualiazada timestamp with time zone NOT NULL,
    CONSTRAINT estaciones_pkey PRIMARY KEY (id_estacion)
)
WITH (
    OIDS = FALSE
);

ALTER TABLE IF EXISTS public.estaciones
    OWNER to postgres;

-- ==========================================================================
-- Trenes
-- ==========================================================================
CREATE TABLE public.trenes
(
    id_tren serial NOT NULL,
    line_id serial NOT NULL,
    tipo character varying(15) NOT NULL,
    "año" integer NOT NULL,
    actualiazada timestamp with time zone NOT NULL,
    CONSTRAINT trenes_pkey PRIMARY KEY (id_tren)
)
WITH (
    OIDS = FALSE
);

ALTER TABLE IF EXISTS public.trenes
    OWNER to postgres;
-----------------------------
CREATE TABLE public.lineas
(
    id_linea serial NOT NULL,
    nombre character varying NOT NULL,
    actualizada timestamp with time zone NOT NULL,
    CONSTRAINT lineas_pkey PRIMARY KEY (id_linea)
)
WITH (
    OIDS = FALSE
);

ALTER TABLE IF EXISTS public.lineas
    OWNER to postgres;
-- ==========================================================================
-- Lineas Estaciones
-- ==========================================================================
CREATE TABLE public.lineas_estaciones
(
    id serial NOT NULL,
    linea_id serial NOT NULL,
    estacion_id serial NOT NULL,
    actualiazada timestamp with time zone NOT NULL,
    CONSTRAINT lineas_estaciones_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
);

ALTER TABLE IF EXISTS public.lineas_estaciones
    OWNER to postgres;