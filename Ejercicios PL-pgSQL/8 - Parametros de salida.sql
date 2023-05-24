-- Enunciado

--17.Crea un procedimiento al que le pasaremos el dni_cliente y la matricula. El procedimiento debera controlar en las ventas de los coches(tabla vende) los siguientes supuestos:

"""
A.SI NO EXISTE UN REGISTRO CON ESE DNI_CLIENTE Y ESA MATRICULA SALTARA A LA ZONA DE EXCEPCIONES Y MOSTRARA UN MENSAJE
 "NO EXISTE LA VENTA INTRODUCIDA"
 B.SI EXISTE LA VENTA INTRODUCIDA:
  I.MOSTRARA EL PRECIO ANTIGUO ||
  II.ACTUALIZARA EL PRECIO SUBIENDO 1000 EUROS
  III. DEVOLVERA EN UN PARAMETRO DE SALIDA DEL PROCEDIMIENTO(PS_NUEVO_PRECIO) EL PRECIO NUEVO TRAS LA ACTUALIZACION
CREA UN BLOQUE ANONIMO QUE LLAME AL PROCEDIMIENTO ANTERIOR Y MUESTRE EL PRECIO NUEVO DEVUELTO POR EL PROCEDIMIENTO.
"""

-- Procedimiento

CREATE OR REPLACE PROCEDURE actualiza_venta(v_dni_cliente VARCHAR, v_matricula VARCHAR, INOUT ps_nuevo_precio NUMERIC)
AS $$
DECLARE
    venta vende%rowtype;
BEGIN
    SELECT * INTO venta
    FROM vende
    WHERE dni_cliente = v_dni_cliente;

    RAISE NOTICE 'precio antiguo: %', venta.precio;

    ps_nuevo_precio := venta.precio + 1000;

    UPDATE vende SET precio = ps_nuevo_precio
    WHERE dni_cliente = v_dni_cliente;

EXCEPTION
    WHEN no_data_found THEN
        RAISE NOTICE 'NO EXISTE LA VENTA INTRODUCIDA';
END;
$$ LANGUAGE plpgsql;

-- Bloque anonimo (existente)

DO $$
DECLARE
    v_nuevo_precio NUMERIC;
BEGIN
    -- Llamar al procedimiento almacenado y obtener el nuevo precio
    call actualiza_venta('07541212F', '3345GVF', v_nuevo_precio);
    IF v_nuevo_precio IS NOT NULL THEN

        -- Imprimir el nuevo precio obtenido
        RAISE NOTICE 'Nuevo precio: %', v_nuevo_precio;
    END IF;

END;
$$;

-- Resultado

"""
NOTICE:  precio antiguo: 7000
NOTICE:  Nuevo precio: 8000
"""

-- Bloque anonimo (no existente)
DO $$
DECLARE
    v_nuevo_precio NUMERIC;
BEGIN
    -- Llamar al procedimiento almacenado y obtener el nuevo precio
    call actualiza_venta('11111', '311111', v_nuevo_precio);
    IF v_nuevo_precio IS NOT NULL THEN

        -- Imprimir el nuevo precio obtenido
        RAISE NOTICE 'Nuevo precio: %', v_nuevo_precio;
    END IF;

END;
$$;

-- Resultado
-- RAISE NOTICE 'NO EXISTE LA VENTA INTRODUCIDA';


