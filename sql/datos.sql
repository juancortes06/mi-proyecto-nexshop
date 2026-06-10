-- ============================================================
-- NexShop Group S.A. — datos.sql
-- Datos de prueba realistas
-- ============================================================
USE nexshop;

-- ------------------------------------------------------------
-- SEDES
-- ------------------------------------------------------------
INSERT INTO sede (nombre, tipo, ciudad, direccion) VALUES
('Almacén Central Valencia',  'almacen_central', 'Valencia',  'Calle Industria 45'),
('Tienda Valencia Centro',    'tienda_fisica',   'Valencia',  'Calle Colón 12'),
('Tienda Madrid Gran Vía',    'tienda_fisica',   'Madrid',    'Gran Vía 38'),
('Tienda Barcelona Diagonal', 'tienda_fisica',   'Barcelona', 'Av. Diagonal 200');

-- ------------------------------------------------------------
-- EMPLEADOS
-- ------------------------------------------------------------
INSERT INTO empleado (nombre, apellidos, dni, email_corporativo, id_sede, fecha_incorporacion) VALUES
('Carlos',   'Martínez López',   '12345678A', 'c.martinez@nexshop.es',  1, '2018-03-01'),
('Laura',    'Pons García',      '23456789B', 'l.pons@nexshop.es',      1, '2019-06-15'),
('David',    'Cano Fernández',   '34567890C', 'd.cano@nexshop.es',      1, '2020-01-10'),
('Ana',      'Ferrer Ruiz',      '45678901D', 'a.ferrer@nexshop.es',    1, '2017-09-01'),
('Sergio',   'Blanco Torres',    '56789012E', 's.blanco@nexshop.es',    1, '2021-02-20'),
('María',    'Sánchez Pérez',    '67890123F', 'm.sanchez@nexshop.es',   2, '2019-04-01'),
('José',     'López Moreno',     '78901234G', 'j.lopez@nexshop.es',     3, '2020-07-15'),
('Elena',    'Gómez Díaz',       '89012345H', 'e.gomez@nexshop.es',     4, '2021-11-01'),
('Pablo',    'Jiménez Castro',   '90123456I', 'p.jimenez@nexshop.es',   2, '2022-03-10'),
('Carmen',   'Ruiz Navarro',     '01234567J', 'c.ruiz@nexshop.es',      3, '2022-08-20');

-- ------------------------------------------------------------
-- CATEGORIAS
-- ------------------------------------------------------------
INSERT INTO categoria (nombre, id_categoria_padre) VALUES
('Informática',     NULL),
('Portátiles',      1),
('Portátiles Gaming', 2),
('Portátiles Oficina', 2),
('Monitores',       1),
('Periféricos',     1),
('Ratones',         6),
('Teclados',        6),
('Smartphones',     NULL),
('Android',         9),
('iPhone',          9),
('Accesorios Móvil', 9),
('Electrodomésticos', NULL),
('Pequeño Electrodoméstico', 13),
('Audio',           NULL),
('Auriculares',     15),
('Altavoces',       15);

-- ------------------------------------------------------------
-- PRODUCTOS
-- ------------------------------------------------------------
INSERT INTO producto (nombre, descripcion, pvp_actual, id_subcategoria, activo) VALUES
('Laptop Gaming ROG Strix G16',   'Intel i9, RTX 4070, 32GB RAM', 1899.99, 3, TRUE),
('Laptop Dell XPS 15',             'Intel i7, 16GB RAM, OLED',     1299.99, 4, TRUE),
('Monitor LG 27" 4K',              'IPS, 144Hz, HDR600',            699.99, 5, TRUE),
('Ratón Logitech MX Master 3',    'Inalámbrico, 7 botones',         99.99, 7, TRUE),
('Teclado Mecánico Keychron K8',  'TKL, switches Brown',            89.99, 8, TRUE),
('Samsung Galaxy S24',            '256GB, 12GB RAM, 6.2"',         999.99, 10, TRUE),
('iPhone 15 Pro',                 '256GB, Titanio, 48MP',         1299.99, 11, TRUE),
('Funda iPhone 15 Pro MagSafe',   'Silicona, compatible MagSafe',   49.99, 12, TRUE),
('Auriculares Sony WH-1000XM5',   'ANC, 30h batería, BT 5.2',      349.99, 16, TRUE),
('Altavoz JBL Charge 5',          'Portátil, 20h, IPX7',           179.99, 17, TRUE),
('Cafetera Nespresso Vertuo Pop', 'Cápsulas, 1500W, 5 tamaños',    119.99, 14, TRUE),
('Laptop HP Pavilion 15',         'AMD Ryzen 5, 8GB, 512GB SSD',   649.99, 4, TRUE),
('Ratón Gaming Razer DeathAdder', 'Óptico, 20000 DPI, RGB',         79.99, 7, TRUE),
('Monitor Samsung 24" FHD',       'VA, 75Hz, FreeSync',            199.99, 5, TRUE),
('Samsung Galaxy A54',            '128GB, 8GB RAM, 6.4"',          449.99, 10, TRUE);

-- ------------------------------------------------------------
-- HISTORIAL DE PRECIOS
-- ------------------------------------------------------------
INSERT INTO historial_precio (id_producto, precio, fecha_inicio, fecha_fin) VALUES
(1, 1999.99, '2024-01-01', '2024-06-30'),
(1, 1899.99, '2024-07-01', NULL),
(2, 1399.99, '2024-01-01', '2024-09-30'),
(2, 1299.99, '2024-10-01', NULL),
(6, 1099.99, '2024-01-01', '2024-11-30'),
(6,  999.99, '2024-12-01', NULL),
(9,  379.99, '2024-01-01', '2024-05-31'),
(9,  349.99, '2024-06-01', NULL);

-- ------------------------------------------------------------
-- PROMOCIONES
-- ------------------------------------------------------------
INSERT INTO promocion (nombre, descuento_porcentaje, fecha_inicio, fecha_fin) VALUES
('Black Friday 2024',     20.00, '2024-11-29', '2024-12-01'),
('Rebajas Enero 2025',    15.00, '2025-01-07', '2025-01-31'),
('Vuelta al Cole 2024',   10.00, '2024-09-01', '2024-09-30'),
('Oferta Flash Gaming',   25.00, '2025-03-15', '2025-03-17'),
('Primavera Tech',         8.00, '2025-04-01', '2025-04-30');

-- ------------------------------------------------------------
-- PROMOCION_PRODUCTO
-- ------------------------------------------------------------
INSERT INTO promocion_producto (id_promocion, id_producto) VALUES
(1, 1), (1, 2), (1, 6), (1, 7), (1, 9),
(2, 3), (2, 4), (2, 5), (2, 14),
(3, 2), (3, 12),
(4, 1), (4, 13),
(5, 3), (5, 9), (5, 10);

-- ------------------------------------------------------------
-- PROVEEDORES
-- ------------------------------------------------------------
INSERT INTO proveedor (nombre, email, telefono, id_empleado_representante) VALUES
('TechDistrib S.L.',       'ventas@techdistrib.com',   '961234567', 3),
('Iberian Electronics',    'comercial@iberian-elec.es','911234567', 3),
('MobileSupply Europe',    'orders@mobilesupply.eu',  '932345678', 4),
('AudioPro Distribución',  'info@audiopro.es',        '963456789', 3);

-- ------------------------------------------------------------
-- SUMINISTRO
-- ------------------------------------------------------------
INSERT INTO suministro (id_producto, id_proveedor, precio_coste, plazo_entrega_dias, fecha_inicio, fecha_fin) VALUES
(1,  1, 1400.00, 7,  '2024-01-01', NULL),
(2,  1, 950.00,  7,  '2024-01-01', NULL),
(3,  1, 480.00,  5,  '2024-01-01', NULL),
(4,  2, 55.00,   3,  '2024-01-01', NULL),
(5,  2, 48.00,   3,  '2024-01-01', NULL),
(6,  3, 720.00,  5,  '2024-01-01', NULL),
(7,  3, 950.00,  5,  '2024-01-01', NULL),
(9,  4, 210.00,  4,  '2024-01-01', NULL),
(10, 4, 105.00,  4,  '2024-01-01', NULL),
(1,  2, 1450.00, 10, '2024-01-01', '2024-06-30');

-- ------------------------------------------------------------
-- STOCK_UBICACION
-- ------------------------------------------------------------
INSERT INTO stock_ubicacion (id_producto, id_sede, cantidad) VALUES
(1,  1, 15), (1,  2, 3),  (1,  3, 2),  (1,  4, 2),
(2,  1, 20), (2,  2, 5),  (2,  3, 4),  (2,  4, 3),
(3,  1, 30), (3,  2, 8),  (3,  3, 6),
(4,  1, 50), (4,  2, 12), (4,  3, 10), (4,  4, 8),
(5,  1, 40), (5,  2, 10), (5,  3, 8),
(6,  1, 25), (6,  2, 6),  (6,  3, 5),  (6,  4, 4),
(7,  1, 18), (7,  2, 4),  (7,  3, 3),  (7,  4, 3),
(9,  1, 22), (9,  2, 5),  (9,  3, 4),
(10, 1, 35), (10, 2, 8),  (10, 3, 7),  (10, 4, 6),
(12, 1, 28), (12, 2, 7),  (12, 3, 0),
(13, 1, 45), (13, 2, 11), (13, 3, 9),
(15, 1, 20), (15, 2, 5),  (15, 3, 4),  (15, 4, 3);

-- ------------------------------------------------------------
-- TRANSFERENCIAS DE STOCK
-- ------------------------------------------------------------
INSERT INTO transferencia_stock (id_producto, id_sede_origen, id_sede_destino, cantidad, fecha, id_empleado_autoriza) VALUES
(12, 1, 3, 5, '2025-02-10', 3),
(1,  1, 4, 2, '2025-03-05', 3),
(4,  1, 4, 5, '2025-04-01', 4);

-- ------------------------------------------------------------
-- CLIENTES
-- ------------------------------------------------------------
INSERT INTO cliente (nombre, apellidos, email, contrasena_hash, fecha_nacimiento, puntos_saldo) VALUES
('Miguel',   'Torres Vega',      'miguel.torres@gmail.com',   SHA2('pass1234',256), '1990-05-15', 350),
('Sara',     'Medina Fuentes',   'sara.medina@hotmail.com',   SHA2('sara2024',256), '1988-11-22', 1200),
('Roberto',  'Iglesias Mora',    'r.iglesias@yahoo.es',       SHA2('rob1234',256),  '1995-03-08', 80),
('Lucía',    'Herrera Santos',   'lucia.h@gmail.com',         SHA2('lucia99',256),  '1992-07-30', 500),
('Antonio',  'Navarro Gil',      'antonio.nav@outlook.com',   SHA2('ant2025',256),  '1985-12-01', 0),
('Isabel',   'Castillo Ramos',   'isabel.c@gmail.com',        SHA2('isa2024',256),  '1998-04-18', 2800),
('Fernando', 'Ortega Blanco',    'f.ortega@empresa.com',      SHA2('fern123',256),  '1980-09-25', 150),
('Marta',    'Delgado Prieto',   'marta.del@gmail.com',       SHA2('mart456',256),  '1993-02-14', 900),
('Javier',   'Moreno Campos',    'javier.m@hotmail.com',      SHA2('javi789',256),  '1991-06-03', 60),
('Cristina', 'Vargas López',     'cristina.v@gmail.com',      SHA2('cris2024',256), '1996-10-20', 1500);

-- ------------------------------------------------------------
-- DIRECCIONES
-- ------------------------------------------------------------
INSERT INTO direccion_cliente (id_cliente, tipo, calle, numero, piso, codigo_postal, ciudad, pais) VALUES
(1, 'domicilio', 'Calle Mayor',        '15', '3A', '46001', 'Valencia',  'España'),
(1, 'trabajo',   'Av. Constitución',   '8',  NULL, '46002', 'Valencia',  'España'),
(2, 'domicilio', 'Calle Serrano',      '42', '2B', '28001', 'Madrid',    'España'),
(3, 'domicilio', 'Paseo de Gracia',    '100','4C', '08008', 'Barcelona', 'España'),
(4, 'domicilio', 'Calle Alcalá',       '55', '1A', '28009', 'Madrid',    'España'),
(5, 'domicilio', 'Gran Vía',           '22', '5D', '28013', 'Madrid',    'España'),
(6, 'domicilio', 'Calle Valencia',     '33', '2A', '08015', 'Barcelona', 'España'),
(7, 'domicilio', 'Av. del Puerto',     '12', NULL, '46021', 'Valencia',  'España'),
(8, 'domicilio', 'Calle Fuencarral',   '78', '3B', '28004', 'Madrid',    'España'),
(9, 'domicilio', 'Rambla Catalunya',   '45', '1C', '08007', 'Barcelona', 'España'),
(10,'domicilio', 'Calle Sagasta',      '19', '4A', '28004', 'Madrid',    'España');

-- ------------------------------------------------------------
-- PEDIDOS ONLINE
-- ------------------------------------------------------------
INSERT INTO pedido_online (id_cliente, id_direccion_entrega, fecha_pedido, estado, total, puntos_canjeados) VALUES
(1,  1,  '2025-01-15 10:30:00', 'entregado',   1989.98, 0),
(2,  3,  '2025-01-20 14:15:00', 'entregado',   1299.99, 0),
(3,  4,  '2025-02-05 09:00:00', 'entregado',    789.98, 0),
(4,  5,  '2025-02-18 16:45:00', 'entregado',    349.99, 500),
(5,  6,  '2025-03-01 11:20:00', 'cancelado',    999.99, 0),
(6,  7,  '2025-03-10 13:00:00', 'entregado',   2249.98, 2800),
(7,  8,  '2025-04-02 10:00:00', 'enviado',      649.99, 0),
(8,  9,  '2025-04-15 15:30:00', 'en_proceso',   269.98, 0),
(9,  10, '2025-05-03 08:45:00', 'pendiente',    449.99, 0),
(1,  1,  '2025-05-20 12:00:00', 'entregado',     99.99, 0),
(10, 11, '2025-05-25 17:00:00', 'enviado',      529.98, 0),
(2,  3,  '2025-06-01 10:00:00', 'pendiente',    179.99, 0);

-- ------------------------------------------------------------
-- LINEAS DE PEDIDO
-- ------------------------------------------------------------
INSERT INTO linea_pedido (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(1,  1,  1, 1899.99),
(1,  4,  1,   89.99),
(2,  2,  1, 1299.99),
(3,  3,  1,  699.99),
(3,  4,  1,   89.99),
(4,  9,  1,  349.99),
(5,  6,  1,  999.99),
(6,  1,  1, 1899.99),
(6,  9,  1,  349.99),
(7,  12, 1,  649.99),
(8,  4,  1,   99.99),
(8,  5,  1,   89.99),
(8,  13, 1,   79.99),
(9,  15, 1,  449.99),
(10, 4,  1,   99.99),
(11, 9,  1,  349.99),
(11, 10, 1,  179.99),
(12, 10, 1,  179.99);

-- ------------------------------------------------------------
-- ENVIOS
-- ------------------------------------------------------------
INSERT INTO envio (id_pedido, id_sede_origen, numero_seguimiento, transportista, fecha_estimada_entrega, fecha_entrega_real, estado) VALUES
(1,  1, 'SEUR-20250115-001', 'SEUR',    '2025-01-18', '2025-01-17', 'entregado'),
(2,  1, 'MRW-20250120-002',  'MRW',     '2025-01-23', '2025-01-22', 'entregado'),
(3,  1, 'SEUR-20250205-003', 'SEUR',    '2025-02-08', '2025-02-07', 'entregado'),
(4,  1, 'GLS-20250218-004',  'GLS',     '2025-02-21', '2025-02-20', 'entregado'),
(6,  1, 'SEUR-20250310-005', 'SEUR',    '2025-03-13', '2025-03-12', 'entregado'),
(7,  1, 'MRW-20250402-006',  'MRW',     '2025-04-05', NULL,         'en_transito'),
(8,  2, 'GLS-20250415-007',  'GLS',     '2025-04-18', NULL,         'preparando'),
(11, 1, 'SEUR-20250525-008', 'SEUR',    '2025-05-28', NULL,         'en_transito');

-- ------------------------------------------------------------
-- LINEAS ENVIO
-- ------------------------------------------------------------
INSERT INTO linea_envio (id_envio, id_linea, cantidad_enviada) VALUES
(1, 1, 1), (1, 2, 1),
(2, 3, 1),
(3, 4, 1), (3, 5, 1),
(4, 6, 1),
(5, 8, 1), (5, 9, 1),
(6, 10, 1),
(7, 11, 1), (7, 12, 1), (7, 13, 1),
(8, 16, 1), (8, 17, 1);

-- ------------------------------------------------------------
-- VENTAS PRESENCIALES
-- ------------------------------------------------------------
INSERT INTO venta_presencial (id_sede, id_empleado, id_cliente, fecha_venta, total) VALUES
(2, 6, 1,    '2025-01-10 11:30:00', 1299.99),
(3, 7, NULL, '2025-01-22 16:00:00',  699.99),
(4, 8, 3,    '2025-02-14 12:45:00',  449.99),
(2, 9, 4,    '2025-03-05 10:15:00',  179.99),
(3, 10,NULL, '2025-03-20 17:30:00',   99.99),
(2, 6, 6,    '2025-04-08 13:00:00', 1899.99),
(4, 8, 8,    '2025-04-25 15:45:00',  349.99),
(3, 7, NULL, '2025-05-12 11:00:00',   89.99);

-- ------------------------------------------------------------
-- LINEAS VENTA PRESENCIAL
-- ------------------------------------------------------------
INSERT INTO linea_venta_presencial (id_venta, id_producto, cantidad, precio_unitario) VALUES
(1, 2,  1, 1299.99),
(2, 3,  1,  699.99),
(3, 15, 1,  449.99),
(4, 10, 1,  179.99),
(5, 4,  1,   99.99),
(6, 1,  1, 1899.99),
(7, 9,  1,  349.99),
(8, 5,  1,   89.99);

-- ------------------------------------------------------------
-- DEVOLUCIONES PRESENCIALES
-- ------------------------------------------------------------
INSERT INTO devolucion_presencial (id_venta, id_empleado, fecha_devolucion, motivo, importe_devuelto) VALUES
(2, 6, '2025-01-28', 'Producto defectuoso', 699.99),
(5, 7, '2025-03-25', 'No era lo esperado',   99.99);

-- ------------------------------------------------------------
-- TICKETS INCIDENCIA
-- ------------------------------------------------------------
INSERT INTO ticket_incidencia (id_cliente, id_pedido, id_empleado_agente, asunto, descripcion, estado, fecha_apertura, fecha_cierre, nota_resolucion) VALUES
(1, 1,  2, 'Retraso en entrega',       'El pedido llegó un día tarde',         'resuelto',   '2025-01-18', '2025-01-19', 'Se compensó con cupón 10€'),
(3, 3,  2, 'Monitor con píxel muerto', 'Defecto en esquina inferior',           'resuelto',   '2025-02-10', '2025-02-15', 'Reemplazo enviado'),
(5, 5,  2, 'Pedido cancelado error',   'Cancelé sin querer, ¿puedo reactivar?', 'resuelto',   '2025-03-02', '2025-03-03', 'No fue posible reactivar'),
(8, 8,  2, 'Falta artículo pedido',    'Recibí teclado pero falta ratón',       'en_gestion', '2025-04-16', NULL,         NULL),
(2, NULL, 2,'Consulta catálogo',        'Pregunta sobre disponibilidad S24',     'resuelto',   '2025-05-01', '2025-05-01', 'Informado de stock disponible');

-- ------------------------------------------------------------
-- VALORACIONES
-- ------------------------------------------------------------
INSERT INTO valoracion (id_cliente, id_producto, puntuacion, comentario, verificada) VALUES
(1,  1, 5, 'Increíble portátil gaming, muy rápido y pantalla espectacular', TRUE),
(1,  4, 4, 'Muy buen ratón, aunque el precio es algo elevado',              TRUE),
(2,  2, 5, 'El mejor portátil que he tenido, pantalla OLED preciosa',       TRUE),
(3,  3, 4, 'Buena calidad de imagen, el stand es un poco básico',           TRUE),
(4,  9, 5, 'Cancelación de ruido perfecta, batería brutal',                  TRUE),
(6,  1, 5, 'Segunda unidad que compro, insuperable',                         TRUE),
(7, 12, 3, 'Correcta para el precio, nada especial',                         TRUE),
(8,  4, 5, 'El mejor ratón que he probado, muy preciso',                     TRUE),
(8, 13, 4, 'Buen ratón gaming, algo grande para mi mano',                    TRUE),
(10, 9, 4, 'Muy buenos auriculares, el micro podría ser mejor',              TRUE),
(2,  9, 2, 'Me esperaba más por el precio',                                  FALSE);

-- ------------------------------------------------------------
-- MOVIMIENTOS DE PUNTOS
-- ------------------------------------------------------------
INSERT INTO movimiento_puntos (id_cliente, id_pedido, tipo, cantidad, fecha, concepto) VALUES
(1,  1,  'ganado',   19899, '2025-01-15', 'Compra pedido #1'),
(2,  2,  'ganado',   12999, '2025-01-20', 'Compra pedido #2'),
(3,  3,  'ganado',    7899, '2025-02-05', 'Compra pedido #3'),
(4,  4,  'ganado',    3499, '2025-02-18', 'Compra pedido #4'),
(4,  4,  'canjeado',  5000, '2025-02-18', 'Canje en pedido #4'),
(6,  6,  'ganado',   22499, '2025-03-10', 'Compra pedido #6'),
(6,  6,  'canjeado', 28000, '2025-03-10', 'Canje en pedido #6'),
(7,  7,  'ganado',    6499, '2025-04-02', 'Compra pedido #7'),
(8,  8,  'ganado',    2699, '2025-04-15', 'Compra pedido #8'),
(1,  10, 'ganado',     999, '2025-05-20', 'Compra pedido #10'),
(10, 11, 'ganado',    5299, '2025-05-25', 'Compra pedido #11');
