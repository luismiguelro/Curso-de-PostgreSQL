CREATE OR REPLACE FUNCTION sp_tr_test() RETURNS TRIGGER
AS $$
BEGIN
	INSERT INTO "trigger_actualizar"

     -- Accion del trigger. new: nueva informacion, old: informacion actual
	VALUES (old.codigo_cliente,OLD.nombre_cliente,OLD.nombre_contact,OLD.pais);
	
      -- Utiliza NEW en lugar de OLD para que el trigger se ejecute correctamente
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

-- CREAR EL TRIGGER EN LA TABLA: practica_trigger
CREATE TRIGGER trr_update BEFORE UPDATE ON practica_trigger
FOR EACH ROW
EXECUTE PROCEDURE sp_tr_test();