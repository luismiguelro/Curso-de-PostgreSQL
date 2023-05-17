-- Enunciado:

"""
15. crea una funcion a la que le pasaremos como parametros de entrada: MATRICULA, NUEVO_PRECIO_COMPRA. lA FUNCION MODIFICARA LOS DATOS DEL COCHE QUE TENGA LA MATRICULA INTRODUCIDA ACTUALIZANDO EL PRECIO_COMPRA DE LA SIGUIENTE FORMA:

-Si precio_compra es nulo= hacer un update en el campo precio_compra asignandole el valor de nuevo_precio_compra

-Si no= hacer un update en el campo precio_compra asignandole el valor de precio_compra+(precio_compra-nuevo_precio_compra)

la funcion devolvera el numero de filas actualizadas
crea un bloque anonimo que ejecute la funcion anterior y muestre el resultado devuelto por la funcion
"""
CREATE OR REPLACE FUNCTION actualizada_precio_coche(v_matricula VARCHAR, nuevo_precio_compra NUMERIC) 
RETURNS NUMERIC AS $$
DECLARE
   -- Variable compra
   v_precio_compra coche.precio_compra%TYPE;
	v_filas_actualizadas INTEGER;
BEGIN
   -- Consulta
   SELECT precio_compra INTO v_precio_compra
   FROM coche 
   WHERE matricula = v_matricula;

   -- Validar
   IF v_precio_compra IS NULL THEN
      UPDATE coche SET precio_compra = nuevo_precio_compra 
      WHERE matricula = v_matricula;
	    v_filas_actualizadas := 1;
   ELSE
      -- Asignar nuevo valor
      UPDATE coche SET precio_compra = precio_compra + (precio_compra - nuevo_precio_compra) 
      WHERE matricula = v_matricula;
	    v_filas_actualizadas := 1;
   END IF;

   -- Filas actualizadas
   RETURN v_filas_actualizadas;
END;
$$ LANGUAGE plpgsql;

-- Ejemplo con null
SELECT actualizada_precio_coche ('3346GVA',3000)

"""
matricula | descripcion    | id_marca | precio_compra
-----------+----------------+----------+---------------
3346GVA   | C4 Exclusive   | 3        | null        
3346GVA   | C4 Exclusive   | 3        | 3000
"""

-- Ejemplo de auto con precio
SELECT actualizada_precio_coche ('5689ADD',4000)
"""
matricula | descripcion    | id_marca | precio_compra
-----------+----------------+----------+---------------
5689ADD   | Golf GTI   | 7        | 3000       
5689ADD   | Golf GTI   | 7        | 2000

"""

