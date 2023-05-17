-- Eliminar tablas con restricciones en cascada
DROP TABLE IF EXISTS vende CASCADE;
DROP TABLE IF EXISTS empleado CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS coche CASCADE;
DROP TABLE IF EXISTS tipos_puesto CASCADE;
DROP TABLE IF EXISTS marcas_coche CASCADE;
DROP TABLE IF EXISTS tipos_forma_pago CASCADE;
DROP TABLE IF EXISTS coche_madrid CASCADE;
DROP TABLE IF EXISTS coche_barcelona CASCADE;

-- Crear tabla empleado
CREATE TABLE empleado (
  dni VARCHAR(9),
  nombre VARCHAR(60),
  id_puesto INTEGER,
  telef VARCHAR(12),
  anio_incorporacion INTEGER,
  CONSTRAINT pk_empleado PRIMARY KEY (dni)
);

-- Crear tabla coche
CREATE TABLE coche (
  matricula VARCHAR(7),
  descripcion VARCHAR(60),
  id_marca INTEGER,
  precio_compra INTEGER,
  CONSTRAINT pk_coche PRIMARY KEY (matricula)
);

-- Crear tabla coche_barcelona
CREATE TABLE coche_barcelona (
  matricula VARCHAR(7),
  descripcion VARCHAR(60),
  id_marca INTEGER,
  precio_compra INTEGER,
  CONSTRAINT pk_coche_bar PRIMARY KEY (matricula)
);

-- Crear tabla coche_madrid
CREATE TABLE coche_madrid (
  matricula VARCHAR(7),
  descripcion VARCHAR(60),
  id_marca INTEGER,
  precio_compra INTEGER,
  CONSTRAINT pk_coche_mad PRIMARY KEY (matricula)
);

-- Crear tabla cliente
CREATE TABLE cliente (
  dni VARCHAR(9),
  nombre VARCHAR(60),
  telef VARCHAR(12),
  CONSTRAINT pk_cliente PRIMARY KEY (dni)
);

-- Crear tabla vende
CREATE TABLE vende (
  dni_empleado VARCHAR(9),
  dni_cliente VARCHAR(9),
  matricula VARCHAR(7),
  fecha DATE,
  id_forma_pago INTEGER,
  precio INTEGER,
  CONSTRAINT pk_vende PRIMARY KEY (dni_cliente, matricula),
  CONSTRAINT fk_vende_empleado FOREIGN KEY (dni_empleado) REFERENCES empleado (dni),
  CONSTRAINT fk_vende_cliente FOREIGN KEY (dni_cliente) REFERENCES cliente (dni),
  CONSTRAINT fk_vende_coche FOREIGN KEY (matricula) REFERENCES coche (matricula)
);

-- Crear tabla tipos_forma_pago
CREATE TABLE tipos_forma_pago (
  id_forma_pago INTEGER,
  forma_pago VARCHAR(20),
  CONSTRAINT pk_forma_pago PRIMARY KEY (id_forma_pago)
);

-- Crear tabla marcas_coche
CREATE TABLE marcas_coche (
  id_marca INTEGER,
  marca VARCHAR(30),
  CONSTRAINT pk_marcas_coche PRIMARY KEY (id_marca)
);

-- Crear tabla tipos_puesto
CREATE TABLE tipos_puesto (
  id_puesto INTEGER,
  puesto VARCHAR(30),
  CONSTRAINT pk_tipos_puesto PRIMARY KEY (id_puesto)
);

-- ALTER TABLE
ALTER TABLE empleado ADD CONSTRAINT fk_empleado_tipos_puesto FOREIGN KEY (id_puesto) REFERENCES tipos_puesto;
ALTER TABLE vende ADD CONSTRAINT fk_venta_tipos_forma_pago FOREIGN KEY (id_forma_pago) REFERENCES tipos_forma_pago;
ALTER TABLE coche ADD CONSTRAINT fk_coche_marcas_coche FOREIGN KEY (id_marca) REFERENCES marcas_coche;
ALTER TABLE coche_madrid ADD CONSTRAINT fk_cochem_marcas_coche FOREIGN KEY (id_marca) REFERENCES marcas_coche;
ALTER TABLE coche_barcelona ADD CONSTRAINT fk_cocheb_marcas_coche FOREIGN KEY (id_marca) REFERENCES marcas_coche;

-- INSERT INTO
INSERT INTO tipos_puesto (id_puesto, puesto) VALUES (1, 'Vendedor particulares');
INSERT INTO tipos_puesto (id_puesto, puesto) VALUES (2, 'Coordinador ventas');
INSERT INTO tipos_puesto (id_puesto, puesto) VALUES (3, 'Recepcionista');
INSERT INTO tipos_puesto (id_puesto, puesto) VALUES (4, 'Mecánico');
INSERT INTO tipos_puesto (id_puesto, puesto) VALUES (5, 'Vendedor empresas');

INSERT INTO marcas_coche (id_marca, marca) VALUES (1, 'Renault');
INSERT INTO marcas_coche (id_marca, marca) VALUES (2, 'Ford');
INSERT INTO marcas_coche (id_marca, marca) VALUES (3, 'Citroen');
INSERT INTO marcas_coche (id_marca, marca) VALUES (4, 'Audi');
INSERT INTO marcas_coche (id_marca, marca) VALUES (5, 'Mercedes');
INSERT INTO marcas_coche (id_marca, marca) VALUES (6, 'Kia');
INSERT INTO marcas_coche (id_marca, marca) VALUES (7, 'Volkswagen');
INSERT INTO marcas_coche (id_marca, marca) VALUES (8, 'Opel');

INSERT INTO tipos_forma_pago (id_forma_pago, forma_pago) VALUES (1, 'Contado');
INSERT INTO tipos_forma_pago (id_forma_pago, forma_pago) VALUES (2, 'Tarjeta');
INSERT INTO tipos_forma_pago (id_forma_pago, forma_pago) VALUES (3, 'Talón');
INSERT INTO tipos_forma_pago (id_forma_pago, forma_pago) VALUES (4, 'Transferencia');
INSERT INTO tipos_forma_pago (id_forma_pago, forma_pago) VALUES (5, 'Financiado');

INSERT INTO empleado (dni, nombre, id_puesto, telef, anio_incorporacion) VALUES ('05678245B', 'García Gómez, Andrés', 3, '694532211', 2000);
INSERT INTO empleado (dni, nombre, id_puesto, telef, anio_incorporacion) VALUES ('90774536C', 'Pérez Pérez, Luisa', 1, '676885643', 2016);
INSERT INTO empleado (dni, nombre, id_puesto, telef, anio_incorporacion) VALUES ('45327865A', 'Gómez Rubio, Ana', 5, '654772134', 2014);
INSERT INTO empleado (dni, nombre, id_puesto, telef, anio_incorporacion) VALUES ('05789494D', 'Martínez Alberca, José', 4, NULL, 2002);

-- Tabla CLIENTE
INSERT INTO CLIENTE (DNI, NOMBRE, TELEF) VALUES ('07541212F', 'Fernández Arco, Cristina', '926227345');
INSERT INTO CLIENTE (DNI, NOMBRE, TELEF) VALUES ('05478218A', 'Gracia Soler, Luis Alberto', '676443789');
INSERT INTO CLIENTE (DNI, NOMBRE, TELEF) VALUES ('04787675D', 'Ruiz Morales, Fernando', '654332211');

-- Tabla COCHE
INSERT INTO COCHE (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA) VALUES ('3345GVF', 'A5 modelo alta gama', 4, 6000);
INSERT INTO COCHE (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA) VALUES ('3346GVA', 'C4 Exclusive', 3, NULL);
INSERT INTO COCHE (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA) VALUES ('4446GCN', 'C4 Gran Picasso', 3, NULL);
INSERT INTO COCHE (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA) VALUES ('3287GVA', 'Zafira Año 2015', 8, 3000);
INSERT INTO COCHE (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA) VALUES ('1290ASX', 'Kouga', 2, NULL);
INSERT INTO COCHE (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA) VALUES ('5487NDA', 'DS C4', 3, NULL);
INSERT INTO COCHE (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA) VALUES ('8666KKK', 'Kangoo', 3, 9000);
INSERT INTO COCHE (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA) VALUES ('5689ADD', 'Golf GTI', 7, 3000);
INSERT INTO COCHE (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA) VALUES ('7894AAA', 'A4 básico', 4, 3000);
INSERT INTO COCHE (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA) VALUES ('1212BAD', 'Astra Año 2014', 8, NULL);
INSERT INTO COCHE (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA) VALUES ('4569GVA', 'C4 Exclusive', 3, 5000);
INSERT INTO COCHE (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA) VALUES ('9876AFF', 'C4 Exclusive', 3, 5000);

-- VENDE
INSERT INTO VENDE (DNI_EMPLEADO, DNI_CLIENTE, MATRICULA, FECHA, ID_FORMA_PAGO, PRECIO)
VALUES ('90774536C', '07541212F', '3345GVF', '2018-03-19', 1, 7000);
INSERT INTO VENDE (DNI_EMPLEADO, DNI_CLIENTE, MATRICULA, FECHA, ID_FORMA_PAGO, PRECIO)
VALUES ('90774536C', '07541212F', '7894AAA', '2016-03-09', 5, 12000);
INSERT INTO VENDE (DNI_EMPLEADO, DNI_CLIENTE, MATRICULA, FECHA, ID_FORMA_PAGO, PRECIO)
VALUES ('45327865A', '04787675D', '1290ASX', '2018-02-06', 5, 9000);
INSERT INTO VENDE (DNI_EMPLEADO, DNI_CLIENTE, MATRICULA, FECHA, ID_FORMA_PAGO, PRECIO)
VALUES ('45327865A', '04787675D', '8666KKK', '2017-12-12', 3, 16000);

-- COCHE_BARCELONA
INSERT INTO COCHE_BARCELONA (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA)
VALUES ('3345GVF', 'A5 modelo alta gama', '4', 6000);
INSERT INTO COCHE_BARCELONA (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA)
VALUES ('3287GVA', 'Zafira Año 2015', '8', 3000);
INSERT INTO COCHE_BARCELONA (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA)
VALUES ('8666KKK', 'Kangoo', '3', 9000);
INSERT INTO COCHE_BARCELONA (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA)
VALUES ('5689ADD', 'Golf GTI', '7', 3000);
INSERT INTO COCHE_BARCELONA (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA)
VALUES ('7894AAA', 'A4 básico', '4', 3000);
INSERT INTO COCHE_BARCELONA (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA)
VALUES ('4569GVA', 'C4 Exclusive', '3', 5000);
INSERT INTO COCHE_BARCELONA (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA)
VALUES ('9876AFF', 'C4 Exclusive', '3', 5000);

INSERT INTO COCHE_MADRID (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA) VALUES ('3346GVA', 'C4 Exclusive', '3', NULL);
INSERT INTO COCHE_MADRID (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA) VALUES ('4446GCN', 'C4 Gran Picasso', '3', NULL);
INSERT INTO COCHE_MADRID (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA) VALUES ('1290ASX', 'Kouga', '2', NULL);
INSERT INTO COCHE_MADRID (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA) VALUES ('5487NDA', 'DS C4', '3', NULL);
INSERT INTO COCHE_MADRID (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA) VALUES ('1212BAD', 'Astra Año 2014', '8', NULL);
INSERT INTO COCHE_MADRID (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA) VALUES ('4569GVA', 'C4 Exclusive', '3', '5000');
INSERT INTO COCHE_MADRID (MATRICULA, DESCRIPCION, ID_MARCA, PRECIO_COMPRA) VALUES ('9876AFF', 'C4 Exclusive', '3', '5000');

COMMIT;