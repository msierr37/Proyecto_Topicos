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

### URL de ejecución 
http://proyecto25.dis.eafit.edu.co
# 3. Implementación y pruebas por atributo de calidad 
## a. Implementación

### Herramientas utilizadas
1. JMeter
2. HAProxy
3. 

### Cambios en la implementación de la aplicación

## b. Esquemas de pruebas para comprobar el atributo de calidad
![resultadoPruebas](/imagenes/resultadopruebas.jpg)
