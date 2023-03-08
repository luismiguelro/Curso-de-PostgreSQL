-- ==========================================================================
-- Trenes
-- ==========================================================================

CREATE TABLE public.tren
(
id serial,
modelo character varying(20),
capacidad character varying,
CONSTRAINT tren_pkey PRIMARY KEY (id)
)
WITH (
OIDS = FALSE
);

ALTER TABLE public.tren
OWNER to postgres;

-- ==========================================================================
-- Estación
-- ==========================================================================

CREATE TABLE public.estacion
(
id serial,
nombre character varying,
direccion character varying,
CONSTRAINT estacion_pkey PRIMARY KEY (id)
)
WITH (
OIDS = FALSE
);

ALTER TABLE public.estacion
OWNER to postgres;

-- ==========================================================================
-- Trayecto
-- ==========================================================================

CREATE TABLE public.trayecto
(
id serial,
id_estacion integer,
id_tren integer,
nombre character varying,
CONSTRAINT trayecto_pkey PRIMARY KEY (id)
)
WITH (
OIDS = FALSE
);


ALTER TABLE public.trayecto
OWNER to postgres;

-- ==========================================================================
-- Viaje
-- ==========================================================================

CREATE TABLE public.viaje
(
id serial,
id_pasajero integer,
id_trayecto integer,
inicio date,
fin date,
CONSTRAINT viaje_pkey PRIMARY KEY (id)
)
WITH (
OIDS = FALSE
);

ALTER TABLE public.viaje
OWNER to postgres;