-- listar todas las extensiones disponibles en postgres y visualizar una pequeña descripción de su funcionamiento 
SELECT * FROM pg_available_extensions;

-- 
CREATE EXTENSION fuzzystrmatch;
-- Funcion que retorna el número de letras que hay que cambiar para que las palabras sean iguales.
SELECT levenshtein('oswaldo', 'osvaldo')

-- Esta función nos retorna de 0 a  4 que tan iguales suenan las dos palabras.`
SELECT difference('oswaldo', 'osvaldo');
SELECT difference('beard', 'bird');


-- Esta función nos permite encriptar un password segun la forma de encriptación
CREATE EXTENSION pgcrypto;

SELECT crypt('123456789', 'md5');

-- Extensiones mas usadas: 
https://railsware.com/blog/postgresql-most-useful-extensions/