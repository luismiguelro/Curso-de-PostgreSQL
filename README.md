# Curso-de-PostgreSQL x Platzi 馃挌
- [Curso de PostgreSQL](#curso-de-postgresql)
  - [Modulo 1 Configurar Postgres](#modulo-1-configurar-postgres)
    - [Clase 1 Introduccion](#clase-1-introduccion)
    - [Clase 2 Que es Postgresql](#clase-2-que-es-postgresql)
    - [Clase 3 Instalacion y configuraci贸n de la Base de Datos](#clase-3-instalacion-y-configuraci贸n-de-la-base-de-datos)
    - [Clase 4 Interacci贸n con Postgres desde la Consola](#clase-4-interacci贸n-con-postgres-desde-la-consola)
      - [Comandos importantes PostgreSQL](#comandos-importantes-postgresql)
    - [Clase 5 PgAdmin: Interaccion con Postgres desde la Interfaz Grafica](#clase-5-pgadmin-interaccion-con-postgres-desde-la-interfaz-grafica)
    - [Clase 6 Archivos de Configuracion](#clase-6-archivos-de-configuracion)
    - [Clase 7 Comandos mas utilizados en PostgreSQL](#clase-7-comandos-mas-utilizados-en-postgresql)
      - [Comandos de ayuda](#comandos-de-ayuda)
      - [Comandos de navegacion y consulta de informacion](#comandos-de-navegacion-y-consulta-de-informacion)
      - [Comandos de inspeccion y ejecucion](#comandos-de-inspeccion-y-ejecucion)
      - [Comandos para debug y optimizacion](#comandos-para-debug-y-optimizacion)
      - [Comandos para cerrar la consola](#comandos-para-cerrar-la-consola)
      - [Ejecutando consultas en la base de datos usando la consola](#ejecutando-consultas-en-la-base-de-datos-usando-la-consola)
  - [Clase 8 Presentaci贸n del Proyecto](#clase-8-presentaci贸n-del-proyecto)
  - [Clase 9 Tipos de Datos](#clase-9-tipos-de-datos)
  - [Clase 10 Dise帽ando nuestra base de datos: estructura de las tablas](#clase-10-dise帽ando-nuestra-base-de-datos-estructura-de-las-tablas)
  - [Clase 11 Jerarquia de Bases de Datos](#clase-11-jerarquia-de-bases-de-datos)
  - [Modulo 2 Gesti贸n de la informaci贸n en bases de datos](#modulo-2-gesti贸n-de-la-informaci贸n-en-bases-de-datos)
    - [Clase 12 Creaci贸n de Tablas](#clase-12-creaci贸n-de-tablas)
    - [clase 13 Particiones](#clase-13-particiones)
    - [Clase 14 Creacion de Roles](#clase-14-creacion-de-roles)
      - [Creando roles desde SQL Shell](#creando-roles-desde-sql-shell)
      - [Creando roles desde PGAdmin](#creando-roles-desde-pgadmin)
## Modulo 1 Configurar Postgres

### Clase 1 Introduccion

Introduccion por el profesor

### Clase 2 Que es Postgresql

Postgre es un motor de base de datos open source y usa el Objeto-Relacional, existen tres conceptos importantes acerca de las bases de datos

- lenguaje
- motor: Permite estructurar toda la informaci贸n dentro de un servidor
- servidor

Esta base de datos cumple con el est谩ndar ACID (reglas para bases de datos para tener buenas practicas)

**鈥? A: Atomicity 鈥? Atomicidad** -> Separar las funciones desarrolladas en la BD como peque帽as tareas y ejecutarlas como un todo. Si alguna tarea falla se hace un rollback(Se deshacen los cambios)

**鈥? C: Consistency 鈥? Consistencia** -> Todo lo que se desarroll贸 en base al objeto relacional. Los datos tienen congruencia (gracias a PK y FK)

**鈥? I: Isolation 鈥? Aislamiento** -> Varias tareas ejecut谩ndose al mismo tiempo dentro de la BD (o varias instancias)

**鈥? D: Durability 鈥? Durabilidad** -> Puedes tener seguridad que la informaci贸n no se perder谩 por un fallo catastr贸fico. PostgreSQL guarda la informaci贸n en una Bit谩cora y luego guarda el cambio efectivo en la base de datos.

Por Que PostgreSQL

- Tipos de Datos
- Integridad de Datos
- Concurrencia, Rendimiento
- Fiabilidad, recuperaci贸n ante desastres
- Seguridad
- Extensibilidad
- Internacionalizacion
- B煤squeda de Texto
- Funciones com PostGIS y PL

### Clase 3 Instalacion y configuraci贸n de la Base de Datos

Vamos a instalar PostgreSQL en nuestra computadora. A continuaci贸n veremos el paso a paso y algunos consejos 煤tiles para instalar y configurar correctamente PostgreSQL en nuestro equipo. En 茅ste caso, usaremos Windows, pero los pasos son bastante similares entre los diferentes sistemas operativos.

Primer paso: ir a <https://www.postgresql.org/> y descargar la version acorde a tu sistema operativo, una vez dentro de esa seccion haz click en **download installer**.

Es altamente recomendable seleccionar la pen煤ltima o antepen煤ltima versi贸n. Si bien la 煤ltima versi贸n estable est谩 disponible, en 茅ste caso la 2.0, no es recomendable instalarla en nuestro equipo, ya que al momento de instalarla o usar un servicio en la Nube para Postgres, lo m谩s seguro es que no est茅 disponible y s贸lo est茅 hasta la versi贸n.5, que no es la 煤ltima versi贸n. Esto porque todos los proveedores de Infraestructura no disponen de la versi贸n de Postgres m谩s actual siempre (tardan un poco en apropiar los nuevos lanzamientos).

Si tienes un equipo con Linux, la instalaci贸n la puedes hacer directamente desde los repositorios de Linux, EDB ya no ofrece soporte para instaladores en Linux debido a que se ha vuelto innecesario, el repositorio de Linux con PostgreSQL ofrece una manera mucho m谩s sencilla y est谩ndar para instalar PostgreSQL en linux.

Segundo paso: descargamos la versi贸n 鈥淲indows x86-64鈥? (porque nuestro sistema operativo es de 64 bits). En caso de que tu equipo sea de 32 bits debes seleccionar la opci贸n 鈥淲indows x86-32鈥?.

Vamos a descargar la versi贸n.5. Hacemos clic en Download y guardamos el archivo que tendr谩 un nombre similar a:
鈥減ostgresql-.5-2-windows-x64.exe鈥?

Ahora vamos a la carpeta donde descargamos el archivo .exe, debe ser de aproximadamente 90 MB, lo ejecutamos.

![postgre_instal_](src/postgre_instal_1.jpg)

Hacemos clic en siguiente. Si deseas cambiar la carpeta de destino, ahora es el momento:

![postgre_instal_2](src/postgre_instal_2.jpg)

Seleccionamos los servicios que queremos instalar. En este caso dejamos seleccionados todos menos 鈥淪tack Builder鈥?, pues ofrece la instalaci贸n de servicios adicionales que no necesitamos hasta ahora. Luego hacemos clic en siguiente:

![postgre_instal_3](src/postgre_instal_3.jpg)

Ahora indicamos la carpeta donde iran guardados los datos de la base de datos, es diferente a la ruta de instalaci贸n del Motor de PostgreSQL, pero normalmente ser谩 una carpeta de nuestra carpeta de instalaci贸n. Puedes cambiar la ruta si quieres tener los datos en otra carpeta. Hacemos clic en siguiente.

![postgre_instal_4](src/postgre_instal_4.jpg)

Ingresamos la contrase帽a del usuario administrador. De manera predeterminada, Postgres crea un usuario super administrador llamado **postgres** que tiene todos los permisos y acceso a toda la base de datos, tanto para consultarla como para modificarla. En 茅ste paso indicamos la clave de ese usuario super administrador.

Debes ingresar una clave muy segura y guardarla porque la vas a necesitar despu茅s. Luego hacemos clic en siguiente.

![postgre_instal_5](src/postgre_instal_5.jpg)

Ahora si queremos cambiar el puerto por donde el servicio de Postgresql estar谩 escuchando peticiones, podemos hacerlo en la siguiente pantalla, si queremos dejar el predeterminado simplemente hacemos clic en siguiente.

![postgre_instal_6](src/postgre_instal_6.jpg)

La configuraci贸n regional puede ser la predeterminada, no es necesario cambiarla, incluso si vamos a usarla en espa帽ol, ya que las tildes y las e帽es estar谩n soportadas si dejas la configuraci贸n regional predeterminada. Es 煤til cambiarla cuando quieras dejar de soportar otras funciones de idiomas y lenguajes diferentes a uno espec铆fico. Luego hacemos clic en siguiente:

![postgre_instal_7](src/postgre_instal_7.jpg)

En pantalla aparecer谩 el resumen de lo que se va a instalar:

![postgre_instal_8](src/postgre_instal_8.jpg)

Al hacer clic en siguiente se muestra una pantalla que indica que PostgreSQL est谩 listo para instalar, al hacer clic de nuevo en siguiente iniciar谩 la instalaci贸n, espera un par de minutos hasta que la aplicaci贸n termine.

Una vez terminada la instalaci贸n, aparecer谩 en pantalla un mensaje mostrando que PostgreSQL ha sido instalado correctamente.

![postgre_instal_9](src/postgre_instal_9.jpg)

Podemos cerrar 茅sta pantalla y proceder a comprobar que todo qued贸 instalado correctamente.

Vamos a buscar el programa PgAdmin, el cual usaremos como editor favorito para ejecutar en 茅l todas las operaciones sobre nuestra base de datos.

Tambi茅n vamos a buscar la consola鈥? Tanto la consola como PgAdmin son 煤tiles para gestionar nuestra base de datos, una nos permite ingresar comando por comandos y la otra nos ofrece una interfaz visual f谩cil de entender para realizar todas las operaciones.

En el men煤 de Windows (o donde aparecen instalados todos los programas) buscamos 鈥淧gAdmin鈥︹??

![postgre_instal_0](src/postgre_instal_0.jpg)

Ahora buscamos 鈥淪QL Shell鈥︹??

![postgre_instal_1](src/postgre_instal_1.jpg)

Efectivamente, ahora aparecen las herramientas que vamos a utilizar en 茅ste curso.
Ahora vamos a crear una base de datos de prueba usando la consola y comprobaremos si existe usando PgAdmin, la crearemos para validar que la conexi贸n con el servicio de base de datos interno funciona correctamente.

Para ello abrimos la consola, buscamos SQL Shell y lo ejecutamos. Veremos algo as铆:

![postgre_instal_2](src/postgre_instal_2.jpg)

Lo que vemos en pantalla es la consola esperando que ingresemos cada par谩metro para la conexi贸n.

Primero est谩 el nombre del par谩metro. En 茅ste caso es 鈥淪erver鈥? seguido de unos corchetes que contienen el valor predeterminado. Si presionamos 鈥淓nter鈥? sin digitar nada la consola asumir谩 que te refieres al valor predeterminado, si en 茅ste caso presionamos 鈥淓nter鈥? el valor asumido ser谩 鈥淟ocalhost鈥?. Localhost se refiere a nuestra propia m谩quina, si instalaste la base de datos en el mismo pc que est谩s usando para la consola, el valor correcto es Localhost o 27.0.0. (representan lo mismo).

Podemos dejar todos los valores predeterminados (presionando 鈥淓nter鈥?) hasta que la consola pregunte por la clave del usuario maestro:

![postgre_instal_3](src/postgre_instal_3.jpg)

Debemos ingresar la clave que usamos cuando est谩bamos instalando Postgres, de lo contrario no podremos acceder. Presionamos Enter y veremos a continuaci贸n una pantalla que nos indica que estamos logueados en la base de datos y estamos listos para hacer modificaciones.

De manera predeterminada, la base de datos instalada es Postgres, la cual no debemos tocar, ya que ejecuta funciones propias del motor. Es usada por el Motor de PostgreSQL para interactuar con todas las bases de datos que vayamos a crear en el futuro.

La siguiente imagen indica que estamos conectados a la base de datos Postgres. Vamos a crear una base de datos nueva y luego saltar el cursor a 茅sta base de datos reci茅n creada.

![postgre_instal_4](src/postgre_instal_4.jpg)

Para ello escribimos el comando 鈥?**CREATE DATABASE transporte_publico;**鈥? y presionamos 鈥淓nter鈥?. Veremos:

![postgre_instal_5](src/postgre_instal_5.jpg)

El mensaje **鈥淐REATE DATABASE鈥?** justo despu茅s de la l铆nea que acabamos de escribir indica que la base de datos fue creada correctamente.

Para saltar a la base de datos reci茅n creada ejecutamos el comando 鈥?**\c transporte_publico**鈥?, el cursor mostrar谩 lo siguiente:

![postgre_instal_6](src/postgre_instal_6.jpg)

Ahora vamos a validar desde PgAdmin que la base de datos fu茅 creada correctamente. Abrimos PgAdmin y nos encontramos con una lista de items a la izquierda, lo que significa que de manera predeterminada PgAdmin ha creado un acceso a nuestra base de datos local, el cual llam贸 鈥淧ostgreSQL鈥?:

![postgre_instal_7](src/postgre_instal_7.jpg)

Al hacer hacer doble clic sobre 茅ste elemento (鈥淧ostgreSQL鈥?) nos pedir谩 ingresar la clave que hemos determinado para el super usuario postgres, al igual que la consola, hasta no ingresarla correctamente no nos podremos conectar:

![postgre_instal_8](src/postgre_instal_8.jpg)

Ingresamos la clave. Te recomiendo seleccionar la opci贸n 鈥淪ave Password鈥? o 鈥淕uardar Contrase帽a鈥?. Si la m谩quina sobre la que est谩s trabajando es de confianza, que seas s贸lo t煤 o tu equipo quien tenga acceso a ella, de lo contrario, no guardes la contrase帽a para mantenerla segura.

Veremos la lista de bases de datos disponibles, la predeterminada 鈥減ostgres鈥? y la que acabamos de crear usando la consola, lo que comprueba que la base de datos y la consola funcionan correctamente.

![postgre_instal_9](src/postgre_instal_9.jpg)

Ahora procedemos a eliminar la base de datos reci茅n creada para comprobar que PgAdmin est谩 correctamente configurada y si pueda realizar cambios sobre la base de datos.

Para ello hacemos clic derecho sobre el elemento 鈥渢ransporte_publico鈥? y seleccionamos la opci贸n 鈥淒elete/Drop鈥?. Al mensaje de confirmar hacemos clic en OK.

Con ello, si el elemento 鈥渢ransporte_publico鈥? desaparece del men煤 de la izquierda comprobamos que PgAdmin funcionan correctamente.

### Clase 4 Interacci贸n con Postgres desde la Consola

Vamos a aprender los comandos mas 煤tiles en la shell, al iniciar siempre encontramos los siguientes puntos

Server [localhost]: valor predeterminado o del server al que queremos conectarnos

Database [postgres]: Escribe aqu铆 la base de datos a la que quieres ingresar o enter para la predeterminada

Port [5432]: Idem conceptos anteriores

Username [postgres]: Idem conceptos anteriores

Contrase帽a para usuario postgres:

#### Comandos importantes PostgreSQL

- **\l**: lista las bases de datos del sistema (siempre va a haber por default 3 bases de datos propias de postgre + las que agreguemos).

- **\dt**" muestra las tablas de la base de datos de postgresql

- **\c + nombre base de datos**: usar una base de datos

- **\d + nombre tabla consultar**: describe el contenido de una tabla especifica.

- **\h SELECT**: ayuda para funciones est谩ndar SQL.

- **SELECT version();**: ver la version de PostgreSQL

- **\g** permite volver a ejecutar la funcion previa ejecutada en consola (repetir lo anterior).

- **\timing**: muestra el tiempo de ejecuci贸n de un comando, algo muy importante para las optimizaciones.

### Clase 5 PgAdmin: Interaccion con Postgres desde la Interfaz Grafica

Esta clase retoma los comandos anteriores del shell ahora con la interfaz grafica.

Para conectarnos tenemos el item PostgreSQL(   ), a diferencia de la shell PGAdmin permite hacer cosas custom como colores y tags.

Creamos una base de datos propia usando la parte de server del arbol del admin.

En el dashboard podemos observar como Postgres usa el mismo motor de forma redundante para hacerse consultas a si mismo y saber que esta pasando en el entorno de ejecuci贸n para esta base de datos.

En la parte del Admin en Server podemos crear una base de datos  desde cero a partir del servidor y conectarla al localhost o a una base de datos alojada en un server local o remoto.

![pgadmin_](src/pgadmin_1.jpg)

![pgadmin_2](src/pgadmin_2.jpg)

![pgadmin_3](src/pgadmin_3.jpg)

![pgadmin_4](src/pgadmin_4.jpg)

Podemos usar en el menu de  tools el Query tools

![pgadmin_5](src/pgadmin_5.jpg)

![pgadmin_6](src/pgadmin_6.jpg)

### Clase 6 Archivos de Configuracion

Antes de crear tablas o hacer dise帽os es importante conocer 3 archivos de configuracion que muchas veces son el origen de los problemas cuando estamos agregando nuevos servicios o configurando la base de datos

Los archivos de configuraci贸n son tres principales:

- **postgreql.conf**: en este archivo podemos cambiar puerto, numero de conexiones maxima, accesos para ip 煤nicas. (un pro en bases de datos siempre ha le铆do todo el documento). En este archivo tambi茅n se encuentra la informaci贸n de las replicas

- **pg.hba.conf**: contiene los roles, tipos de usuarios, permisos, direcciones, m茅todos de acceso con MD5, tambi茅n puedo negar a otros hosts a conectarnos,este archivo es muy importante dado que nos permite no solo dar acceso a usuarios y a las replicas sino protegernos de ataques o personas mal intencionados

- **pg_ident.conf**

La ruta de los mismos depende del sistema Operativo, para saber que que ruta est谩n, basta con hacer una Query

**SHOW config_file**;

NOTA: siempre es bueno hacer una copia original de los archivos antes de modificarlos por si movemos algo que no.

### Clase 7 Comandos mas utilizados en PostgreSQL

La consola en PostgreSQL es una herramienta muy potente para crear, administrar y depurar nuestra base de datos. podemos acceder a ella despu茅s de instalar PostgreSQL y haber seleccionado la opci贸n de instalar la consola junto a la base de datos.

PostgreSQL est谩 m谩s estrechamente acoplado al entorno UNIX que algunos otros sistemas de bases de datos, utiliza las cuentas de usuario nativas para determinar qui茅n se conecta a ella (de forma predeterminada). El programa que se ejecuta en la consola y que permite ejecutar consultas y comandos se llama psql, psql es la terminal interactiva para trabajar con PostgreSQL, es la interfaz de l铆nea de comando o consola principal, as铆 como PgAdmin es la interfaz gr谩fica de usuario principal de PostgreSQL.

Despu茅s de emitir un comando PostgreSQL, recibir谩s comentarios del servidor indic谩ndote el resultado de un comando o mostr谩ndote los resultados de una solicitud de informaci贸n. Por ejemplo, si deseas saber qu茅 versi贸n de PostgreSQL est谩s usando actualmente, puedes hacer lo siguiente:

```sql
SELECT version()
```

#### Comandos de ayuda

En consola los dos principales comandos con los que podemos revisar el todos los comandos y consultas son:

**\?** Con el cual podemos ver la lista de todos los comandos disponibles en consola, comandos que empiezan con backslash()

![comandos_](src/comandos_1.jpg)

**\h** Con este comando veremos la informaci贸n de todas las consultas SQL disponibles en consola. Sirve tambi茅n para buscar ayuda sobre una consulta espec铆fica, para buscar informaci贸n sobre una consulta espec铆fica basta con escribir \h seguido del inicio de la consulta de la que se requiera ayuda, as铆: \h ALTER

De esta forma podemos ver toda la ayuda con respecto a la consulta ALTER

![comandos_2](src/comandos_2.jpg)

#### Comandos de navegacion y consulta de informacion

**\c** Saltar entre bases de datos

**\l** Listar base de datos disponibles

**\dt** Listar las tablas de la base de datos

**\d <nombre_tabla>** Describir una tabla

**\dn** Listar los esquemas de la base de datos actual

**\df** Listar las funciones disponibles de la base de datos actual

**\dv** Listar las vistas de la base de datos actual

**\du** Listar los usuarios y sus roles de la base de datos actual

#### Comandos de inspeccion y ejecucion

**\g** Volver a ejecutar el comando ejecutando justo antes

**\s** Ver el historial de comandos ejecutados

**\s <nombre_archivo>** Si se quiere guardar la lista de comandos ejecutados en un archivo de texto plano

**\i <nombre_archivo>** Ejecutar los comandos desde un archivo

**\e** Permite abrir un editor de texto plano, escribir comandos y ejecutar en lote. \e abre el editor de texto, escribir all铆 todos los comandos, luego guardar los cambios y cerrar, al cerrar se ejecutar谩n todos los comandos guardados.

**\ef** Equivalente al comando anterior pero permite editar tambi茅n funciones en PostgreSQL\

#### Comandos para debug y optimizacion

**\timing** Activar / Desactivar el contador de tiempo por consulta

#### Comandos para cerrar la consola

**\q** Cerrar la consola

#### Ejecutando consultas en la base de datos usando la consola

De manera predeterminada PostgreSQL no crea bases de datos para usar, debemos crear nuestra base de datos para empezar a trabajar, ver谩s que existe ya una base de datos llamada **postgres** pero no debe ser usada ya que hace parte del CORE de PostgreSQL y sirve para gestionar las dem谩s bases de datos.

Para crear una base de datos debes ejecutar la consulta de creaci贸n de base de datos, es importante entender que existe una costumbre no oficial al momento de escribir consultas; consiste en poner en may煤sculas todas las palabras propias del lenguaje SQL c贸mo **CREATE**, **SELECT**, **ALTER**, etc y el resto de palabras como los nombres de las tablas, columnas, nombres de usuarios, etc en min煤scula. No est谩 claro el porqu茅 de esta especie de 鈥渆st谩ndar鈥? al escribir consultas SQL pero todo apunta a que en el momento que SQL nace, no exist铆an editores de consultas que resaltaran las palabras propias del lenguaje para diferenciar f谩cilmente de las palabras que no son parte del lenguaje, por eso el uso de may煤sculas y min煤sculas.

Las palabras reservadas de consultas SQL usualmente se escriben en may煤scula, 茅sto para distinguir entre nombres de objetos y lenguaje SQL propio, no es obligatorio, pero podr铆a serte 煤til en la creaci贸n de Scripts SQL largos.

Vamos ahora por un ligero ejemplo desde la creaci贸n de una base de datos, la creaci贸n de una tabla, la inserci贸n, borrado, consulta y alteraci贸n de datos de la tabla.

Primero crea la base de datos, **鈥淐REATE DATABASE transporte;鈥?** ser铆a el primer paso.

![comandos_3](src/comandos_3.jpg)

Ahora saltar de la base de datos **postgres** que ha sido seleccionada de manera predeterminada a la base de datos transporte reci茅n creada utilizando el comando \c transporte.

![comandos_4](src/comandos_4.jpg)

Ahora vamos a crear la tabla tren, el SQL correspondiente ser铆a:

```sql
CREATE TABLE tren ( id serial NOT NULL, modelo character varying, capacidad integer, CONSTRAINT tren_pkey PRIMARY KEY (id) );
```

La columna id ser谩 un n煤mero autoincremental (cada vez que se inserta un registro se aumenta en uno), modelo se refiere a una referencia al tren, capacidad ser铆a la cantidad de pasajeros que puede transportar y al final agregamos la llave primaria que ser谩 id.

![comandos_5](src/comandos_5.jpg)

Ahora que la tabla ha sido creada, podemos ver su definici贸n utilizando el comando `\d tren`

![comandos_6](src/comandos_6.jpg)

PostgreSQL ha creado el campo id autom谩ticamente c贸mo integer con una asociaci贸n predeterminada a una secuencia llamada 鈥榯ren_id_seq鈥?. De manera que cada vez que se inserte un valor, id tomar谩 el siguiente valor de la secuencia, vamos a ver la definici贸n de la secuencia. Para ello, \d `tren_id_seq` es suficiente:

![comandos_7](src/comandos_7.jpg)

Vemos que la secuencia inicia en uno, as铆 que nuestra primera inserci贸n de datos dejar谩 a la
columna id con valor uno.

```sql
INSERT INTO tren( modelo, capacidad ) VALUES (鈥榁olvo 鈥?, 00);
```

![comandos_8](src/comandos_8.jpg)

```sql
SELECT * FROM tren;
```

Consultamos ahora los datos en la tabla:

![comandos_9](src/comandos_9.jpg)

Vamos a modificar el valor, establecer el tren con id uno que sea modelo Honda 0726. Para ello ejecutamos la consulta tipo **UPDATE tren SET modelo = 'Honda 0726' Where id = 1**;

![comandos_0](src/comandos_0.jpg)

Verificamos la modificaci贸n **SELECT * FROM tren;**

![comandos_   ](src/comandos_   .jpg)

Ahora borramos la fila: **DELETE FROM tren WHERE id = ;**

![comandos_2](src/comandos_2.jpg)

Verificamos el borrado **SELECT * FROM tren;**

![comandos_3](src/comandos_3.jpg)

El borrado ha funcionado tenemos 0 rows, es decir, no hay filas. Ahora activemos la herramienta que nos permite medir el tiempo que tarda una consulta **\timing**

![comandos_4](src/comandos_4.jpg)

Probemos c贸mo funciona al medici贸n realizando la encriptaci贸n de un texto cualquiera usando el algoritmo md5:

![comandos_5](src/comandos_5.jpg)

La consulta tard贸 0.0mili-segundos

Ahora que sabes como manejar algunos de los comandos m谩s utilizados en PostgreSQL es momento de comenzar a practicar!!!

### Clase 8 Presentaci贸n del Proyecto

El proyecto consiste en el modelado de un sistema de transporte de personas mediante trenes.

Reto

- Pasajero
- Trayecto
- Estaci贸n
- Tren
- Viaje
### Clase 9 Tipos de Datos

PostgreSQL soporta los siguientes tipos de datos

Principales y comunes en SQL:

- Num茅ricos(N煤meros enteros, N煤meros Decimales, Seriales)
- Monetarios(cantidad de moneda)
- Texto(almacenar cadenas y texto, existen tres VARCHAR, CHAR, TEXT)
- Binario(1 Y 0)
- Fecha/Hora(Para almacenar Fechas y/o Horas, DATE TYPE, TIME TYPE, TIMESTAMP, INTERVAL)
- Boolean(Verdadero o Falso)

Especiales propios de postgres

- Geom茅tricos: Permiten calcular distancias y 谩reas usando dos valores X y Y.
- Direcciones de Red: C谩lculos de m谩scara de red
- Texto tipo bit: C谩lculos en otros sistemas, ejm(hexadecimal, binario)
XML, JSON: Postgres no permite guardar en estos formatos
- Arreglos: Vectores y Matrices

### Clase 10 Dise帽ando nuestra base de datos: estructura de las tablas

![diagrama_entidad_relacion_proyecto](src/diagrama_entidad_relacion_proyecto.jpg)
![diagrama_entidad_relacion_proyecto](https://user-images.githubusercontent.com/101124184/222177318-2c013519-e122-423d-9a3b-351764fb0c69.jpg)


### Clase 11 Jerarquia de Bases de Datos

Toda jerarqu铆a de base de datos se basa en los siguientes elementos:

- **Servidor de base de datos:** Computador que tiene un motor de base de datos instalado y en ejecuci贸n.

- **Motor de base de datos:** Software que provee un conjunto de servicios encargados de administrar una base de datos.

- **Base de datos:** Grupo de datos que pertenecen a un mismo contexto.

- **Esquemas de base de datos en PostgreSQL:** Grupo de objetos de base de datos que guarda relaci贸n entre s铆 (tablas, funciones, relaciones, secuencias).

- **Tablas de base de datos:** Estructura que organiza los datos en filas y columnas formando una matriz.

**PostgreSQL es un motor de base de datos**.

La estructura de la base de datos dise帽ada para el reto corresponde a los siguientes
elementos:

![bd_proyecto](src/bd_proyecto.jpg)

La base de datos se llama transporte, usaremos su esquema predeterminado public.

El esquema public contiene las siguientes tablas:

- Estaci贸n
- Pasajero
- Tren

Y las tablas de relaciones entre cada uno de los elementos anteriores son:

- Trayecto
- Viaje

El esquema relacional entre las tablas corresponde al siguiente diagrama:

![diagrama_entidad_relacion_proyecto_styled](src/diagrama_entidad_relacion_proyecto_styled.jpg)

**Estaci贸n**
Contiene la informaci贸n de las estaciones de nuestro sistema, incluye datos de nombre con tipo de dato texto y direcci贸n con tipo de dato texto, junto con un n煤mero de identificaci贸n 煤nico por estaci贸n.

**Tren**
Almacena la informaci贸n de los trenes de nuestro sistema, cada tren tiene un modelo con tipo de dato texto y una capacidad con tipo de dato num茅rico que representa la cantidad de personas que puede llevar ese tren, tambi茅n tiene un ID 煤nico por tren.

**Trayecto**
Relaciona los trenes con las estaciones, simula ser las rutas que cada uno de los trenes pueden desarrollar entre las estaciones

**Pasajero**
Es la tabla que contiene la informaci贸n de las personas que viajan en nuestro sistema de transporte masivo, sus columnas son nombre tipo de dato texto con el nombre completo de la persona, direcci贸n_residencia con tipo de dato texto que indica d贸nde vive la persona, fecha_nacimiento tipo de dato texto y un ID 煤nico tipo de dato num茅rico para identificar a cada persona.

**Viaje**
Relaciona Trayecto con Pasajero ilustrando la din谩mica entre los viajes que realizan las personas, los cuales parten de una estaci贸n y se hacen usando un tren.

## Modulo 2 Gesti贸n de la informaci贸n en bases de datos

### Clase 12 Creaci贸n de Tablas

Las tablas en PostgreSQL siguen el est谩ndar SQL para las tablas

- CREATE
- ALTER
- DROP

**Creaci贸n una base de datos en pgAdmin**.

En el arbol del server damos click derecho en nuestra BD_PRUEBAS/databases en la opcion CREATE y asignamos un nombre.

![create_table_](src/create_table_1.jpg)

PGAdmin tambi茅n nos muestra la sentencia que ejecutara por debajo en consola.

![create_table_2](src/create_table_2.jpg)

Se crea todo el arbol relacionado a la base de datos, dentro de este se encuentran los Schemas, de manera predeterminada se crea el Schema public en el vamos a crear nuestra primera tabla

![create_table_3](src/create_table_3.jpg)

Le asignamos el nombre de pasajero (aunque como practica com煤n las tablas se nombren en plural)

![create_table_4](src/create_table_4.jpg)

Y creamos las columnas definidas en nuestro diagrama entidad-relacion

![create_table_5](src/create_table_5.jpg)

Nota:

**Serial** es un tipo de dato de postgreSQL y corresponde a un tipo de dato Integer Autoincremental.

**Character Varying** es un tipo de dato similar a Varchar en otros manejadores, si no estamos seguros de la longitud podemos dejar el area vac铆a.

**Date** Corresponde a fechas.

Ahora definimos los constraints para definir nuestra llave primaria, el **est谩ndar de postgres** es **nombre_de_la_tabla_pkey**

![create_table_6](src/create_table_6.jpg)

Al final podemos ver la sentencia SQL y guardamos nuestra tabla.

![create_table_7](src/create_table_7.jpg)

Con ello creamos la tabla pasajero, ahora usaremos PGAdmin para crear el script de inserci贸n dando click derecho a la tabla y seleccionando insert, esto crear el script autom谩ticamente para (INSERT INTO de SQL) agregar los datos.

![create_table_8](src/create_table_8.jpg)

![create_table_9](src/create_table_9.jpg)

Borramos **id** por ser autoincremental

Para obtener la fecha actual escribimos y saber en que formato insertar los datos

```sql
SELECT current_date;
```

Insertamos el registro seleccionado solo el query a realizar y usamos el boten de play o F5.

![create_table_0](src/create_table_0.jpg)

Podemos verificar que los datos yendo a los query tools y hacemos la consulta de la tabla.

**Reto:** crear las tablas faltantes del diagrama entidad-relacion.

Aqu铆 los scripts del reto

```sql
-- Crear tabla tren
CREATE TABLE public.tren
(
id serial,
modelo character varying(20),
capacidad character varying,
CONSTRAINT tren_pkey PRIMARY KEY (id)
)
WITH (
OIDS = FALSE
);
ALTER TABLE public.tren
OWNER to postgres;
-- Crear tabla estacion
CREATE TABLE public.estacion
(
id serial,
nombre character varying,
direccion character varying,
CONSTRAINT estacion_pkey PRIMARY KEY (id)
)
WITH (
OIDS = FALSE
);
ALTER TABLE public.estacion
OWNER to postgres;
-- Crear tabla trayecto
CREATE TABLE public.trayecto
(
id serial,
id_estacion integer,
id_tren integer,
nombre character varying,
CONSTRAINT trayecto_pkey PRIMARY KEY (id)
)
WITH (
OIDS = FALSE
);
-- Crear tabla trayecto
ALTER TABLE public.trayecto
OWNER to postgres;
CREATE TABLE public.viaje
(
id serial,
id_pasajero integer,
id_trayecto integer,
inicio date,
fin date,
CONSTRAINT viaje_pkey PRIMARY KEY (id)
)
WITH (
OIDS = FALSE
);
ALTER TABLE public.viaje
OWNER to postgres;
```

### clase 13 Particiones

En ocasiones llega un punto en elq ue tienes mucha informacion en una sola tabla, y al momento de consultarla la base de datos tendr谩 que hacer el recorrido de toda la informacion para encontrar el contenido que estas buscando.

Imagina que nuestra tabla de viajes tiene cien mil registros, y que quieres consultar los viajes realizados en un rango de fechas, esa consulta ocupara un espacio en memoria que deber谩 ser le铆da para obtener la respuesta, en este punto entran las particiones.

Las particiones tiene como ventaja lo siguiente:

- Separaci贸n f铆sica de datos
- Conservan la Estructura L贸gica

La separacion f铆sica hace referencia a que es posible guardar varias parte de la misma tabla en diferentes espacios de disco o incluso en otros discos, internamente Postgre usando el mismo nombre de la tabla asigna otras peque帽as tablas que tienen un rango definido, en nuestro caso le dir铆amos que el rango son las fechas o las horas, por ejemplo una partici贸n para junio, otra para julio y al hacer la consulta con el mismo **SELECT** de siempre Postgre buscar铆a la informacion solo en la partici贸n correspondiente, esto reduce el tiempo de ejecucion de la consulta y a su vez evita que la tabla se bloquee al ser consultada o escrita demasiadas veces en periodos de tiempo cortos.

En esta clase vamos a crear una tabla, asignarle particiones y despu茅s hacer un **INSERT** com煤n y corriente y hacer una consulta com煤n y corriente con pgAdmin.

Creamos la tabla bitacora_viaje con toda la informacion de los viajes tendra los campos id, id_viaje, fecha, fecha sera el campo por el cual vamos a particionar la tabla.

![particiones_1](src/particiones_1.jpg)

**Como lo hacemos?**

Primero indicamos a la tabla que haremos la partici贸n y luego por cual campo seria, para despu茅s agregar cada una de las particiones por separado para ello iremos al apartado **Partition**.

Dejamos constraints vac铆o, y en General indicamos que es una tabla particionada.

![particiones_2](src/particiones_2.jpg)

Con ello nos pide una llave para hacer la partici贸n, la asignamos en la tabla partitions

![particiones_3](src/particiones_3.jpg)

![particiones_4](src/particiones_4.jpg)

Creamos un **INSERT**  para dicha tabla.

![particiones_5](src/particiones_5.jpg)

Observamos el error al no existir ninguna partici贸n, ahora hay que crearla, esto lo hacemos creando una nueva tabla

```sql
CREATE TABLE bitacora_viaje_200_0 PARTITION OF bitacora_viaje
FOR VALUES FROM ('200-0-0') TO ('209-0-3')
```

Creamos la tabla de partici贸n para 200 del mes de enero ahora todos los **INSERT** correspondientes a ese rango de tiempo se guardaran en esa tabla.

![particiones_6](src/particiones_6.jpg)

Ejecutamos el INSERT con un rango de la partici贸n.

![particiones_7](src/particiones_7.jpg)

 Pero en contraste de que si queremos insertar datos fuera de ese rango de tiempo la operaci贸n nos arrojara un error como al principio, por lo tanto tendremos que crear una nueva partici贸n.

Observa que las particiones si existen f铆sicamente.

![particiones_8](src/particiones_8.jpg)

Nota final, no es posible crear llaves primarias en tablas particionadas ya que la informacion esta toda dividas, no te preocupes estas tablas se utilizan para guardar informacion en masa como bit谩coras y hacen referencia a tablas que si tienen estas llaves primarias (miralo como un pivot table)

Si vas a crear un proyecto donde tengas informacion hist贸rica es buena practica iniciarla como una tabla particionada para mejorar el performance de nuestra aplicaci贸n

En mi ejemplo use un rango de 9 a帽os de 200 a 209, pero si la data es enorme podemos hacer particiones en unidades de meses, semanas o dias.

Una vez aprendido este concepto borramos la tabla, ya que no es necesaria para el proyecto.

### Clase 14 Creacion de Roles

Hemos creado la tablas, ahora debemos mirar los roles, estos igual que las tablas tienen la capacidad de ser creados y eliminados, sin embargo tiene las siguientes caracteristicas especiales.

- Crear y eliminar otros roles
- Asignar atributos
- Agrupar con otros roles (conjunto global de permisos)
- Roles predeterminados
- Son independientes de las bases de datos

Hasta ahora hemos estado utilizando el usuario predeterminado de postgres, lo cual sabemos que es muy peligroso ya que al ser un usuario de tipo root este tiene todos los privilegios para borrar todo, lo ideal es crear un usuario para trabajar con los roles y permisos adecuados.

#### Creando roles desde SQL Shell

Crearemos un rol con la terminal que tenga la capacidad de hacer login

```sql
\H CREATE ROLE
CREATE ROLE nombre [ [ WITH ] opci贸n [ ... ] ]
donde opci贸n puede ser:
 SUPERUSER | NOSUPERUSER
| CREATEDB | NOCREATEDB
| CREATEROLE | NOCREATEROLE
| INHERIT | NOINHERIT
| LOGIN | NOLOGIN
| REPLICATION | NOREPLICATION
| BYPASSRLS | NOBYPASSRLS
| CONNECTION LIMIT limite_conexiones
| [ ENCRYPTED ] PASSWORD 'contrase帽a' | PASSWORD NULL
| VALID UNTIL 'fecha_hora'
| IN ROLE nombre_de_rol [, ...]
| IN GROUP nombre_de_rol [, ...]
| ROLE nombre_de_rol [, ...]
| ADMIN nombre_de_rol [, ...]
| USER nombre_de_rol [, ...]
| SYSID uid
```

CREATE USER es un alias de CREATE ROLE

```sql
postgres=# CREATE ROLE usuario_consulta;
CREATE ROLE
postgres=# \dg
Lista de roles
  Nombre de rol   | Atributos | Miembro de
------------------+------------------------------------------------------------+------------
 postgres| Superusuario, Crear rol, Crear BD, Replicacion, Ignora RLS | {}
 usuario_consulta | No puede conectarse | {}
postgres=#
```

En este punto hemos creado un nuevo usuario/role, pero este no tiene atributos/permisos para realizar ninguna acci贸n, solucionamos esto igual que una tabla con el comando ALTER.

```sql
postgres=# ALTER ROLE  usuario_consulta WITH LOGIN;
ALTER ROLE
postgres=# \dg
Lista de roles
  Nombre de rol   | Atributos | Miembro de
------------------+------------------------------------------------------------+------------
 postgres| Superusuario, Crear rol, Crear BD, Replicacion, Ignora RLS | {}
 usuario_consulta | | {}
```

Observamos ahora que desaparece la leyenda de que el usuario no puede conectarse, ahora realizamos la misma operaci贸n para darle los atributos de un superusuario.

```SQL
postgres=# ALTER ROLE usuario_consulta SUPERUSER;
ALTER ROLE
postgres=# \dg
Lista de roles
  Nombre de rol   | Atributos | Miembro de
------------------+------------------------------------------------------------+------------
 postgres| Superusuario, Crear rol, Crear BD, Replicacion, Ignora RLS | {}
 usuario_consulta | Superusuario  | {}
```

Ahora asignamos la contrase帽a a la base de datos.

```sql
postgres=# ALTER ROLE  usuario_consulta WITH PASSWORD 'etc23';
```

Ahora ya nos podemos cambiar nuestro rol accediendo con otra consola accediendo con el usuario_consulta

```sql
Server [localhost]:
Database [postgres]:
Port [5432]:
Username [postgres]: usuario_consulta
Contrase帽a para usuario usuario_consulta:
psql (   .9)
ADVERTENCIA: El c贸digo de p谩gina de la consola (850) difiere del c贸digo
  de p谩gina de Windows (252).
  Los caracteres de 8 bits pueden funcionar incorrectamente.
  Vea la p谩gina de referencia de psql 芦Notes for Windows users禄
  para obtener m谩s detalles.
Digite 芦help禄 para obtener ayuda.
postgres=#
```

Ahora hacemos la operaci贸n de borrado desde otro perfil de superusuario en este caso el default postgres

```sql
postgres=# DROP ROLE usuario_consulta;
DROP ROLE
postgres=# \dg
  Lista de roles
 Nombre de rol | Atributos | Miembro de
---------------+------------------------------------------------------------+------------
 postgres | Superusuario, Crear rol, Crear BD, Replicacion, Ignora RLS | {}
postgres=#
```

#### Creando roles desde PGAdmin

![create_user_](src/create_user_1.jpg)

![create_user_2](src/create_user_2.jpg)

Asignamos un password

![create_user_3](src/create_user_3.jpg)

Asignamos permisos para solo lectura

![create_user_4](src/create_user_4.jpg)

![create_user_5](src/create_user_5.jpg)

Ahora vamos a darle permisos a nuestras tablas para que el usuario_consulta pueda tener acceso a interactuar informacion y consultarla, este no podr谩 acceder a la estructura de la misma ni borrar informacion

![create_user_6](src/create_user_6.jpg)

![create_user_7](src/create_user_7.jpg)

Damos click en next y seleccionamos los permisos que se otorgaran en este caso insert, select y update

![create_user_8](src/create_user_8.jpg)

![create_user_9](src/create_user_9.jpg)

Verificamos que en las otras tablas.

![create_user_0](src/create_user_0.jpg)
