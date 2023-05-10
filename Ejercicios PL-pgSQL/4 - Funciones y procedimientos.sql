-- Enunciados:

-- 10. Realizar una función que me devuelva la suma de pagos que ha realizado. Pasa el codigo por parametro.

CREATE OR REPLACE FUNCTION pagos_clientes(v_codigo integer) 
RETURNS NUMERIC AS $$
DECLARE
    -- sumar pagos
	v_sumapagos pago.total%type :=0;
BEGIN
	SELECT SUM(total) into v_sumapagos
    FROM pago
    WHERE codigo_cliente = v_codigo;

	RETURN v_sumapagos;
END;
$$ LANGUAGE plpgsql;


SELECT pagos_clientes(4) -- 81849.00


-- 11. Realizar un método que muestre el total en euros de un pedido, pasale el codigo por parametro.

CREATE OR REPLACE FUNCTION total_pedido(v_codigo integer) 
RETURNS NUMERIC AS $$
DECLARE
    v_codigo_pedido pedido.codigo_pedido%type := v_codigo;
    v_suma_pago pago.total%type;
BEGIN
   v_suma_pago := pagos_clientes(v_codigo_pedido);

   RAISE NOTICE 'La suma del pago es: %', v_suma_pago;
   
   RETURN v_suma_pago;
END;

$$ LANGUAGE plpgsql;


SELECT total_pedido (3) -- La suma del pago es: 10926.00

-- 11.2 Realizar un procedimiento que muestre el total en euros de un pedido, pasale el codigo por parametro.

CREATE OR REPLACE PROCEDURE ps_total_pedido(v_codigo integer) 
AS $$
   DECLARE 
    v_total NUMERIC:=0;
BEGIN
    SELECT SUM(dp.cantidad * dp.precio_unidad) INTO v_total
    FROM pedido p, detalle_pedido dp
    WHERE p.codigo_pedido = dp.codigo_pedido AND p.codigo_pedido = v_codigo;

   RAISE NOTICE 'El pedido total es: %', v_total;
   
END;

$$ LANGUAGE plpgsql;

CALL ps_total_pedido (15) -- NOTICE:  El pedido total es: 214.00