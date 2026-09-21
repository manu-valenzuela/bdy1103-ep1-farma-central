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
│   ├── 00_scripts_utiles.sql         : Para eliminar tablas, casos de prueba, etc.
│   ├── 01_nuevo_usuario.sql          : Crea un usuario para poder abrir una conexión nueva en SQLPlus.
│   ├── 02_tablas_farma_central.sql   : Crea las tablas de la base de datos, en SQLPlus u Oracle SQL Developer.
│   ├── 03_datos_farma_central.sql    : Inserta datos en las tablas de la base de datos.
│   └── 04_inventario.sql             : Contiene los bloque de código PL/SQL para compra, venta y control de inventario.
└── documentacion/
    ├── 05_MER.pdf                    : Modelo Entidad-Relación de la base de datos. Desarrollado en Data Modeler.
    ├── 06_presentacion.pdf           : Diapositivas para acompañar la presentación de este código.
    └── 07_presentacion.docx          : Apuntes que comentan el proyecto según los requisitos de evaluación.
````
## INSTRUCCIONES
  1. Abrir SQLPlus, iniciar como `/as sysdba`, pegar el contenido de 01_nuevo_usuario.sql y crear el usuario.
  2. Crear una nueva conexión de nombre `farma_central` usando el usuario recién creado.    
  3. Abrir una `Hoja de trabajo de SQL` y crear las tablas con 02_tablas_farma_central.sql.
     3.1 Insertar los datos en las tablas con 03_datos_farma_central.sql.
  4. Ejecutar los bloques de `04_inventario.sql`, comprobando el cumplimiento de las reglas de negocio. Apoyarse en los comentarios dentro del script para mayor     detalle.

  ## RESUMEN
Farma Central es una cadena de farmacias que quiere mejorar la gestión de su Stock, para evitar la falta del mismo.

Se ha desarrollado un modelo que, en lo relevante para este ejercicio, contiene las sucursales, farmacias, ventas y bodegas, formas de mover inventario, los medicamentos y sus stocks.

El bloque contenido en 04_inventario hace una búsqueda en las sucursales de la farmacia para encontrar problemas de Stock.

PL/SQL genera un reporte de inventario crítico por sucursal, sea por vencimiento o por bajo stock.

Vencimiento: Se buscan en la tabla lote_stock aquellos lotes cuya fecha_vencimiento es menor a la fecha actual. Se imprime en consola el detalle (nombre, cantidad, fecha de vencimiento y sucursal). y se inserta un registro en la tabla alerta_inventario con el mensaje correspondiente.

Medicamentos con stock bajo (≤ 15 unidades): Se agrupan los lotes no vencidos por medicamento en la misma sucursal. Se calcula el total de unidades disponibles (SUM(cantidad)). Si el total es menor o igual a 15, se imprime en consola y se inserta una alerta en alerta_inventario.

Para ambos casos, se cuentan los productos encontrados bajo ambos criterios, y se inserta en un registro de alertas el evento correspondiente.
