--FARMA CENTRAL
--BLOQUE PL/SQL

--Ejecutar esta línea por sí sola primero.
SET SERVEROUTPUT ON;


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

    TYPE type_varray_meds IS VARRAY(15) OF VARCHAR2(50);
    v_meds_criticos type_varray_meds;

    CURSOR c_sucursales IS
        SELECT id_sucursal, nombre
        FROM sucursal
        WHERE tipo = 'Farmacia';

    CURSOR c_lotes (p_id_sucursal NUMBER) IS
        SELECT m.nombre, l.cantidad
        FROM lote_stock l
        JOIN medicamento m
          ON l.id_medicamento = m.id_medicamento
        WHERE l.id_sucursal = p_id_sucursal
          AND l.cantidad < 5;

    e_sin_problemas EXCEPTION;

    v_contador NUMBER;
    v_nombre_med VARCHAR2(50);
    v_cant NUMBER;

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== REPORTE DE STOCK CRÍTICO POR SUCURSAL ===');

    FOR reg_sucursal IN c_sucursales LOOP
        v_sucursal.id_sucursal := reg_sucursal.id_sucursal;
        v_sucursal.nombre := reg_sucursal.nombre;

        v_meds_criticos := type_varray_meds();
        v_contador := 1;

        DBMS_OUTPUT.PUT_LINE('-> Revisando: ' || v_sucursal.nombre);

        OPEN c_lotes(v_sucursal.id_sucursal);
        LOOP
            FETCH c_lotes INTO v_nombre_med, v_cant;
            EXIT WHEN c_lotes%NOTFOUND;

            IF v_contador <= 15 THEN
                v_meds_criticos.EXTEND;
                v_meds_criticos(v_contador) :=
                    v_nombre_med || ' (Quedan: ' || v_cant || ')';
                v_contador := v_contador + 1;
            END IF;
        END LOOP;
        CLOSE c_lotes;

        BEGIN
            IF v_meds_criticos.COUNT = 0 THEN
                RAISE e_sin_problemas;
            ELSE
                FOR i IN 1..v_meds_criticos.COUNT LOOP
                    DBMS_OUTPUT.PUT_LINE(
                        '   - ALERTA: ' || v_meds_criticos(i)
                    );
                END LOOP;
            END IF;

        EXCEPTION
            WHEN e_sin_problemas THEN
                DBMS_OUTPUT.PUT_LINE(
                    '   - Todo OK. Stock suficiente.'
                );
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