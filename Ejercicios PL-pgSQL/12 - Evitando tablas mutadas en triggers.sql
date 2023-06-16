-- - Enunciado:
"""
23 .Crea un trigger que al actualizar la columna fechaentrega de pedidos la compare con la fechaespera.
Si fechaentrega es menor que fechaespera añadir a los comentarios 'Pedido entregado antes de lo esperado'.
Si fechaentrega es mayor que fechaespera añadir a los comentarios 'Pedido entregado con retraso'.
"""

--Funcion
CREATE OR REPLACE FUNCTION actualizar_comentario_pedidos()
RETURNS TRIGGER AS $$
BEGIN
   IF new.fecha_entrega > old.fecha_esperada THEN
         new.comentarios := old.comentarios || ' Pedido entregado con retraso';
   ELSE
         new.comentarios := old.comentarios || ' Pedido entregado antes de lo esperado';
   END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER tr_actualizar_comentario_pedidos
BEFORE UPDATE OF fecha_entrega
ON pedido
FOR EACH ROW
EXECUTE FUNCTION actualizar_comentario_pedidos();

-- Resultado

-- Consulta antes de actulizar

"""
9	"2008-12-22"	"2008-12-27"	"2008-12-26"	"Entregado"	"El cliente comprueba la integridad del paquete, todo correcto"
"""

--Actualizar
UPDATE pedido SET fecha_entrega =('2008-12-30') WHERE codigo_pedido = 9;
-- Despues de ejecutarse el trigger

"""
9	"2008-12-22"	"2008-12-27"	"2008-12-30"	"Entregado "El cliente comprueba la integridad del paquete, todo correcto Pedido entregado antes de lo esperado Pedido entregado con retraso"

"""


