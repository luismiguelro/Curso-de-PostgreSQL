-- Enunciado:

-- 22. Trigger para actualizar el stock de productos despues de insertar en la tabla de detallepedidos.

CREATE OR REPLACE FUNCTION actualizar_stock()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE producto
    SET cantidad_en_stock = cantidad_en_stock - NEW.cantidad
    WHERE codigo_producto = NEW.codigo_producto;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_productos_actualiza_stock
AFTER INSERT ON detalle_pedido
FOR EACH ROW
EXECUTE FUNCTION actualizar_stock();


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

-- Volvemos a realizar la consulta, y obtenemos que
"""
codigo_productov | nombre                | cantidad_en_stock |
-----------------+-----------------------+-------------------+
FR-4             | Naranjo calibre 8/10  | 5                 |       
"""
