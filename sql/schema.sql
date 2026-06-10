-- ============================================================
-- NexShop Group S.A. — schema.sql
-- Autor: Juan Cortés | CodeArts | Junio 2026
-- ============================================================

DROP DATABASE IF EXISTS nexshop;
CREATE DATABASE nexshop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE nexshop;

-- ------------------------------------------------------------
-- 1. SEDE
-- ------------------------------------------------------------
CREATE TABLE sede (
    id_sede     INT AUTO_INCREMENT PRIMARY KEY,
    nombre      VARCHAR(100) NOT NULL,
    tipo        ENUM('tienda_fisica','almacen_central') NOT NULL,
    ciudad      VARCHAR(100) NOT NULL,
    direccion   VARCHAR(200) NOT NULL
);

-- ------------------------------------------------------------
-- 2. EMPLEADO
-- ------------------------------------------------------------
CREATE TABLE empleado (
    id_empleado         INT AUTO_INCREMENT PRIMARY KEY,
    nombre              VARCHAR(100) NOT NULL,
    apellidos           VARCHAR(100) NOT NULL,
    dni                 VARCHAR(9)   NOT NULL UNIQUE,
    email_corporativo   VARCHAR(150) NOT NULL UNIQUE,
    id_sede             INT          NOT NULL,
    fecha_incorporacion DATE         NOT NULL,
    CONSTRAINT fk_emp_sede FOREIGN KEY (id_sede) REFERENCES sede(id_sede)
);

-- ------------------------------------------------------------
-- 3. CATEGORIA (autorreferencia para jerarquía)
-- ------------------------------------------------------------
CREATE TABLE categoria (
    id_categoria        INT AUTO_INCREMENT PRIMARY KEY,
    nombre              VARCHAR(100) NOT NULL,
    id_categoria_padre  INT NULL,
    CONSTRAINT fk_cat_padre FOREIGN KEY (id_categoria_padre) REFERENCES categoria(id_categoria)
);

-- ------------------------------------------------------------
-- 4. PRODUCTO
-- ------------------------------------------------------------
CREATE TABLE producto (
    id_producto     INT AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(200)   NOT NULL,
    descripcion     TEXT           NULL,
    pvp_actual      DECIMAL(10,2)  NOT NULL,
    id_subcategoria INT            NOT NULL,
    activo          BOOLEAN        NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_prod_cat  FOREIGN KEY (id_subcategoria) REFERENCES categoria(id_categoria),
    CONSTRAINT chk_pvp      CHECK (pvp_actual >= 0)
);

-- ------------------------------------------------------------
-- 5. HISTORIAL_PRECIO
-- ------------------------------------------------------------
CREATE TABLE historial_precio (
    id_historial    INT AUTO_INCREMENT PRIMARY KEY,
    id_producto     INT           NOT NULL,
    precio          DECIMAL(10,2) NOT NULL,
    fecha_inicio    DATE          NOT NULL,
    fecha_fin       DATE          NULL,
    CONSTRAINT fk_hp_prod  FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT chk_hp_precio CHECK (precio >= 0)
);

-- ------------------------------------------------------------
-- 6. PROMOCION
-- ------------------------------------------------------------
CREATE TABLE promocion (
    id_promocion            INT AUTO_INCREMENT PRIMARY KEY,
    nombre                  VARCHAR(150)  NOT NULL,
    descuento_porcentaje    DECIMAL(5,2)  NOT NULL,
    fecha_inicio            DATE          NOT NULL,
    fecha_fin               DATE          NOT NULL,
    CONSTRAINT chk_descuento CHECK (descuento_porcentaje BETWEEN 0 AND 100)
);

-- ------------------------------------------------------------
-- 7. PROMOCION_PRODUCTO (N:M)
-- ------------------------------------------------------------
CREATE TABLE promocion_producto (
    id_promocion    INT NOT NULL,
    id_producto     INT NOT NULL,
    PRIMARY KEY (id_promocion, id_producto),
    CONSTRAINT fk_pp_promo  FOREIGN KEY (id_promocion) REFERENCES promocion(id_promocion),
    CONSTRAINT fk_pp_prod   FOREIGN KEY (id_producto)  REFERENCES producto(id_producto)
);

-- ------------------------------------------------------------
-- 8. PROVEEDOR
-- ------------------------------------------------------------
CREATE TABLE proveedor (
    id_proveedor            INT AUTO_INCREMENT PRIMARY KEY,
    nombre                  VARCHAR(150) NOT NULL,
    email                   VARCHAR(150) NOT NULL,
    telefono                VARCHAR(20)  NULL,
    id_empleado_representante INT        NOT NULL,
    CONSTRAINT fk_prov_emp FOREIGN KEY (id_empleado_representante) REFERENCES empleado(id_empleado)
);

-- ------------------------------------------------------------
-- 9. SUMINISTRO (N:M con histórico)
-- ------------------------------------------------------------
CREATE TABLE suministro (
    id_suministro       INT AUTO_INCREMENT PRIMARY KEY,
    id_producto         INT           NOT NULL,
    id_proveedor        INT           NOT NULL,
    precio_coste        DECIMAL(10,2) NOT NULL,
    plazo_entrega_dias  INT           NOT NULL,
    fecha_inicio        DATE          NOT NULL,
    fecha_fin           DATE          NULL,
    CONSTRAINT fk_sum_prod  FOREIGN KEY (id_producto)  REFERENCES producto(id_producto),
    CONSTRAINT fk_sum_prov  FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
    CONSTRAINT chk_coste    CHECK (precio_coste >= 0),
    CONSTRAINT chk_plazo    CHECK (plazo_entrega_dias > 0)
);

-- ------------------------------------------------------------
-- 10. STOCK_UBICACION
-- ------------------------------------------------------------
CREATE TABLE stock_ubicacion (
    id_stock    INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_sede     INT NOT NULL,
    cantidad    INT NOT NULL DEFAULT 0,
    UNIQUE KEY uq_stock (id_producto, id_sede),
    CONSTRAINT fk_stk_prod  FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT fk_stk_sede  FOREIGN KEY (id_sede)     REFERENCES sede(id_sede),
    CONSTRAINT chk_cantidad CHECK (cantidad >= 0)
);

-- ------------------------------------------------------------
-- 11. TRANSFERENCIA_STOCK
-- ------------------------------------------------------------
CREATE TABLE transferencia_stock (
    id_transferencia    INT AUTO_INCREMENT PRIMARY KEY,
    id_producto         INT  NOT NULL,
    id_sede_origen      INT  NOT NULL,
    id_sede_destino     INT  NOT NULL,
    cantidad            INT  NOT NULL,
    fecha               DATE NOT NULL,
    id_empleado_autoriza INT NOT NULL,
    CONSTRAINT fk_ts_prod   FOREIGN KEY (id_producto)          REFERENCES producto(id_producto),
    CONSTRAINT fk_ts_origen FOREIGN KEY (id_sede_origen)       REFERENCES sede(id_sede),
    CONSTRAINT fk_ts_destino FOREIGN KEY (id_sede_destino)     REFERENCES sede(id_sede),
    CONSTRAINT fk_ts_emp    FOREIGN KEY (id_empleado_autoriza) REFERENCES empleado(id_empleado),
    CONSTRAINT chk_ts_cant  CHECK (cantidad > 0),
    CONSTRAINT chk_ts_sedes CHECK (id_sede_origen <> id_sede_destino)
);

-- ------------------------------------------------------------
-- 12. CLIENTE
-- ------------------------------------------------------------
CREATE TABLE cliente (
    id_cliente      INT AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    apellidos       VARCHAR(100) NOT NULL,
    email           VARCHAR(150) NOT NULL UNIQUE,
    contrasena_hash VARCHAR(255) NOT NULL,
    fecha_nacimiento DATE        NULL,
    fecha_registro  DATETIME     NOT NULL DEFAULT NOW(),
    puntos_saldo    INT          NOT NULL DEFAULT 0,
    CONSTRAINT chk_puntos CHECK (puntos_saldo >= 0)
);

-- ------------------------------------------------------------
-- 13. DIRECCION_CLIENTE
-- ------------------------------------------------------------
CREATE TABLE direccion_cliente (
    id_direccion    INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente      INT          NOT NULL,
    tipo            ENUM('domicilio','trabajo','otro') NOT NULL,
    calle           VARCHAR(200) NOT NULL,
    numero          VARCHAR(10)  NOT NULL,
    piso            VARCHAR(10)  NULL,
    codigo_postal   VARCHAR(10)  NOT NULL,
    ciudad          VARCHAR(100) NOT NULL,
    pais            VARCHAR(100) NOT NULL DEFAULT 'España',
    CONSTRAINT fk_dir_cli FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- ------------------------------------------------------------
-- 14. PEDIDO_ONLINE
-- ------------------------------------------------------------
CREATE TABLE pedido_online (
    id_pedido           INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente          INT           NOT NULL,
    id_direccion_entrega INT          NOT NULL,
    fecha_pedido        DATETIME      NOT NULL DEFAULT NOW(),
    estado              ENUM('pendiente','en_proceso','enviado','entregado','cancelado') NOT NULL DEFAULT 'pendiente',
    total               DECIMAL(10,2) NOT NULL DEFAULT 0,
    puntos_canjeados    INT           NOT NULL DEFAULT 0,
    CONSTRAINT fk_ped_cli FOREIGN KEY (id_cliente)           REFERENCES cliente(id_cliente),
    CONSTRAINT fk_ped_dir FOREIGN KEY (id_direccion_entrega) REFERENCES direccion_cliente(id_direccion),
    CONSTRAINT chk_total  CHECK (total >= 0)
);

-- ------------------------------------------------------------
-- 15. LINEA_PEDIDO
-- ------------------------------------------------------------
CREATE TABLE linea_pedido (
    id_linea        INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido       INT           NOT NULL,
    id_producto     INT           NOT NULL,
    cantidad        INT           NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_lp_ped  FOREIGN KEY (id_pedido)   REFERENCES pedido_online(id_pedido),
    CONSTRAINT fk_lp_prod FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT chk_lp_cant  CHECK (cantidad > 0),
    CONSTRAINT chk_lp_precio CHECK (precio_unitario >= 0)
);

-- ------------------------------------------------------------
-- 16. ENVIO
-- ------------------------------------------------------------
CREATE TABLE envio (
    id_envio                INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido               INT          NOT NULL,
    id_sede_origen          INT          NOT NULL,
    numero_seguimiento      VARCHAR(100) NOT NULL UNIQUE,
    transportista           VARCHAR(100) NOT NULL,
    fecha_estimada_entrega  DATE         NOT NULL,
    fecha_entrega_real      DATE         NULL,
    estado                  ENUM('preparando','en_transito','entregado') NOT NULL DEFAULT 'preparando',
    CONSTRAINT fk_env_ped  FOREIGN KEY (id_pedido)      REFERENCES pedido_online(id_pedido),
    CONSTRAINT fk_env_sede FOREIGN KEY (id_sede_origen) REFERENCES sede(id_sede)
);

-- ------------------------------------------------------------
-- 17. LINEA_ENVIO (N:M entre ENVIO y LINEA_PEDIDO)
-- ------------------------------------------------------------
CREATE TABLE linea_envio (
    id_envio            INT NOT NULL,
    id_linea            INT NOT NULL,
    cantidad_enviada    INT NOT NULL,
    PRIMARY KEY (id_envio, id_linea),
    CONSTRAINT fk_le_env   FOREIGN KEY (id_envio) REFERENCES envio(id_envio),
    CONSTRAINT fk_le_linea FOREIGN KEY (id_linea) REFERENCES linea_pedido(id_linea),
    CONSTRAINT chk_le_cant CHECK (cantidad_enviada > 0)
);

-- ------------------------------------------------------------
-- 18. VENTA_PRESENCIAL
-- ------------------------------------------------------------
CREATE TABLE venta_presencial (
    id_venta        INT AUTO_INCREMENT PRIMARY KEY,
    id_sede         INT           NOT NULL,
    id_empleado     INT           NOT NULL,
    id_cliente      INT           NULL,
    fecha_venta     DATETIME      NOT NULL DEFAULT NOW(),
    total           DECIMAL(10,2) NOT NULL DEFAULT 0,
    CONSTRAINT fk_vp_sede  FOREIGN KEY (id_sede)     REFERENCES sede(id_sede),
    CONSTRAINT fk_vp_emp   FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    CONSTRAINT fk_vp_cli   FOREIGN KEY (id_cliente)  REFERENCES cliente(id_cliente),
    CONSTRAINT chk_vp_total CHECK (total >= 0)
);

-- ------------------------------------------------------------
-- 19. LINEA_VENTA_PRESENCIAL
-- ------------------------------------------------------------
CREATE TABLE linea_venta_presencial (
    id_linea_venta  INT AUTO_INCREMENT PRIMARY KEY,
    id_venta        INT           NOT NULL,
    id_producto     INT           NOT NULL,
    cantidad        INT           NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_lvp_ven  FOREIGN KEY (id_venta)    REFERENCES venta_presencial(id_venta),
    CONSTRAINT fk_lvp_prod FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT chk_lvp_cant CHECK (cantidad > 0)
);

-- ------------------------------------------------------------
-- 20. DEVOLUCION_PRESENCIAL
-- ------------------------------------------------------------
CREATE TABLE devolucion_presencial (
    id_devolucion   INT AUTO_INCREMENT PRIMARY KEY,
    id_venta        INT           NOT NULL,
    id_empleado     INT           NOT NULL,
    fecha_devolucion DATE         NOT NULL,
    motivo          TEXT          NULL,
    importe_devuelto DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_dev_ven FOREIGN KEY (id_venta)    REFERENCES venta_presencial(id_venta),
    CONSTRAINT fk_dev_emp FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    CONSTRAINT chk_dev_imp CHECK (importe_devuelto >= 0)
);

-- ------------------------------------------------------------
-- 21. TICKET_INCIDENCIA
-- ------------------------------------------------------------
CREATE TABLE ticket_incidencia (
    id_ticket           INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente          INT      NULL,
    id_pedido           INT      NULL,
    id_empleado_agente  INT      NOT NULL,
    asunto              VARCHAR(200) NOT NULL,
    descripcion         TEXT         NOT NULL,
    estado              ENUM('abierto','en_gestion','resuelto') NOT NULL DEFAULT 'abierto',
    fecha_apertura      DATETIME NOT NULL DEFAULT NOW(),
    fecha_cierre        DATETIME NULL,
    nota_resolucion     TEXT     NULL,
    CONSTRAINT fk_tic_cli FOREIGN KEY (id_cliente)         REFERENCES cliente(id_cliente),
    CONSTRAINT fk_tic_ped FOREIGN KEY (id_pedido)          REFERENCES pedido_online(id_pedido),
    CONSTRAINT fk_tic_emp FOREIGN KEY (id_empleado_agente) REFERENCES empleado(id_empleado)
);

-- ------------------------------------------------------------
-- 22. VALORACION
-- ------------------------------------------------------------
CREATE TABLE valoracion (
    id_valoracion   INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente      INT      NOT NULL,
    id_producto     INT      NOT NULL,
    puntuacion      INT      NOT NULL,
    comentario      TEXT     NULL,
    fecha_valoracion DATETIME NOT NULL DEFAULT NOW(),
    verificada      BOOLEAN  NOT NULL DEFAULT FALSE,
    UNIQUE KEY uq_val (id_cliente, id_producto),
    CONSTRAINT fk_val_cli  FOREIGN KEY (id_cliente)  REFERENCES cliente(id_cliente),
    CONSTRAINT fk_val_prod FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT chk_puntuacion CHECK (puntuacion BETWEEN 1 AND 5)
);

-- ------------------------------------------------------------
-- 23. MOVIMIENTO_PUNTOS
-- ------------------------------------------------------------
CREATE TABLE movimiento_puntos (
    id_movimiento   INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente      INT      NOT NULL,
    id_pedido       INT      NULL,
    tipo            ENUM('ganado','canjeado') NOT NULL,
    cantidad        INT      NOT NULL,
    fecha           DATETIME NOT NULL DEFAULT NOW(),
    concepto        VARCHAR(200) NULL,
    CONSTRAINT fk_mp_cli FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT fk_mp_ped FOREIGN KEY (id_pedido)  REFERENCES pedido_online(id_pedido),
    CONSTRAINT chk_mp_cant CHECK (cantidad > 0)
);
