-- schema.sql: Creación de tablas y claves foráneas
-- Alumno: Rafael García Moreno

-- Usar (o crear) la base de datos del proyecto
CREATE DATABASE IF NOT EXISTS nexshop
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE nexshop;

-- 1. SEDE (tiendas físicas + almacén central)
-- Lo pide el cliente: "red de tres tiendas físicas" + "almacén central"
-- Decisión de diseño: unificamos en una sola tabla con campo tipo
-- para simplificar las referencias de stock y transferencias.
CREATE TABLE sede (
    sede_id      INT            AUTO_INCREMENT PRIMARY KEY,
    nombre       VARCHAR(100)   NOT NULL,
    tipo         ENUM('tienda','almacen') NOT NULL,
    direccion    VARCHAR(200)   NOT NULL,
    ciudad       VARCHAR(100)   NOT NULL,
    pais         VARCHAR(100)   NOT NULL DEFAULT 'España',
    telefono     VARCHAR(20),
    email        VARCHAR(150)
);

-- 2. EMPLEADO
-- Lo pide el cliente: nombre, DNI, email corporativo,
-- fecha incorporación, sede asignada.
CREATE TABLE empleado (
    empleado_id       INT           AUTO_INCREMENT PRIMARY KEY,
    nombre            VARCHAR(100)  NOT NULL,
    apellidos         VARCHAR(150)  NOT NULL,
    dni               CHAR(9)       NOT NULL UNIQUE,
    email_corporativo VARCHAR(150)  NOT NULL UNIQUE,
    fecha_incorporacion DATE         NOT NULL,
    rol               ENUM('encargado','vendedor','responsable_almacen','logistica','atencion_cliente','comercial','it') NOT NULL,
    sede_id           INT           NOT NULL,
    CONSTRAINT fk_empleado_sede FOREIGN KEY (sede_id) REFERENCES sede(sede_id)
);

-- 3. CATEGORÍA
-- Lo pide el cliente: "categorías y subcategorías"
-- Decisión: modelo jerárquico self-referencing.
-- categoria_padre_id NULL = categoría raíz; NOT NULL = subcategoría.
CREATE TABLE categoria (
    categoria_id       INT           AUTO_INCREMENT PRIMARY KEY,
    nombre             VARCHAR(100)  NOT NULL,
    descripcion        TEXT,
    categoria_padre_id INT           NULL,
    CONSTRAINT fk_categoria_padre FOREIGN KEY (categoria_padre_id)
        REFERENCES categoria(categoria_id)
        ON DELETE RESTRICT
);

-- 4. PRODUCTO
-- Lo pide el cliente: catálogo >2000 referencias, PVP variable,
-- pertenece a UNA subcategoría.
CREATE TABLE producto (
    producto_id   INT             AUTO_INCREMENT PRIMARY KEY,
    referencia    VARCHAR(50)     NOT NULL UNIQUE,
    nombre        VARCHAR(200)    NOT NULL,
    descripcion   TEXT,
    pvp_actual    DECIMAL(10,2)   NOT NULL CHECK (pvp_actual >= 0),
    activo        BOOLEAN         NOT NULL DEFAULT TRUE,
    categoria_id  INT             NOT NULL,
    CONSTRAINT fk_producto_categoria FOREIGN KEY (categoria_id)
        REFERENCES categoria(categoria_id)
);

-- 5. HISTÓRICO DE PRECIOS
-- Lo pide el cliente: "el sistema debe ser capaz de mostrar
-- el historial completo de precios".
-- Cada vez que cambia el PVP, se cierra el registro anterior
-- (fecha_fin) y se abre uno nuevo.
CREATE TABLE historico_precio (
    historico_precio_id INT            AUTO_INCREMENT PRIMARY KEY,
    producto_id         INT            NOT NULL,
    precio              DECIMAL(10,2)  NOT NULL CHECK (precio >= 0),
    fecha_inicio        DATE           NOT NULL,
    fecha_fin           DATE           NULL,  -- NULL = precio vigente
    CONSTRAINT fk_historico_precio_producto FOREIGN KEY (producto_id)
        REFERENCES producto(producto_id)
);

-- 6. PROVEEDOR
-- Lo pide el cliente: "proveedores suministran productos al
-- almacén central", con representante comercial de NexShop.
CREATE TABLE proveedor (
    proveedor_id        INT           AUTO_INCREMENT PRIMARY KEY,
    nombre_empresa      VARCHAR(200)  NOT NULL,
    nif                 VARCHAR(20)   NOT NULL UNIQUE,
    email               VARCHAR(150),
    telefono            VARCHAR(20),
    pais                VARCHAR(100),
    empleado_comercial_id INT         NULL, -- representante de NexShop
    CONSTRAINT fk_proveedor_empleado FOREIGN KEY (empleado_comercial_id)
        REFERENCES empleado(empleado_id)
        ON DELETE SET NULL
);

-- 7. PROVEEDOR_PRODUCTO (resolución N:M Proveedor-Producto)
-- Lo pide el cliente: "precio de coste y plazo de entrega
-- negociados por cada combinación producto-proveedor".
-- Histórico: se usa fecha_inicio para versionar las condiciones.
CREATE TABLE proveedor_producto (
    proveedor_producto_id INT            AUTO_INCREMENT PRIMARY KEY,
    proveedor_id          INT            NOT NULL,
    producto_id           INT            NOT NULL,
    precio_coste          DECIMAL(10,2)  NOT NULL CHECK (precio_coste >= 0),
    plazo_entrega_dias    INT            NOT NULL CHECK (plazo_entrega_dias > 0),
    fecha_inicio          DATE           NOT NULL,
    fecha_fin             DATE           NULL,  -- NULL = condición vigente
    CONSTRAINT fk_pp_proveedor FOREIGN KEY (proveedor_id)
        REFERENCES proveedor(proveedor_id),
    CONSTRAINT fk_pp_producto FOREIGN KEY (producto_id)
        REFERENCES producto(producto_id)
);

-- 8. PROMOCIÓN
-- Lo pide el cliente: "descuento porcentual sobre el PVP
-- durante un rango de fechas concreto".
CREATE TABLE promocion (
    promocion_id         INT            AUTO_INCREMENT PRIMARY KEY,
    nombre               VARCHAR(200)   NOT NULL,
    descripcion          TEXT,
    descuento_porcentual DECIMAL(5,2)   NOT NULL CHECK (descuento_porcentual > 0 AND descuento_porcentual <= 100),
    fecha_inicio         DATE           NOT NULL,
    fecha_fin            DATE           NOT NULL,
    CHECK (fecha_fin >= fecha_inicio)
);

-- 9. PROMOCION_PRODUCTO (resolución N:M Promoción-Producto)
-- Lo propongo yo: necesaria para vincular qué productos
-- participan en cada promoción.
CREATE TABLE promocion_producto (
    promocion_id INT NOT NULL,
    producto_id  INT NOT NULL,
    PRIMARY KEY (promocion_id, producto_id),
    CONSTRAINT fk_promprod_promocion FOREIGN KEY (promocion_id)
        REFERENCES promocion(promocion_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_promprod_producto FOREIGN KEY (producto_id)
        REFERENCES producto(producto_id)
        ON DELETE CASCADE
);

-- 10. CLIENTE
-- Lo pide el cliente: nombre, apellidos, email, contraseña,
-- fecha de nacimiento (opcional), para registro online.
-- También existen clientes anónimos (compra presencial sin registro).
CREATE TABLE cliente (
    cliente_id      INT           AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(100)  NOT NULL,
    apellidos       VARCHAR(150)  NOT NULL,
    email           VARCHAR(150)  NOT NULL UNIQUE,
    password_hash   VARCHAR(255)  NOT NULL,
    fecha_nacimiento DATE          NULL,  -- opcional
    telefono        VARCHAR(20)   NULL,
    fecha_registro  DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    activo          BOOLEAN       NOT NULL DEFAULT TRUE
);

-- 11. DIRECCIÓN
-- Lo pide el cliente: "cliente puede tener múltiples direcciones
-- guardadas (domicilio, trabajo u otras)".
CREATE TABLE direccion (
    direccion_id   INT           AUTO_INCREMENT PRIMARY KEY,
    cliente_id     INT           NOT NULL,
    alias          VARCHAR(50)   NOT NULL DEFAULT 'Principal',  -- ej: 'Trabajo', 'Casa'
    calle          VARCHAR(200)  NOT NULL,
    numero         VARCHAR(10)   NOT NULL,
    piso           VARCHAR(20)   NULL,
    codigo_postal  CHAR(10)      NOT NULL,
    ciudad         VARCHAR(100)  NOT NULL,
    pais           VARCHAR(100)  NOT NULL DEFAULT 'España',
    es_principal   BOOLEAN       NOT NULL DEFAULT FALSE,
    CONSTRAINT fk_direccion_cliente FOREIGN KEY (cliente_id)
        REFERENCES cliente(cliente_id)
        ON DELETE CASCADE
);

-- 12. PEDIDO ONLINE
-- Lo pide el cliente: pedidos a través de nexshop.es
CREATE TABLE pedido_online (
    pedido_id         INT            AUTO_INCREMENT PRIMARY KEY,
    cliente_id        INT            NOT NULL,
    direccion_id      INT            NOT NULL,  -- dirección de entrega elegida
    fecha_pedido      DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado            ENUM('pendiente','confirmado','en_preparacion','enviado','entregado','cancelado') NOT NULL DEFAULT 'pendiente',
    total             DECIMAL(12,2)  NOT NULL DEFAULT 0.00,
    puntos_canjeados  INT            NOT NULL DEFAULT 0,  -- puntos usados como descuento
    notas             TEXT           NULL,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (cliente_id)
        REFERENCES cliente(cliente_id),
    CONSTRAINT fk_pedido_direccion FOREIGN KEY (direccion_id)
        REFERENCES direccion(direccion_id)
);

-- 13. LINEA_PEDIDO (resolución N:M PedidoOnline-Producto)
-- Lo propongo yo: tabla de detalle imprescindible para
-- registrar qué productos y en qué cantidad lleva cada pedido.
-- Se guarda precio_unitario al momento de la compra (histórico).
CREATE TABLE linea_pedido (
    linea_pedido_id  INT            AUTO_INCREMENT PRIMARY KEY,
    pedido_id        INT            NOT NULL,
    producto_id      INT            NOT NULL,
    cantidad         INT            NOT NULL CHECK (cantidad > 0),
    precio_unitario  DECIMAL(10,2)  NOT NULL CHECK (precio_unitario >= 0),
    descuento_aplicado DECIMAL(5,2) NOT NULL DEFAULT 0.00,  -- % de promoción aplicada
    CONSTRAINT fk_lp_pedido FOREIGN KEY (pedido_id)
        REFERENCES pedido_online(pedido_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_lp_producto FOREIGN KEY (producto_id)
        REFERENCES producto(producto_id)
);

-- 14. ENVÍO
-- Lo pide el cliente: "un pedido puede generar varios envíos,
-- cada uno con su propio número de seguimiento, transportista
-- y fecha estimada de entrega".
CREATE TABLE envio (
    envio_id               INT           AUTO_INCREMENT PRIMARY KEY,
    pedido_id              INT           NOT NULL,
    sede_origen_id         INT           NOT NULL,  -- almacén desde el que sale
    numero_seguimiento     VARCHAR(100)  NOT NULL UNIQUE,
    transportista          VARCHAR(100)  NOT NULL,
    fecha_estimada_entrega DATE          NOT NULL,
    fecha_entrega_real     DATE          NULL,
    estado                 ENUM('preparando','en_transito','entregado','fallido') NOT NULL DEFAULT 'preparando',
    CONSTRAINT fk_envio_pedido FOREIGN KEY (pedido_id)
        REFERENCES pedido_online(pedido_id),
    CONSTRAINT fk_envio_sede FOREIGN KEY (sede_origen_id)
        REFERENCES sede(sede_id)
);

-- 15. VENTA PRESENCIAL
-- Lo pide el cliente: "ticket de venta (no un pedido online)"
-- en tiendas físicas, realizado por un empleado.
-- cliente_id es nullable para ventas anónimas.
CREATE TABLE venta_presencial (
    venta_id         INT           AUTO_INCREMENT PRIMARY KEY,
    sede_id          INT           NOT NULL,
    empleado_id      INT           NOT NULL,  -- vendedor que realizó la venta
    cliente_id       INT           NULL,      -- NULL si cliente anónimo
    cliente_anonimo_ref VARCHAR(100) NULL,    -- nombre/tel provisional para vincular después
    fecha_venta      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total            DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_venta_sede FOREIGN KEY (sede_id)
        REFERENCES sede(sede_id),
    CONSTRAINT fk_venta_empleado FOREIGN KEY (empleado_id)
        REFERENCES empleado(empleado_id),
    CONSTRAINT fk_venta_cliente FOREIGN KEY (cliente_id)
        REFERENCES cliente(cliente_id)
        ON DELETE SET NULL
);

-- 16. LINEA_VENTA (resolución N:M VentaPresencial-Producto)
-- Lo propongo yo: misma lógica que linea_pedido.
CREATE TABLE linea_venta (
    linea_venta_id   INT            AUTO_INCREMENT PRIMARY KEY,
    venta_id         INT            NOT NULL,
    producto_id      INT            NOT NULL,
    cantidad         INT            NOT NULL CHECK (cantidad > 0),
    precio_unitario  DECIMAL(10,2)  NOT NULL CHECK (precio_unitario >= 0),
    CONSTRAINT fk_lv_venta FOREIGN KEY (venta_id)
        REFERENCES venta_presencial(venta_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_lv_producto FOREIGN KEY (producto_id)
        REFERENCES producto(producto_id)
);

-- 17. DEVOLUCIÓN
-- Lo pide el cliente: "documento de devolución vinculado al
-- ticket de venta original" (solo ventas presenciales;
-- las devoluciones online se gestionan como incidencia).
CREATE TABLE devolucion (
    devolucion_id    INT            AUTO_INCREMENT PRIMARY KEY,
    venta_id         INT            NOT NULL,
    producto_id      INT            NOT NULL,
    cantidad         INT            NOT NULL CHECK (cantidad > 0),
    motivo           TEXT,
    fecha_devolucion DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    importe_reembolsado DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_dev_venta FOREIGN KEY (venta_id)
        REFERENCES venta_presencial(venta_id),
    CONSTRAINT fk_dev_producto FOREIGN KEY (producto_id)
        REFERENCES producto(producto_id)
);

-- 18. TICKET DE INCIDENCIA (Atención al Cliente)
-- Lo pide el cliente: asunto, descripción, fecha apertura,
-- estado, agente, pedido relacionado (opcional),
-- fecha cierre y nota de resolución.
CREATE TABLE ticket_incidencia (
    ticket_id        INT           AUTO_INCREMENT PRIMARY KEY,
    cliente_id       INT           NOT NULL,
    empleado_id      INT           NOT NULL,  -- agente de atención al cliente
    pedido_id        INT           NULL,      -- NULL si consulta general
    asunto           VARCHAR(300)  NOT NULL,
    descripcion      TEXT          NOT NULL,
    fecha_apertura   DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado           ENUM('abierto','en_gestion','resuelto') NOT NULL DEFAULT 'abierto',
    fecha_cierre     DATETIME      NULL,
    nota_resolucion  TEXT          NULL,
    CONSTRAINT fk_ticket_cliente FOREIGN KEY (cliente_id)
        REFERENCES cliente(cliente_id),
    CONSTRAINT fk_ticket_empleado FOREIGN KEY (empleado_id)
        REFERENCES empleado(empleado_id),
    CONSTRAINT fk_ticket_pedido FOREIGN KEY (pedido_id)
        REFERENCES pedido_online(pedido_id)
        ON DELETE SET NULL
);

-- 19. STOCK
-- Lo pide el cliente: "stock por ubicación: cada tienda y
-- almacén central tienen su propio nivel de stock por referencia".
CREATE TABLE stock (
    stock_id      INT  AUTO_INCREMENT PRIMARY KEY,
    sede_id       INT  NOT NULL,
    producto_id   INT  NOT NULL,
    cantidad      INT  NOT NULL DEFAULT 0 CHECK (cantidad >= 0),
    UNIQUE KEY uq_stock_sede_producto (sede_id, producto_id),
    CONSTRAINT fk_stock_sede FOREIGN KEY (sede_id)
        REFERENCES sede(sede_id),
    CONSTRAINT fk_stock_producto FOREIGN KEY (producto_id)
        REFERENCES producto(producto_id)
);

-- 20. TRANSFERENCIA DE STOCK
-- Lo pide el cliente: "quedan registradas con fecha, origen,
-- destino, producto, cantidad y el empleado que la autorizó".
CREATE TABLE transferencia_stock (
    transferencia_id  INT            AUTO_INCREMENT PRIMARY KEY,
    producto_id       INT            NOT NULL,
    sede_origen_id    INT            NOT NULL,
    sede_destino_id   INT            NOT NULL,
    cantidad          INT            NOT NULL CHECK (cantidad > 0),
    fecha             DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    empleado_id       INT            NOT NULL,  -- quien la autorizó
    estado            ENUM('solicitada','en_transito','completada','cancelada') NOT NULL DEFAULT 'solicitada',
    CONSTRAINT fk_transf_producto FOREIGN KEY (producto_id)
        REFERENCES producto(producto_id),
    CONSTRAINT fk_transf_origen FOREIGN KEY (sede_origen_id)
        REFERENCES sede(sede_id),
    CONSTRAINT fk_transf_destino FOREIGN KEY (sede_destino_id)
        REFERENCES sede(sede_id),
    CONSTRAINT fk_transf_empleado FOREIGN KEY (empleado_id)
        REFERENCES empleado(empleado_id),
    CONSTRAINT chk_transf_distinta CHECK (sede_origen_id <> sede_destino_id)
);

-- 21. VALORACIÓN
-- Lo pide el cliente (email Ana Ferrer): puntuación 1-5 y
-- comentario, solo una vez por producto por cliente,
-- campo verificada para distinguir compra confirmada.
CREATE TABLE valoracion (
    valoracion_id   INT   AUTO_INCREMENT PRIMARY KEY,
    cliente_id      INT   NOT NULL,
    producto_id     INT   NOT NULL,
    puntuacion      TINYINT NOT NULL CHECK (puntuacion BETWEEN 1 AND 5),
    comentario      TEXT,
    fecha           DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    es_verificada   BOOLEAN  NOT NULL DEFAULT FALSE,  -- TRUE = compra confirmada
    pedido_id       INT      NULL,  -- pedido que verificó la compra (si aplica)
    UNIQUE KEY uq_valoracion_cliente_producto (cliente_id, producto_id),
    CONSTRAINT fk_val_cliente FOREIGN KEY (cliente_id)
        REFERENCES cliente(cliente_id),
    CONSTRAINT fk_val_producto FOREIGN KEY (producto_id)
        REFERENCES producto(producto_id),
    CONSTRAINT fk_val_pedido FOREIGN KEY (pedido_id)
        REFERENCES pedido_online(pedido_id)
        ON DELETE SET NULL
);

-- 22. MOVIMIENTO DE PUNTOS (Fidelización)
-- Lo pide el cliente (email Ana Ferrer): registrar cada
-- movimiento de puntos: cuándo, en qué pedido, cuántos,
-- si fueron ganados o canjeados.
-- El saldo se calcula siempre desde el histórico (sin saldo_actual).
CREATE TABLE movimiento_puntos (
    movimiento_id   INT       AUTO_INCREMENT PRIMARY KEY,
    cliente_id      INT       NOT NULL,
    tipo            ENUM('ganado','canjeado') NOT NULL,
    puntos          INT       NOT NULL CHECK (puntos > 0),
    pedido_id       INT       NULL,  -- NULL para ajustes manuales o canjeos
    fecha           DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descripcion     VARCHAR(300),
    CONSTRAINT fk_mp_cliente FOREIGN KEY (cliente_id)
        REFERENCES cliente(cliente_id),
    CONSTRAINT fk_mp_pedido FOREIGN KEY (pedido_id)
        REFERENCES pedido_online(pedido_id)
        ON DELETE SET NULL
);

-- ÍNDICES adicionales para mejorar rendimiento
CREATE INDEX idx_producto_categoria   ON producto(categoria_id);
CREATE INDEX idx_pedido_cliente       ON pedido_online(cliente_id);
CREATE INDEX idx_pedido_estado        ON pedido_online(estado);
CREATE INDEX idx_envio_pedido         ON envio(pedido_id);
CREATE INDEX idx_ticket_cliente       ON ticket_incidencia(cliente_id);
CREATE INDEX idx_stock_producto       ON stock(producto_id);
CREATE INDEX idx_movpto_cliente       ON movimiento_puntos(cliente_id);
CREATE INDEX idx_valoracion_producto  ON valoracion(producto_id);
