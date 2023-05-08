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

SELECT obtener_nombre_product('11679');-- NOTICE:  El nombre del producto es: Sierra de Poda 400MM y su gama es: Herramientas

-- 9. Mostrar toda la informacion de un pedido dado su codigo (fechaEsperada, fechaEntrega, fechapedido, estado, comentarios)

CREATE OR REPLACE FUNCTION obtener_info_pedido(codigo integer) 
RETURNS VOID AS $$
DECLARE
	v_codigo_pedido  pedido.codigo_pedido%type;
	-- rowtype: recorrer tabla
	v_pedido pedido%rowtype;
BEGIN
	SELECT n* INTO v_pedido
	FROM pedido
	WHERE pedido.codigo_pedido = codigo;

	RAISE NOTICE 'La fecha del pedido es: %, la fecha esperada es: %, y la fecha de entrega fue: %, el estado del pedido es: %, y los comentarios fueron: %', v_pedido.fecha_pedido, v_pedido.fecha_esperada, v_pedido.fecha_entrega, v_pedido.estado, v_pedido.comentarios;
END;
$$ LANGUAGE plpgsql;

SELECT obtener_info_pedido(8); -- NOTICE:  La fecha del pedido es: 2008-11-09, la fecha esperada es: 2008-11-14, y la fecha de entrega fue: 2008-11-14, el estado del pedido es: Entregado, y los comentarios fueron: El cliente paga la mitad con tarjeta y la otra mitad con efectivo, se le realizan dos facturas