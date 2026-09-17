# FARMA CENTRAL: bdy1103-ep1-farma-central

Evaluación 1 de Taller de Base de Datos: Bloque PL/SQL para Farma Central, una farmacia que necesita herramientas de control de inventario en su BDD.
Este es un trabajo grupal para el curso en cuestión. 
Este repositorio es un respaldo del trabajo realizado: las contribuciones de los integrantes no son rastreables de acuerdo al historial de este repositorio.

## INTEGRANTES
- Alberto Conejeros Conejeros
- Willy Rodríguez
- Manuel Valenzuela

## CONTENIDO
````
bdy1103-ep1-farma-central/
├── scripts/
│   ├── 01_nuevo_usuario.sql          : Crea un usuario para poder abrir una conexión nueva en SQLPlus.
│   ├── 02_tablas_farma_central.sql   : Crea las tablas de la base de datos, en SQLPlus u Oracle SQL Developer.
│   ├── 03_datos_farma_central.sql    : Inserta datos en las tablas de la base de datos.
│   └── 04_inventario.sql             : Contiene los bloque de código PL/SQL para compra, venta y control de inventario.
└── documentacion/
    ├── 05_MER.pdf                    : Modelo Entidad-Relación de la base de datos. Desarrollado en Data Modeler.
    └── 06_presentacion.pptx          : Diapositivas para acompañar la presentación de este código.
````
## INSTRUCCIONES
  1. Abrir SQLPlus, iniciar como `/as sysdba`, pegar el contenido de 01_nuevo_usuario.sql y crear el usuario.
  2. Crear una nueva conexión de nombre `farma_central` usando el usuario recién creado.    
  3. Abrir una `Hoja de trabajo de SQL` y crear las tablas con 02_tablas_farma_central.sql.
     3.1 Insertar los datos en las tablas con 03_datos_farma_central.sql.
  4. Ejecutar los bloques de `04_inventario.sql`, comprobando el cumplimiento de las reglas de negocio. Apoyarse en los comentarios dentro del script para mayor     detalle.
