-- FARMA CENTRAL
-- Datos de prueba corregidos y ampliados para Oracle.
--
-- Correcciones principales respecto de la versión anterior:
-- 1) Oracle no admite INSERT ... VALUES (...), (...); se usa INSERT ALL.
-- 2) Las fechas de ingreso siempre son anteriores a las fechas de vencimiento.
-- 3) Se generan datos para farmacias y bodegas, incluyendo lotes vigentes,
--    lotes vencidos, stock crítico, ventas, envíos y alertas.
-- 4) Los identificadores generados respetan las precisiones NUMBER definidas.
--
-- Ejecutar después de 02_tablas_farma_central.sql y una sola vez sobre un
-- esquema recién creado.

-- Catálogos geográficos
INSERT ALL
  INTO region VALUES (1, 'Arica y Parinacota')
  INTO region VALUES (2, 'Tarapacá')
  INTO region VALUES (3, 'Antofagasta')
  INTO region VALUES (4, 'Atacama')
  INTO region VALUES (5, 'Coquimbo')
  INTO region VALUES (6, 'Valparaíso')
  INTO region VALUES (7, 'Metropolitana de Santiago')
  INTO region VALUES (8, 'O’Higgins')
  INTO region VALUES (9, 'Maule')
  INTO region VALUES (10, 'Ñuble')
  INTO region VALUES (11, 'Biobío')
  INTO region VALUES (12, 'Araucanía')
  INTO region VALUES (13, 'Los Ríos')
  INTO region VALUES (14, 'Los Lagos')
  INTO region VALUES (15, 'Aysén')
  INTO region VALUES (16, 'Magallanes')
SELECT 1 FROM dual;

INSERT ALL
  INTO comuna VALUES (701, 'Santiago', 7)
  INTO comuna VALUES (702, 'Cerrillos', 7)
  INTO comuna VALUES (703, 'Cerro Navia', 7)
  INTO comuna VALUES (704, 'Conchalí', 7)
  INTO comuna VALUES (705, 'El Bosque', 7)
  INTO comuna VALUES (706, 'Estación Central', 7)
  INTO comuna VALUES (707, 'Huechuraba', 7)
  INTO comuna VALUES (708, 'Independencia', 7)
  INTO comuna VALUES (709, 'La Cisterna', 7)
  INTO comuna VALUES (710, 'La Florida', 7)
  INTO comuna VALUES (711, 'La Granja', 7)
  INTO comuna VALUES (712, 'La Pintana', 7)
  INTO comuna VALUES (713, 'La Reina', 7)
  INTO comuna VALUES (714, 'Las Condes', 7)
  INTO comuna VALUES (715, 'Lo Barnechea', 7)
  INTO comuna VALUES (716, 'Lo Espejo', 7)
  INTO comuna VALUES (717, 'Lo Prado', 7)
  INTO comuna VALUES (718, 'Macul', 7)
  INTO comuna VALUES (719, 'Maipú', 7)
  INTO comuna VALUES (720, 'Ñuñoa', 7)
  INTO comuna VALUES (721, 'Pedro Aguirre Cerda', 7)
  INTO comuna VALUES (722, 'Peñalolén', 7)
  INTO comuna VALUES (723, 'Providencia', 7)
  INTO comuna VALUES (724, 'Pudahuel', 7)
  INTO comuna VALUES (725, 'Quilicura', 7)
  INTO comuna VALUES (726, 'Quinta Normal', 7)
  INTO comuna VALUES (727, 'Recoleta', 7)
  INTO comuna VALUES (728, 'Renca', 7)
  INTO comuna VALUES (729, 'San Joaquín', 7)
  INTO comuna VALUES (730, 'San Miguel', 7)
  INTO comuna VALUES (731, 'San Ramón', 7)
  INTO comuna VALUES (732, 'Vitacura', 7)
  INTO comuna VALUES (733, 'Puente Alto', 7)
  INTO comuna VALUES (734, 'Pirque', 7)
  INTO comuna VALUES (735, 'San José de Maipo', 7)
  INTO comuna VALUES (736, 'Colina', 7)
  INTO comuna VALUES (737, 'Lampa', 7)
  INTO comuna VALUES (738, 'Tiltil', 7)
  INTO comuna VALUES (739, 'San Bernardo', 7)
  INTO comuna VALUES (740, 'Buin', 7)
  INTO comuna VALUES (741, 'Calera de Tango', 7)
  INTO comuna VALUES (742, 'Paine', 7)
SELECT 1 FROM dual;

INSERT ALL
  INTO tipo_sucursal VALUES (1, 'Farmacia')
  INTO tipo_sucursal VALUES (2, 'Bodega')
SELECT 1 FROM dual;

INSERT ALL
  INTO sucursal VALUES (1001, 'Farmacia Central Santiago', 'Av. Libertador Bernardo O’Higgins 1234', 701, 7, 1)
  INTO sucursal VALUES (1002, 'Farmacia Providencia', 'Av. Providencia 1456', 723, 7, 1)
  INTO sucursal VALUES (1003, 'Farmacia Peñalolén', 'Av. Grecia 5678', 722, 7, 1)
  INTO sucursal VALUES (1004, 'Farmacia Ñuñoa', 'Av. Irarrázaval 2233', 720, 7, 1)
  INTO sucursal VALUES (1005, 'Farmacia La Florida', 'Av. Vicuña Mackenna 8900', 710, 7, 1)
  INTO sucursal VALUES (1006, 'Farmacia Maipú', 'Av. Pajaritos 4567', 719, 7, 1)
  INTO sucursal VALUES (1007, 'Farmacia Las Condes', 'Av. Apoquindo 7654', 714, 7, 1)
  INTO sucursal VALUES (1008, 'Farmacia San Bernardo', 'Av. Portales 234', 739, 7, 1)
  INTO sucursal VALUES (2001, 'Bodega Central Nos', 'Camino a Nos 345', 739, 7, 2)
  INTO sucursal VALUES (2002, 'Bodega Oriente', 'Av. Américo Vespucio 789', 705, 7, 2)
SELECT 1 FROM dual;

INSERT ALL
  INTO cargo VALUES (1, 'Farmacéutico')
  INTO cargo VALUES (2, 'Químico Farmacéutico')
  INTO cargo VALUES (3, 'Auxiliar de Farmacia')
  INTO cargo VALUES (4, 'Cajero')
  INTO cargo VALUES (5, 'Administrador de Sucursal')
  INTO cargo VALUES (6, 'Bodeguero')
  INTO cargo VALUES (7, 'Encargado de Inventario')
  INTO cargo VALUES (8, 'Repartidor')
SELECT 1 FROM dual;

INSERT ALL
  INTO categoria_medicamento VALUES (1, 'Antibióticos')
  INTO categoria_medicamento VALUES (2, 'Analgésicos')
  INTO categoria_medicamento VALUES (3, 'Antiinflamatorios')
  INTO categoria_medicamento VALUES (4, 'Antihistamínicos')
  INTO categoria_medicamento VALUES (5, 'Antipiréticos')
  INTO categoria_medicamento VALUES (6, 'Anticonceptivos')
  INTO categoria_medicamento VALUES (7, 'Vitaminas y Suplementos')
  INTO categoria_medicamento VALUES (8, 'Antidepresivos')
  INTO categoria_medicamento VALUES (9, 'Antihipertensivos')
  INTO categoria_medicamento VALUES (10, 'Antidiabéticos')
  INTO categoria_medicamento VALUES (11, 'Antifúngicos')
  INTO categoria_medicamento VALUES (12, 'Antivirales')
  INTO categoria_medicamento VALUES (13, 'Productos Oftálmicos')
  INTO categoria_medicamento VALUES (14, 'Productos Dermatológicos')
  INTO categoria_medicamento VALUES (15, 'Productos Gastrointestinales')
  INTO categoria_medicamento VALUES (16, 'Productos Respiratorios')
  INTO categoria_medicamento VALUES (17, 'Vacunas')
  INTO categoria_medicamento VALUES (18, 'Homeopáticos y Naturales')
  INTO categoria_medicamento VALUES (19, 'Productos Pediátricos')
  INTO categoria_medicamento VALUES (20, 'Productos Geriátricos')
SELECT 1 FROM dual;

INSERT ALL
  INTO tipo_receta VALUES (1, 'Venta libre')
  INTO tipo_receta VALUES (2, 'Receta médica')
  INTO tipo_receta VALUES (3, 'Receta retenida')
SELECT 1 FROM dual;

-- Catálogo de medicamentos
INSERT ALL
  INTO medicamento VALUES (100001, 2, 'Paracetamol 500mg', 1, 1200)
  INTO medicamento VALUES (100002, 2, 'Ibuprofeno 400mg', 1, 1500)
  INTO medicamento VALUES (100003, 2, 'Aspirina 100mg', 1, 1000)
  INTO medicamento VALUES (100004, 2, 'Naproxeno 250mg', 1, 1800)
  INTO medicamento VALUES (100005, 1, 'Amoxicilina 500mg', 3, 3500)
  INTO medicamento VALUES (100006, 1, 'Ciprofloxacino 500mg', 3, 4200)
  INTO medicamento VALUES (100007, 1, 'Azitromicina 500mg', 3, 4000)
  INTO medicamento VALUES (100008, 1, 'Cefalexina 500mg', 3, 3800)
  INTO medicamento VALUES (100009, 3, 'Diclofenaco 50mg', 2, 2500)
  INTO medicamento VALUES (100010, 3, 'Ketorolaco 10mg', 2, 2800)
  INTO medicamento VALUES (100011, 3, 'Prednisona 5mg', 2, 3000)
  INTO medicamento VALUES (100012, 3, 'Meloxicam 15mg', 2, 3200)
  INTO medicamento VALUES (100013, 4, 'Loratadina 10mg', 1, 2200)
  INTO medicamento VALUES (100014, 4, 'Cetirizina 10mg', 1, 2300)
  INTO medicamento VALUES (100015, 4, 'Fexofenadina 120mg', 1, 2600)
  INTO medicamento VALUES (100016, 4, 'Clorfenamina 4mg', 1, 1500)
  INTO medicamento VALUES (100017, 5, 'Metamizol 500mg', 1, 2000)
  INTO medicamento VALUES (100018, 5, 'Ibuprofeno suspensión pediátrica', 1, 1800)
  INTO medicamento VALUES (100019, 5, 'Paracetamol suspensión pediátrica', 1, 1700)
  INTO medicamento VALUES (100020, 5, 'Ácido acetilsalicílico 500mg', 1, 1600)
  INTO medicamento VALUES (100021, 7, 'Vitamina C 1g', 1, 2500)
  INTO medicamento VALUES (100022, 7, 'Multivitamínico adulto', 1, 3500)
  INTO medicamento VALUES (100023, 7, 'Hierro 325mg', 1, 2800)
  INTO medicamento VALUES (100024, 7, 'Vitamina D 2000UI', 1, 3000)
  INTO medicamento VALUES (100025, 9, 'Losartán 50mg', 2, 3200)
  INTO medicamento VALUES (100026, 9, 'Enalapril 10mg', 2, 3100)
  INTO medicamento VALUES (100027, 9, 'Amlodipino 5mg', 2, 3300)
  INTO medicamento VALUES (100028, 9, 'Propranolol 40mg', 2, 2900)
  INTO medicamento VALUES (100029, 10, 'Metformina 850mg', 2, 2800)
  INTO medicamento VALUES (100030, 10, 'Glibenclamida 5mg', 2, 2700)
  INTO medicamento VALUES (100031, 10, 'Insulina NPH 100UI/ml', 2, 8500)
  INTO medicamento VALUES (100032, 10, 'Insulina Glargina 100UI/ml', 2, 12000)
  INTO medicamento VALUES (100033, 11, 'Fluconazol 150mg', 2, 3500)
  INTO medicamento VALUES (100034, 11, 'Itraconazol 100mg', 2, 4200)
  INTO medicamento VALUES (100035, 11, 'Ketoconazol 200mg', 2, 3800)
  INTO medicamento VALUES (100036, 11, 'Clotrimazol crema 1%', 2, 2500)
  INTO medicamento VALUES (100037, 12, 'Aciclovir 400mg', 2, 3600)
  INTO medicamento VALUES (100038, 12, 'Oseltamivir 75mg', 2, 9500)
  INTO medicamento VALUES (100039, 12, 'Valaciclovir 500mg', 2, 4800)
  INTO medicamento VALUES (100040, 12, 'Zidovudina 300mg', 2, 5200)
SELECT 1 FROM dual;

-- Empleados: tres por sucursal, 30 registros.
BEGIN
  FOR s IN 1..8 LOOP
    INSERT INTO empleado VALUES
      (600000 + (s - 1) * 3 + 1, 1000 + s,
       '2' || TO_CHAR(10000000 + s * 100 + 1) || '-' || TO_CHAR(MOD(s, 10)),
       'Empleado', 'Farmacia' || s, 1, 'Calle Principal ' || s,
       700 + s, 7, '9120000' || LPAD(s, 2, '0'));
    INSERT INTO empleado VALUES
      (600000 + (s - 1) * 3 + 2, 1000 + s,
       '2' || TO_CHAR(11000000 + s * 100 + 2) || '-' || TO_CHAR(MOD(s + 1, 10)),
       'Auxiliar', 'Farmacia' || s, 3, 'Calle Principal ' || s,
       700 + s, 7, '9130000' || LPAD(s, 2, '0'));
    INSERT INTO empleado VALUES
      (600000 + (s - 1) * 3 + 3, 1000 + s,
       '2' || TO_CHAR(12000000 + s * 100 + 3) || '-' || TO_CHAR(MOD(s + 2, 10)),
       'Cajero', 'Farmacia' || s, 4, 'Calle Principal ' || s,
       700 + s, 7, '9140000' || LPAD(s, 2, '0'));
  END LOOP;

  INSERT INTO empleado VALUES
    (600025, 2001, '29100001-1', 'Luis', 'Bodeguero', 6,
     'Camino a Nos 345', 739, 7, '920123001');
  INSERT INTO empleado VALUES
    (600026, 2001, '29100002-2', 'Carolina', 'Inventario', 7,
     'Camino a Nos 350', 739, 7, '920123002');
  INSERT INTO empleado VALUES
    (600027, 2001, '29100003-3', 'Miguel', 'Repartos', 8,
     'Camino a Nos 360', 739, 7, '920123003');
  INSERT INTO empleado VALUES
    (600028, 2002, '30100001-1', 'Claudio', 'Bodeguero', 6,
     'Av. Vespucio 789', 705, 7, '921234001');
  INSERT INTO empleado VALUES
    (600029, 2002, '30100002-2', 'Verónica', 'Inventario', 7,
     'Av. Vespucio 790', 705, 7, '921234002');
  INSERT INTO empleado VALUES
    (600030, 2002, '30100003-3', 'Esteban', 'Repartos', 8,
     'Av. Vespucio 791', 705, 7, '921234003');
END;
/

-- Clientes: 100 registros generados con RUT y teléfonos únicos.
BEGIN
  FOR i IN 1..100 LOOP
    INSERT INTO cliente VALUES
      (7000 + i,
       '31' || LPAD(TO_CHAR(i), 6, '0') || '-' || TO_CHAR(MOD(i, 10)),
       'Cliente' || i, 'FarmaCentral', 'Avenida Cliente ' || i,
       700 + MOD(i - 1, 42) + 1, 7, '930' || LPAD(TO_CHAR(i), 6, '0'));
  END LOOP;
END;
/

-- Lotes de stock: 320 lotes en farmacias y 80 en bodegas.
-- Cada farmacia recibe los 40 medicamentos; aproximadamente una séptima
-- parte queda vencida y varias cantidades quedan bajo el umbral de 15.
BEGIN
  FOR s IN 1..8 LOOP
    FOR m IN 1..40 LOOP
      INSERT INTO lote_stock
        (id_lote, id_medicamento, id_sucursal, cantidad,
         fecha_ingreso, fecha_vencimiento)
      VALUES
        (900000000000000 + (s - 1) * 40 + m,
         100000 + m, 1000 + s,
         CASE WHEN MOD(s + m, 5) = 0 THEN MOD(s + m, 15)
              ELSE 40 + MOD(s * m, 80) END,
         DATE '2026-01-01' + MOD(s * m, 200),
         CASE WHEN MOD(s + m, 7) = 0 THEN DATE '2026-08-31'
              ELSE DATE '2027-01-01' + MOD(s * m, 500) END);
    END LOOP;
  END LOOP;

  FOR b IN 1..2 LOOP
    FOR m IN 1..40 LOOP
      INSERT INTO lote_stock
        (id_lote, id_medicamento, id_sucursal, cantidad,
         fecha_ingreso, fecha_vencimiento)
      VALUES
        (900000000000400 + (b - 1) * 40 + m,
         100000 + m, 2000 + b, 200 + MOD(b * m, 100),
         DATE '2026-01-01' + MOD(b * m, 100),
         DATE '2028-01-01' + MOD(b * m, 300));
    END LOOP;
  END LOOP;
END;
/

-- Estados y ventas.
INSERT ALL
  INTO estado_envio VALUES (1, 'Pendiente')
  INTO estado_envio VALUES (2, 'En tránsito')
  INTO estado_envio VALUES (3, 'Finalizado')
SELECT 1 FROM dual;

BEGIN
  FOR i IN 1..100 LOOP
    INSERT INTO venta
      (id_venta, id_cliente, id_empleado, id_sucursal, fecha, total)
    VALUES
      (500000 + i, 7001 + MOD(i - 1, 100),
       600000 + MOD(i - 1, 8) * 3 + 1,
       1001 + MOD(i - 1, 8),
       DATE '2026-01-01' + MOD(i * 3, 260),
       1000 + MOD(i, 40) * 250);

    INSERT INTO detalle_venta
      (id_venta, id_lote, cantidad, subtotal)
    VALUES
      (500000 + i,
       900000000000000 + MOD(i - 1, 8) * 40 + MOD(i - 1, 40) + 1,
       1 + MOD(i, 3),
       1000 + MOD(i, 40) * 250);
  END LOOP;
END;
/

-- Envíos desde las bodegas hacia las farmacias.
BEGIN
  FOR i IN 1..40 LOOP
    INSERT INTO envio_bodega
      (id_envio, id_sucursal_origen, id_sucursal_destino,
       fecha_envio, id_estado)
    VALUES
      (800000 + i, 2001 + MOD(i - 1, 2), 1001 + MOD(i - 1, 8),
       DATE '2026-02-01' + i, MOD(i - 1, 3) + 1);

    INSERT INTO detalle_envio
      (id_envio, id_lote, cantidad, observacion)
    VALUES
      (800000 + i,
       900000000000400 + MOD(i - 1, 2) * 40 + MOD(i - 1, 40) + 1,
       10 + MOD(i, 40), 'Reposición de inventario');
  END LOOP;
END;
/

-- Alertas iniciales: se incluyen algunas de ejemplo para que la tabla no
-- quede vacía antes de ejecutar el bloque de control de inventario.
BEGIN
  FOR i IN 1..40 LOOP
    INSERT INTO alerta_inventario
      (id_alerta, id_sucursal, mensaje, fecha_registro)
    VALUES
      (100000000000000 + i, 1001 + MOD(i - 1, 8),
       CASE WHEN MOD(i, 2) = 0 THEN 'Stock crítico de medicamento'
            ELSE 'Lote próximo a vencer' END,
       DATE '2026-09-01' + MOD(i, 17));
  END LOOP;
END;
/

COMMIT;

-- Consultas rápidas de comprobación:
-- SELECT COUNT(*) FROM sucursal WHERE id_tipo = 1;
-- SELECT COUNT(*) FROM lote_stock;
-- SELECT id_sucursal, COUNT(*) FROM lote_stock GROUP BY id_sucursal ORDER BY id_sucursal;
-- SELECT COUNT(*) FROM cliente;
-- SELECT COUNT(*) FROM venta;
-- SELECT COUNT(*) FROM envio_bodega;
