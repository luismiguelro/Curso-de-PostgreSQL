-- Enunciado:

-- 20. Crear un cursor para ver todos los productos pedidos en un pedido. Muestra la cantidad tambien.

CREATE OR REPLACE PROCEDURE mostrarProductosPedidos(p_codigo_pedido pedido.codigo_pedido%type)
AS $$
    DECLARE prod_pedido CURSOR IS 
    SELECT p.nombre,dp.cantidad
    FROM producto p, detalle_pedido dp
    WHERE p.codigo_producto = dp.codigo_producto
    AND dp.codigo_pedido = p_codigo_pedido;
BEGIN
    FOR registro in prod_pedido LOOP
         RAISE NOTICE 'Se ha pedido del producto %: % unidades.', registro.nombre,registro.cantidad;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Llamarlo
DO $$
DECLARE
   p_codigo_pedido INTEGER := 1; -- Cambia el valor según tus necesidades
BEGIN
    CALL mostrarProductosPedidos(p_codigo_pedido);
END;
$$

-- Resultado
    """
    NOTICE:  Se ha pedido del producto Cerezo: 10 unidades.
    NOTICE:  Se ha pedido del producto Camelia japonica: 40 unidades.
    NOTICE:  Se ha pedido del producto Pitimini rojo: 25 unidades.
    NOTICE:  Se ha pedido del producto Phoenix Canariensis: 15 unidades.
    NOTICE:  Se ha pedido del producto Mimosa DEALBATA Gaulois Astier: 23 unidades.
    """
-- 21. Crear un cursor para ver todos los empleados de un jefe.

CREATE OR REPLACE PROCEDURE mostrarEmpleadosJef(p_codigo_jefe empleado.codigo_jefe%type)
AS $$
DECLARE
    empleado_jefe CURSOR IS
    SELECT em.nombre || ' ' || em.apellido1 || ' ' || em.apellido2 AS nombre_empleado
    FROM empleado em, empleado jefe
    WHERE em.codigo_jefe = jefe.codigo_empleado
    AND jefe.codigo_empleado = p_codigo_jefe;

    v_nombre_jefe VARCHAR;
	
BEGIN
    SELECT nombre || ' ' || apellido1 || ' ' || apellido2 INTO v_nombre_jefe
    FROM empleado
    WHERE codigo_empleado = p_codigo_jefe;
	RAISE NOTICE 'El jefe llamado % :  tiene a cargo a los siguientes empleados', v_nombre_jefe;
    
	FOR registro IN empleado_jefe LOOP
        RAISE NOTICE '-%',registro.nombre_empleado;
    END LOOP;

EXCEPTION WHEN NO_DATA_FOUND THEN
    RAISE NOTICE 'NO EXISTE';
END;
$$ LANGUAGE plpgsql;

-- Llamarlo
DO $$
DECLARE
   p_codigo_jefe INTEGER := 3; -- Cambia el valor según tus necesidades
BEGIN
    CALL mostrarEmpleadosJefe(p_codigo_jefe);
END;
$$

-- Resultado
"""
NOTICE:  El jefe llamado Alberto Soria Carrasco tiene a cargo a los siguientes empleados: Felipe Rosas Marquez, Juan Carlos Ortiz Serrano, Carlos Soria Jimenez, Emmanuel Magaña Perez, Francois Fignon , Michael Bolton , Hilary Washington , Nei Nishikori , Amy Johnson , Kevin Fallmer 
DO
"""