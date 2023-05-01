
-- 4. Mostrar los numeros del 1 al 10 con un while.
do $$
declare
	i integer := 1;
begin
	while i <=10 loop
		raise notice '# %', i;
		i:= i+1;
	end loop;
end$$;

-- 5. Mostrar los numeros del 1 al 10 con un for.
do $$
begin
	for i in 1..10
	loop
		raise notice 'El valor actual es %', i;
	end loop;
end$$;
-- 5. Mostrar los numeros del 10 al 1 con un for.

do $$
begin
	for i in reverse 10..1
	loop
		raise notice 'El valor actual es %', i;
		
	end loop;
end$$;

-- 6. Mostrar los numeros del 1 al 10 con un loop.
do $$
declare
	i integer := 1;
begin
	loop
	raise notice '%',i;
	i := i + 1;
	--  se usa para salir del loop cuando se cumple la condición.
    EXIT WHEN i > 10; 
	end loop;
end$$;