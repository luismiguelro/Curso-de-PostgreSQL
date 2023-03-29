
INSERT INTO lineas_estaciones (linea_id, estacion_id) VALUES(
-- LINEA A
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Acevedo')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Aguacatala')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Alpujarra')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Ayurá')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Bello')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Caribe')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Exposiciones')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Envigado')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Hospital')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Industriales')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Itagui')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'La Estrella')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Madera')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Niquia')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Parque Berrio')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Poblado')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Prado')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Sabaneta')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'San Antonio')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Tricentenario')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea A'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Universidad')
),
-- LINEA B
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea B'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Estadio')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea B'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Floresta')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea B'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'San Antonio')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea B'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'San Javier')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea B'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Santa Lucia')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea B'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Suramericana')
),
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea B'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'Cisneros')
),
-- LINEA J
(
    (SELECT id_linea FROM lineas WHERE nombre = 'Linea J'),
    (SELECT id_estacion FROM estaciones WHERE nombre = 'San Javier')
),
(
	(SELECT id_linea FROM lineas WHERE nombre = 'Linea J'),
	(SELECT id_estacion FROM estaciones WHERE nombre = 'Juan XXIII')
),
(
	(SELECT id_linea FROM lineas WHERE nombre = 'Linea J'),
	(SELECT id_estacion FROM estaciones WHERE nombre = 'Vallejuelos')
),
(
	(SELECT id_linea FROM lineas WHERE nombre = 'Linea J'),
	(SELECT id_estacion FROM estaciones WHERE nombre = 'La Aurora')
),
-- LINEA K
	(
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea K')
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Acevedo')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea K'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Andalucia')
    ),
    (
		(SELECT id_linea  FROMlineas` WHEREnombre` = 'Linea K'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Popular')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea K'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Santo Domingo')
    ),
    -- LINEA L
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea L'),
		(SELECT id_estacion FROM estaciones WHERE nombre  = 'Santo Domingo')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea L'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Arvi')
    ),
    
    -- LINEA H
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea H'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Oriente')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea H'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Las Torres')
    ),
     (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea H'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Villa Sierra')
    ),
    
    -- LINEA M
     (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea M'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Miraflores')
    ),
     (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea M'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'El Pinal')
    ),
     (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea M'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Trece de Noviembre')
    ),
    
    -- LINEA P
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea P'),
		(SELECT id_estacion FROM estaciones WHERE nombre= 'Acevedo')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea P'),
		(SELECT id_estacion FROM estaciones WHERE nombre= 'Doce de Octubre')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea P'),
		(SELECT id_estacion FROM estaciones WHERE nombre= 'El Progreso')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea P'),
		(SELECT id_estacion FROM estaciones WHERE nombre= 'SENA')
    ),
    
    -- LINEA T
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea T'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'San Antonio')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea T'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'San Jose')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea T'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Pabellón del Agua EPM')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea T'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Bicentenario')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea T'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Buenos Aires')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea T'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Miraflores')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea T'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Loyola')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea T'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Alejandro Echavarria')
    ),
      (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea T'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Oriente')
    ),
    
    -- LINEA 1
      (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea 1'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Universidad de Medellín')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea 1'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Los Alpes')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea 1'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'La Palma')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea 1'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Parque de Belen')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea 1'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Rosales')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea 1'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Fátima')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea 1'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Nutibara')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea 1'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Industriales')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea 1'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Plaza Mayor')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea 1'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Cisneros')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea 1'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Minorista')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea 1'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Chagualo')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea 1'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Ruta N - U de A')
    ),
        (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea 1'),
		(SELECT id_estacion FROM estaciones WHERE nombre = 'Hospital')
    ),
        (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea 1'),
		(SELECT id_estacion FROM estaciones WHERE nombre ='Palos Verdes')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea 1'),
		(SELECT id_estacion FROM estaciones WHERE nombre ='Gardel')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea 1'),
		(SELECT id_estacion FROM estaciones WHERE nombre ='Manrique')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea 1'),
		(SELECT id_estacion FROM estaciones WHERE nombre ='Las Esmeraldas')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea 1'),
		(SELECT id_estacion FROM estaciones WHERE nombre ='Berín')
    ),
    (
		(SELECT id_linea FROM lineas WHERE nombre = 'Linea 1'),
		(SELECT id_estacion FROM estaciones WHERE nombre ='Parque de Aranjuez')
    ),
    
    -- LINEA 2
    (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre = 'Universidad de Medellín')
    ),
    (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre = 'Los Alpes')
    ),
    (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre = 'La Palma')
    ),
    (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre = 'Parque de Belen')
    ),
    (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre = 'Rosales')
    ),
    (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre = 'Fátima')
    ),
    (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre = 'Nutibara')
    ),
    (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre = 'Industriales')
    ),
    (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre ='Palos Verdes')
    ),
    
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre ='Gardel'
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre ='Manrique')
    ),
    (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre ='Las Esmeraldas')
    ),
    (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre ='Berín')
    ),
    (
		(SELECT id_linea FROM lineas WHERE  nombre = "Linea 2"),
		(SELECT   id_estacion FROM  estaciones WHERE nombre ='Parque de Aranjuez')
    ),
    (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre ='Barrio Colombia')
    ),
     (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre ='Perpetuo Socorro')
    ),
     (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre ='Barrio Colón')
    ),
    (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre ='San José')
    ),
    (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre ='La Playa')
    ),
    (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre ='Catedral')
    ),
    (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre ='Prado')
    ),
    (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea 2'),
		(SELECT   id_estacion FROM  estaciones WHERE nombre ='Hospital')
    ),
    
    -- LINEA O
    (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea O'),
		(SELECT id_estacion FROM  estaciones WHERE nombre ='Caribe')
    ),
    (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea O'),
		(SELECT id_estacion FROM  estaciones WHERE nombre ='Universal')
        ),
         (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea O'),
		(SELECT id_estacion FROM  estaciones WHERE nombre ='Ciudadela Universitaria')
        ),
         (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea O'),
		(SELECTid_estacion  FROM  estaciones WHERE nombre ='Facultad de Minas')
        ),
         (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea O'),
		(SELECT id_estacion FROM  estaciones WHERE nombre ='Floresta')
        ),
         (
		(SELECTid_linea  FROMlineas  WHERE nombre  = 'Linea O'),
		(SELECT id_estacion FROM estaciones  WHERE nombre  ='Los Pinos')
        ),
         (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea O'),
		(SELECT id_estacion FROM  estaciones WHERE nombre ='Laureles')
        ),
         (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea O'),
		(SELECT id_estacion FROM  estaciones WHERE nombre ='Santa Gema')
        ),
         (
		(SELECT id_linea FROM lineas WHERE  nombre = 'Linea O'),
		(SELECT id_estacion FROM  estaciones WHERE nombre ='Villa de Aburrá')
        )
