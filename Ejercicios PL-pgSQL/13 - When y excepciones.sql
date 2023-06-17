-- Enunciados
"""
24. Modifica el anterior: (12 - Evitando tablas mutadas en triggers), pero solo se ejecute si fecha_entrega es mayor que fecha_espera.

25. Modifica el trigger del -EJERCICIO: (11-Trigger actualiza stock.sql)-  si el stock que vamos a modificar se queda a cero o menor, devolver una excepcion ORA.
"""

-- 24
--Funcion
CREATE OR REPLACE FUNCTION actualizar_comentario_pedidos()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.fecha_entrega IS NOT NULL AND NEW.fecha_entrega > OLD.fecha_esperada THEN
        NEW.comentarios := OLD.comentarios || ' Pedido entregado con retraso';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER tr_actualizar_comentario_pedidos
BEFORE UPDATE OF fecha_entrega
ON pedido
FOR EACH ROW
WHEN (NEW.fecha_entrega IS NOT NULL AND NEW.fecha_entrega > OLD.fecha_esperada)
EXECUTE FUNCTION actualizar_comentario_pedidos();


-- Resultado

-- Consulta antes de actulizar

"""
119	"2009-01-10"	"2009-01-15"	"2009-01-15"	"El pedido llego perfectamente"
"""

--Actualizar
UPDATE pedido SET fecha_entrega =('2008-01-20') WHERE codigo_pedido = 119;
-- Despues de ejecutarse el trigger

"""
119	"2009-01-10"	"2009-01-15"	"2009-01-20"	"El pedido llego perfectamente Pedido entregado con retraso"

"""


-- 25
CREATE OR REPLACE FUNCTION fr_actualizar_stock()
RETURNS TRIGGER AS $$
DECLARE
    v_stock_actual producto.cantidad_en_stock;
BEGIN
    SELECT cantidad_en_stock INTO v_stock_actual 
    FROM producto
    WHERE codigo_producto = NEW.codigo_producto;

    -- Validar
    IF v_stock_actual - NEW.cantidad > 0 THEN
        UPDATE producto
        SET cantidad_en_stock = cantidad_en_stock - NEW.cantidad
        WHERE codigo_producto = NEW.codigo_producto;
    ELSE
        RAISE EXCEPTION 'NO HAY SUFICIENTE STOCK';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER productos_actualiza_stock_tr
BEFORE INSERT ON detalle_pedido
FOR EACH ROW
EXECUTE FUNCTION fr_actualizar_stock();


-- PRUEBA Y RESULTADO

-- Al realizar la consulta, tenemos que
SELECT codigo_producto, nombre,cantidad_en_stock 
FROM producto WHERE codigo_producto = 'FR-4';

"""
codigo_productov | nombre                | cantidad_en_stock |
-----------------+-----------------------+-------------------+
FR-4             | Naranjo calibre 8/10  | 15                |       
"""

-- Al realizar un nuevo insert
INSERT INTO detalle_pedido values (1,'FR-4',10,10,6);

-- Respuesta
"""
ERROR:  NO HAY SUFICIENTE STOCK
CONTEXT:  función PL/pgSQL fr_actualizar_stock() en la línea 15 en RAISE
SQL state: P0001
"""