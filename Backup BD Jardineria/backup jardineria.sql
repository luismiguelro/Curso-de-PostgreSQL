PGDMP     ;    /                {         
   jardineria    12.14    12.14 F    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    24769 
   jardineria    DATABASE     �   CREATE DATABASE jardineria WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Colombia.1252' LC_CTYPE = 'Spanish_Colombia.1252';
    DROP DATABASE jardineria;
                postgres    false                        3079    41574    dblink 	   EXTENSION     :   CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;
    DROP EXTENSION dblink;
                   false            �           0    0    EXTENSION dblink    COMMENT     _   COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';
                        false    2            �            1255    41517    actualizar_comentario_pedido()    FUNCTION     4  CREATE FUNCTION public.actualizar_comentario_pedido() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.fecha_entrega IS NOT NULL AND NEW.fecha_entrega > OLD.fecha_esperada THEN
        NEW.comentarios := OLD.comentarios || ' Pedido entregado con retraso';
    END IF;
    RETURN NEW;
END;
$$;
 5   DROP FUNCTION public.actualizar_comentario_pedido();
       public          postgres    false            �            1255    41511    actualizar_comentario_pedidos()    FUNCTION     t  CREATE FUNCTION public.actualizar_comentario_pedidos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
   IF new.fecha_entrega > old.fecha_esperada THEN
         new.comentarios := old.comentarios || ' Pedido entregado con retraso';
   ELSE
         new.comentarios := old.comentarios || ' Pedido entregado antes de lo esperado';
   END IF;

    RETURN NEW;
END;
$$;
 6   DROP FUNCTION public.actualizar_comentario_pedidos();
       public          postgres    false            �            1255    41505    actualizar_stock()    FUNCTION     �   CREATE FUNCTION public.actualizar_stock() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE producto
    SET cantidad_en_stock = cantidad_en_stock - NEW.cantidad
    WHERE codigo_producto = NEW.codigo_producto;

    RETURN NEW;
END;
$$;
 )   DROP FUNCTION public.actualizar_stock();
       public          postgres    false            �            1255    24875    ejemplo(integer)    FUNCTION     }   CREATE FUNCTION public.ejemplo(numero integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN numero;
END;
$$;
 .   DROP FUNCTION public.ejemplo(numero integer);
       public          postgres    false            �            1255    41522    fr_actualizar_stock()    FUNCTION     A  CREATE FUNCTION public.fr_actualizar_stock() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_stock_actual producto.cantidad_en_stock%type;
BEGIN
    SELECT cantidad_en_stock INTO v_stock_actual 
    FROM producto
    WHERE codigo_producto = NEW.codigo_producto;

    -- Validar
    IF v_stock_actual - NEW.cantidad > 0 THEN
        UPDATE producto
        SET cantidad_en_stock = cantidad_en_stock - NEW.cantidad
        WHERE codigo_producto = NEW.codigo_producto;
    ELSE
        RAISE EXCEPTION 'NO HAY SUFICIENTE STOCK';
    END IF;

    RETURN NEW;
END;
$$;
 ,   DROP FUNCTION public.fr_actualizar_stock();
       public          postgres    false            �            1255    41515 "   ft_actualizar_comentario_pedidos()    FUNCTION     :  CREATE FUNCTION public.ft_actualizar_comentario_pedidos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (NEW.fecha_entrega IS NOT NULL AND NEW.fecha_entrega > OLD.fecha_esperada) THEN
        NEW.comentarios := OLD.comentarios || ' Pedido entregado con retraso';
    END IF;
    RETURN NEW;
END;
$$;
 9   DROP FUNCTION public.ft_actualizar_comentario_pedidos();
       public          postgres    false            �            1255    33296    mostrarempleadosjef(integer) 	   PROCEDURE       CREATE PROCEDURE public.mostrarempleadosjef(p_codigo_jefe integer)
    LANGUAGE plpgsql
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
$$;
 B   DROP PROCEDURE public.mostrarempleadosjef(p_codigo_jefe integer);
       public          postgres    false            �            1255    33289    mostrarempleadosjefe(integer) 	   PROCEDURE     �  CREATE PROCEDURE public.mostrarempleadosjefe(p_codigo_jefe integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
    empleado_jefe CURSOR IS
    SELECT em.nombre || ' ' || em.apellido1 || ' ' || em.apellido2 AS nombre_empleado
    FROM empleado em
    WHERE em.codigo_jefe = p_codigo_jefe;

    v_nombre_jefe VARCHAR;
    v_empleados TEXT := '';
BEGIN
    SELECT nombre || ' ' || apellido1 || ' ' || apellido2 INTO v_nombre_jefe
    FROM empleado
    WHERE codigo_empleado = p_codigo_jefe;

    FOR registro IN empleado_jefe LOOP
        v_empleados := v_empleados || registro.nombre_empleado || ', ';
    END LOOP;

    IF v_empleados <> '' THEN
        v_empleados := SUBSTRING(v_empleados, 1, LENGTH(v_empleados) - 2);
        RAISE NOTICE 'El jefe llamado % tiene a cargo a los siguientes empleados: %', v_nombre_jefe, v_empleados;
    ELSE
        RAISE NOTICE 'El jefe llamado % no tiene empleados a cargo.', v_nombre_jefe;
    END IF;

EXCEPTION WHEN NO_DATA_FOUND THEN
    RAISE NOTICE 'NO EXISTE';
END;
$$;
 C   DROP PROCEDURE public.mostrarempleadosjefe(p_codigo_jefe integer);
       public          postgres    false            �            1255    33288     mostrarproductospedidos(integer) 	   PROCEDURE     �  CREATE PROCEDURE public.mostrarproductospedidos(p_codigo_pedido integer)
    LANGUAGE plpgsql
    AS $$
    DECLARE prod_pedido CURSOR IS 
    SELECT p.nombre,dp.cantidad
    FROM producto p, detalle_pedido dp
    WHERE p.codigo_producto = dp.codigo_producto
    AND dp.codigo_pedido = p_codigo_pedido;
BEGIN
    FOR registro in prod_pedido LOOP
         RAISE NOTICE 'Se ha pedido del producto %: % unidades', registro.nombre,registro.cantidad;
    END LOOP;
END;
$$;
 H   DROP PROCEDURE public.mostrarproductospedidos(p_codigo_pedido integer);
       public          postgres    false            �            1255    24879    obtener_info_pedido(integer)    FUNCTION     7  CREATE FUNCTION public.obtener_info_pedido(codigo integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_codigo_pedido  pedido.codigo_pedido%type;
	-- rowtype: recorrer tabla
	v_pedido pedido%rowtype;
BEGIN
	SELECT * INTO v_pedido
	FROM pedido
	WHERE pedido.codigo_pedido = codigo;

	RAISE NOTICE 'La fecha del pedido es: %, la fecha esperada es: %, y la fecha de entrega fue: %, el estado del pedido es: %, y los comentarios fueron: %', v_pedido.fecha_pedido, v_pedido.fecha_esperada, v_pedido.fecha_entrega, v_pedido.estado, v_pedido.comentarios;
END;
$$;
 :   DROP FUNCTION public.obtener_info_pedido(codigo integer);
       public          postgres    false            �            1255    24876    obtener_nombre_cliente(integer)    FUNCTION     �  CREATE FUNCTION public.obtener_nombre_cliente(codigo integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_nombre_cliente cliente.nombre_cliente%type;
BEGIN
	SELECT nombre_cliente INTO v_nombre_cliente
	FROM cliente
	WHERE codigo_cliente = codigo;
EXCEPTION 
	WHEN NO_DATA_FOUND THEN
    	RAISE NOTICE 'El cliente NO existe';
		
RAISE NOTICE 'El nombre del cliente es: %', v_nombre_cliente;
    -- Controlar la excepcion
END;
$$;
 =   DROP FUNCTION public.obtener_nombre_cliente(codigo integer);
       public          postgres    false            �            1255    24877 )   obtener_nombre_product(character varying)    FUNCTION     �  CREATE FUNCTION public.obtener_nombre_product(codigo character varying) RETURNS TABLE(nombre_producto text, gama_producto text)
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_nombre_producto  producto.nombre%type;
	v_gama_producto producto.gama%type;
BEGIN
	SELECT nombre, gama INTO v_nombre_producto, v_gama_producto
	FROM producto
	WHERE codigo_producto = codigo;

	RAISE NOTICE 'El nombre del producto es: % y su gama es: %', v_nombre_producto, v_gama_producto;
END;
$$;
 G   DROP FUNCTION public.obtener_nombre_product(codigo character varying);
       public          postgres    false            �            1255    24880    pagos_clientes(integer)    FUNCTION     �  CREATE FUNCTION public.pagos_clientes(v_codigo integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
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
        RETURN -1;
END;
$$;
 7   DROP FUNCTION public.pagos_clientes(v_codigo integer);
       public          postgres    false            �            1255    24884    ps_total_pedido(integer) 	   PROCEDURE     r  CREATE PROCEDURE public.ps_total_pedido(v_codigo integer)
    LANGUAGE plpgsql
    AS $$
   DECLARE 
    v_total NUMERIC:=0;
BEGIN
    SELECT SUM(dp.cantidad * dp.precio_unidad) INTO v_total
    FROM pedido p, detalle_pedido dp
    WHERE p.codigo_pedido = dp.codigo_pedido AND p.codigo_pedido = v_codigo;

   RAISE NOTICE 'El pedido total es: %', v_total;
   
END;

$$;
 9   DROP PROCEDURE public.ps_total_pedido(v_codigo integer);
       public          postgres    false            �            1255    33347 	   sp_test()    FUNCTION     �  CREATE FUNCTION public.sp_test() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

    -- Accion del trigger. new: nueva informacion, old: informacion actual
    INSERT INTO trigger_actualizar (codigo_cliente, nombre_cliente, nombre_contact, pais)
    VALUES (NEW.codigo_cliente, NEW.nombre_cliente, NEW.nombre_contact, NEW.pais);

    -- Utiliza NEW en lugar de OLD para que el trigger se ejecute correctamente
    RETURN NEW;
END;
$$;
     DROP FUNCTION public.sp_test();
       public          postgres    false            �            1255    41499    sp_tr_test()    FUNCTION     �   CREATE FUNCTION public.sp_tr_test() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO "trigger_actualizar"
	VALUES (old.codigo_cliente,OLD.nombre_cliente,OLD.nombre_contact,OLD.pais);
	
RETURN NEW;
END;
$$;
 #   DROP FUNCTION public.sp_tr_test();
       public          postgres    false            �            1255    24881    total_pedido(integer)    FUNCTION     �  CREATE FUNCTION public.total_pedido(v_codigo integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_codigo_pedido pedido.codigo_pedido%type := v_codigo;
    v_suma_pago pago.total%type;
BEGIN
   v_suma_pago := pagos_clientes(v_codigo_pedido);
   IF v_suma_pago = -1 THEN
    RAISE NOTICE 'CLIENTE NO EXISTE';
   ELSE
        RAISE NOTICE 'La suma del pago es: %', v_suma_pago;
   END IF;
END;
$$;
 5   DROP FUNCTION public.total_pedido(v_codigo integer);
       public          postgres    false            �            1259    24802    cliente    TABLE     <  CREATE TABLE public.cliente (
    codigo_cliente integer NOT NULL,
    nombre_cliente character varying(50) NOT NULL,
    nombre_contacto character varying(30) DEFAULT NULL::character varying,
    apellido_contacto character varying(30) DEFAULT NULL::character varying,
    telefono character varying(15) NOT NULL,
    fax character varying(15) NOT NULL,
    linea_direccion1 character varying(50) NOT NULL,
    linea_direccion2 character varying(50) DEFAULT NULL::character varying,
    ciudad character varying(50) NOT NULL,
    region character varying(50) DEFAULT NULL::character varying,
    pais character varying(50) DEFAULT NULL::character varying,
    codigo_postal character varying(10) DEFAULT NULL::character varying,
    codigo_empleado_rep_ventas integer,
    limite_credito numeric(15,2) DEFAULT NULL::numeric
);
    DROP TABLE public.cliente;
       public         heap    postgres    false            �            1259    24847    detalle_pedido    TABLE     �   CREATE TABLE public.detalle_pedido (
    codigo_pedido integer NOT NULL,
    codigo_producto character varying(15) NOT NULL,
    cantidad integer NOT NULL,
    precio_unidad numeric(15,2) NOT NULL,
    numero_linea smallint NOT NULL
);
 "   DROP TABLE public.detalle_pedido;
       public         heap    postgres    false            �            1259    24777    empleado    TABLE     �  CREATE TABLE public.empleado (
    codigo_empleado integer NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido1 character varying(50) NOT NULL,
    apellido2 character varying(50) DEFAULT NULL::character varying,
    extension character varying(10) NOT NULL,
    email character varying(100) NOT NULL,
    codigo_oficina character varying(10) NOT NULL,
    codigo_jefe integer,
    puesto character varying(50) DEFAULT NULL::character varying
);
    DROP TABLE public.empleado;
       public         heap    postgres    false            �            1259    24794    gama_producto    TABLE     �   CREATE TABLE public.gama_producto (
    gama character varying(50) NOT NULL,
    descripcion_texto text,
    descripcion_html text,
    imagen character varying(256)
);
 !   DROP TABLE public.gama_producto;
       public         heap    postgres    false            �            1259    24770    oficina    TABLE     �  CREATE TABLE public.oficina (
    codigo_oficina character varying(10) NOT NULL,
    ciudad character varying(30) NOT NULL,
    pais character varying(50) NOT NULL,
    region character varying(50) DEFAULT NULL::character varying,
    codigo_postal character varying(10) NOT NULL,
    telefono character varying(20) NOT NULL,
    linea_direccion1 character varying(50) NOT NULL,
    linea_direccion2 character varying(50) DEFAULT NULL::character varying
);
    DROP TABLE public.oficina;
       public         heap    postgres    false            �            1259    24862    pago    TABLE     �   CREATE TABLE public.pago (
    codigo_cliente integer NOT NULL,
    forma_pago character varying(40) NOT NULL,
    id_transaccion character varying(50) NOT NULL,
    fecha_pago date NOT NULL,
    total numeric(15,2) NOT NULL
);
    DROP TABLE public.pago;
       public         heap    postgres    false            �            1259    24819    pedido    TABLE       CREATE TABLE public.pedido (
    codigo_pedido integer NOT NULL,
    fecha_pedido date NOT NULL,
    fecha_esperada date NOT NULL,
    fecha_entrega date,
    estado character varying(15) NOT NULL,
    comentarios text,
    codigo_cliente integer NOT NULL
);
    DROP TABLE public.pedido;
       public         heap    postgres    false            �            1259    41479    practica_trigger    TABLE     �   CREATE TABLE public.practica_trigger (
    codigo_cliente integer NOT NULL,
    nombre_cliente character varying,
    nombre_contact character varying,
    pais character varying
);
 $   DROP TABLE public.practica_trigger;
       public         heap    postgres    false            �            1259    24832    producto    TABLE     �  CREATE TABLE public.producto (
    codigo_producto character varying(15) NOT NULL,
    nombre character varying(70) NOT NULL,
    gama character varying(50) NOT NULL,
    dimensiones character varying(25),
    proveedor character varying(50) DEFAULT NULL::character varying,
    descripcion text,
    cantidad_en_stock smallint NOT NULL,
    precio_venta numeric(15,2) NOT NULL,
    precio_proveedor numeric(15,2) DEFAULT NULL::numeric
);
    DROP TABLE public.producto;
       public         heap    postgres    false            �            1259    41492    trigger_actualizar    TABLE     �   CREATE TABLE public.trigger_actualizar (
    codigo_cliente integer,
    nombre_cliente character varying(50),
    nombre_contact character varying(50),
    pais character varying(50)
);
 &   DROP TABLE public.trigger_actualizar;
       public         heap    postgres    false            �          0    24802    cliente 
   TABLE DATA           �   COPY public.cliente (codigo_cliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax, linea_direccion1, linea_direccion2, ciudad, region, pais, codigo_postal, codigo_empleado_rep_ventas, limite_credito) FROM stdin;
    public          postgres    false    206   Zv       �          0    24847    detalle_pedido 
   TABLE DATA           o   COPY public.detalle_pedido (codigo_pedido, codigo_producto, cantidad, precio_unidad, numero_linea) FROM stdin;
    public          postgres    false    209   p~       �          0    24777    empleado 
   TABLE DATA           �   COPY public.empleado (codigo_empleado, nombre, apellido1, apellido2, extension, email, codigo_oficina, codigo_jefe, puesto) FROM stdin;
    public          postgres    false    204   &�       �          0    24794    gama_producto 
   TABLE DATA           Z   COPY public.gama_producto (gama, descripcion_texto, descripcion_html, imagen) FROM stdin;
    public          postgres    false    205   ��       �          0    24770    oficina 
   TABLE DATA           �   COPY public.oficina (codigo_oficina, ciudad, pais, region, codigo_postal, telefono, linea_direccion1, linea_direccion2) FROM stdin;
    public          postgres    false    203   L�       �          0    24862    pago 
   TABLE DATA           ]   COPY public.pago (codigo_cliente, forma_pago, id_transaccion, fecha_pago, total) FROM stdin;
    public          postgres    false    210   ��       �          0    24819    pedido 
   TABLE DATA           �   COPY public.pedido (codigo_pedido, fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, codigo_cliente) FROM stdin;
    public          postgres    false    207   ˍ       �          0    41479    practica_trigger 
   TABLE DATA           `   COPY public.practica_trigger (codigo_cliente, nombre_cliente, nombre_contact, pais) FROM stdin;
    public          postgres    false    211   �       �          0    24832    producto 
   TABLE DATA           �   COPY public.producto (codigo_producto, nombre, gama, dimensiones, proveedor, descripcion, cantidad_en_stock, precio_venta, precio_proveedor) FROM stdin;
    public          postgres    false    208   ��       �          0    41492    trigger_actualizar 
   TABLE DATA           b   COPY public.trigger_actualizar (codigo_cliente, nombre_cliente, nombre_contact, pais) FROM stdin;
    public          postgres    false    212   ��       �
           2606    24813    cliente cliente_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (codigo_cliente);
 >   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
       public            postgres    false    206            �
           2606    24851 "   detalle_pedido detalle_pedido_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.detalle_pedido
    ADD CONSTRAINT detalle_pedido_pkey PRIMARY KEY (codigo_pedido, codigo_producto);
 L   ALTER TABLE ONLY public.detalle_pedido DROP CONSTRAINT detalle_pedido_pkey;
       public            postgres    false    209    209            �
           2606    24783    empleado empleado_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (codigo_empleado);
 @   ALTER TABLE ONLY public.empleado DROP CONSTRAINT empleado_pkey;
       public            postgres    false    204            �
           2606    24801     gama_producto gama_producto_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.gama_producto
    ADD CONSTRAINT gama_producto_pkey PRIMARY KEY (gama);
 J   ALTER TABLE ONLY public.gama_producto DROP CONSTRAINT gama_producto_pkey;
       public            postgres    false    205            �
           2606    24776    oficina oficina_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.oficina
    ADD CONSTRAINT oficina_pkey PRIMARY KEY (codigo_oficina);
 >   ALTER TABLE ONLY public.oficina DROP CONSTRAINT oficina_pkey;
       public            postgres    false    203                       2606    24866    pago pago_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.pago
    ADD CONSTRAINT pago_pkey PRIMARY KEY (codigo_cliente, id_transaccion);
 8   ALTER TABLE ONLY public.pago DROP CONSTRAINT pago_pkey;
       public            postgres    false    210    210            �
           2606    24826    pedido pedido_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (codigo_pedido);
 <   ALTER TABLE ONLY public.pedido DROP CONSTRAINT pedido_pkey;
       public            postgres    false    207                       2606    41486 &   practica_trigger practica_trigger_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.practica_trigger
    ADD CONSTRAINT practica_trigger_pkey PRIMARY KEY (codigo_cliente);
 P   ALTER TABLE ONLY public.practica_trigger DROP CONSTRAINT practica_trigger_pkey;
       public            postgres    false    211            �
           2606    24841    producto producto_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (codigo_producto);
 @   ALTER TABLE ONLY public.producto DROP CONSTRAINT producto_pkey;
       public            postgres    false    208                       2620    41518 '   pedido actualizar_comentario_pedidos_tr    TRIGGER     �   CREATE TRIGGER actualizar_comentario_pedidos_tr BEFORE UPDATE OF fecha_entrega ON public.pedido FOR EACH ROW WHEN (((new.fecha_entrega IS NOT NULL) AND (new.fecha_entrega > old.fecha_esperada))) EXECUTE FUNCTION public.actualizar_comentario_pedido();
 @   DROP TRIGGER actualizar_comentario_pedidos_tr ON public.pedido;
       public          postgres    false    207    243    207    207    207                       2620    41523 +   detalle_pedido productos_actualiza_stock_tr    TRIGGER     �   CREATE TRIGGER productos_actualiza_stock_tr BEFORE INSERT ON public.detalle_pedido FOR EACH ROW EXECUTE FUNCTION public.fr_actualizar_stock();
 D   DROP TRIGGER productos_actualiza_stock_tr ON public.detalle_pedido;
       public          postgres    false    209    244                       2620    41504    practica_trigger t_update    TRIGGER     s   CREATE TRIGGER t_update AFTER UPDATE ON public.practica_trigger FOR EACH ROW EXECUTE FUNCTION public.sp_tr_test();
 2   DROP TRIGGER t_update ON public.practica_trigger;
       public          postgres    false    215    211                       2620    41512 '   pedido tr_actualizar_comentario_pedidos    TRIGGER     �   CREATE TRIGGER tr_actualizar_comentario_pedidos BEFORE UPDATE OF fecha_entrega ON public.pedido FOR EACH ROW EXECUTE FUNCTION public.actualizar_comentario_pedidos();
 @   DROP TRIGGER tr_actualizar_comentario_pedidos ON public.pedido;
       public          postgres    false    207    207    241                       2620    41506 +   detalle_pedido tr_productos_actualiza_stock    TRIGGER     �   CREATE TRIGGER tr_productos_actualiza_stock AFTER INSERT ON public.detalle_pedido FOR EACH ROW EXECUTE FUNCTION public.actualizar_stock();
 D   DROP TRIGGER tr_productos_actualiza_stock ON public.detalle_pedido;
       public          postgres    false    209    223                       2620    33348    cliente tr_update    TRIGGER     i   CREATE TRIGGER tr_update BEFORE UPDATE ON public.cliente FOR EACH ROW EXECUTE FUNCTION public.sp_test();
 *   DROP TRIGGER tr_update ON public.cliente;
       public          postgres    false    222    206                       2620    41495    trigger_actualizar tr_update    TRIGGER     t   CREATE TRIGGER tr_update BEFORE UPDATE ON public.trigger_actualizar FOR EACH ROW EXECUTE FUNCTION public.sp_test();
 5   DROP TRIGGER tr_update ON public.trigger_actualizar;
       public          postgres    false    222    212                       2620    41516 (   pedido trf_actualizar_comentario_pedidos    TRIGGER     �   CREATE TRIGGER trf_actualizar_comentario_pedidos BEFORE UPDATE OF fecha_entrega ON public.pedido FOR EACH ROW EXECUTE FUNCTION public.actualizar_comentario_pedidos();
 A   DROP TRIGGER trf_actualizar_comentario_pedidos ON public.pedido;
       public          postgres    false    241    207    207                       2620    41502    practica_trigger trr_update    TRIGGER     v   CREATE TRIGGER trr_update BEFORE UPDATE ON public.practica_trigger FOR EACH ROW EXECUTE FUNCTION public.sp_tr_test();
 4   DROP TRIGGER trr_update ON public.practica_trigger;
       public          postgres    false    215    211                       2620    41501    trigger_actualizar trr_update    TRIGGER     x   CREATE TRIGGER trr_update BEFORE UPDATE ON public.trigger_actualizar FOR EACH ROW EXECUTE FUNCTION public.sp_tr_test();
 6   DROP TRIGGER trr_update ON public.trigger_actualizar;
       public          postgres    false    212    215                       2606    24814 /   cliente cliente_codigo_empleado_rep_ventas_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_codigo_empleado_rep_ventas_fkey FOREIGN KEY (codigo_empleado_rep_ventas) REFERENCES public.empleado(codigo_empleado);
 Y   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_codigo_empleado_rep_ventas_fkey;
       public          postgres    false    206    204    2805            	           2606    24852 0   detalle_pedido detalle_pedido_codigo_pedido_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalle_pedido
    ADD CONSTRAINT detalle_pedido_codigo_pedido_fkey FOREIGN KEY (codigo_pedido) REFERENCES public.pedido(codigo_pedido);
 Z   ALTER TABLE ONLY public.detalle_pedido DROP CONSTRAINT detalle_pedido_codigo_pedido_fkey;
       public          postgres    false    2811    209    207            
           2606    24857 2   detalle_pedido detalle_pedido_codigo_producto_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalle_pedido
    ADD CONSTRAINT detalle_pedido_codigo_producto_fkey FOREIGN KEY (codigo_producto) REFERENCES public.producto(codigo_producto);
 \   ALTER TABLE ONLY public.detalle_pedido DROP CONSTRAINT detalle_pedido_codigo_producto_fkey;
       public          postgres    false    209    208    2813                       2606    24789 "   empleado empleado_codigo_jefe_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_codigo_jefe_fkey FOREIGN KEY (codigo_jefe) REFERENCES public.empleado(codigo_empleado);
 L   ALTER TABLE ONLY public.empleado DROP CONSTRAINT empleado_codigo_jefe_fkey;
       public          postgres    false    204    204    2805                       2606    24784 %   empleado empleado_codigo_oficina_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_codigo_oficina_fkey FOREIGN KEY (codigo_oficina) REFERENCES public.oficina(codigo_oficina);
 O   ALTER TABLE ONLY public.empleado DROP CONSTRAINT empleado_codigo_oficina_fkey;
       public          postgres    false    203    204    2803                       2606    24867    pago pago_codigo_cliente_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pago
    ADD CONSTRAINT pago_codigo_cliente_fkey FOREIGN KEY (codigo_cliente) REFERENCES public.cliente(codigo_cliente);
 G   ALTER TABLE ONLY public.pago DROP CONSTRAINT pago_codigo_cliente_fkey;
       public          postgres    false    206    2809    210                       2606    24827 !   pedido pedido_codigo_cliente_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_codigo_cliente_fkey FOREIGN KEY (codigo_cliente) REFERENCES public.cliente(codigo_cliente);
 K   ALTER TABLE ONLY public.pedido DROP CONSTRAINT pedido_codigo_cliente_fkey;
       public          postgres    false    2809    206    207                       2606    24842    producto producto_gama_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_gama_fkey FOREIGN KEY (gama) REFERENCES public.gama_producto(gama);
 E   ALTER TABLE ONLY public.producto DROP CONSTRAINT producto_gama_fkey;
       public          postgres    false    208    2807    205            �     x��X�r7]�_��L�H�n �XR���FTSqj����	��P��L��|ɬ2��"����͹�nRVǳ�XE���ǹ�^(f�*�l���ڗ�f/umM���_0�TZDq&�a��3]5�/ZoL�U�>a�_��������6KG|���DFQ�₉(����`=��W|�4niuk6�kþ�v�n	*�q$z�~���tU>ٚ�3t�����8"�t������t���vi�;vV�5tp"'�a����]3 ����$!�+�#���w�K���b�.N ŮM�!��;g�Gtx'B$0����UWUc�������?=P�.u��8�#d����?bBq�D��2W1|bӯ.�
�4<Vt�Yg�J�x]j6ӥ�%[�k[�$/�5g��"h;1^�:�.\c��Ƽu(E���&�{s<o̪#��M�o͈� /f��VΦUw�A�[>�o5/Aĵ5�;6נӥ�7�,M�Js���%T�a�W��w�і��ǘϡED�r�.ؕn����΂'~��kS��-\͋D�L`*�[� �跈�����%v���4#812���^��M��M����-큷�h��Q��q@�����'��Ȕ ��!�����Bq�ޚ�k��^���B9��@ `�� ��W�V��(�`ޟI�X���t5 /P�� _��)A��ܕ��1��X�2�K��so�!�x��	���)$�[]=�+��Je�$����8\t�f���:ЙL �QJٰ�e�Jpՙ���3��Q�"8�!���S�Ϫ����x��X�x�T���W"�2"���!>�T�P:������|���B��������R��#@�C���U�� �؏�7�8B�4�瑝_�$4��
Vdy�(�u�Y�@W?Pa��;G2E��4n�14�D���\�G|��b���x��X.[J?����t):I�5�ؼҏ�Y`�k=�w�H����`Aa�
mF?=Py�&S��fD�ӦE�%��0�s	���A�[������,5�ȓ�����M6ر\�b<Æ�٘��ːb���dK*%��?�R��"D��CP���U���@�ݫzɤrk
(���d�9W�"���<���mP��p�N=���	e��h���{ݲÜi�˵#�<�9  �I�$`Kͯ�^n�ԭC8[�֭<�t�J�"(bL7i���U�G7����?��ΓS��7�#"d3 �{D	rn�w��݆*5RRBё݆
%4lLr�f$�<PhF5U[�Q�^?p�e<�yqfA2)zL5T2����]������gP>�g9ژ��@N
�ST����B���(�BLR���bg(��l��8z����w����5
�����P3���ڽ[���Wu�Q7�66����3W�ø��צu�!��PB�X6N�I6�G�6��5OX�NB�{W�z!c�E�!�2����'�Z�*z#����}>�t'݃-hc�r6Yy7h�	����(�@$�ُpIh:0�l�1K�PZq��G�ҟ�=�@��qs��PQ�f����2�*p�	tBH�n,�Q$�!Y�x5��1��e�iJ$8:i�.���h�a�[ e#P̂'k�������� 	a�/q�2s\28&�?�h�B$����[ʳ᭩��mH�v���޵�*ױ��W�)p#���M�}�����ZQ�����ŀv� 2)��$)�c�T�J��qB�٦�z��4q���dﺟ&��x<}+1��i�d��a�CMDs��Z{�������8�pP1>J$��u.�����l!O�D�o�y�~M#���;\��ePˇ��u����u54�E�لJ]W�a�=�>�c?ф�qY�i �������HH`�o�Pj����T�̅Ab�
P�zmhD������+6[��S��� j��ڮW-ݝ�p#��5���˷(rS��%8��p�ɟx�S�D�
��n�c̦�5[ll�F�1[��4�ƭ-K�����V�XrĻ�]��D_P��Ѭ��#x���?���/^����      �   �  x�m�=�d)�m�.3���\g܍h{���P���zf}� !���%���5f��f��s�/I����2S˩�&�tG�QQ$=�6֜�JMr>�b�TS9� ]--S��[?�r�H�S��9�;II�S�j��?`��6��9�[UϊKG�#�o��Z|�F�����HMU-�W �����V*M=�{h�j�u�RN���[J�6�0�D�㤒��F��@3U�fv�������n��%�d��@:N��#�ńd�N����Y�R��Vj�(��������N�l��tD[�׳#��ق���58�W��_KDx�wY���P�q�C���1�N(-P�Q��0�+<Я���t����5����ٛ�R��x�y��B��8p`VrML3J�*W;���q����t�{_3��k�v��l�%�g�c.�Ef�N��ǠE���a�b菅�n��H��P��7vC6P��O���������NC�;�D�:��m=�[�/��VM ?bz����}�~G]���qP�kB���'��4Q��И&a�v��g���:��)	1n�q\�At�Mg1�ˊ�b��?��D�teB�;�:W��j7Yi؉(KА/Ev�K�L�L�P���n����ae�ޤҬ�7>[!���B��-�u�!"tp�ݖ������BP7�K�nVO�8rdU}�)��>�T�L�,�`�r��Y�q\��:���њ��{�!	�Ҥ�l�u8mӢ�ʪff¼��o��~�	8�����M�+���8pQ�tm,��a6�@|��s��w.�X���� �Ƥb��w2M�
�%N=jI�b��
� kk�[Л1s�&h]��ɼCO��]Yvh�܊z��|�z1I����hw�x	At�O�����~ՃLk��^=�清_�]_�@���ָ���� ��#6�2�~c%*���
1k�¯����+T�$�*Q��+(촚��;�;}g�����	�J*V��m���h��$ʏ~�n
2���4)�mEϒ�+%�<�ݟ_��A�h�rg8#��{G�ဃ�Q_=3R#�$����BM��U�.J}��6��L��鄢���R���/���
(q� :q�3��x˸Y��F���}�. ��������gz��8�AT��@��ɺO?_����En��:�[� �"_v�f��[Ӎ#�+j4`=�HpY <�>>�����O�UHO��s�h���d��DͼR�n+<���j?�2VB���H0��s�=�(��l�������ʠ-�mƵ��f�����Lo�繢��צv�^�4�/Fw�W�6x��gl`꜊�̇3*7r'��z�2��=y.���S�iVY�DZ�)�a�qs���ф��&��]��`M�ʼ���{�U��Ia}�p�����s��wb+�18&}m�ϵ,�y@k�++���z&Q^v4�p!�GJ}�-Ԡ^�Vʹ��X����͈]⦭�l</�y����ŏrv�Y@*j�l�𨎤�F?$�|�Z߮���掖rw���z�D#``z���T'Z\�D�,T���+Ly��ۥi�i�!E��J4��(���'Ul����;��W�z�ؑ�_a6�n\�"��&�����[�@*�Հ��v��9^7�=r�i�N��>��{)��;RnWg���=XC:�{���ܡ�ƸK���u�ا^��Ť&���b�A�*wS�jb�0�
l�mW�R�c3P{�7����
�6�*VBu�;J��-�Nik��\ũ��\���B��T�`����|ٻ��q߯\�mi>#Ygܸ���|Ȑàh�Dp����	ލ�k����N��>E�Uh�^�Oq���-�E�T��K$�h��C@'ԛ%/���KAѲ'�{��9Z����F~`��������x`�o&�`�ȃ�"&�<�(�`����n��|��<�Y��,Ov�';˃7����SH������ ��~�^���%      �   X  x����r�0�ׇ����.ޅ$�B!I;��FY����y�.���x���q�2b:t�9�s>��&�T[<Vl���7���^ҥ�|s�af!7�]pK��Q���>��F���4�p�e�Ҵ�sE��� �{���$d���hV�5q[��U#���s�k�iD�53��T�u�Y��ÿ��ʙm�N03-��-�L�^�L���D�@���܅6�4�R�8M�e�h�sQAbZ��C"����	Q9�uhX0�D^-��^�8I*�cܦT;�Y�.pU͆"�ebHL}%{׿�p/�,E*k���AL��¤`�R�k���KKhT�BC`��,Ӧ���wUeZ�Ϣ�譐�ѕ�+ב��*�^��8��Y�T���z���G����z|��AHCm��0��a9nxS���2Mh�M~��yƄ��	1~�8�=��1�1�\�G[��/�$0��M���� �4��TK�RZ%I/�岴.W�q���HuFw�ik0�ְC#��7f摡x���Q���x��.�Xa`T+Wì3�DaQD�fPv�e���혲yi�f���ì��0�L��4g���͇ʭ���m[�}��r� C�WfxX��8ĮU)mwڴ~z�A�&�Sjà�x���7+ە�	D�ŅH�`�a����"sAc�����z�(&�j��~r��ys�ݰ��)k��?"<q+�m�g�5�Y��6媴�du��}�}�V�*��	���#�h2n=�z3s�o�0p�/���$a�j������z��r��B�<1�
����-�P�qV�[~Q�����M����0z�ϫ���������S���_<~$x�E�̻Q�u�t�e[g�G�t�h4~dH"      �   �   x�M�A� E��s��ƸR���Ch���0��	�M����?��IԄ��9�	#���iLv.���u&-Ui�4.�aH6pA����W�(<�w�z�w��:ɔ�Q��K.��(9V� l�f�E�rW�8� ���g�-�õO���f�l	��R�Ze      �   %  x�M�Mn�0���t��
�"-yI�v�����@7���b@II}���.����� K��`��8ʗ���Ԯ!�������}a�C�H$LԀ�L�~0��ǖ���&$M[Rm|�0ޔ�F�"�F��\��nLp��G�fI�,
�Rs���5���v9�|��w3�����f_Sg�/&&�X"���)Q0L�4LrPWu�#�¢��t�ͻ��pZ;磅�Ty[��9��%✝c���Y
��6��B��:\{k:Dk���X��-L=5�}�1U��aX�\b*��IC���\{����tsCMQ1͟�
j�<�-�Y0�0����� �	>D��^8c� g�װg���1���c՘#��<�a9��9,������A(�b�
�1�xm�����{�v�AD[=?�m���S���pc컷�S�ٺ�xN��@ ���U��A��[F���zo�Aտ�xo[��̯P�u�s�]��5l�����?�i ?أ�(��AęJ���8n!$*�Ș��:[D?�FQ�hmؚ      �   :  x����N�0��λ����ϼ@�DU�-���6���F9X���xf�n?��O7}������# G]�`@��NҚd�d��G(3�����/2�LQAo�Q����T�pM��r?��F���g%�{<N���|����fCM+Vg�lN������y��BɃsU�-K\żLUZ!�oз,��мZ�h��cl�
��K�&ʫ�o�clZw�sn�2���:@LJ��@��T��H�x�n kT(�̢d�x��=����nr/�Z���a�����К��0S̀M�w0����O�a~V���      �   B	  x��Z�n��>��B����_wnA✒�`7ǽ��e�j�Wj���(s�a��r�Y?"KR�c�f0���Xd�?�G�d�U���5�.���A?���}T�O�ҧN}1�L$.�oEv+s�$Vl�_U��i��G8�?�1=�3����Ğ���Ȍ�r��w��u�I}������qs3�c{6�8�'���w'8��>����54�P&{�@���0���"pץMg7�O
�P)\B����Y��Y���_���?��9���&�X�Zu�էG3��9O�w"t[Qr���kt�:�s(�z�����~Jo�;���K�����<b�E�UM��ij��ӟ&�j8��:{ܳN�9D��,�A"%
h�$�W�u�DT��@R%
�VzO�_'��Lr1
��O=�P�*&���Af{�E�-�K�ga+[_^Qi;$��vK�G�o��84=MC�*��c!���*s`��2$7�%7{K̗I	B��,E�����Hy��P��!Z=�c��bV96?��wY±Q�nl�����a�b��T�\wT|��Ӫ��7�W�p�Yڴ�6���h���F���Ԝ$��I��.P��w�zr7o���E����=䓺�'  ��bja1�b�Bdlb�h��J�Do���s�>{�C�l��]�#�xX����h�/_-����w�H�����|�m.�Py���6�tM%��������تi��4��!�v��E2+}z9qz/�1V��:������K�2�w�}�yU��#*����W6E��-�{j*����AU�~ꛙ0�r��xn{�~?_{�Ɯr/_a�8$����Y<�H{��D�4�=y��������[A%i�\�S�O��L�(��yR���7�=����sGq�׸��=��2���=��5WzḂ�{oD%g�?���-P�����g�_ Ɛ�Mf4;Y%E��ڿ�%�y����0�/?;� ]}?M���%�6@5��i�#R:��A�-�lm%�Y�8�:��?���	��������@�@����`Ϊ������S���Ĝ��37�bn�w�Ը2V��-b�C��ѣ��"0q �p�˿��>sN���P3~�ב3�d�,Y��؏��sǡٖ$[��U�75�k�B��6P�-�&>,���._G�p�6�])'_�\�W�B�U
ctM���Ԑa�%�-#�e�h�P~��'#�@�No���40lv���Wt8ѹea�<f.R�B�P���x0cakz�k��J�LN41J:~���q��<�G��7vUFKq,Y﷯c!`���N-��qh��ܦ���E�:Gƃ6ƥ߷��$?�}�Ȋz��n#�����߫��޻��~���m���j�C�
��g�����w ��{���uƦ"�2�)��v�Í�	�R�l<�q�Ֆ�'�bLaCZ��bp�e���&��2*' 3��<�t�e?'�5�f�4���� �NzhT�xw���a�]�OaU��|ѷ��ɞA���<�;��8�=������`T��6�P"YsE '+4���������1A���ؤ%Nb��~F�@%9��,��$���m-r�ҋ�{�^5pl�;�Zg���qU�3%�6:@8���ᦀ��zH�29��!z�?��60�^?��F]~>*��#`��8���6G�s��)Dj���Tp'����5�*%u{Q�Avmcj/�h�T�� �x:�ꨭ�:���/�UB� �UД����
	�=��{�g���{��(�����|��{��^&�j��.���e�����>�-���?[�� �p.�(HJF�Y�F�i8�(�1�*�CUP#WĈ��qd�6�� n��:.�����ڗ�h/�=��K�� _%"���%_]h�<6`ކ��d[�W�gr��p��ٙ�r$� ����1�~��Y?0N��k+F�04>���oy�ct�x�6�A�k�T�Z�n�G�و\5W�v�#z!�@g�����a��Ӄ�JbI&ٱ���d4���XM��=m"�%�G7�/K�1���k�'B�IiNS�� �7����H(_��c���\���h����h ��&�T���ŇE<W�[. t�����S�ͳ��V��ؒ�Z5\��,Qq��ib���	ur�i��M��``_�fY3�f�,l��U��f:M��r���gY>Z�0��eH�"�J6�UK���[Kox}�ɷ��|��w�9���o�9�҂f8L����V�.�G�1G]=���<��́�r����Q����ۢp�U�k��w"��v�,�/�|��Z<���+�S��"N������x%%z��*��C�$����      �   t  x���Mn�@�לS�E��/�0X����Z�$"��3j!�&� ֪�a.V:I�����{Ï�)<`E�-��K����;lљsx$�n=<6i���n�Fs�d��\���AGPx�]��\���U[��|�]��p�����0�DXva���!U������W�$�x_�����/�&ˠ��f�
��mװ�e�5���֡�V]�]��#![�����t��1wSKeT\F��Z�p����!ve�G��(yo���(��%U��D'�{�l��ty��0i�i�
r���p����>��]�*��՗��]��}��mF�Aכ1,V�a4��l)���%�;=|!G�NOk��&���J������1�7.ݥ      �      x��}K��H���+��I�w59�v�*�Λ��x"#%�(RŇ��o�?q/0�Zz /��� �ҿd�w"HQ�#e�n�Uf�QVf��q�s��m�#��Wq,���U�I�m�//��񻹯�T&V������B�Od�P��� �����e"��X��D	7
�)1�����,�����4�e��Ȇ��?�^(��6��R����?%"�1͒T��9�W����W���}�D�}E#�C��I����_��-(�SM)��-�)7Vo\�A�<�"�"�cFLb�E�*��X%�rg)���T�$������"LU�j�9���Z₨�WQ,�Y�&�g�f��ɤ�+5�!�vB�Z��T�J
P��WR/<i��TE�^АZb�)�=�ȉ��[��4rw��<3�'���������a"����������DϤX]z˒7�|ũ��-��Yv��n[�M���c�;}�J�
"���"|�' ]�5%fa ��� XFt���kZ�	�*�Yű
��x����B�L���!�M���g�*�|!]Oy�7��g]�$�� `�}C�\���a7���y<���X	zU�L4�UFk����D��i�_y����E�����[��@I���2���F�^�d�z���Y�N�c����Ѥw��Oz/�p꧙���u�-Qz��h��s���ˊ�Bv�ZD��q-�jDf£�OH���b��D�c�'fѤ���#?Q�PB�6`���;Xr#�;�_7�m���uS���>�1CzM�m]f1�Q�(I�E�b���s㖀岖ʈE��N��cŉ3��C�|1�H@/$�%��_^{��$Z0˦��л�K�Ő�ň�B.!��#�#�!=a���"�մPs�����U�Nb�'K��@�9�qd
�WHC_~%.��Q���؟��+R��a�&pEMe��RK]��ow�rI��TT�ʊk������XYҝb�ib���'z/�*qGx#��[�T�Q��ǄPh�H���_�f��Uh�x�|C��Z�7!asSe��{� l���Y�%�L��v	hb]�.�?�N�&X����O�"p�A}%�~|,a�W$`�ٜEs��0��)4re������㑽 Q!G�
����L�M�f%�9f�_���֩����/Ӑ=���'1e�$lي��6�i����ꇄs<N3y�ѓ>��ŋ6���/d����u�P�'�X�a6'SA?��6[��6#���+/�x��� 8�d����$�4>b���isJ�9�o����2�;���J��S����!<ql�Z�>�
�$��Q��W@)C�WA@{}"��>aU���1�XB,0泐�@,�w2Q4I�a��Gg�}Mh��3eB%����?7덥0+d�_���mI�պö���#�0Th�y�0�o�ƃ�7�s�?f��Б��i!� !� ,^�]�G�'���AX*u�
IN�anbI& fXr����[b�O��I�Xv�Ha'&��
������іbg����b�=�B�pBʉT m��e��J+a43��U�S�ي��U�Xل��f)$��|fQ��Fyb�2W��������/5�ɒ�%%��_.�(����)E�º3jhmH6��M3���1o,�Os}M���i�\2	�4�{@��"�
��h�$�g���O�x�C!�bǧ5�l��[�!)����x% H�@�"��u�7����EmBK�B�һ<�y�&��yhLF�77�[��;���q����͈�v �z��%޽�=Bt������'h����؜#\ӯY��,�?����7c#pk���f��:ネ��)Ʈ�N0-�ofv|xTF�ld��$�^K�������f2��W��e��AKD�Q�PhH����ܹ
yaBP�ٸ�o,T�v���s#e=ŻAƳaD�c�`�I�x�!�5�u��}�b�c�>j��]�;�Ҹj$4j�'�|b4��D��'ԑΏ�)�~�3�����I����
#�=�צ�&��t�.f��濤��?`e�D���ٮ��IS��_ɵRجiZ�q~������S?�7��a�������[։Ī����&N�myf�7��U���ج5%z����%2�X��F��أs��	m�>�G���'	���r��{|d�,)lr!�!��T�$5	�����E��-e|��7R���%[ek���B�����F��Q���Iπ�@(�`Lj���&��`������S	��CxqHN0N��3� G�E������X72X�/��w�������h��l�x�%�q\���Ik< 
o@[�@���_��t���T�F��],�m����i��}������0dO��@V[���H�ece`9�;��'K�)�Q�~�M���1���#����7��t��vyظZ/f�9�Ng~J
�<|qF͞��Y��Y�"V�(t�j�����rH���I�����	��J��<G�o��g��Ǐ����I%7�pŜ
LT�$�S� ��<2"����8������)Ҧ6��1�ae%���b����g��b��S��@#נ)�58��-���[�w��#\���
����s�E�C:0�ό5��Oo�X����G�����)d����Ҵ7v
�g@@�ר�Ch\� ���f�&څS���ODB�(i���ڛy"뀶Kx&o6�=�?a�Xʭe
uL�_�~g�#'�1���ք'-̴��g�4�"j�3�e��j�|>a���X��.�7��~�B�?i^�;-��g�N.R�4C���kN��J�lm$=�䡘t<�8�,xy뿿!Uc�l�q�iT����B�!D3�R��o�1D�����<���1�s� %;��"��	d0����Q�\�c��'�JU"��Q+�Z���L^��_�k���RĿ\��m���2:��k��"��tK����m��&#�����;��`�"E���v�i��4�@K�Mkl!�? Ş�ر�3?��c�:J��2��Ip2�f���:�v�\�1n�$x��}v�E�I��8�V����xQSǙ	.�)rfD��}��f0J�"�*Bߚ��Z��Ȳ��:��ٹ%�iL�~3�$��Cp2rr]e��K�X�KK7���s���R@!G��W�Ci��B��w�#XDvI-��<�Nr�.�4A���G�2sVsvQg}��5�����fuTS�F;pI�q̆�4��3e�(#�8*bi�\9Q������{+h=2�
`�M�`��v��ʗǨ^Ӝt�?���c����+&�m�:a�\�GX�#�t�3w4�R���`�0G�RXb�:�n&��:d9㽚ÿ�$x��f��s�E�U'<v�bD�[;bCRf=S.��aI\��C��o�ň'�ş�sE��;'�t����s�8��S�W����W�>,0�o(�,)�&����󔯯�+��i�]�!ȟ���+�t1���y7�U�Q/R����M�h��,�'����f�Aم�s����#K�^U�*��OZQ~����B?��y�d�y�/���9�h�#���I�}��� I��=L�?I�t��q�d���[q&���c��b�n��ӄ���h�<C,ɳ:c~��#���2'��q̌� {�:�QL��fO�-	�٣&/Q(�ǤEH|�E�-�1xFK 9� ��fS�$:�SM%)�.t!��o��SZfD.��Й/��iR*ڊӸ4+�Gv��m��sh�2�|�hƦ�"�dJE�e#7�n3zs�|"9�b�,e�gX��"��8S�B1=d��u�`�ǩ�mE���I=OZ���\���HBr��O�%��K(d�d�b�µǝ�8��l�r���vH��(�� ;�5�k�8�Ψ�q� ���~�ȟ+�m�[6�*���&����KY�(���"��E��ಘj�lIs�<��3�=DK|��ނg�F�&Ni�7��ۘ�H`�ɍ�{&�e�H�5��D�=�Ahp@�a�    f2Ю�ە���q�>&����օn��R���ȍ�20��2�s�f^Q+����������[CT��#�T��
a�MD!9~�+H6���
���� ��;f�����st}����p����%T��S���s������u���:��y������[ް�A�[��2'���<ܭ�!P{IW$���s���ᔏq����H*hv��g^w�ʤD�
	w�^���cԅ�*$�@��&a~-��C�i��a�>�~��9��c?��9���"T|�Ȓ�lfs�? �@�Ff����/�Eᚾ<Ȟ�iU
�:�(Y�,(�ivD)����"[HE���A��~�Y$�T��=:8��v�Ib��F.����.i>Tv�Bk��T1d�6�A��P׫k59�%��Â��G����E�����X��lw.P��E�+p0��>M���*��8/�7�20�qF*�9%!�y���˰#�z��R�"�xn����H=�J�-
�y�<�GR>Ȳ�P��t��Vl%Qo�� gS9F�WqK��o �y��=��-i�[�0W|7�G@��ҵ�+4tmٿ������bΈ���Ŷ�˛�8VI_�TR�j�>҇b(zZ�E���I�&}�	ep�P��O/��<���|1.�ʽv��k-Qk�ZK|Z����na�u�32��(Yť�w&�+"Q.��M�{a�����|&F1[DKS��O�UĄ'7R"� �"�R�u��*��v��Wff��+Ȓ����`���u%J	[ �m
" '(��V�e�,8�!*}��Fy�K�:�N�g���.�}=<��$%P��<j�N�2��U{��S�sD���^O���`Q�c�Ռ�W>N�	�����)R��@��	'���<���F��[�@e{�_�Qt��0�at7��i�����r��t9Z T��F���Na,T}\W*��_��E�<?q��9�O�Od�S�Ta�`6��7���7�����j�����$:H��0s#�l��!L Z��Y�J�گ#��D�$����S����8滑h�w@�U�$Lٺ#�{Uw���>R��5������;��N�����h��w7�"�3j�h�`�>��ơDA�v�>�hg:��q��[Z	7�؜�Ղ�g�̱���j���Ml�l��~|���jL#�Qsc޷Kp�0�(.ʂ˒/L�)�Ɗ[R	>�l����iB���?��4H���?��
������c�F�D|��Ȕk
�>[�96���\ī�6P#xcd?��^�����Fz)�> �m}q���
�tA�)K��H5r��T�>䅎u�8��s�(�$+g����Z�`"�>Dv���x"�����c��P�D���r��]$�<���v?u�[��̞1���E��¹����J��XK��"H��r�1^�%�|���0�)�λ�Q,ʓ���]L�ݖѧe�浪Ɵ���+5gg:�M6��T�U�d-���ؼn�s1�N�*���B��̯9��q�_�ԷYL�xͨώQ댛S��YL�K�:]<��4i����M�e]p�5�w�]]S+���D<h��Kz;�wg!��r�g����f>�}徭��$K��0�y����?�~Pe���!cS�` ��U�Yޞ7)� Is択5�&+�Ai
�{�.��ld��)E�O<SS�͙$�yL�[����u�R�Y��b�o�C/E�6;%�h��r0�}6��5�l� �޲Me�m��&*�o񢤠9���5&��t΁H���ǲ5��?-l���\�kb������'��m��u����Lj��+�t�I^
��a'/�I����y�,s,_��Ie��˿Z,�r,?��(P��o�ο*8w����U����h����vq��%��y$]��
��=��(K��k��_�E,��)����"�HK��5�=� 
������e��^abR�)�ᗒ�X6�OL��н��&�@
�q
�<��J#��p��Bw�|L�g\/��K���,�G�[�σ��zO_�^����9V���%�9;7e���@���wvw �Ⱥ��t%�Xo� Ư4��	Ƙ[�r痥.���7*ѷ�z�X�Q�j_t�>���Η�9Mj�^�!d�#5�<n2�(���k%���䧺z
��l�nP�I�2����!�t��;��p�O&E�x+�������tcK�����W
�mhˡ7.�P�hSF�~V���9k���$StH3@�9���
�.1�x��;�kt��.�][��)f�{�}7�.����Fwn;z������������z�L� �k��{����=���R�[���&���&����cr�rs��XwŤO-z�OnH�V<"���3�</�o���(T�n��)\��?7%�>�d�u�śr;~��kZ<��FS�2�~��0�`r.���a���I6�&8Jks�g/M�%���_���`xs�@�;�*�����y��;X ���XE�?]0`�U�	����L����ݙ9׀%(�`��E���� #�����5��@@|���8�q�)p�m[��Si5oR���S�"�9ew{�����y	�-����t]Z4pe�A�Ǒ%�W�i4��	�6Mu��6���"�ز�܌[�is�8��0�ߤ7S8D�(�T|<�[�"ԅ~=&G����N�W:��\�r��3�c����FnKT��z�=�aۜ)�L�}�O��3~����<w�+MB���Ⓗ�Ƙ9@�/����y�8҇�QŦJ�ma�U�(n���.?T�w�65l�N;��N�����~�s|����3q�s�����RѼA�r�.ɉuB�^�a�:r��e�h���E�V|sm�	n�#[[W%|��.�J$2��QDQ� ��-�]���n��cT��&c����i�z�p��I�E�$ ��$�d^��.&ǪW��䂬������L�o2�&�v,s�0���6 �����Z\�U��O�-����=`�>�D���e�`�Z��'�c�!E��\�1�Z�	�!�/�����
sN�އ=�m#,/��2�F'�x�8�qvg���XW3?�4�Ōz�����|�2���Y�2�U������$��-	�������_@���uE|�frU��^����7�8�N35��.#�
�\�/�	��w҃���p��I'Ӷ���ں!j�R��{2}ҞL�h��'e���	U 5?/:��B���wg�k~f<��h�8#"��75/m��Z�����x!ɬ�{�뮨[-e2��P�t3�e���Zz�a�ŵ;�m����)�ʟ�{���V���/%-���Oz�}6ɐ�3�,O�3_hQ������
A���@����<�~g�uձI�y�^~hғ�M�,��ϝ�,".�kt�m�oZ��ۀ�>M�����F����ɬD�Y}Ch���mN\�D���y߅|h�$][���Foo⬇.�x��|��;�Q7A�� �&Ȼ
��������������ap���{T��΄�O�Ǡ�Is%���d����&��2�mN;�g�:����4�(n�h�������Ef�J�U�Y�m״+���n�qi�{��'CC��0��' �en���v3B��o�K��oʏ�kd�)���a�J��$�8�촫=�{�Clҭ�k>}*>U�Q�Kq����N�G��>�unp]s�Sq��ºod_eQ3�S1�r�H�9Ȩ�{X3�1�|�g���d1�������R�+b����c��^�{��gD�l�$%�^g��GP���l�pg�D<��	.��Y�(����l����&�K|H���@�j;��|�:����G�?��;���A�6`k(�P�����K��e��k(�P�������b���5�?g,�^*��B�]��5�?s(W���w�<|��~_���|Q���+��(;�N��r���#�`�A)Ã;�ܺ���l�8y�A�-���>A;w��݅;zi��r����ٳt��������&:yw��ĵ�H��H5�aa��twqLՐ��A��_{{ qD�֐��A��o��    @��5$�HT��Hp���ė�J�oPt<ɺ�۸�m�>��LZ�d����h��L��5V��u��u��ҏܫ��Y��i��I~��{����S���&���'x�q�uLY�.�6���y���A�C����Ka�� �~p��8��e��b^m��r��h�Ǩ^#vʵ��qޜG�+1�Z>T"qȉ��`�(W��R�x�a�#ȝ?L�X��$�_�[��ɼa����a{�
9��*�V!��
��]C{��]5k�"8�8{Cg�8{5k�"8�x���rEI�����8�T��|ػ�Ox�'�wsT�^e���S/�/��U%���Q�ƫ;Pq�w�Y��]��՘�1S���Aցu&�|��f�����nv��97��U�zȌ��&g̮(���*��%�kp9+�?���q��ǯx1o�3�	_˅Ĵ.�&�-x���Gu=� �����k�1*t[��%�=	T��=l�|y�|	FM�
̛LJ���5��<�北��CoE�H��'��ۅl=�X�M�CK����-�cj�\���>d�hv�`��y�1P^����r��p�d��Ւ�%Jv5l5��#a�4_"h*1��&]r�*�Ε|&��J��]��<-<X7��M6��u%G�>d	�����"�A9[��޵�������t!�N(b�9 �;��Ȫ����JAϨ{Zw53��UCkZ�y�;���/�Ъ����_�/�yZJ�Bs�
��ͭ"�J~J���X��2��v��g0�է�1h3骖8�1�Ǳ�{��a��2Gf�6P����D"�����"#F���Y� (����p���rG��Ku4��ŬUu7X�c��/f���}t`��EE���*k����v��s<���_�K��.�}�!
OpB(nT��]e��W����K�c�Ou7kqv1�yz6��&��j��i�ݴ�}�'W��c-�L�ȸ|�Y0��W¼�#���_�������I�q���m,C����X;_�Ԉy�%�s��+1�5�q�C�6p������ē������|\����-"nN��"R�J!Z��M(%�m7K̖K�$�$y^M�k\�*)gؤ��U��4Oӌ���ÅdV��_�8�ew���3���J�1�l8��x3F�K>�L@��^,r1�r�fی��5�fB�RY�.j��l�����;� �$%1�C�	<g�E➎7�������-�yѣ5� �a|xh'02I�<�k���%e����%��EA�(F؅�)���X��f�z�I"$JK�F�}u��%Ǫ�t#h��u}~��eжq�k�'(��Y|\����OB��5A��WG.�����	�N�1���a;��t)�^�9�D7�(�Ƅ����7��{Th�c��y�+O��רۤ[�S*7�h�ǩ�	���F��C�<�Ɩn���*C����!#���8�����KL8NI|K�0���`a�*3��K��E���2��2�3�wF��)W:-Ք�$q-n�I����׋��Ĺڹѐ���(����ε��oP���mǪ�C�
ԊĽz�s-(��|���9"(I!)i:�Ӡ��ZR~�����:�Ģҭ���I���𹖖ZZji)IK�*-���"�#��n�!VK-,_��T��~UV.� �ŵV�ʗ-*�}eP��ڟ��8�|i;�V6�6�n���R�eHMe�Z�	��ˉ�����G֙�l�ŽK����h]���4� �_�Fi���A9��F>ӥ^��@��$����7[�Å������4'B0}�of�=b�}׈S��Xg���Y���͠��/�E!����K"w�±��GBB����sߤݱΗDfN�<����O�J��S�n(^e�;��g�S�Y��8Y�>2�8Ԃ�XǋU��(�����T��ߓ[��p�y��C�����ί�*�k�� S���NU�j�i�|�u�ud]�,&f>�t�!?�,�6͇��Q�z����s��p� �P���x����j}&���L�h�W�~�3:�c�v��7AXs쿓c���
�u�����W㊓�e��ΐàfv�:�u�i��n�l�+�i寞^�/�>:ߞ���en�geg��{,�^r�)W"
�Q�<_<}4~�y>_?:�c0���k0��m��Sn�:����Yu�39���C����y1�83������{���=�r��C{|���EA�������ۯ�u8��������B��>�?z~�M� ���S���>�>i��Y�J�5m�qC�h%�9��좤4hsC���1EF�Jƞ���׆Ds�B:�=ݶ�����T|K�tA���nrcU W�T��pn�C^h[W~J�D��cݐ�%U'��o�R�{��؄9� 趥�۱�����7~���d�⪢��9��K,O)W�[��=��>��������F<:?[��?��*�'A�Cz��4��(�������E�EF��*oϲ�߇�Mbxx��ދ��vڶ=�Ã���8����S{��]ڣ��}��]�
}q�>	��q�!;[�ϧ��gvCtD�����iҼ��9�"I}�J%�J=�0�k����s�[-&?��}��!;b��^�{��U|q#�8xjzi��&��d����=N���4��De^�����1I�����-f(@��j�{��2��6�G~�����I{���l�p%i5�q�Օ��m2��t�YD.��|��]r��~�:���`AJ ���C��)O�=v����+Z7҂���H�G�{?��l{G)�נ��y��`�H	xg~�Q���Z�=��I>��<]���(~7F�Bj�ɸe�pt�Ʊ)��c��c�&��fq%I�7��;�qp��Y��}��G���)�\�h������+�Ġc]F�s���{��ܻ[t~�����\�z���5�[�R兟������F�X4��;�Թa�y����1U�9�ҽ6���uC��Z<��U��N��^|��F֍J&�G�U����A�~�ݬ���CH�u��h1\�����з?���0r�X/�I�t�z��2�N��G��k������,!dI���I�����|�%͇r>Y�]���*hso0h�x�P�2�wOU:���Dfp�̡�ўU�s(�34gwi���u5#�C��l��Ūjt톻�OG�;���^��1�s��Ѿ��L=X(�w��	2�x��+���5c�q�{�*�?�J&�pl��Q��w<'apԷΔ��쑊<��?1���ѠJ����?V*�éxd�|-�U�~I,Q�G'Y2�������0!"�wЎ�Hv°GDr;�1����oТ�z<�T���9o"� ���A
�C	�%´K�|%H��N�)�~�{*�+�Fޘ
�}(q�;V�Ҥ>/���iw�����ZG%�J�g���Hh�?}^�M7�٢;@��Ө�����N��}�l+���Pz�rE��g6�>�!CM534M���Z��`�C)��q��P���E*$��,C�	39��!��TΓ��P�G�U׊�ȪRjw�$��YGwd�:vA�>�$r�.سzL�;((:�C?��?������{���嘰�XS�s7�.�ܻ��>�Nax;v��Mz�wf�����vy�;F�v��{�&�he?��9�s�v��A�05f��+���y�� �����@eh=�Rv8w*�ځ��F|�M/�%6��kա���Ղ!�nj{���C����}�ڰ�L8X^W��9J�zH\An���/ � FF}uA[@6ߕ����mu�t�$�k�������IE�����l��q0�PI;���.�w�*(��!���j�����"��Ly��~����oi��"��گ/�T%.���9�>?�f��A�1pPI�ފlWU���G�����*u(�xV��c[g+���V�(Ȫ"�cm{0F�2q:�Qbã��0�ͼ;֣X���cA���b{�+{�F#&�=J�G�Duzǉ�L"���؈���>;}2m'�����=�!M�������')�
(�����*����i>RhcL#<y7�Grtɣ6��Ի��5wȄ �  �TD�����N���X�wױ�gr1#�=��������{��v����~�k��&[�s�k�ȉ�%��>!;��M7?��;L瘭���.�(:���ctY��z{7�ݚ)�;8����cu�,��͆�Z�˄\��u�2)y����fo��;:�����҇!�����ߨ?�`/��*�^u�������$g�m���=�B"�����CC�>}���������IA���$������TX}*�7x*�U�V��i�5�|�}-�yr�օ�a��5�+L�l�f��^��۹��Q*X^��,��5a�w��r�E�Rw�\���_���ߒ�c|��i��?h�u=+��D_^^�z�$���f��9i���d�+2_��A�h��*X�[�:�&
�TH�*J�
�7d���0���ݸ��-�#>aadT��Ʊ��?��4H���?��^dM;'I~?a�ݢe3�G�B�U~��d5в:�z��f�<k�Y+ϣ��e�w�������5      �   ]   x�3��O*J,Vp�,��I-Vp
��)�,�,��K�K�*M�I�2ģ�9?'?7)3�˄�9�� 5�$��ӵ����TNǢ��<�RF�=... iY�     