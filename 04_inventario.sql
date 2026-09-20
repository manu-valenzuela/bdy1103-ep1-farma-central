--FARMA CENTRAL
--BLOQUE PL/SQL

--Ejecutar esta línea por sí sola primero.
SET SERVEROUTPUT ON;

--Secuencias: Estas secuencias generan el ID de: lote_stock, venta, detalle_venta, envio_bodega, detalle_envio y alterta_inventario.
CREATE SEQUENCE seq_id_alerta_inventario START WITH 010000000000001 INCREMENT BY 1 NOCACHE NOCYCLE;

--BLOQUE

DECLARE
--RECORD y VARRAY
    TYPE r_datos_sucursal IS RECORD (
        id_sucursal sucursal.id_sucursal%type,
        nombre sucursal.nombre%type);
    v_sucursal r_datos_sucursal;
    
    TYPE r_vencido IS RECORD (
        id_medicamento   medicamento.id_medicamento%TYPE,
        id_sucursal      lote_stock.id_sucursal%type,
        nombre           medicamento.nombre%TYPE,
        cantidad         lote_stock.cantidad%TYPE,
        fecha_vencimiento lote_stock.fecha_vencimiento%TYPE);
    v_vencido r_vencido;
    
    TYPE r_stock IS RECORD (
        id_medicamento   medicamento.id_medicamento%TYPE,
        nombre           medicamento.nombre%TYPE,
        total_cantidad   NUMBER);
    v_stock_bajo r_stock;

    TYPE medicamentos_varray IS VARRAY(15) OF VARCHAR2(100);
    
    v_meds_criticos medicamentos_varray := medicamentos_varray();
    v_meds_vencidos medicamentos_varray := medicamentos_varray();
--Cursor que recorre sucursales
    CURSOR c_sucursales IS
        SELECT id_sucursal, nombre
        FROM sucursal
        WHERE id_tipo = 1;
--Cursor que recorre medicamentos vencidos
    CURSOR c_vencido (p_id_sucursal NUMBER) IS
    SELECT m.id_medicamento,
           l.id_sucursal,
           m.nombre,
           l.cantidad,
           l.fecha_vencimiento
    FROM lote_stock l
    JOIN medicamento m
      ON l.id_medicamento = m.id_medicamento
    WHERE l.id_sucursal = p_id_sucursal
      AND l.fecha_vencimiento < SYSDATE;
--Cursor que recorre Stock
    CURSOR c_stock_bajo (p_id_sucursal NUMBER) IS
    SELECT m.id_medicamento,
           m.nombre,
           SUM(l.cantidad) AS total_cantidad
    FROM lote_stock l
    JOIN medicamento m
      ON l.id_medicamento = m.id_medicamento
    WHERE l.id_sucursal = p_id_sucursal
      AND l.fecha_vencimiento >= SYSDATE
    GROUP BY m.id_medicamento, m.nombre
    HAVING SUM(l.cantidad) <= 15;

    e_sin_problemas EXCEPTION;
    e_sin_vencidos EXCEPTION;

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== REPORTE DE STOCK CRÍTICO POR SUCURSAL ===');

--Uso de cursor sucursales, para hacer una búsqueda sucursal por sucursal.
OPEN c_sucursales;
LOOP
    FETCH c_sucursales INTO v_sucursal;
    EXIT WHEN c_sucursales%NOTFOUND;

        v_meds_criticos := medicamentos_varray();
        v_meds_vencidos := medicamentos_varray();

        DBMS_OUTPUT.PUT_LINE('Revisando la sucursal ID: ' || v_sucursal.id_sucursal || ' ' || v_sucursal.nombre);

 --Uso de cursores, para buscar problemas de Stock en dos casos.
    --CASO 1: Medicamentos vencidos.
        OPEN c_vencido(v_sucursal.id_sucursal);
        LOOP
            FETCH c_vencido INTO v_vencido;
            EXIT WHEN c_vencido%NOTFOUND;
            v_meds_vencidos.EXTEND;
            v_meds_vencidos(v_meds_vencidos.COUNT) :=
                v_vencido.nombre || ' (Unidades vencidas: ' || v_vencido.cantidad || ')';
                DBMS_OUTPUT.PUT_LINE('Medicamento Vencido: ' || v_vencido.nombre || ' (Unidades: ' || v_vencido.cantidad || ')');
                DBMS_OUTPUT.PUT_LINE('Fecha vencimiento: ' || TO_CHAR(v_vencido.fecha_vencimiento, 'DD/MM/YYYY'));
                DBMS_OUTPUT.PUT_LINE('Sucursal ID: ' || v_sucursal.id_sucursal || ' - ' || v_vencido.nombre);
            INSERT INTO alerta_inventario (id_alerta, id_sucursal, mensaje, fecha_registro)
            VALUES (seq_id_alerta_inventario.NEXTVAL, v_vencido.id_sucursal,
                    'Medicamento Vencido: ' || v_vencido.nombre ||' (Unidades: ' || v_vencido.cantidad || ')', SYSDATE);
        END LOOP;
    CLOSE c_vencido;

    --CASO 2: Medicamentos con stock bajo.
        OPEN c_stock_bajo(v_sucursal.id_sucursal);
        LOOP
            FETCH c_stock_bajo INTO v_stock_bajo;
            EXIT WHEN c_stock_bajo%NOTFOUND;
            IF v_meds_criticos.COUNT <= 15 THEN
                v_meds_criticos.EXTEND;
                v_meds_criticos(v_meds_criticos.COUNT) := v_stock_bajo.nombre || ' (Total: ' || v_stock_bajo.total_cantidad || ' unidades).';
                DBMS_OUTPUT.PUT_LINE('Stock bajo: ' || v_stock_bajo.nombre || ' (Unidades: ' || v_stock_bajo.total_cantidad || ')');
                INSERT INTO alerta_inventario (id_alerta, id_sucursal, mensaje, fecha_registro)
                VALUES (seq_id_alerta_inventario.NEXTVAL, v_sucursal.id_sucursal,
                        'Stock crítico: ' || v_stock_bajo.nombre || 
                        ' (Total: ' || v_stock_bajo.total_cantidad || ' unidades).',
                        SYSDATE);
            END IF;
        END LOOP;
        CLOSE c_stock_bajo;
    --EXCEPCIONES:
    --Muestra el total de productos vencidos por farmacia.
        BEGIN
            IF v_meds_vencidos.COUNT = 0 THEN
                RAISE e_sin_vencidos;
            ELSE
                DBMS_OUTPUT.PUT_LINE('Cantidad de productos vencidos: ' || v_meds_vencidos.COUNT);
            END IF;
        EXCEPTION
            WHEN e_sin_vencidos THEN
                DBMS_OUTPUT.PUT_LINE('No hay medicamentos vencidos en esta sucursal.');
        END;
    --Muestra el total de productos con bajo stock por farmacia.
        BEGIN
            IF v_meds_criticos.COUNT = 0 THEN
                RAISE e_sin_problemas;
            ELSE
                DBMS_OUTPUT.PUT_LINE('Cantidad de productos con bajo Stock: ' || v_meds_criticos.COUNT);
            END IF;

        EXCEPTION
            WHEN e_sin_problemas THEN
                DBMS_OUTPUT.PUT_LINE('Todos los medicamentos tienen stocks mayores a 15 unidades.');
        END;

        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------');
    END LOOP;
CLOSE c_sucursales;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No hay información.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error en el sistema: ' || SQLERRM);
END;
/