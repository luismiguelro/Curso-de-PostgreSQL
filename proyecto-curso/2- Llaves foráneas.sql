
-- ==========================================================================
-- llave foranea de id_estacion a la tabla trayectos
-- ==========================================================================
ALTER TABLE public.trayecto
    ADD CONSTRAINT trayecto_estacion_fkey FOREIGN KEY (id_estacion)
    REFERENCES public.estacion (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;

-- ==========================================================================
-- llave foranea de id_tren a la tabla trayectos
-- ==========================================================================
ALTER TABLE public.trayecto
    ADD CONSTRAINT trayecto_tren_fkey FOREIGN KEY (id_tren)
    REFERENCES public.tren (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;

-- ==========================================================================
-- llave foranea de id_trayecto a la tabla viajes
-- ==========================================================================
ALTER TABLE public.viaje
    ADD CONSTRAINT viaje_trayecto_fkey FOREIGN KEY (id_trayecto)
    REFERENCES public.trayecto (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;
-- ==========================================================================
-- llave foranea de id_pasajero a la tabla viajes
-- ==========================================================================
ALTER TABLE public.viaje
    ADD CONSTRAINT viaje_pasajero_fkey FOREIGN KEY (id_pasajero)
    REFERENCES public.pasajero (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;

-- ==========================================================================
-- Borrar alguna llave foranea por algun error
-- ==========================================================================
ALTER TABLE public.viaje DROP CONSTRAINT viaje_trayecto_fkey;