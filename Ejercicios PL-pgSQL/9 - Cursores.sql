-- Enunciado:

-- 19. Crear un cursor para ver todos los clientes que no hayan hecho pagos. Hazlo con un loop.
DO $$

DECLARE clientes_sin_pagos CURSOR FOR SELECT nombre_cliente FROM cliente c
WHERE NOT EXISTS (SELECT codigo_cliente FROM pago WHERE codigo_cliente = c.codigo_cliente);

-- Abrir el cursor
OPEN clientes_sin_pagos;

-- Declarar variables para almacenar los valores de las columnas
v_nombre_cliente cliente.nombre_cliente%type;


-- Iterar sobre las filas del cursor
LOOP
  -- Obtener los valores de las columnas en las variables
  FETCH NEXT FROM clientes_sin_pagos INTO v_nombre_cliente;
  
  -- Salir del bucle si no hay más filas
  EXIT WHEN NOT FOUND;
  
  -- imprimirlos en la salida
  RAISE NOTICE 'Nombre del cliente: %,', v_nombre_cliente;
END LOOP;

-- Cerrar el cursor
CLOSE clientes_sin_pagos;

END $$;

"""
- Resultado
+-------------------------------+
|     Nombre del cliente        |
+-------------------------------+
|        Lasas S.A.             |
|   Club Golf Puerta del hierro |
|    DaraDistribuciones         |
|   Madrileña de riegos         |
|        Lasas S.A.             |
|       Flowers, S.A            |
|         Naturajardin          |
| Americh Golf Management SL    |
|            Aloha              |
|           El Prat             |
|       Vivero Humanes          |
|        Fuenla City            |
|         Top Campo             |
|        Campohermoso           |
|       france telecom          |
|       Musée du Louvre         |
|         Flores S.L.           |
|      The Magic Garden         |
+-------------------------------+

"""

-- 20. Crear un cursor para ver todos los clientes que no hayan hecho pagos. Hazlo con un for.

DO $$
DECLARE 
  v_nombre_cliente cliente.nombre_cliente%type;
BEGIN
  -- Iterar sobre los resultados de la consulta utilizando un bucle FOR
  FOR v_nombre_cliente IN 
    SELECT nombre_cliente FROM cliente c
    WHERE NOT EXISTS (SELECT codigo_cliente FROM pago WHERE codigo_cliente = c.codigo_cliente)
  LOOP
    -- Hacer algo con el nombre del cliente
    -- Por ejemplo, imprimirlo en la salida
    RAISE NOTICE 'Nombre del cliente: %', v_nombre_cliente;
  END LOOP;
END $$;

"""
- Resultado
+-------------------------------+
|     Nombre del cliente        |
+-------------------------------+
|        Lasas S.A.             |
|   Club Golf Puerta del hierro |
|    DaraDistribuciones         |
|   Madrileña de riegos         |
|        Lasas S.A.             |
|       Flowers, S.A            |
|         Naturajardin          |
| Americh Golf Management SL    |
|            Aloha              |
|           El Prat             |
|       Vivero Humanes          |
|        Fuenla City            |
|         Top Campo             |
|        Campohermoso           |
|       france telecom          |
|       Musée du Louvre         |
|         Flores S.L.           |
|      The Magic Garden         |
+-------------------------------+

"""