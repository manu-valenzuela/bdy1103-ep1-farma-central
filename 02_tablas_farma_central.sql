CREATE TABLE sucursal (
    id_sucursal NUMBER(4) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    direccion VARCHAR2(80) NOT NULL,
    tipo VARCHAR2(20)
);

CREATE TABLE empleado (
    id_empleado NUMBER(6) PRIMARY KEY,
    id_sucursal NUMBER(4) NOT NULL,
    rut VARCHAR2(12) UNIQUE NOT NULL,
    nombre VARCHAR2(40) NOT NULL,
    apellido VARCHAR2(40) NOT NULL,
    cargo VARCHAR2(30),
    CONSTRAINT fk_emp_suc FOREIGN KEY (id_sucursal)
        REFERENCES sucursal(id_sucursal)
);

CREATE TABLE cliente (
    id_cliente NUMBER(8) PRIMARY KEY,
    rut VARCHAR2(12) UNIQUE NOT NULL,
    nombre_completo VARCHAR2(60) NOT NULL,
    telefono VARCHAR2(15)
);

CREATE TABLE categoria (
    id_categoria NUMBER(3) PRIMARY KEY,
    nombre_categoria VARCHAR2(40) NOT NULL
);

CREATE TABLE medicamento (
    id_medicamento NUMBER(6) PRIMARY KEY,
    id_categoria NUMBER(3) NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    requiere_receta CHAR(1) NOT NULL,
    precio NUMBER(8) NOT NULL,
    CONSTRAINT fk_med_cat FOREIGN KEY (id_categoria)
        REFERENCES categoria(id_categoria)
);

CREATE TABLE lote_stock (
    id_lote VARCHAR2(20) PRIMARY KEY,
    id_medicamento NUMBER(6) NOT NULL,
    id_sucursal NUMBER(4) NOT NULL,
    cantidad NUMBER(5) NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    CONSTRAINT fk_lote_med FOREIGN KEY (id_medicamento)
        REFERENCES medicamento(id_medicamento),
    CONSTRAINT fk_lote_suc FOREIGN KEY (id_sucursal)
        REFERENCES sucursal(id_sucursal)
);

CREATE TABLE venta (
    id_venta NUMBER(10) PRIMARY KEY,
    id_cliente NUMBER(8) NOT NULL,
    id_empleado NUMBER(6) NOT NULL,
    fecha DATE NOT NULL,
    total NUMBER(9) NOT NULL,
    CONSTRAINT fk_ven_cli FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente),
    CONSTRAINT fk_ven_emp FOREIGN KEY (id_empleado)
        REFERENCES empleado(id_empleado)
);

CREATE TABLE detalle_venta (
    id_venta NUMBER(10) NOT NULL,
    id_lote VARCHAR2(20) NOT NULL,
    cantidad NUMBER(3) NOT NULL,
    subtotal NUMBER(9) NOT NULL,
    PRIMARY KEY (id_venta, id_lote),
    CONSTRAINT fk_det_ven FOREIGN KEY (id_venta)
        REFERENCES venta(id_venta),
    CONSTRAINT fk_det_lote FOREIGN KEY (id_lote)
        REFERENCES lote_stock(id_lote)
);

CREATE TABLE envio_bodega (
    id_envio NUMBER(8) PRIMARY KEY,
    id_sucursal NUMBER(4) NOT NULL,
    fecha_envio DATE NOT NULL,
    estado VARCHAR2(20),
    CONSTRAINT fk_envio_suc FOREIGN KEY (id_sucursal)
        REFERENCES sucursal(id_sucursal)
);

CREATE TABLE auditoria_alerta (
    id_alerta NUMBER(10) PRIMARY KEY,
    id_sucursal NUMBER(4),
    mensaje VARCHAR2(100),
    fecha_registro DATE,
    CONSTRAINT fk_alerta_suc FOREIGN KEY (id_sucursal)
        REFERENCES sucursal(id_sucursal)
);