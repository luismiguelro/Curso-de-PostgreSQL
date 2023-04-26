-- 1. Mostrar 'Hola mundo' por pantalla.
DO $$
BEGIN
    -- mostrar por pantalla
    RAISE NOTICE 'Hola, mundo';
END $$;


-- 2. Declarar una variable numerica y mostrar si es mayor de 10 o no.
DO $$
DECLARE 
	mi_numero integer:= 8;
BEGIN
	IF(mi_numero>10) THEN
    -- mostrar por pantalla
    RAISE NOTICE 'mayor que 10';
	else
		RAISE NOTICE 'menor que 10';
	end if;
END $$;

-- 3. Declarar una variable numerica y pedir su valor y mostrarlo.

CREATE OR REPLACE FUNCTION ejemplo(numero INTEGER) RETURNS INTEGER AS $$
BEGIN
	RETURN numero;
END;
$$ LANGUAGE plpgsql;

SELECT ejemplo(104);
