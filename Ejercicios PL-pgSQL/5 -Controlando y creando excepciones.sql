-- Enunciados:

-- 12. Mostrar el nombre de un cliente dado su codigo. Controla en caso de que no se encuentre, mostrando un mensaje.
CREATE OR REPLACE FUNCTION obtener_nombre_cliente(codigo integer) RETURNS VOID AS $$
DECLARE
	v_nombre_cliente cliente.nombre_cliente%type;
BEGIN
	SELECT nombre_cliente INTO v_nombre_cliente
	FROM cliente
	WHERE codigo_cliente = codigo;
	RAISE NOTICE 'El nombre del cliente es: %', nombre_cliente;
EXCEPTION 
	WHEN NO_DATA_FOUND THEN
    	RAISE NOTICE 'No se encontró ningún cliente con el código %', codigo;
END;
$$ LANGUAGE plpgsql;


-- 13. Realizar una función que me devuelva la suma de pagos que ha realizado. Pasa el codigo por parametro.  Controla en caso de que no se encuentre, en ese caso devuelve un -1.
CREATE OR REPLACE FUNCTION pagos_clientes(v_codigo integer) 
RETURNS NUMERIC AS $$
DECLARE
    v_sumapagos pago.total%TYPE := 0;
BEGIN
    SELECT SUM(total) into v_sumapagos
    FROM pago
    WHERE codigo_cliente = v_codigo;

    IF v_sumapagos IS NULL THEN
        RAISE NO_DATA_FOUND;
    ELSE
        RETURN v_sumapagos;
    END IF;
    
EXCEPTION 
    WHEN NO_DATA_FOUND THEN
        RETURN RAISE NOTICE 'No se encontró ningún cliente';
END;
$$ LANGUAGE plpgsql

SELECT pagos_clientes(2) -- -1

-- 14. Realizar un método o procedimiento que muestre el total en euros de un pedido, pasale el codigo por parametro. Controla en caso de que no se encuentre, en ese caso devuelve un 0. Pasale otro parametro, si supera ese limite, lanzaremos una excepcion propia y devolveremos un 0.

CREATE OR REPLACE FUNCTION f_total_pedido(v_codigo integer, v_limite integer) 
RETURNS NUMERIC AS $$
DECLARE 
    v_total NUMERIC := 0;
    limite_superado EXCEPTION;
BEGIN
    SELECT SUM(dp.cantidad * dp.precio_unidad)
    INTO v_total
    FROM pedido p
    INNER JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
    WHERE p.codigo_pedido = v_codigo;

    IF v_total IS NULL THEN
        RAISE NOTICE 'NO EXISTE EL PEDIDO CON CÓDIGO %', v_codigo;
        RETURN 0;
    ELSE
        IF v_codigo > v_limite THEN
            RAISE limite_superado;
        ELSE
            RETURN v_total;
        END IF;
    END IF;
   
EXCEPTION 
    WHEN limite_superado THEN
        RAISE NOTICE 'SE HA SUPERADO EL LIMITE DE CÓDIGO DE PEDIDO';
        RETURN 0;
    WHEN NO_DATA_FOUND THEN
        RAISE NOTICE 'NO HAY REGISTROS DE PEDIDOS PARA EL CÓDIGO %', v_codigo;
        RETURN 0;
END;
$$ LANGUAGE plpgsql;


-- Llamar a la función del punto 4: total_pedido

CREATE OR REPLACE FUNCTION total_pedido(v_codigo integer, v_limite integer) 
RETURNS NUMERIC AS $$
DECLARE
    v_codigo_pedido pedido.codigo_pedido%type := v_codigo;
    v_total NUMERIC:=0;
BEGIN
    v_total := f_total_pedido(v_codigo_pedido,v_limite);
	RAISE NOTICE 'El pedido es de: %', v_total;
END;
$$ LANGUAGE plpgsql;