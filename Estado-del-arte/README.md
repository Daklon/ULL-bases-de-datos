# Administracion y Diseño de Bases de Datos
## Estado del Arte en Gestion y Almacenamiento de Big Data

### Introducción

Las bases de datos han estado en uso desde los primeros días de las computadoras electrónicas. A diferencia de los sistemas modernos, que se pueden aplicar a datos y necesidades muy diferentes, la mayor parte de los sistemas originales estaban enfocados a bases de datos específicas y pensados para ganar velocidad a costa de perder flexibilidad. Los *sistemas de gestión de bbdd* originales solo estaban a disposición de las grandes organizaciones que podían disponer de las complejas computadoras necesarias.

Hoy en día se ha extendido el uso de estos *SGBD* y cada vez son más utilizados y esenciales gracias a las funciones que ofrecen a múltiples usuarios y empresas, las cuales pueden ser controlar el acceso a los datos, asegurar su integridad, gestionar el acceso concurrente a ellos, recuperarlos tras un fallo del sistema y hacer copias de la información, 

Proporcionar métodos para mantener la integridad de los datos, para administrar el acceso de usuarios a los datos y para recuperar la información si el sistema se corrompió, así como también permitir presentar la información de la base de datos en variados formatos.

Generalmente se accede a ellos mediante lenguajes de consulta.

### Tipos de licencias
[Mac-OS]:https://www.wired.com/2013/08/jordan-hubbard/
[PlayStation-3]:https://en.wikipedia.org/wiki/PlayStation_3_system_software

Las licencias más utilizadas en las bases de datos pueden dividirse en dos grandes grupos, las privativas y las libres.

Las licencias privativas son usadas por bases de datos como SQL Server de Microsoft o por Oracle Database. Este tipo de licencias se caracterizan principalmente porque suelen tener un coste asociado. Además al pagar por la licencia, en la mayoría de casos, solo estás comprando la autorización a utilizar un determinado software bajo unas circunstancias determinadas. En ningún momento se podrá acceder o modificar ese software para que se adapte a tus requisitos a no ser que el fabricante te autorice expresamente a ello.

Por otro lado, las licencias libres pueden dividirse en dos grandes grupos, las licencias permisivas y las no permisivas.

Dentro de las licencias permisivas podemos encontrar la licencia MIT o BSD. La principal característica de estas licencias es que permiten total libertad con el software, no tienen ningún tipo de restricción. Incluso se puede licenciar el trabajo derivado como privativo (véase _Mac-OS_ o el Sistema operativo de la consola _PlayStation-3_).

En cambio, las licencias no permisivas se caracterizan por permitir cualquier cambio en el software, siempre y cuando el resultado sea compartido bajo la misma licencia o una similar que permita que el software siga siendo libre.

En cualquier caso ambas licencias libres permiten a los usuarios consultar, alterar y compartir el código del software licenciado. El tipo de licencia utilizado no implica el coste del software, el software libre se puede vender (por ejemplo Red Hat) siempre y cuando se respete la licencia.

### Bases de datos en la nube

Una “cloud database” o una base de datos en la nube, normalmente corre sobre plataformas que ofrecen las bases de datos como servicios. Hay dos tipos de bases de datos, independientes, que suelen ser populares:

* Usando una máquina virtual con una imagen, algún ejemplo puede ser Azure SQL que admite aplicaciones modernas en la nube en un servicio inteligente y administrado que incluye procesos sin servidor, usando la máquina virtual que ofrece se pueden migrar las cargas de trabajo con facilidad con compatibilidad del 100% con cualquier servidor de SQL, así como acceder a las bases de datos a nivel de sistemas operativos.

* Usando un servicio con suscripción a una base de datos, un ejemplo puede ser Personio. Los datos y documentos se guardan todos en expedientes digitales en un fichero centralizado, que se mantiene actualizado y con el que se ahorra más tiempo. Además cuenta con gestión de datos conforme a la normativa legal vigente de forma global.

Las bases de datos que están disponibles son las basadas en SQL y las que usan NoSQL.

* Las bases de datos *SQL* son aquellas que se pueden ejecutar en la nube, además estas poseen baja escalabilidad. Algunos ejemplos de bases de datos en la nube para SQL son:
  * Oracle DB
  * MySQL
  * NuoDB

* Las bases de datos NoSQL también pueden ejecutarse en la nube, pero estas están diseñadas para cargas pesadas de lectura y escritura y son capaces de escalar con facilidad, por lo tanto estas son mucho más adecuadas para funcionar de forma nativa en la nube. 
Sin embargo, actualmente casi todas las bases de datos están hechas en torno a un modelo SQL y por eso, trabajar con NoSQL requiere un desarrollo completo de código; aun sabiendo esto, existen algunos pioneros en el modelo de datos que ya usan NoSQL, estas son:
  * CouchDB
  * Apache Cassandra
  * MongoDB

### Principales empresas proveedoras

En el mercado de las bases de datos existen muchas opciones a elegir. Por ello podemos apreciar como ciertas de estas opciones aglomeran a una gran cantidad de personas. Debido a esto podemos observar cómo ciertas opciones destacan sobre otras haciendo que las entidades que se encuentran detrás de estos productos consiguen convertirse en opciones de referencia para nuevos usuarios. Entre estos nombres nos encontramos con los siguientes:

Dentro de las principales empresas proveedoras de servicios de bases de datos nos encontramos principalmente con Oracle como una de las empresas más conocidas y una de las bases de datos más empleadas.

También nos encontramos con Microsoft con su servicio Microsoft SQL server el cual se implementa en su propio sistema operativo para servidores y que puede ser complementado con los servicios en la nube de Azure. Este se encontraría como una de las bases de datos más populares.

Y entre otros de los grandes proveedores de bases de datos está MongoDB que proporciona tanto una versión gratuita como una de pago.

Aunque no tan extendido como otras bases de datos, IBM también provee con su propio sistema de gestión de bases de datos bajo la marca de DB2.

Aparte de estas nos encontramos con un gran uso de bases de datos libre. Estas bases de datos no pertenecen a ninguna empresa, sino que son mantenidas por la propia comunidad de personas que emplea estas herramientas, aunque en muchos casos también suelen recibir la financiación de empresas como son el caso de PostgreSQL o MySQL. Estas serían a su vez algunas de las bases de datos más empleadas en el mundo compitiendo con las bases de datos de pago.

Y por último mencionar a otra importante empresa que también se dedica a la comercialización de bases de datos es Amazon con su gestor Amazon simpleDB. Aunque hay que decir que esta cuenta con mucha menos repercusión sobre el mercado de las bases de datos que el resto de las ya mencionadas aquí.

Así podemos ver algunos ejemplos de empresas y comunidades que actualmente soportan y mantienen estos sistemas de bases de datos.

### Diferentes modos de comercialización

A la hora de elegir un servicio de base de datos se pueden elegir diferentes modos de usarlo.

En primer lugar tenemos el sistema tradicional. El software es descargado en tus propias máquinas y ahí es ejecutado. La ventaja de este sistema es que tienes un gran control sobre la infraestructura, la seguridad de los datos y sobre donde se almacenan. Las principales desventajas consisten en que puede llegar a ser más caro si el hardware no es dimensionado correctamente. Además es necesario darle mantenimiento a dicho hardware.

Otra forma de uso es como SaaS (Software as a Service). En este modo, no es necesario preocuparse por el hardware necesario para ejecutar la base de datos. 
Solamente se contrata el uso de una determinada base de datos y el proveedor se encarga de aprovisionar una máquina con el software solicitado. No tienes que gestionar el coste de compra del hardware ni su mantenimiento o configuración. Se suele cobrar siguiendo un modelo de pago por uso. Ejemplos de esto son dynamoDB, o RDS. La gran ventaja de esto es que podría llegar a ser más barato, ya que solamente se paga por el uso y no es necesario tener tanto personal o tan cualificado. La desventaja es que el coste de mantenimiento final podría ser mayor si no se tiene cuidado a la hora de liberar recursos no utilizados.

Por otro lado, dependiendo del software y de la licencia asociada, combinado con lo anterior, tendríamos el software privativo y el libre.

En el caso del software privativo se suele pagar una licencia para su uso. El precio de esta suele estar relacionado con el número de máquinas que la usarán y como de potentes sean. Por ejemplo, SQL Server cobra por cada máquina y por cada core usado por máquina. En otros casos se cobra por cada cliente concurrente en la base de datos. Por último también se suele pagar un extra para desbloquear algunas características más avanzadas.

Por otra parte, en el software libre el modelo que predomina consiste en poder hacer uso de todas las características de forma gratuita. Los desarrolladores posteriormente venden un servicio de soporte para aquellos clientes que lo deseen.

Hay un segundo modelo, no muy extendido en las bases de datos que consiste en tener una versión comunitaria gratuita y una versión empresarial de pago con algunas características añadidas no disponibles en la versión comunitaria, al menos hasta que alguien decida implementarla.

### Tipos de bases de datos

Como ya sabemos existen multitud de bases de datos diferentes aunque las principales son SQL y NOSQL. 

#### SQL

Las bases de datos SQL son bases de datos relacionales escrita en el lenguaje de consulta estructurado SQL (Structured Query Language). También hay que saber que las bbdd relacionales son aquellas que disponen de una relación predefinida entre sus elementos, donde cada registro pueda ser identificado de forma inequívoca. Este tipo es de las más utilizadas  y esto es debido a las ventajas que ofrece como:

* Permite evitar la duplicidad de registros garantizando la integridad referencial
* Atomicidad de la información evitando realizar operaciones que no deseadas al surgir un problema
* Dispone de un sistema estándar bien definido el cual es sencillo de entender

#### NoSQL

Por otro lado tenemos las bases de datos de tipo NoSQL estas son no relacionales, es decir,  que no cuenta con un identificador que relacione un conjunto de datos con otro. Este tipo también tiene sus ventajas aunque no sea tan utilizado.
Las ventajas son las siguientes:

* Son versátiles
* Las bases de datos NoSQL open source no requieren del pago de licencia
* Permiten guardar datos de cualquier tipo
* Realiza consultas utilizando JSON

Estos dos tipos nombrados anteriormente son respecto a cómo están desarrollados y que nos aportan pero también existen otros tipos que dependen de otros aspectos como del uso que se puede hacer de ellos.
Hay dos tipos dependiendo si el software es libre o no, software libre y software propietario.

### Software Libre

En el caso del software libre es aquel que puede ser distribuido, utilizado, copiado y modificado pero está protegido por copyleft lo cual impide a los distribuidores poner restricciones sus principales libertades son:

* Estudiar cómo funciona el programa y modificarlo, adaptándolo a tus necesidades.
* Mejorar el programa y hacer públicas esas mejoras a los demás.
* Distribuir copias del programa.

Sin embargo como muchos creen software libre no significa que sea gratis, que es algo que siempre se ha malentendido así que trabajar y vivir de este tipo software es posible.

### Software Propietario

En el caso de software propietario se basa en el uso de licencias que sin duda es una de las mejores maneras para obtener rendimientos económicos y al contrario que con el software libre pues no se permite la modificación, copiado, distribución ya que no dejan el código al público.
Alguna ventajas de este software son:

* Atención al cliente, ya que la empresa proporciona un soporte especializado en la ayuda a los usuarios
* Especialización y focalización, suelen tener un valor añadido respecto a otros software del mismo ámbito.
* Control a favor del autor y el uso malintencionado.
