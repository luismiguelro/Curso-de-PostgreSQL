
-- - Enunciado:

-- 16. Crea procedimiento que reciba como parametros de entrada:P_ID_MARCA,P_NUMERO_COCHES. Utiliza un bucle para insertar N registros nuevos en la tabla COCHE. El numero de registros a insertar viene indicado por el parametro P_NUMEROS_COCHES(CONTADOR) y el bucle empezará en 1, los datos a insertar seran:

"""
-matricula='A00'||CONTADOR
-DESCRIPCION=p_id_marca
-id_marca=p_id_marca
-precio_compra=nulo

Controlar excepcion para cuando exista algun coche en la bbdd y se viole la pk
"""

CREATE OR REPLACE PROCEDURE ps_crear_coche(p_id_marca INTEGER, p_numero_coche NUMERIC)
AS $$
BEGIN
    FOR contador IN 1..p_numero_coche LOOP
        BEGIN
            INSERT INTO coche (matricula, descripcion, id_marca, precio_compra)
            VALUES ('BB00 ' || contador, contador, p_id_marca, null);
        EXCEPTION
            WHEN unique_violation THEN
                RAISE NOTICE 'Error: Violación de restricción única en la columna matricula';
        END;
    END LOOP;
END;
$$ LANGUAGE plpgsql;



-- Ejecutar

DO $$
DECLARE
    p_id_marca INTEGER := 1; -- Cambia el valor según tus necesidades
    p_numero_coche NUMERIC := 5; -- Cambia el valor según tus necesidades
BEGIN
    CALL ps_crear_coche(p_id_marca, p_numero_coche);
    RAISE NOTICE 'Procedimiento ejecutado correctamente';
END;
$$;

-- Resultado:
"""
matricula | descripcion    | id_marca | precio_compra
-----------+----------------+----------+---------------
BB001     |       1        |     1    | null       
BB002     |       2        |     1    | null
BB003     |       3        |     1    | null
BB004     |       4        |     1    | null
BB005     |       5        |     1    | null
"""
-- Resultado en caso de ejecutar otra vez: NOTICE:  Error: Violación de restricción única en la columna matricula

"""