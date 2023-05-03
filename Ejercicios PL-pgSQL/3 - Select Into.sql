-- 7. Mostrar el nombre de un cliente dado su codigo.
CREATE OR REPLACE FUNCTION obtener_nombre_cliente(codigo integer) RETURNS void AS $$
DECLARE
	v_nombre_cliente cliente.nombre_cliente%type;
BEGIN
	SELECT nombre_cliente INTO v_nombre_cliente
	FROM cliente
	WHERE codigo_cliente = codigo;
	RAISE NOTICE 'El nombre del cliente es: %', v_nombre_cliente;
END;
$$ LANGUAGE plpgsql;


    -- Ejecutar esta función
    SELECT obtener_nombre_cliente(3); -- El nombre del cliente es: Gardening Associates 

    
-- 8. Mostrar el precioVenta y la gama de un producto dado su codigo.

CREATE OR REPLACE FUNCTION obtener_nombre_product(codigo varchar) 
RETURNS TABLE (nombre_producto text, gama_producto text) AS $$
DECLARE
	v_nombre_producto  producto.nombre%type;
	v_gama_producto producto.gama%type;
BEGIN
	SELECT nombre, gama INTO v_nombre_producto, v_gama_producto
	FROM producto
	WHERE codigo_producto = codigo;

	RAISE NOTICE 'El nombre del producto es: % y su gama es: %', v_nombre_producto, v_gama_producto;
END;
$$ LANGUAGE plpgsql;
-- 9. Mostrar toda la informacion de un pedido dado su codigo (fechaEsperada, fechaEntrega, fechapedido, estado, comentarios)