
-- ==========================================================================
-- lineas_estaciones
-- ==========================================================================
ALTER TABLE IF EXISTS public.lineas_estaciones
    ADD CONSTRAINT lineas_estaciones_lineas_fkey FOREIGN KEY (linea_id)
    REFERENCES public.lineas (id_linea) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;

ALTER TABLE IF EXISTS public.lineas_estaciones
    ADD CONSTRAINT lineas_estaciones_estaciones_fkey FOREIGN KEY (estacion_id)
    REFERENCES public.estaciones (id_estacion) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;
-- ==========================================================================
-- trenes
-- ==========================================================================
ALTER TABLE IF EXISTS public.trenes
    ADD CONSTRAINT trenes_lineas_fkey FOREIGN KEY (line_id)
    REFERENCES public.lineas (id_linea) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;

-- ==========================================================================
-- Viajes
-- ==========================================================================
ALTER TABLE IF EXISTS public.viajes
    ADD CONSTRAINT viajes_pasajeros_fkey FOREIGN KEY (id_pasajero)
    REFERENCES public.pasajeros (id_pasajero) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;

ALTER TABLE IF EXISTS public.viajes DROP COLUMN IF EXISTS id_horario_trayecto;
ALTER TABLE IF EXISTS public."horarios-trayectos"
    ADD COLUMN IF NOT EXISTS id_viaje integer NOT NULL;

-- ==========================================================================
-- Horarios trayectos
-- ==========================================================================
ALTER TABLE IF EXISTS public.horarios-trayectos
	ADD CONSTRAINT "horarios-trayectos_pkey" PRIMARY KEY (id_horario_trayecto),
    CONSTRAINT "horarios-trayectos_viajes_fkey" FOREIGN KEY (id_viaje)
        REFERENCES public.viajes (id_viaje) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID

ALTER TABLE IF EXISTS public."horarios-trayectos"
    ADD CONSTRAINT "horarios-trayectos_trenes_fkey" FOREIGN KEY (id_tren)
    REFERENCES public.trenes (id_tren) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."horarios-trayectos" DROP COLUMN IF EXISTS fecha_trayecto;

ALTER TABLE IF EXISTS public."horarios-trayectos"
    ADD COLUMN IF NOT EXISTS id_trayecto integer NOT NULL;
ALTER TABLE IF EXISTS public."horarios-trayectos"
    ADD CONSTRAINT "horarios-trayectos_trayectos_fkey" FOREIGN KEY (id_trayecto)
    REFERENCES public.trayectos (id_trayecto) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;

-- ==========================================================================
-- Trayectos
-- ==========================================================================
ALTER TABLE IF EXISTS public.trayectos
    ADD CONSTRAINT trayectos_estaciones_fkey FOREIGN KEY (estacion_llegada)
    REFERENCES public.estaciones (id_estacion) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;

ALTER TABLE IF EXISTS public.trayectos
    ADD CONSTRAINT trayectos_estaciones_fkey FOREIGN KEY (estacion_salida)
    REFERENCES public.estaciones (id_estacion) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;