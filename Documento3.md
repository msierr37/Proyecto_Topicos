# 1. Miembros del equipo
## QA1: Disponibilidad Estudiantes: Daniel Restrepo Aristizabal, Marcos David Sierra Gallego
## QA2: Rendimiento Estudiante: Mateo Hincapie Zapata
## QA3: Seguridad Estudiante: Jose David Sanchez Castrillon

# 2. Diseño de arquitectura de la aplicación y sistema
## a. Vista de desarrollo
![Vista de desarrollo](/imagenes/imagen1.jpg)

### Definición de Tecnología de Desarrollo
1. Rails, framework utilizado para la aplicación
2. Haproxy, es una solución confiable que nos ofrece alta disponibilidad y balanceo de cargas, permite tener alto trafico.
3. Postgresql, base de datos relacionada, con facil integrado a ruby, nos permite usar heroku, tiene alta confiabilidad, integridad y exactitud en los datos.
### URLs de repositorio (github)
*https://github.com/msierr37/Proyecto_Topicos*

## b. Vista de despliegue
![Vista de despliegue](/imagenes/imagen2.jpg)

### Definición de Tecnología – Infraestructura TI: Servidores, Software Base, Redes, etc.

1. Load balancer: Se uso un servidor para hacer la función del load balancer y poder aumentar la disponibilidad de la app.
2. Apps: Se usaron dos servidores diferentes para crear dos apps que seran llamadas por el load balancer.
3. Data base: al igual que las apps se usaron dos servidores para tener 2 bases de datos en modo master slave.
4. DCA - CentOS 7.1
5. Intel(R) Xeon(R) CPU     X5660  @ 2.80GHz 
6. CPU MHz: 2799.269
7. 2 GB RAM
8. 20 GB de disco duro


### URL de ejecución 
http://proyecto25.dis.eafit.edu.co
# 3. Implementación y pruebas por atributo de calidad 
## a. Implementación
Para garantizar la calidad de la aplicación se implementaron mejoras en la disponibilidad, rendimiento y seguridad de la misma, para asi lograr una mejor experiencia del usuario; Para medir la capacidad de la aplicación se usaron herramientas como jmeter que nos permitian ver como reaccionaba la app ante diferentes situaciones.
### Herramientas utilizadas
1. JMeter
2. HAProxy

### Cambios en la implementación de la aplicación
## Los cambios implementados fueron los siguientes:
1. Disponibilidad: Con la ayuda de otros servidores se copio la app y se creo load balancer que permite redireccionar los request a una sola app si se llegara a caer una de las dos, además tambien con otra base de datos que nos permite tener un file systems con los datos duplicados para usar la otra en caso de que haya un fallo, y asi garantizar que la app siga corriendo.
2. Rendimiento: Se implemento un cache para mejorar los tiempos de respuesta, tambien se mejoro las rutas que nos permiten tener las canciones en el file system duplicado; Ademas con la implementación de la app en dos servidores el load balancer distribuye las cargas en estas para mejorar el rendimiento de la app.
3. Seguridad: Se modifico el registro para usar un tercero (Google) lo que garantiza la seguridad a la hora de los usuarios.

## b. Esquemas de pruebas para comprobar el atributo de calidad

Se uso la herramienta Jmeter para medir la apliación frente a diferentes situaciones los resultados fueron los siguientes:

![resultadoPruebas](/imagenes/resultadopruebas.jpg)
