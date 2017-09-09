# Atributos de calidad seleccionados:
### QA1: Disponibilidad Estudiantes: Daniel Restrepo Aristizabal, Marcos David Sierra Gallego
### QA2: Rendimiento Estudiante: Mateo Hincapie Zapata
### QA3: Seguridad Estudiante: Jose David Sanchez Castrillon

# Marco de referencia Disponibilidad
## 1. ¿Qué es?

*La métrica empleada para medir la disponibilidad es el porcentaje de tiempo que un sistema es capaz de realizar las funciones para las que está diseñado. Se emplea la fórmula siguiente para calcular los niveles de disponibilidad:*

*Percentage of availability = (total elapsed time - sum of downtime)/total elapsed time*

*La disponibilidad suele medirse en “nueves”. Por ejemplo, una solución cuyo nivel de disponibilidad sea de “tres nueves” es capaz de realizar su función prevista el 99,9 por ciento del tiempo, lo que equivale a un tiempo de inactividad anual de 8,76 horas por año sobre una base de 24x7x365 (24 horas al día, siete días a la semana, 365 días al año). En la tabla siguiente se muestran los niveles de disponibilidad frecuentes que muchas organizaciones intentan conseguir.*

#### Porcentajes de disponibilidad y tiempo de inactividad anual

**Porcantaje de disponibilidad**          **Día de 24 horas**           **Día de 8 horas**
1. *90%*                                     *876 horas (36,5 días)*       *291,2 horas (12,13 días)*
2. *95%*                                     *438 horas (18,25 días)*      *145,6 horas (6,07 días)*
3. *99%*                                     *87,6 horas (3,65 días)*      *29,12 horas (1,21 días)*
4. *99.9%*                                   *8,76 horas*                  *2,91 horas*
5. *99.99%*                                  *52,56 minutos*               *17,47 minutos*
6. *99.999%*                                 *5,256 minutos*               *1,747 minutos*
7. *99.9999%*                                *31,536 segundos*             *10,483 segundos*
  
## 2. ¿Qué patrones se pueden emplear?
#### a. Failover
*La conmutación por error, o failover, es un modo de funcionamiento de respaldo en el que las funciones de un componente de sistema (tal como un procesador, servidor, red o base de datos, por ejemplo) son asumidos por componentes del sistema secundario cuando el componente principal no está disponible ya sea debido a una falla o por el tiempo de inactividad programado.*

#### b. Failback
*Es el proceso para restaurar una operación a una maáquina primaria o a una secundaria en caso de que la primaria haya fallado.*

#### c. Replication
*Esto implica copiar los datos del nodo primario a todos sus nodos de respaldo y espera para que sea más fácil de cambiar en caso de failover.*

***Replicación activa:** En esta configuración, la solicitud del cliente es procesada por
Todos los nodos.*

***Replicación pasiva:** En esta configuración, el nodo primario procesa la solicitud y despues se copiará a los nodos secundarios.*

#### d. Redundancy
*Habrá múltiples componentes redundantes en el sistema para facilitar el failover normalmente se seguirá una configuración N + 1  o N + M.*

#### e. Virtualization
*Las interrupciones causadas por el hardware y el sistema operativo pueden ser reducidos mediante el empleo de la virtualización. La virtualización proporciona muchas ventajas, como
Distribución de la carga y enrutamiento de solicitudes, y permite a los administradores mejorar el hardware subyacente sin problemas.*

#### f. Continuous maintenance
*El mantenimiento regular aumenta la fiabilidad del hardware, asegura operaciones confiables, y extiende la vida total de este. A largo plazo, el mantenimiento reduce el costo total de propiedad del sistema. Las actividades de mantenimiento de hardware incluyen servicios regulares de servidores, limpieza de los componentes, copias de seguridad del disco y de la base de datos, actualización del hardware en base a las necesidades del negocio.*

***Mantenimiento Correctivo:** Esta es una forma reactiva de mantener el hardware en el que
el equipo de operaciones de producción y mantenimiento identificará la causa raíz y arreglará los problemas después de que se produzcan.*

***Mantenimiento Preventivo:** Supervisar de forma proactiva el rendimiento de los componentes de hardware y tomar medidas para incidentes de interrupción.*


***Perfective Maintenance:** Agregando más hardware para mejorar los tiempos de respuesta o optimizaciones de bases de datos para una ejecución más rápida de las consultas. Del mismo modo, en el frente de software, Perfective Maintenance incluye el desarrollo de un código más sensible, mejorando la autoayuda / páginas de preguntas frecuentes, mejorar la navegación y el descubrimiento de información, con el fin de mejorar la experiencia general del usuario.*

## 3. Especificación mediante escenarios

*Para identificar los escenarios se sigue la siguiente estructura:*

1. Fuente del estímulo: quién o qué genera el estímulo. 
2. Estímulo: lo que se quiere llevar a cabo.
3. Artefacto: parte del sistema que recibe el estímulo.
4. Entorno: condiciones dentro de las cuales se presenta el estímulo.
5. Respuesta: actividad que ocurre luego de la llegada del estímulo.
6. Medida de la Respuesta: criterio para testear el requerimiento.

![Escenario](/imagenes/escenario.jpg)

## 4. ¿Qué tácticas se pueden emplear?

1. ***Utilizar servicios de balanceado (ELB) y autoescalado de instancias EC2 (M3)**, de modo que nuestra web soporte tanto días de pocas visitas como días de muchas visitas, o fallos en alguna de las instancias que soportan el servidor web.*
2. ***Utilizar el servicio de base de datos relacionales de amazon (RDS) que soporta MultiAZ**, es decir dos bases de datos, y si falla la maestra (M) la esclava (S) pasa a ocupar su lugar.*
3. ***Utilizar el servicio red distribución de contenido (CloudFront)** para agilizar la visualización a la web en otras zonas geográficas del planeta, a la vez que permite el uso del servicio de Firewall Web ( WAF) que actúa de filtro evitando posibles ataques de seguridad a la web.*
4. ***Sobre los diferentes servicios e infraestructura** para que nos avise en caso de cualquier posible incidencia: checks de Route53, ELB, EC2.*
5. *Mediante el servicio **Cloudwatch**, con alertas personalizadas.*
6. *Realizar **backups periódicos** de los datos importantes o necesario en un servicio “duradero” como es el servicio Amazon Simple Storage (S3)*
7. *Crear una **web de backup** en S3 hosting/Cloudfront usando Route53 Dns Failover, si todo lo demás falla, la web seguirá*

## 5. Qué herramientas se pueden utilizar para lograrlo

1. JMeter
2. Amazon Web Services (Route 53, ELB, RDS, M3, WAF)

# Análisis mediante escenarios

### Primer escenario 
1. Fuente: Petición de un usuario para escuchar una canción.
2. Estímulo: Reproducir la canción.
3. Artefacto: Página web.
4. Entorno: normal.
5. Respuesta: El sistema maneja dos servidores, con el load balancer se decide a cual mandarle la petición, en el caso de que alguno de los 2 servidores falle el otro toma se convierte en el principal manteniendo así la funcionalidad de la aplicación.
6. Medida de la Respuesta: Número de veces que el sistema esté caido en un tiempo determinado.

### Segundo escenario
1. Fuente: Petición de varios usuarios a la vez para buscar una canción.
2. Estímulo: Buscar la canción.
3. Artefacto: Página web.
4. Entorno: Exhaustivo.
5. Respuesta: Si una base de datos se cae ya sea por el número de peticiones que tiene, o por otro motivo, tener otra disponible lo que permitirá hacer un failover para que la otra se vuelva la principal mientras se recupera la que fallo.
6. Medida de la Respuesta: Porcentaje de disponibilidad de la aplicación.

# Diseño

## 1. Vistas de arquitectura

![Vista de arquitectura](/imagenes/vistaarquitectura.jpg)

## 2. Patrones de arquitectura
*Los patrones de arquitectura a utilizar son los siguientes:*

### a. Replication
*Esto implica copiar los datos del nodo primario a todos sus nodos de respaldo y espera para que sea más fácil de cambiar en caso de failover.*

### b. Redundancy
*Habrá múltiples componentes redundantes en el sistema para facilitar el failover normalmente se seguirá una configuración N + 1 o N + M.*

### c. Virtualization
*Las interrupciones causadas por el hardware y el sistema operativo pueden ser reducidos mediante el empleo de la virtualización. La virtualización proporciona muchas ventajas, como Distribución de la carga y enrutamiento de solicitudes, y permite a los administradores mejorar el hardware subyacente sin problemas.*

## 3. Best practices
1. Monitoreo proactivo y alertando la infraestructura.
2. Redundancia de Hardware
3. Recuperación de desastres.
4. Arquitectura de software simple.
5. Automatización de actividades de mantenimiento.

## 4. Tácticas
1. Se utilizaran balanceadores de carga que nos ayuden a enviar los usuarios por diferentes rutas y así un servidor sólo no tenga que manejar toda la carga.
2. Utiliar herramientas como heartbeat que nos informen si la aplicación está "viva".
3. Utilizar redundancia para que el usuario pueda acceder a su información desde cualquier servidor.

## 5. Herramientas

1. Amazon Web Services (AWS abreviado) es una colección de servicios de computación en la nube (también llamados servicios web) que en conjunto forman una plataforma de computación en la nube, ofrecidas a través de Internet por Amazon.com.

2. JMeter es un proyecto de Apache que puede ser utilizado como una herramienta de prueba de carga para analizar y medir el desempeño de una variedad de servicios, con énfasis en aplicaciones web.

# Marco de referencia Rendimiento
## 1. ¿Qué es?
*El rendimiento es una requisito no funcional, del proceso de desarrollo de software al que no se le suele prestar demasiada atención pero que hace daño cuando el producto se encuentra en una fase avanzada de su construcción (porque requerirá esfuerzo corregirla) y todavía más en producción porque a ese coste hay que sumarle la pérdida de eficiencia y productividad de los usuarios en el uso de la herramienta y la disminución de la confianza de los mismos en el producto, lo que afectará negativamente a los gestores funcionales y técnicos del proyecto.*

*El objetivo del rendimiento es tener un buen tiempo de ejecución de las diferentes partes del programa, intentando minimizar los puntos problemáticos y las áreas donde se deba  llevar a cabo una optimización del rendimiento (ya sea en velocidad o en consumo de recursos).*

## 2. ¿Qué patrones se pueden emplear?
### a. Active-active redundancy 
*Consiste en tener n nodos, mínimo dos; los n nodos van a estar corriendo los mismos servicios al mismo tiempo. Para que esto suceda se usan los Load Balancer (Balanceadores de carga) para distribuir los servicios por todos los nodos, para evitar una sobrecarga en uno sólo de los n nodos. Este patrón nos proporciona una mejora en el tiempo de respuesta y en throughput.*
### b. Cache-Aside
*Cargar datos a petición en una caché desde un almacén de datos.*
### c. CQRS
*Segregar operaciones que leen datos de operaciones que actualizan datos mediante interfaces independientes.*
### d. Event Sourcing
*Utilice un almacén de sólo anexos para registrar la serie completa de eventos que describen las acciones tomadas en los datos de un dominio.*
### e. Index Table
*Cree índices sobre los campos en almacenes de datos que son frecuentemente referenciados por consultas.*
### f. Materialized view
*Genere vistas prepopuladas sobre los datos en uno o más almacenes de datos cuando los datos no están formateados idealmente para las operaciones de consulta requeridas.*
### g. Priority Queue
*Prioriza las solicitudes enviadas a los servicios para que las solicitudes con mayor prioridad sean recibidas y procesadas más rápidamente que aquellas con una prioridad inferior.*
### h. Queue-Based Load Leveling
*Utilice una cola que actúe como un búfer entre una tarea y un servicio que invoca para suavizar cargas pesadas intermitentes.*
### i. Sharding
*Divide un almacén de datos en un conjunto de particiones horizontales o fragmentos.*
### j. Static Content Hosting
*Implemente contenido estático en un servicio de almacenamiento basado en la nube que puede entregarlos directamente al cliente.*
### k. Throttling
*Controlar el consumo de recursos utilizados por una instancia de una aplicación, un inquilino individual o un servicio completo.*

## 3. Especificación mediante escenarios

*Para identificar los escenarios se sigue la siguiente estructura:*

1. Fuente del estímulo: quién o qué genera el estímulo. 
2. Estímulo: lo que se quiere llevar a cabo.
3. Artefacto: parte del sistema que recibe el estímulo.
4. Entorno: condiciones dentro de las cuales se presenta el estímulo.
5. Respuesta: actividad que ocurre luego de la llegada del estímulo.
6. Medida de la Respuesta: criterio para testear el requerimiento.

![Escenario](/imagenes/escenario.jpg)

## 4. ¿Qué tácticas se pueden emplear?

1. Diseñar de forma modular y simple el sistema. 
2. Usar nuevas versiones de las tecnologías utilizadas.
3. Optimización de software (performance tuning).
4. Código limpio.
5. Reducir la cantidad de recursos involucrados.
6. Reducir el número de eventos procesados.
7. Limitar los tiempos de ejecución.
8. Procesamiento en paralelo o distribuido.
9. Reducir puntos de acceso a datos comunes.
10. Aumentar los capacidad de los recursos, tanto horizontal como verticalmente.
11. Definir una estrategia de programación de uso de los recursos.
12. Asignar prioridades.

## 5. Qué herramientas se pueden utilizar para lograrlo

1. NGINX
2. Jmeter

# Análisis mediante escenarios

### Primer escenario 
1. Fuente: Petición de un usuario para escuchar una canción.
2. Estímulo: Reproducir la canción.
3. Artefacto: Página web.
4. Entorno: normal.
5. Respuesta: El sistema consulta en el caché si la canción ya fue reproducida o se encuentra guardada allí para no tener que consultarla en el file system y así mejorar el tiempo de respuesta.
6. Medida de la Respuesta: Tiempo que tarda en reproducir la canción (Latencia).

### Segundo escenario
1. Fuente: Petición de varios usuarios a la vez para buscar una canción.
2. Estímulo: Buscar la canción.
3. Artefacto: Página web.
4. Entorno: Exhaustivo.
5. Respuesta: El sistema guarda en una cola las tareas o peticiones de cada usuario de tal manera que se puedan distribuir en diferentes servidores para luego ser procesadas y de esa forma mejorar la cantidad de peticiones que se pueden atender por segundo.
6. Medida de la Respuesta: Cantidad de usuarios que hacen la petición de buscar a la vez (Concurrencia).

# Diseño

## 1. Vistas de arquitectura

![Vista de arquitectura](/imagenes/vistaarquitectura.jpg)

## 2. Patrones de arquitectura
*Los patrones de arquitectura a utilizar son los siguientes:*
### a. Cache-Aside
*Este patrón es muy efectivo debido a que con este se puede tener un almacenamiento provisional de las canciones más reproducidas de tal forma que no siempre se tenga que ir hasta el sistema de archivos para hacer la consulta de la canción.*

### b. Priority Queue
*Se utilizará este patrón para darle prioridad al usuario que haga primero la petición.*

### c. Queue-Based Load Leveling
*Esta puede ser la misma cola del patrón anterior pero añadiendo que esta cola va a ser administrada por un load balancer para que así las tareas sean realizadas por los diferentes servidores y así no dejar que uno sólo atienda todas las peticiones.*

## 3. Best practices
1. Se manejarán  las excepciones correctamente
2. No se utilizarán funciones síncronas
3. Se almacenará en la caché los resultados de las solicitudes más requeridas a la base de datos
4. Se utilizarś un equilibrador de carga
5. Se utilizará NGINX como proxy inverso

## 4. Tácticas
1. Usar nuevas versiones de las tecnologías utilizadas: Esta táctica nos ayuda porque cada vez las nuevas tecnologías vienen más optimizadas y por ende nos pueden ayudar en el rendimiento.
2. Optimización de software (performance tuning): De esta forma podemos configurar los parámetros de los programas de necesitemos para así no llenarnos de cosas que no van a servir y que harán el sistema más lento.
3. Asignar prioridades: Esta táctica se utilizará por la prioridad de tareas que se tendrá en cuenta con la cola que se utilizará para mejorar el rendimiento.
4. Aumentar los capacidad de los recursos, tanto horizontal como verticalmente: Esta táctica se logrará gracias a las otras máquinas que nos proveerá el profesor.

## 5. Herramientas
1. Jmeter: Se usará esta herramienta para monitorear el comportamiento de los métodos HTTP de la aplicación con diferentes cantidades de usuarios para comprobar su rendimiento, tiempo de respuesta y throughtput que se toman cada uno de esos y así enterarnos si hay que realizar más mejoras de rendimiento.
2. NGINX: Esta tecnología se utilizará como un balanceador de cargas para repartir las tareas en los diferentes servidores.


# Marco de referencia Seguridad
## 1. ¿Qué es?
*La seguridad es la medida de la capacidad del sistema para resistir intentos de ataques, los cuales buscan robar algún tipo de información de los usuarios o del sistema, y a su vez me permite la negación de los servicios de la aplicación a usuarios no autorizados, pero sin quitarle los permisos o servicios los usuarios autorizados.*

## 2. ¿Qué patrones se pueden emplear?
***Patrón ROLE:** Esto evolucionó, incorporando el concepto de ROLE-BASED ACCESS CONTROL (RBAC), donde el problema se enfoca en las funciones de trabajo que las personas tienen que realizar en su actividad diaria. RBAC está basado en el principio de acceso con el menor privilegio, un rol sólo concede los mínimos privilegios requeridos por un individuo para realizar su trabajo.

El principio básico de RBAC es que un sujeto puede ejecutar una transacción sólo si tiene asignado un rol con los permisos requeridos para hacerlo. Los roles pueden ser asignados estática o dinámicamente, mientras que una jerarquía de roles simplifica el modelado de roles habilitando roles superiores para heredar los privilegios a roles inferiores. Se pueden aplicar restricciones a las asignaciones y jerarquías de roles para prevenir que se asignen roles conflictivos a los usuarios, o que se asigne demasiada autoridad a un usuario.*

***Patrón de Identidad Federada:** Delegar la autenticación en un proveedor de identidad externo. Esto puede simplificar el desarrollo, minimizar los requisitos de administración de usuarios y mejorar la experiencia del usuario de la aplicación.

Los usuarios normalmente necesitan trabajar con múltiples aplicaciones proporcionadas y alojadas por diferentes organizaciones con las que tienen una relación comercial. Es posible que estos usuarios necesiten utilizar credenciales específicas (y diferentes) para cada uno.*

***Patrón de Valet Key:** Utiliza un token que proporciona a los clientes acceso restringido directo a un recurso específico para descargar la transferencia de datos de la aplicación. Esto es particularmente útil en aplicaciones que utilizan sistemas de almacenamiento alojados en la nube o colas, y puede minimizar el costo y maximizar la escalabilidad y el rendimiento.

Los programas de cliente y los navegadores web a menudo necesitan leer y escribir archivos o flujos de datos desde y hacia el almacenamiento de una aplicación. Normalmente, la aplicación manejará el movimiento de los datos, ya sea recolectándolo desde el almacenamiento y transmitiéndolo al cliente, o leyendo el flujo cargado desde el cliente y almacenándolo en el almacén de datos. Sin embargo, este enfoque absorbe recursos valiosos como el cálculo, la memoria y el ancho de banda.*

## 3. Especificación mediante escenarios

### Antecedentes para todos los escenarios

*Antes de la reunión principal del modelo de amenaza, recogimos la siguiente información de fondo. Esta información se aplica a todos los escenarios de uso que identificamos para la arquitectura de ejemplo:*

1. Límites y alcance de la arquitectura
2. Límites entre componentes confiables y no confiables
3. Modelo de configuración y administración para cada componente
4. Suposiciones sobre otros componentes y aplicaciones

### Ejemplo de un escenario:

*Primero es necesario sacar u obtener la información de la empresa o de lo que se necesita para sacar los escenarios correctamente.*

### Límites y alcance de la arquitectura

1. Firewall 2 ayuda a proteger los servidores y las aplicaciones en el dominio de E-Business tanto de la red perimetral como de cualquier otro dominio de su entorno (por ejemplo, un dominio corporativo o dominios para otras aplicaciones).

2. Firewall 2 encamina todo el tráfico entrante y saliente al dominio de E-Business.

3. Todos los grupos de usuarios y cuentas que acceden al entorno de BizTalk Server deben ser grupos globales en el dominio de E-Business.

4. El acceso está limitado a la cuenta de servicio para la instancia de host; Las aplicaciones que descartan mensajes en el servidor de recepción para archivos, SQL o Message Queue Server; Y administradores para BizTalk Server, Enterprise Single Sign-On (SSO) y Windows.

*En nuestra arquitectura de ejemplo, identificamos los siguientes escenarios de uso basados ​​en algunos de los adaptadores que puede utilizar fuera de la caja:*

1. Escenario de adaptadores HTTP y SOAP (servicios Web)
2. Escenario de adaptador BizTalk Message Queue Server
3. Escenario del adaptador de archivos
4. Escenario del adaptador de FTP

*Para cada escenario, seguimos estos pasos para completar el análisis del modelo de amenaza:*

1. Recopilar información de fondo
2. Crear y analizar el modelo de amenaza
3. Revisar amenazas
4. Identificar las técnicas y tecnologías de mitigación

*Para cada escenario, hemos tratado de desarrollar clasificaciones genéricas del nivel de amenaza que los diversos ataques podrían representar. Sin embargo, su entorno o experiencia podría sugerir que una amenaza particular merece una calificación diferente de la que le hemos dado. Como con todos los escenarios de seguridad, sus propios datos son los más robustos para determinar los niveles de amenaza y le recomendamos que realice su propio análisis utilizando nuestro análisis y resultados como guía.
La información de fondo, excepto el diagrama de flujo de datos (DFD), es la misma para todos nuestros escenarios de uso. En las siguientes secciones mostramos el DFD para cada escenario.*

## 4. ¿Qué tácticas se pueden emplear?

*Para mantener la seguridad se pueden tener varias tácticas, una de ellas es en la parte física. Pero de allí en adelante se tienen varios pasos que me garantiza mejor la seguridad de mi aplicación web, los pasos son los siguientes:*

***1ª) Detectar:** En esta parte se realiza la tarea de la detención del intruso a partir de ciertas características sospechosas que este realizando en el sistema, a su vez se detecta el servicio el cual se está afectando en la aplicación web. Además, debe detectar el servicio se está realizando el ataque, y que tipo de ataque se está realizando. En este punto se debe realizar una detallada detención a cada usuario*

***2ª) Resistir ataques:** En esta táctica debe realizar la identificación, autenticación, autorización de los actores, la limitación en el acceso a la aplicación, encriptar los datos. Entre otras. Esto con la intención de hacer la aplicación mucho más segura, y que sea compleja en el momento que reciba ataques.*

***3ª) Reaccionar al ataque:** En el momento que se tiene un ataque se debe reaccionar de la siguiente manera. Primero es revocar el acceso a la aplicación, luego se debe de bloquear el computador, y por último es necesario obtener información del actor.*

***4ª) Recuperarse de los ataques:** Al final de un ataque es necesario guardar las huellas, o información que quedo de este, para prevenir y prepararse para ataques similares o nuevos ataques. Luego restaurar todo a la normalidad, y al final mirar la disponibilidad.*

*Si se siguen estas tácticas, se podrá garantizar que la aplicación será mucho más segura, y esta ira aprendiendo de cada ataque que tenga.*

## 5. Qué herramientas se pueden utilizar para lograrlo

*Las herramientas que se pueden utilizar son varias, entre esta OpenID, el cual es un estándar de identificación descentralizado, con el que un usuario puede identificarse en una página web a través de una URL (o un XRI en la versión actual) y puede ser verificado por cualquier servidor que soporte el protocolo.
también existe la herramienta SAML (security assertion Markup Language), el cual es un estándar OASIS basado en XML para el intercambio de información de la identidad de usuario y atributos de seguridad.
Mediante la función SAML del producto, puede aplicar conjuntos de políticas a las aplicaciones JAX-WS para utilizar las aserciones SAML en los mensajes de servicios web y en escenarios de uso de servicios web.*


*Este es uno de los ejemplos de los tipos de herramientas que existen para seguridad.*

# Análisis mediante escenarios

### Primer escenario 
1. Este es uno de los escenarios de seguridad correspondientes al usuario en el momento de inicio de sección, donde a su vez se muestra a su vez los permisos, y en cuales cosas no puede acceder, y no tiene permisos de modificación.

![Escenarios de Seguridad](/imagenes/escenarioseguridad.jpg)

# Diseño

## 1. Vistas de arquitectura

![Vista de arquitectura](/imagenes/vistaarquitectura.jpg)

## 2. Patrones de arquitectura
*Los patrones de arquitectura a utilizar son los siguientes:*

### a. Patrón de Identidad Federada

*En la aplicación, uno de los patrones que utilizaremos es este, en el cual funciona con un proveedor externo de identidad, y será OpenID. Con el cual el usuario se podrá conectar con una url.*

![Patrones](/imagenes/patrones.jpg)

## 3. Best practices
1. Análisis de seguridad
2. Utilizar el firewall
3. identificar escenarios de vulnerabilidad
4. Revisar la codificación de seguridad.
5. ayudarse de herramientas de seguridad.

## 4. Tácticas
1. Detectar: En esta parte se realiza la tarea de la detención del intruso a partir de ciertas características sospechosas que este realizando en el sistema, a su vez se detecta el servicio el cual se está afectando en la aplicación web. Además, debe detectar el servicio se está realizando el ataque, y que tipo de ataque se está realizando. En este punto se debe realizar una detallada detención a cada usuario
2. Resistir ataques: En esta táctica debe realizar la identificación, autenticación, autorización de los actores, la limitación en el acceso a la aplicación, encriptar los datos. Entre otras. Esto con la intención de hacer la aplicación mucho más segura, y que sea compleja en el momento que reciba ataques.
3. Reaccionar al ataque: En el momento que se tiene un ataque se debe reaccionar de la siguiente manera. Primero es revocar el acceso a la aplicación, luego se debe de bloquear el computador, y por último es necesario obtener información del actor.
4. Recuperarse de los ataques: Al final de un ataque es necesario guardar las huellas, o información que quedo de este, para prevenir y prepararse para ataques similares o nuevos ataques. Luego restaurar todo a la normalidad, y al final mirar la disponibilidad.


## 5. Herramientas
1. OpenID: Las herramientas que se pueden utilizar son varias, entre esta OpenID, el cual es un estándar de identificación descentralizado, con el que un usuario puede identificarse en una página web a través de una URL (o un XRI en la versión actual) y puede ser verificado por cualquier servidor que soporte el protocolo. 

# Biografia
1. https://technet.microsoft.com/es-es/library/aa996704(v=exchg.65).aspx
2. http://searchdatacenter.techtarget.com/es/definicion/Failover-o-conmutacion-por-error
3. http://whatis.techtarget.com/definition/failback
4. https://www.beeva.com/beeva-view/cloud-enterprise/alta-disponibilidad-como-conseguir-un-servicio-99-99/
5. http://cic.javerianacali.edu.co/wiki/lib/exe/fetch.php?media=materias:s3_atributoscalidad.pdf
6. https://docs.microsoft.com/en-us/azure/architecture/patterns/category/performance-scalability
7. https://books.google.com.co/books?hl=es&lr=&id=0bWYBAAAQBAJ&oi=fnd&pg=PP1&dq=Architecting+High+Performing,+Scalable+and+Available+Enterprise+Web+Applications%E2%80%9D+by:+Shailesh+Kumar+Shivakumar,+2015&ots=0NHciRamN_&sig=O8E7LWSlCFA6vjFLtWWd47FNdak#v=onepage&q=Architecting%20High%20Performing%2C%20Scalable%20and%20Available%20Enterprise%20Web%20Applications%E2%80%9D%20by%3A%20Shailesh%20Kumar%20Shivakumar%2C%202015&f=false
8. http://sedici.unlp.edu.ar/bitstream/handle/10915/23841/Documento_completo.pdf?sequence=1
9. https://docs.microsoft.com/en-us/azure/architecture/patterns/federated-identity
10. https://es.wikipedia.org/wiki/OpenID
11. https://www.ibm.com/support/knowledgecenter/es/SSAW57_7.0.0/com.ibm.websphere.nd.doc/info/ae/ae/cwbs_whatissaml.html


