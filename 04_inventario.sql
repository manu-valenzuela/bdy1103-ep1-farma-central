--FARMA CENTRAL
--BLOQUE PL/SQL

--Ejecutar esta línea por sí sola primero.
SET SERVEROUTPUT ON;

--Secuencias: Estas secuencias generan el ID de: lote_stock, venta, detalle_venta, envio_bodega, detalle_envio y alterta_inventario.
CREATE SEQUENCE seq_id_lote_stock START WITH 010000000000001 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_venta START WITH 020000000000001 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_detalle_venta START WITH 030000000000001 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_envio_bodega START WITH 040000000000001 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_detalle_envio START WITH 050000000000001 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_alterta_inventario START WITH 060000000000001 INCREMENT BY 1 NOCACHE NOCYCLE;

--BLOQUE 1
/*
Crea un reporte buscando en las distintas FARMACIAS por medicamentos con stocks bajos
(15 unidades o menos), reportándolas en una tabla. Si no hay casos, se devuelve un
mensaje de excepción indicando que no hay problemas de stock.

(opciones para) Próximas versiones:
-Incluir stock de bodega junto al de farmacia.
-Hacer los ajustes necesarios luego de la normalización de las tablas.
-Implementar RECORD.
-Implementar registro de alertas de inventario en auditoria_alerta, aunque
es posible un cambio de nombre a alerta_inventario.
-Que se pueda acceder en el reporte a la cantidad total del medicamento en todas
las sucursales.
-Que se ofrezca pedir un restock a bodega a partir del reporte, que se guarde en
una tabla (puede ser alerta), que luego se referencie en envio_bodega cuando se
despacha el restock. Para ello falta mejorar envío bodega con un detalle_envio

*/
DECLARE
    TYPE type_datos_sucursal IS RECORD (
        id_sucursal NUMBER(4),
        nombre VARCHAR2(50)
    );
    v_sucursal type_datos_sucursal;

    TYPE type_varray_meds IS VARRAY(15) OF VARCHAR2(100);
    v_meds_criticos type_varray_meds := type_varray_meds();

    CURSOR c_sucursales IS
        SELECT id_sucursal, nombre
        FROM sucursal
        WHERE tipo = 'Farmacia';

    CURSOR c_lotes (p_id_sucursal NUMBER) IS
        SELECT m.nombre, l.cantidad, l.fecha_vencimiento
        FROM lote_stock l
        JOIN medicamento m
          ON l.id_medicamento = m.id_medicamento
        WHERE l.id_sucursal = p_id_sucursal
          AND l.cantidad <= 15;

    e_sin_problemas EXCEPTION;
    e_vencido EXCEPTION;

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== REPORTE DE STOCK CRÍTICO POR SUCURSAL ===');

    -- Loop principal: recorrer sucursales
    FOR reg_sucursal IN c_sucursales LOOP
        v_sucursal.id_sucursal := reg_sucursal.id_sucursal;
        v_sucursal.nombre := reg_sucursal.nombre;

        v_meds_criticos := type_varray_meds(); -- reiniciar varray

        DBMS_OUTPUT.PUT_LINE('-> Revisando: ' || v_sucursal.nombre);

        -- Loop anidado: recorrer lotes críticos de cada sucursal
        FOR reg_lote IN c_lotes(v_sucursal.id_sucursal) LOOP
            -- Caso vencido: solo registrar alerta, no modificar stock
            IF reg_lote.fecha_vencimiento < SYSDATE THEN
                DBMS_OUTPUT.PUT_LINE('   - ALERTA: ' || reg_lote.nombre || ' está VENCIDO (Quedan: ' || reg_lote.cantidad || ')');

                INSERT INTO alerta_inventario (id_alerta, id_sucursal, mensaje, fecha_registro)
                VALUES (seq_alerta.NEXTVAL, v_sucursal.id_sucursal,
                        'Medicamento VENCIDO: ' || reg_lote.nombre || ' (Quedan ' || reg_lote.cantidad || ')',
                        SYSDATE);

            ELSE
                -- Caso stock crítico
                IF v_meds_criticos.COUNT <= 15 THEN
                    v_meds_criticos.EXTEND;
                    v_meds_criticos(v_meds_criticos.COUNT) :=
                        reg_lote.nombre || ' (Quedan: ' || reg_lote.cantidad || ')';

                    INSERT INTO alerta_inventario (id_alerta, id_sucursal, mensaje, fecha_registro)
                    VALUES (seq_alerta.NEXTVAL, v_sucursal.id_sucursal,
                            'Stock crítico: ' || reg_lote.nombre || ' (Quedan ' || reg_lote.cantidad || ')',
                            SYSDATE);
                END IF;
            END IF;
        END LOOP;

        BEGIN
            IF v_meds_criticos.COUNT = 0 THEN
                RAISE e_sin_problemas;
            ELSE
                FOR i IN 1..v_meds_criticos.COUNT LOOP
                    DBMS_OUTPUT.PUT_LINE('   - ALERTA: ' || v_meds_criticos(i));
                END LOOP;
            END IF;

        EXCEPTION
            WHEN e_sin_problemas THEN
                DBMS_OUTPUT.PUT_LINE('   - No hay problemas de stock.');
        END;

        DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    END LOOP;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No hay datos registrados.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error en el sistema: ' || SQLERRM);
END;
/