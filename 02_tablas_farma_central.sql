--tabla normalizando a: sucursal, cliente, empleado
CREATE TABLE region (
    id_region NUMBER(2) PRIMARY KEY,
    nombre_region VARCHAR2(50) NOT NULL
);

--tabla normalizando a: sucursal, cliente, empleado
CREATE TABLE comuna (
    id_comuna NUMBER(4) PRIMARY KEY,
    nombre_comuna VARCHAR2(50) NOT NULL,
    id_region NUMBER(2) NOT NULL,
    CONSTRAINT fk_comuna_region FOREIGN KEY (id_region)
        REFERENCES region(id_region)
);

--tabla normalizando a: sucursal
CREATE TABLE tipo_sucursal (
    id_tipo NUMBER(2) PRIMARY KEY,
    nombre_tipo VARCHAR2(20) NOT NULL
);

CREATE TABLE sucursal (
    id_sucursal NUMBER(4) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    calle VARCHAR2(80) NOT NULL,
    id_comuna NUMBER(4) NOT NULL,
    id_region NUMBER(2) NOT NULL,
    id_tipo NUMBER(2) NOT NULL,
    CONSTRAINT fk_suc_comuna FOREIGN KEY (id_comuna)
        REFERENCES comuna(id_comuna),
    CONSTRAINT fk_suc_region FOREIGN KEY (id_region)
        REFERENCES region(id_region),
    CONSTRAINT fk_suc_tipo FOREIGN KEY (id_tipo)
        REFERENCES tipo_sucursal(id_tipo)
);

--tabla normalizando a: empleado
CREATE TABLE cargo (
    id_cargo NUMBER(3) PRIMARY KEY,
    nombre_cargo VARCHAR2(30) NOT NULL
);

CREATE TABLE empleado (
    id_empleado NUMBER(6) PRIMARY KEY,
    id_sucursal NUMBER(4) NOT NULL,
    rut VARCHAR2(12) UNIQUE NOT NULL,
    nombre VARCHAR2(30) NOT NULL,
    apellido VARCHAR2(30) NOT NULL,
    id_cargo NUMBER(3) NOT NULL,
    calle VARCHAR2(80) NOT NULL,
    id_comuna NUMBER(4) NOT NULL,
    id_region NUMBER(2) NOT NULL,
    telefono VARCHAR2(15),
    CONSTRAINT fk_emp_suc FOREIGN KEY (id_sucursal)
        REFERENCES sucursal(id_sucursal),
    CONSTRAINT fk_emp_cargo FOREIGN KEY (id_cargo)
        REFERENCES cargo(id_cargo),
    CONSTRAINT fk_emp_comuna FOREIGN KEY (id_comuna)
        REFERENCES comuna(id_comuna),
    CONSTRAINT fk_emp_region FOREIGN KEY (id_region)
        REFERENCES region(id_region)
);

CREATE TABLE cliente (
    id_cliente NUMBER(8) PRIMARY KEY,
    rut VARCHAR2(12) UNIQUE NOT NULL,
    nombre VARCHAR2(30) NOT NULL,
    apellido VARCHAR2(30) NOT NULL,
    calle VARCHAR2(80) NOT NULL,
    id_comuna NUMBER(4) NOT NULL,
    id_region NUMBER(2) NOT NULL,
    telefono VARCHAR2(15),
    CONSTRAINT fk_cli_comuna FOREIGN KEY (id_comuna)
        REFERENCES comuna(id_comuna),
    CONSTRAINT fk_cli_region FOREIGN KEY (id_region)
        REFERENCES region(id_region)
);

--tabla normalizando a: medicamento
CREATE TABLE categoria_medicamento (
    id_categoria NUMBER(3) PRIMARY KEY,
    nombre_categoria VARCHAR2(40) NOT NULL
);

--tabla normalizando a: medicamento
CREATE TABLE tipo_receta (
    id_tipo_receta NUMBER(2) PRIMARY KEY,
    descripcion VARCHAR2(20) NOT NULL
);

CREATE TABLE medicamento (
    id_medicamento NUMBER(6) PRIMARY KEY,
    id_categoria NUMBER(3) NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    id_tipo_receta NUMBER(2) NOT NULL,
    precio NUMBER(8) NOT NULL,
    CONSTRAINT fk_med_cat FOREIGN KEY (id_categoria)
        REFERENCES categoria_medicamento(id_categoria),
    CONSTRAINT fk_med_tiporec FOREIGN KEY (id_tipo_receta)
        REFERENCES tipo_receta(id_tipo_receta)
);

CREATE TABLE lote_stock (
    id_lote VARCHAR2(20) PRIMARY KEY,
    id_medicamento NUMBER(6) NOT NULL,
    id_sucursal NUMBER(4) NOT NULL,
    cantidad NUMBER(5) NOT NULL,
    fecha_ingreso DATE NOT NULL,
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

--tabla normaliza a: envio_bodega
CREATE TABLE estado_envio (
    id_estado NUMBER(2) PRIMARY KEY,
    descripcion VARCHAR2(20) NOT NULL
);

CREATE TABLE envio_bodega (
    id_envio NUMBER(8) PRIMARY KEY,
    id_sucursal_origen NUMBER(4) NOT NULL,
    id_sucursal_destino NUMBER(4) NOT NULL,
    fecha_envio DATE NOT NULL,
    id_estado NUMBER(2) NOT NULL,
    CONSTRAINT fk_envio_origen FOREIGN KEY (id_sucursal_origen)
        REFERENCES sucursal(id_sucursal),
    CONSTRAINT fk_envio_destino FOREIGN KEY (id_sucursal_destino)
        REFERENCES sucursal(id_sucursal),
    CONSTRAINT fk_envio_estado FOREIGN KEY (id_estado)
        REFERENCES estado_envio(id_estado)
);

--un envío necesita un detalle de lo enviado

CREATE TABLE detalle_envio (
    id_envio NUMBER(8) NOT NULL,
    id_lote VARCHAR2(20) NOT NULL,
    cantidad NUMBER(5) NOT NULL,
    observacion VARCHAR2(100),
    PRIMARY KEY (id_envio, id_lote),
    CONSTRAINT fk_det_envio FOREIGN KEY (id_envio)
        REFERENCES envio_bodega(id_envio),
    CONSTRAINT fk_det_envio_lote FOREIGN KEY (id_lote)
        REFERENCES lote_stock(id_lote)
);

--tabla alerta_inventario reemplaza a auditoria_alerta
CREATE TABLE auditoria_alerta (
    id_alerta NUMBER(10) PRIMARY KEY,
    id_sucursal NUMBER(4),
    mensaje VARCHAR2(100),
    fecha_registro DATE,
    CONSTRAINT fk_alerta_suc FOREIGN KEY (id_sucursal)
        REFERENCES sucursal(id_sucursal)
);