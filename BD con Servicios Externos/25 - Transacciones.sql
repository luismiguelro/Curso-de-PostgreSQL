"""
Transacciones: Procesos complejo seguros
- Commit: Si llegamos al final devuelva todos los cambios
- Rollback: Si algo fallo que devuelva todo lo que hicimos

BEGIN
<consultas>
COMMIT | ROLLBACK
"""

-- Si todo va correctamente hace commit
BEGIN;
INSERT INTO cliente VALUES (39,'GoldFish Garden 2','Daniel G','GoldFish','5556901745','5556901746','False Street 52 2 A',NULL,'San Francisco',NULL,'USA','24006',19,3000);

INSERT INTO producto VALUES ('ORR-100','Mimosa DEALBATA Gaulois Astier  ','Ornamentales','200-225','Viveros EL OASIS','Acacia dealbata. Nombre común o vulgar: Mimosa fina, Mimosa, Mimosa común, Mimosa plateada, Aromo francés. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floración amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento rápido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constreñidos entre las semillas, que se disponen en el fruto longitudinalmente...',100,14,11);

COMMIT;

-- si alguna de ellas falla, el id ya existe. Vuelve donde nos quedamos antes de Begin.

BEGIN;
INSERT INTO cliente VALUES (1,'GoldFish Garden 2','Daniel G','GoldFish','5556901745','5556901746','False Street 52 2 A',NULL,'San Francisco',NULL,'USA','24006',19,3000);
INSERT INTO producto VALUES ('ORR-101','Mimosa DEALBATA Gaulois Astier  ','Ornamentales','200-225','Viveros EL OASIS','Acacia dealbata. Nombre común o vulgar: Mimosa fina, Mimosa, Mimosa común, Mimosa plateada, Aromo francés. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floración amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento rápido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constreñidos entre las semillas, que se disponen en el fruto longitudinalmente...',100,14,11);

ROLLBACK;

-- Error:
-- ERROR:  llave duplicada viola restricción de unicidad «cliente_pkey» DETAIL:  Ya existe la llave (codigo_cliente)=(1). SQL state: 23505


-- Función SAVEPOINT
BEGIN;
INSERT INTO cliente
VALUES (40,'GoldFish Garden 3','Daniel G','GoldFish','5556901745','5556901746','False Street 52 2 A',NULL,'San Francisco',NULL,'USA','24006',19,3000);

SAVEPOINT clienteadd;

UPDATE public.producto
SET gama = 'Frutales'
WHERE codigo_producto = 'ORR-101';

ROLLBACK TO SAVEPOINT clienteadd;

COMMIT;