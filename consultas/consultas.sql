-- ============================================================
-- NexShop Group S.A. — consultas.sql
-- 14 consultas comentadas
-- Autor: Juan Cortés | CodeArts | Junio 2026
-- ============================================================
USE nexshop;

-- ------------------------------------------------------------
-- CONSULTA 1: Mostrar todos los empleados de la empresa
-- Devuelve todos los registros de la tabla empleado
-- ------------------------------------------------------------
SELECT * FROM empleado;

-- ------------------------------------------------------------
-- CONSULTA 2: Mostrar solo nombre y email de los clientes registrados
-- Selecciona campos concretos sin mostrar datos sensibles
-- ------------------------------------------------------------
SELECT nombre, apellidos, email
FROM cliente;

-- ------------------------------------------------------------
-- CONSULTA 3: Mostrar solo los pedidos con estado 'pendiente'
-- Filtra por un valor exacto con WHERE
-- ------------------------------------------------------------
SELECT id_pedido, id_cliente, fecha_pedido, total
FROM pedido_online
WHERE estado = 'pendiente';

-- ------------------------------------------------------------
-- CONSULTA 4: Buscar productos cuyo nombre contenga 'Gaming'
-- Usa LIKE con comodín % para buscar patrón en campo de texto
-- ------------------------------------------------------------
SELECT id_producto, nombre, pvp_actual
FROM producto
WHERE nombre LIKE '%Gaming%';

-- ------------------------------------------------------------
-- CONSULTA 5: Clientes cuyo nombre empiece por 'M'
-- Usa LIKE para filtrar registros que empiecen por una letra
-- ------------------------------------------------------------
SELECT id_cliente, nombre, apellidos, email
FROM cliente
WHERE nombre LIKE 'M%';

-- ------------------------------------------------------------
-- CONSULTA 6: Pedidos realizados entre dos fechas concretas
-- Filtra por un rango de fechas usando BETWEEN
-- ------------------------------------------------------------
SELECT id_pedido, id_cliente, fecha_pedido, estado, total
FROM pedido_online
WHERE fecha_pedido BETWEEN '2025-01-01' AND '2025-03-31';

-- ------------------------------------------------------------
-- CONSULTA 7: Productos cuyo precio esté entre 100 y 500 euros
-- Filtra por un rango numérico usando BETWEEN
-- ------------------------------------------------------------
SELECT id_producto, nombre, pvp_actual
FROM producto
WHERE pvp_actual BETWEEN 100 AND 500
ORDER BY pvp_actual;

-- ------------------------------------------------------------
-- CONSULTA 8: Líneas de pedido con cantidad superior a 1
-- Filtra por condición numérica mayor que un valor
-- ------------------------------------------------------------
SELECT lp.id_linea, lp.id_pedido, p.nombre AS producto,
       lp.cantidad, lp.precio_unitario
FROM linea_pedido lp
JOIN producto p ON lp.id_producto = p.id_producto
WHERE lp.cantidad > 1;

-- ------------------------------------------------------------
-- CONSULTA 9: Pedidos ordenados del más antiguo al más reciente
-- Ordena resultados de forma ascendente con ORDER BY
-- ------------------------------------------------------------
SELECT id_pedido, id_cliente, fecha_pedido, estado, total
FROM pedido_online
ORDER BY fecha_pedido ASC;

-- ------------------------------------------------------------
-- CONSULTA 10: Productos ordenados de mayor a menor precio
-- Ordena resultados de forma descendente con ORDER BY
-- ------------------------------------------------------------
SELECT id_producto, nombre, pvp_actual
FROM producto
ORDER BY pvp_actual DESC;

-- ------------------------------------------------------------
-- CONSULTA 11: Clientes ordenados alfabéticamente por nombre
-- Ordena de la A a la Z por campo de texto
-- ------------------------------------------------------------
SELECT id_cliente, nombre, apellidos, email
FROM cliente
ORDER BY nombre ASC;

-- ------------------------------------------------------------
-- CONSULTA 12: Cambiar el estado de un pedido específico
-- Actualiza un campo de un registro concreto con UPDATE
-- ------------------------------------------------------------
UPDATE pedido_online
SET estado = 'en_proceso'
WHERE id_pedido = 9;

-- Verificar el cambio
SELECT id_pedido, estado FROM pedido_online WHERE id_pedido = 9;

-- ------------------------------------------------------------
-- CONSULTA 13: Modificar el saldo de puntos de un cliente por su ID
-- Actualiza un campo usando WHERE para identificar el registro
-- ------------------------------------------------------------
UPDATE cliente
SET puntos_saldo = puntos_saldo + 500
WHERE id_cliente = 5;

-- Verificar el cambio
SELECT id_cliente, nombre, puntos_saldo FROM cliente WHERE id_cliente = 5;

-- ------------------------------------------------------------
-- CONSULTA 14: Mostrar el nombre del cliente junto con sus pedidos
-- Combina dos tablas con JOIN mostrando campos de ambas
-- ------------------------------------------------------------
SELECT c.nombre, c.apellidos, c.email,
       p.id_pedido, p.fecha_pedido, p.estado, p.total
FROM cliente c
JOIN pedido_online p ON c.id_cliente = p.id_cliente
ORDER BY c.nombre, p.fecha_pedido;
