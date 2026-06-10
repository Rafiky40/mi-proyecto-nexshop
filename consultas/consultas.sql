-- NEXSHOP GROUP S.A. - Batería de 14 Consultas SQL
-- consultas.sql: Consultas para probar la base de datos
-- Alumno: Rafael García Moreno

USE nexshop;

-- CONSULTA 1: SELECT * — Todos los empleados de NexShop
-- Muestra el registro completo de todos los empleados de la empresa.
SELECT *
FROM empleado;

-- CONSULTA 2: SELECT campos específicos
-- Muestra solo el nombre completo y email de los clientes registrados.
SELECT
    CONCAT(nombre, ' ', apellidos) AS nombre_completo,
    email
FROM cliente
WHERE activo = TRUE
ORDER BY apellidos, nombre;

-- CONSULTA 3: WHERE valor exacto
-- Muestra todos los pedidos online con estado 'Pendiente'.
SELECT
    pedido_id,
    cliente_id,
    fecha_pedido,
    total,
    notas
FROM pedido_online
WHERE estado = 'pendiente'
ORDER BY fecha_pedido ASC;

-- CONSULTA 4: LIKE — Buscar patrón en campo de texto
-- Busca productos cuyo nombre contenga la palabra 'Gaming'.
SELECT
    referencia,
    nombre,
    pvp_actual,
    activo
FROM producto
WHERE nombre LIKE '%Gaming%'
ORDER BY pvp_actual DESC;

-- CONSULTA 5: LIKE — Registros que empiezan por letra/palabra
-- Muestra clientes cuyo nombre empiece por 'A'.
SELECT
    cliente_id,
    nombre,
    apellidos,
    email,
    fecha_registro
FROM cliente
WHERE nombre LIKE 'A%'
ORDER BY apellidos;

-- CONSULTA 6: BETWEEN — Rango de fechas
-- Pedidos online realizados durante el período de Black Friday 2024.
SELECT
    pedido_id,
    cliente_id,
    fecha_pedido,
    estado,
    total,
    puntos_canjeados
FROM pedido_online
WHERE fecha_pedido BETWEEN '2024-11-29 00:00:00' AND '2024-12-01 23:59:59'
ORDER BY fecha_pedido;

-- CONSULTA 7: BETWEEN — Rango numérico
-- Productos cuyo PVP actual esté entre 100€ y 500€ (gama media).
SELECT
    referencia,
    nombre,
    pvp_actual,
    activo
FROM producto
WHERE pvp_actual BETWEEN 100.00 AND 500.00
  AND activo = TRUE
ORDER BY pvp_actual;

-- CONSULTA 8: Condición numérica mayor que
-- Muestra líneas de pedido con cantidad superior a 1 unidad.
SELECT
    lp.linea_pedido_id,
    lp.pedido_id,
    p.nombre AS producto,
    lp.cantidad,
    lp.precio_unitario,
    (lp.cantidad * lp.precio_unitario) AS subtotal
FROM linea_pedido lp
JOIN producto p ON p.producto_id = lp.producto_id
WHERE lp.cantidad > 1
ORDER BY lp.cantidad DESC;

-- CONSULTA 9: ORDER BY ASC — Ordenar por fecha ascendente
-- Pedidos ordenados del más antiguo al más reciente.
SELECT
    pedido_id,
    cliente_id,
    fecha_pedido,
    estado,
    total
FROM pedido_online
ORDER BY fecha_pedido ASC;

-- CONSULTA 10: ORDER BY DESC — Ordenar por valor descendente
-- Productos activos ordenados de mayor a menor precio.
SELECT
    referencia,
    nombre,
    pvp_actual
FROM producto
WHERE activo = TRUE
ORDER BY pvp_actual DESC;

-- CONSULTA 11: ORDER BY texto — Orden alfabético
-- Clientes registrados ordenados alfabéticamente por apellidos y nombre.
SELECT
    cliente_id,
    apellidos,
    nombre,
    email,
    telefono
FROM cliente
ORDER BY apellidos ASC, nombre ASC;

-- CONSULTA 12: UPDATE — Actualizar un registro concreto
-- Cambia el estado del pedido nº 7 a 'enviado' y registra
UPDATE pedido_online
SET estado = 'enviado'
WHERE pedido_id = 7;

-- Verificación del cambio
SELECT pedido_id, estado, fecha_pedido, total
FROM pedido_online
WHERE pedido_id = 7;

-- CONSULTA 13: UPDATE con WHERE — Actualizar usando identificador
-- Modifica el teléfono del cliente con ID 3 (Carlos Fernández).
UPDATE cliente
SET telefono = '634999888'
WHERE cliente_id = 3;

-- Verificación del cambio
SELECT cliente_id, nombre, apellidos, email, telefono
FROM cliente
WHERE cliente_id = 3;

-- CONSULTA 14: JOIN — Combinar tablas relacionadas
-- Muestra el nombre completo del cliente junto con sus pedidos:
-- número de pedido, fecha, estado y total.
SELECT
    c.cliente_id,
    CONCAT(c.nombre, ' ', c.apellidos) AS cliente,
    c.email,
    po.pedido_id,
    po.fecha_pedido,
    po.estado,
    po.total,
    po.puntos_canjeados
FROM cliente c
JOIN pedido_online po ON po.cliente_id = c.cliente_id
ORDER BY c.apellidos, c.nombre, po.fecha_pedido DESC;
