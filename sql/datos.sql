USE nexshop;

-- ============================================================
-- 1. SEDES (3 tiendas + 1 almacén central)
-- ============================================================
INSERT INTO sede (nombre, tipo, direccion, ciudad, pais, telefono, email) VALUES
('Almacén Central Valencia',   'almacen', 'Polígono Industrial Vara de Quart, Nave 7',     'Valencia',  'España', '963001001', 'almacen@nexshop.es'),
('Tienda NexShop Valencia',    'tienda',  'Calle Colón 45, Local 2',                         'Valencia',  'España', '963001002', 'valencia@nexshop.es'),
('Tienda NexShop Madrid',      'tienda',  'Calle Gran Vía 22, Local 1',                      'Madrid',    'España', '915001003', 'madrid@nexshop.es'),
('Tienda NexShop Barcelona',   'tienda',  'Passeig de Gràcia 88, Local 3',                   'Barcelona', 'España', '932001004', 'barcelona@nexshop.es');

-- ============================================================
-- 2. EMPLEADOS (variados roles en distintas sedes)
-- ============================================================
INSERT INTO empleado (nombre, apellidos, dni, email_corporativo, fecha_incorporacion, rol, sede_id) VALUES
('Ana',     'Ferrer García',    '12345678A', 'a.ferrer@nexshop.es',    '2015-03-01', 'logistica',          1),
('David',   'Cano Martínez',    '23456789B', 'd.cano@nexshop.es',      '2016-06-15', 'responsable_almacen',1),
('Sergio',  'Blanco López',     '34567890C', 's.blanco@nexshop.es',    '2017-01-10', 'it',                 1),
('Laura',   'Pons Ruiz',        '45678901D', 'l.pons@nexshop.es',      '2018-04-20', 'atencion_cliente',   1),
('Carlos',  'Mendez Torres',    '56789012E', 'c.mendez@nexshop.es',    '2019-09-01', 'encargado',          2),
('María',   'Sánchez Vega',     '67890123F', 'm.sanchez@nexshop.es',   '2020-02-14', 'vendedor',           2),
('Jorge',   'Ramírez Ortiz',    '78901234G', 'j.ramirez@nexshop.es',   '2019-11-05', 'encargado',          3),
('Elena',   'Castro Moreno',    '89012345H', 'e.castro@nexshop.es',    '2021-03-22', 'vendedor',           3),
('Pablo',   'Torres Jiménez',   '90123456I', 'p.torres@nexshop.es',    '2020-07-07', 'encargado',          4),
('Lucía',   'Navarro Gil',      '01234567J', 'l.navarro@nexshop.es',   '2022-01-17', 'vendedor',           4),
('Andrés',  'Molina Pérez',     '11223344K', 'a.molina@nexshop.es',    '2018-08-30', 'comercial',          1),
('Rosa',    'Giménez Fdez',     '22334455L', 'r.gimenez@nexshop.es',   '2023-05-12', 'atencion_cliente',   1);

-- ============================================================
-- 3. CATEGORÍAS (árbol padre-hijo)
-- ============================================================
-- Categorías raíz
INSERT INTO categoria (nombre, descripcion, categoria_padre_id) VALUES
('Informática',   'Equipos informáticos y periféricos', NULL),
('Smartphones',   'Teléfonos inteligentes y accesorios', NULL),
('Electrodomésticos', 'Grandes y pequeños electrodomésticos', NULL),
('Audio y Video',  'Equipos de sonido y televisión', NULL);

-- Subcategorías de Informática (padre_id = 1)
INSERT INTO categoria (nombre, descripcion, categoria_padre_id) VALUES
('Portátiles',         'Portátiles de todas las gamas',      1),
('Ordenadores Sobremesa','PCs de escritorio y all-in-one',   1),
('Periféricos',        'Teclados, ratones, monitores...',    1);

-- Subcategorías de Portátiles (padre_id = 5)
INSERT INTO categoria (nombre, descripcion, categoria_padre_id) VALUES
('Portátiles Gaming',    'Alto rendimiento para juegos',     5),
('Portátiles Oficina',   'Productividad y uso profesional',  5),
('Portátiles Ultraligeros','Ultrabooks y ligeros de viaje',  5);

-- Subcategorías de Smartphones (padre_id = 2)
INSERT INTO categoria (nombre, descripcion, categoria_padre_id) VALUES
('Android',    'Smartphones con sistema Android',  2),
('iPhone',     'Smartphones de Apple',             2);

-- Subcategorías de Electrodomésticos (padre_id = 3)
INSERT INTO categoria (nombre, descripcion, categoria_padre_id) VALUES
('Frigoríficos','Frigoríficos y congeladores',    3),
('Lavadoras',   'Lavadoras y secadoras',          3);

-- ============================================================
-- 4. PRODUCTOS (20 referencias variadas)
-- ============================================================
INSERT INTO producto (referencia, nombre, descripcion, pvp_actual, activo, categoria_id) VALUES
('LAP-GAM-001', 'ASUS ROG Strix G16 RTX 4070',    'Portátil gaming 16" 165Hz, 32GB RAM, 1TB SSD',       1499.99, TRUE, 8),
('LAP-GAM-002', 'MSI Katana 15 RTX 4060',          'Portátil gaming 15.6" FHD 144Hz, 16GB, 512GB',      999.99,  TRUE, 8),
('LAP-OFI-001', 'Dell Latitude 5540',              'Portátil oficina 15" i5 13ª gen, 16GB, 512GB SSD',  849.99,  TRUE, 9),
('LAP-OFI-002', 'HP EliteBook 840 G10',            'Portátil empresarial 14" i7, 16GB, 1TB',            1199.99, TRUE, 9),
('LAP-ULT-001', 'LG Gram 14 2024',                 'Ultraligero 14" i7, 16GB, 1TB, 1130g',              1099.99, TRUE, 10),
('LAP-ULT-002', 'Lenovo ThinkPad X1 Carbon Gen 11','Ultraligero 14" i7 vPro, 16GB, 512GB',             1349.99, TRUE, 10),
('SMT-AND-001', 'Samsung Galaxy S24 Ultra',         '6.8" 200MP, 12GB RAM, 256GB, Titanio Violeta',     1349.99, TRUE, 11),
('SMT-AND-002', 'Google Pixel 8 Pro',              '6.7" 50MP, 12GB, 256GB, Android 14 puro',           899.99,  TRUE, 11),
('SMT-AND-003', 'Xiaomi 14',                       '6.36" Leica 50MP, 12GB, 256GB',                     699.99,  TRUE, 11),
('SMT-IPH-001', 'Apple iPhone 16 Pro 256GB',       '6.3" OLED 48MP, A18 Pro, Titanio Natural',          1199.99, TRUE, 12),
('SMT-IPH-002', 'Apple iPhone 15 128GB',           '6.1" OLED 48MP, A16 Bionic, Negro',                 799.99,  TRUE, 12),
('PER-MON-001', 'LG 27" 4K UHD IPS 27UK850',       'Monitor 4K HDR10, USB-C, FreeSync',                499.99,  TRUE, 7),
('PER-TEC-001', 'Logitech MX Keys S',              'Teclado inalámbrico retroiluminado, multidispositivo',119.99, TRUE, 7),
('PER-RAT-001', 'Logitech MX Master 3S',           'Ratón ergonómico 8000dpi, silent click',             99.99,  TRUE, 7),
('ELE-FRI-001', 'Samsung Frigorífico Side by Side', 'NoFrost 635L, WiFi SmartThings, Inox',              999.99,  TRUE, 13),
('ELE-FRI-002', 'LG Frigorífico Americano GSX961MCCZ','NoFrost 601L, Door Cooling+, Negro Mat',         849.99,  TRUE, 13),
('ELE-LAV-001', 'Bosch Serie 6 WAU28PH0ES',        'Lavadora 9Kg A, 1400rpm, i-DOS, EcoSilence',        649.99,  TRUE, 14),
('AUD-AUR-001', 'Sony WH-1000XM5',                 'Auriculares inalámbricos ANC, 30h batería',          299.99,  TRUE, 4),
('AUD-AUR-002', 'Apple AirPods Pro 2ª gen (USB-C)', 'ANC adaptativo, Transparencia, IP54',              249.99,  TRUE, 4),
('LAP-GAM-003', 'ASUS TUF Gaming F15 FX507',       'Portátil gaming 15.6" i7, RTX 3050, 16GB, 512GB',   799.99,  FALSE, 8); -- producto inactivo (descatalogado)

-- ============================================================
-- 5. HISTÓRICO DE PRECIOS (trazabilidad de cambios de PVP)
-- ============================================================
INSERT INTO historico_precio (producto_id, precio, fecha_inicio, fecha_fin) VALUES
(1, 1599.99, '2024-01-01', '2024-06-30'),  -- ASUS ROG: bajó en julio
(1, 1499.99, '2024-07-01', NULL),           -- precio actual
(7, 1449.99, '2024-01-01', '2024-09-30'),  -- S24 Ultra: bajó en octubre
(7, 1349.99, '2024-10-01', NULL),           -- precio actual
(10,1299.99, '2024-09-20', '2024-11-14'),  -- iPhone 16 Pro: bajó en lanzamiento de oferta
(10,1199.99, '2024-11-15', NULL),           -- precio actual (Black Friday)
(5, 1199.99, '2024-01-01', '2024-03-31'),
(5, 1099.99, '2024-04-01', NULL);

-- ============================================================
-- 6. PROVEEDORES
-- ============================================================
INSERT INTO proveedor (nombre_empresa, nif, email, telefono, pais, empleado_comercial_id) VALUES
('Tech Distribution Iberia S.L.',  'B12345678', 'compras@techdi.es',    '963100200', 'España',  11),
('Global Electronics GmbH',        'DE123456789','info@globalelec.de',  '+493012345', 'Alemania', 11),
('Apple Distribution International','IE6388517V', 'b2b@apple.com',     '+35314065000','Irlanda', 11),
('Samsung Electronics España S.A.','A87654321',  'b2b@samsung.es',     '902100102', 'España',   11),
('Bosch España S.A.',              'A11111111',  'comercial@bosch.es',  '902244448', 'España',   11);

-- ============================================================
-- 7. PROVEEDOR_PRODUCTO (condiciones negociadas + histórico)
-- ============================================================
INSERT INTO proveedor_producto (proveedor_id, producto_id, precio_coste, plazo_entrega_dias, fecha_inicio, fecha_fin) VALUES
-- Tech Distribution suministra portátiles ASUS y Logitech
(1, 1,  1050.00, 7,  '2024-01-01', '2024-06-30'),  -- histórico
(1, 1,   999.00, 5,  '2024-07-01', NULL),            -- vigente (mejor precio negociado)
(1, 2,   699.00, 7,  '2024-01-01', NULL),
(1, 13,   65.00, 3,  '2024-01-01', NULL),
(1, 14,   55.00, 3,  '2024-01-01', NULL),
-- Global Electronics: Sony, LG
(2, 12,  299.00, 10, '2024-01-01', NULL),
(2, 18,  159.00, 7,  '2024-01-01', NULL),
-- Apple Distribution: iPhone y AirPods
(3, 10,  850.00, 14, '2024-01-01', NULL),
(3, 11,  550.00, 14, '2024-01-01', NULL),
(3, 19,  150.00, 14, '2024-01-01', NULL),
-- Samsung: Galaxy y Frigorífico
(4, 7,   850.00, 10, '2024-01-01', NULL),
(4, 8,   550.00, 10, '2024-01-01', NULL),
(4, 15,  650.00, 21, '2024-01-01', NULL),
-- Bosch: Lavadora
(5, 17,  399.00, 14, '2024-01-01', NULL);

-- ============================================================
-- 8. PROMOCIONES
-- ============================================================
INSERT INTO promocion (nombre, descripcion, descuento_porcentual, fecha_inicio, fecha_fin) VALUES
('Black Friday 2024',     'Descuentos especiales Black Friday',            15.00, '2024-11-29', '2024-12-01'),
('Vuelta al Cole 2024',   'Descuentos en portátiles para el curso',        10.00, '2024-08-26', '2024-09-15'),
('Rebajas Enero 2025',    'Rebajas de enero en toda la tienda',            20.00, '2025-01-07', '2025-01-31'),
('Semana Gaming',         'Semana de descuentos en productos gaming',      12.00, '2024-10-14', '2024-10-20'),
('San Valentín Tech',     'Regalos tech para enamorados',                  8.00, '2025-02-10', '2025-02-14');

-- ============================================================
-- 9. PROMOCION_PRODUCTO (qué productos entran en cada promo)
-- ============================================================
INSERT INTO promocion_producto (promocion_id, producto_id) VALUES
-- Black Friday: portátiles, móviles y auriculares
(1, 1),(1, 2),(1, 3),(1, 5),(1, 7),(1, 10),(1, 18),(1, 19),
-- Vuelta al cole: portátiles
(2, 1),(2, 2),(2, 3),(2, 4),(2, 5),(2, 6),
-- Rebajas enero: todo
(3, 1),(3, 2),(3, 7),(3, 10),(3, 12),(3, 15),(3, 17),(3, 18),
-- Semana Gaming: gaming
(4, 1),(4, 2),
-- San Valentín: smartphones y auriculares
(5, 7),(5, 10),(5, 18),(5, 19);

-- ============================================================
-- 10. CLIENTES REGISTRADOS
-- ============================================================
INSERT INTO cliente (nombre, apellidos, email, password_hash, fecha_nacimiento, telefono, fecha_registro) VALUES
('Alejandro', 'García Ruiz',      'alex.garcia@gmail.com',    '$2b$12$hashed1', '1990-03-15', '612345001', '2023-01-10 09:30:00'),
('Beatriz',   'López Martínez',   'bea.lopez@hotmail.com',    '$2b$12$hashed2', '1988-07-22', '623456002', '2023-02-14 11:00:00'),
('Carlos',    'Fernández Torres', 'carlosfernandez@gmail.com','$2b$12$hashed3', '1995-11-30', '634567003', '2023-03-20 16:45:00'),
('Diana',     'Morales Vega',     'diana.morales@yahoo.es',   '$2b$12$hashed4', '1992-05-08', '645678004', '2023-04-05 10:20:00'),
('Eduardo',   'Jiménez Sanz',     'ejsanz@outlook.com',       '$2b$12$hashed5', '1985-12-01', '656789005', '2023-05-15 14:00:00'),
('Fátima',    'Hernández Gil',    'fatima.h@gmail.com',       '$2b$12$hashed6', '1998-09-25', '667890006', '2023-06-01 18:30:00'),
('Gonzalo',   'Romero Cano',      'gonzalorc@gmail.com',      '$2b$12$hashed7', '1987-04-17', '678901007', '2023-07-12 12:00:00'),
('Helena',    'Navarro Cruz',     'helena.navarro@icloud.com','$2b$12$hashed8', '2001-02-28', '689012008', '2024-01-08 09:00:00'),
('Iván',      'Torres Blanco',    'ivan.torres@gmail.com',    '$2b$12$hashed9', '1993-08-14', '690123009', '2024-02-20 20:00:00'),
('Julia',     'Castro Prieto',    'julia.castro@gmail.com',   '$2b$12$hashed0', '1996-06-10', '601234010', '2024-03-05 15:30:00');

-- ============================================================
-- 11. DIRECCIONES
-- ============================================================
INSERT INTO direccion (cliente_id, alias, calle, numero, piso, codigo_postal, ciudad, pais, es_principal) VALUES
(1, 'Casa',     'Calle Ruzafa',         '23', '3ºB', '46002', 'Valencia',   'España', TRUE),
(1, 'Trabajo',  'Avenida del Puerto',   '55', 'S/N', '46021', 'Valencia',   'España', FALSE),
(2, 'Casa',     'Calle Alcalá',         '112','2ºA', '28009', 'Madrid',     'España', TRUE),
(3, 'Casa',     'Passeig Sant Joan',    '67', '5ºC', '08009', 'Barcelona',  'España', TRUE),
(3, 'Padres',   'Carrer de Balmes',     '12', '1ºB', '08007', 'Barcelona',  'España', FALSE),
(4, 'Casa',     'Gran Vía',            '88', '4ºD', '48011', 'Bilbao',     'España', TRUE),
(5, 'Casa',     'Calle Sierpes',        '34', '2ºA', '41004', 'Sevilla',    'España', TRUE),
(6, 'Casa',     'Calle Larios',         '5',  'Bajo','29005', 'Málaga',     'España', TRUE),
(7, 'Casa',     'Plaza Mayor',          '1',  '3ºB', '47001', 'Valladolid', 'España', TRUE),
(8, 'Casa',     'Calle de la Paz',      '20', '1ºA', '46003', 'Valencia',   'España', TRUE),
(9, 'Casa',     'Av. Diagonal',         '233','7ºA', '08013', 'Barcelona',  'España', TRUE),
(10,'Casa',     'Calle Corredera',      '9',  'S/N', '14002', 'Córdoba',    'España', TRUE);

-- ============================================================
-- 12. PEDIDOS ONLINE (variados estados y fechas)
-- ============================================================
INSERT INTO pedido_online (cliente_id, direccion_id, fecha_pedido, estado, total, puntos_canjeados, notas) VALUES
(1,  1, '2024-11-29 10:15:00', 'entregado',       1499.99, 0,    'Black Friday - Entrega urgente'),
(2,  3, '2024-11-30 14:22:00', 'entregado',        999.99, 0,    NULL),
(3,  4, '2024-12-05 09:00:00', 'entregado',       1349.99, 500,  'Canjeo 500 puntos = 5€ descuento'),
(4,  6, '2024-12-20 16:30:00', 'entregado',        849.99, 0,    NULL),
(5,  7, '2025-01-10 11:45:00', 'entregado',       1099.99, 1000, NULL),
(6,  8, '2025-01-15 20:00:00', 'enviado',         1199.99, 0,    NULL),
(7,  9, '2025-02-01 08:30:00', 'en_preparacion',   299.99, 0,    NULL),
(8, 10, '2025-02-14 12:00:00', 'confirmado',       249.99, 0,    'Regalo San Valentín'),
(9, 11, '2025-02-20 19:45:00', 'pendiente',        699.99, 0,    NULL),
(1,  2, '2025-03-01 10:00:00', 'cancelado',        119.99, 0,    'Cliente cambió de opinión'),
(10,12, '2025-03-10 15:20:00', 'entregado',        649.99, 0,    NULL),
(2,  3, '2025-04-05 11:00:00', 'pendiente',       1199.99, 0,    NULL);

-- ============================================================
-- 13. LÍNEAS DE PEDIDO
-- ============================================================
INSERT INTO linea_pedido (pedido_id, producto_id, cantidad, precio_unitario, descuento_aplicado) VALUES
-- Pedido 1 (cliente 1, Black Friday): ASUS ROG
(1,  1, 1, 1499.99, 15.00),
-- Pedido 2 (cliente 2, Black Friday): MSI Katana
(2,  2, 1,  999.99, 15.00),
-- Pedido 3 (cliente 3): Samsung Galaxy S24 Ultra
(3,  7, 1, 1349.99, 0.00),
-- Pedido 4 (cliente 4): Dell Latitude
(4,  3, 1,  849.99, 0.00),
-- Pedido 5 (cliente 5, Enero): LG Gram + teclado
(5,  5, 1, 1099.99, 20.00),
(5, 13, 1,  119.99, 20.00),
-- Pedido 6 (cliente 6): iPhone 16 Pro
(6, 10, 1, 1199.99, 0.00),
-- Pedido 7 (cliente 7): Sony WH-1000XM5
(7, 18, 1,  299.99, 0.00),
-- Pedido 8 (cliente 8): AirPods Pro
(8, 19, 1,  249.99, 8.00),
-- Pedido 9 (cliente 9): Xiaomi 14
(9,  9, 1,  699.99, 0.00),
-- Pedido 10 (cancelado): Logitech MX Keys
(10,13, 1,  119.99, 0.00),
-- Pedido 11 (cliente 10): Lavadora Bosch
(11,17, 1,  649.99, 0.00),
-- Pedido 12 (cliente 2): iPhone 16 Pro
(12,10, 1, 1199.99, 0.00);

-- ============================================================
-- 14. ENVÍOS
-- ============================================================
INSERT INTO envio (pedido_id, sede_origen_id, numero_seguimiento, transportista, fecha_estimada_entrega, fecha_entrega_real, estado) VALUES
-- Pedido 1 completo desde almacén central
(1,  1, 'GLS-2024-001001', 'GLS',    '2024-12-02', '2024-12-01', 'entregado'),
-- Pedido 2 completo desde almacén central
(2,  1, 'GLS-2024-001002', 'GLS',    '2024-12-03', '2024-12-03', 'entregado'),
-- Pedido 3 completo desde almacén central
(3,  1, 'MRW-2024-003001', 'MRW',    '2024-12-08', '2024-12-07', 'entregado'),
-- Pedido 4 completo
(4,  1, 'SEUR-2024-004',   'SEUR',   '2024-12-22', '2024-12-22', 'entregado'),
-- Pedido 5: DIVIDIDO en 2 envíos desde distintos almacenes
(5,  1, 'DHL-2025-005A',   'DHL',    '2025-01-14', '2025-01-13', 'entregado'),  -- portátil desde central
(5,  2, 'DHL-2025-005B',   'DHL',    '2025-01-15', '2025-01-14', 'entregado'),  -- teclado desde Valencia
-- Pedido 6 enviado
(6,  1, 'GLS-2025-006001', 'GLS',    '2025-01-18', NULL,         'en_transito'),
-- Pedidos 7 y 8: en preparación/confirmado (sin envío aún)
-- Pedido 11 entregado
(11, 1, 'NACEX-2025-011',  'NACEX',  '2025-03-14', '2025-03-13', 'entregado');

-- ============================================================
-- 15. VENTAS PRESENCIALES
-- ============================================================
INSERT INTO venta_presencial (sede_id, empleado_id, cliente_id, cliente_anonimo_ref, fecha_venta, total) VALUES
-- Venta con cliente registrado en Valencia
(2, 6, 1,   NULL,         '2024-10-15 11:30:00', 99.99),
-- Venta anónima en Valencia (cliente desconocido)
(2, 6, NULL,'Juan Perez',  '2024-11-02 17:00:00', 249.99),
-- Venta en Madrid con cliente registrado
(3, 8, 3,   NULL,         '2024-11-20 12:15:00', 119.99),
-- Venta en Barcelona anónima
(4, 10,NULL,'María López', '2024-12-03 10:00:00', 999.99),
-- Venta en Valencia con cliente registrado
(2, 6, 5,   NULL,         '2025-01-08 16:45:00', 299.99),
-- Venta en Madrid (el cliente anónimo después se registrará → vinculación futura)
(3, 8, NULL,'Carlos Fdez 634567003', '2025-02-10 09:30:00', 499.99);

-- ============================================================
-- 16. LÍNEAS DE VENTA
-- ============================================================
INSERT INTO linea_venta (venta_id, producto_id, cantidad, precio_unitario) VALUES
(1, 14, 1, 99.99),   -- Ratón MX Master (venta 1)
(2, 19, 1, 249.99),  -- AirPods Pro (venta 2 anónima)
(3, 13, 1, 119.99),  -- Teclado MX Keys (venta 3)
(4, 15, 1, 999.99),  -- Frigorífico Samsung (venta 4 Barcelona)
(5, 18, 1, 299.99),  -- Sony WH-1000XM5 (venta 5)
(6, 12, 1, 499.99);  -- Monitor LG 27" (venta 6)

-- ============================================================
-- 17. DEVOLUCIONES PRESENCIALES
-- ============================================================
INSERT INTO devolucion (venta_id, producto_id, cantidad, motivo, fecha_devolucion, importe_reembolsado) VALUES
-- Cliente 1 devuelve el ratón (venta 1) - venía defectuoso
(1, 14, 1, 'Rueda de scroll defectuosa desde el primer día. Se devuelve en perfecto estado de embalaje.', '2024-10-20 10:00:00', 99.99);

-- ============================================================
-- 18. TICKETS DE INCIDENCIA
-- ============================================================
INSERT INTO ticket_incidencia (cliente_id, empleado_id, pedido_id, asunto, descripcion, fecha_apertura, estado, fecha_cierre, nota_resolucion) VALUES
-- Ticket relacionado con pedido (devolución online)
(3, 4, 3, 'Quiero devolver el Galaxy S24 Ultra',
 'El teléfono llegó con la pantalla rallada. Solicito devolución y reembolso completo.',
 '2024-12-09 09:00:00', 'resuelto', '2024-12-12 16:00:00',
 'Se ha aceptado la devolución. Se ha generado envío de recogida con número GLS-DEV-2024-003. Reembolso procesado en 3-5 días hábiles.'),

-- Ticket consulta general (sin pedido asociado)
(5, 4, NULL, 'Pregunta sobre compatibilidad de producto',
 '¿El teclado Logitech MX Keys S es compatible con Mac y Windows simultáneamente?',
 '2025-01-20 14:30:00', 'resuelto', '2025-01-20 16:00:00',
 'Sí, el MX Keys S es compatible con ambos sistemas y puede conectarse a hasta 3 dispositivos simultáneamente.'),

-- Ticket en gestión
(6, 12, 6, 'Mi pedido lleva 5 días sin actualización de seguimiento',
 'El pedido con el iPhone 16 Pro lleva desde el 17 de enero sin actualización. El número de seguimiento no muestra información.',
 '2025-01-22 11:00:00', 'en_gestion', NULL, NULL),

-- Ticket pendiente
(9, 4, 9, 'No he recibido confirmación de mi pedido',
 'Realicé un pedido del Xiaomi 14 y no me llegó email de confirmación. ¿Está correcto?',
 '2025-02-21 08:30:00', 'abierto', NULL, NULL);

-- ============================================================
-- 19. STOCK (nivel de inventario por sede)
-- ============================================================
INSERT INTO stock (sede_id, producto_id, cantidad) VALUES
-- Almacén Central (sede 1): stock principal
(1, 1,  8), (1, 2, 15), (1, 3, 12), (1, 4,  6), (1, 5,  4),
(1, 6,  3), (1, 7, 20), (1, 8, 10), (1, 9, 18), (1,10,  9),
(1,11, 25), (1,12,  5), (1,13, 30), (1,14, 35), (1,15,  4),
(1,16,  6), (1,17,  8), (1,18, 22), (1,19, 14),
-- Tienda Valencia (sede 2): stock exhibición y venta rápida
(2, 1,  2), (2, 2,  3), (2, 7,  5), (2, 9,  4), (2,10,  2),
(2,11,  6), (2,13,  8), (2,14, 10), (2,18,  4), (2,19,  6),
-- Tienda Madrid (sede 3)
(3, 1,  1), (3, 3,  3), (3, 7,  4), (3,10,  3), (3,11,  5),
(3,13,  6), (3,14,  8), (3,18,  3), (3,19,  4),
-- Tienda Barcelona (sede 4)
(4, 2,  2), (4, 5,  2), (4, 6,  1), (4, 7,  3), (4,10,  2),
(4,12,  1), (4,13,  5), (4,14,  6), (4,18,  2), (4,15,  2);

-- ============================================================
-- 20. TRANSFERENCIAS DE STOCK
-- ============================================================
INSERT INTO transferencia_stock (producto_id, sede_origen_id, sede_destino_id, cantidad, fecha, empleado_id, estado) VALUES
-- Madrid solicita más teclados desde almacén central
(13, 1, 3, 5, '2025-01-05 09:00:00', 2, 'completada'),
-- Barcelona solicita portátil LG Gram desde central
(5,  1, 4, 2, '2025-01-10 11:00:00', 2, 'completada'),
-- Valencia transfiere un Galaxy S24 a Madrid (urgente)
(7,  2, 3, 1, '2025-02-01 14:00:00', 2, 'completada'),
-- Central envía Samsung Galaxy a Barcelona
(7,  1, 4, 2, '2025-02-15 08:30:00', 2, 'en_transito'),
-- Madrid pide AirPods al central
(19, 1, 3, 3, '2025-03-01 10:00:00', 2, 'solicitada');

-- ============================================================
-- 21. VALORACIONES
-- ============================================================
INSERT INTO valoracion (cliente_id, producto_id, puntuacion, comentario, fecha, es_verificada, pedido_id) VALUES
-- Valoración verificada (compra confirmada via pedido)
(1, 1, 5, 'Increíble portátil gaming. El rendimiento es top y la pantalla es una pasada. Muy recomendable para gaming exigente.', '2024-12-05 10:00:00', TRUE, 1),
(2, 2, 4, 'Buena relación calidad-precio para gaming. Se calienta un poco bajo carga pero es normal en esta gama.', '2024-12-10 15:30:00', TRUE, 2),
(3, 7, 2, 'Me llegó con la pantalla rallada. Muy decepcionante para un producto de esta categoría y precio.', '2024-12-12 09:00:00', TRUE, 3),
(4, 3, 5, 'Perfecto para trabajo. Teclado cómodo, batería que dura todo el día. Muy contento.', '2024-12-28 11:00:00', TRUE, 4),
(5, 5, 5, 'Ligero como una pluma y potente. Se nota la diferencia al viajar. 100% recomendado.', '2025-01-20 16:00:00', TRUE, 5),
(5,13, 4, 'Gran teclado, muy cómodo para escribir largas horas. La retroiluminación es perfecta.', '2025-01-20 16:30:00', TRUE, 5),
(10,17, 5, 'La lavadora lleva 2 meses funcionando y es silenciosísima. El i-DOS es una maravilla.', '2025-03-20 12:00:00', TRUE, 11),
-- Valoración histórica sin verificación (de cuando se permitía sin compra previa)
(7, 1, 3, 'No tengo este portátil pero lo vi en tienda y parecía sólido aunque caro.', '2024-05-15 18:00:00', FALSE, NULL);

-- ============================================================
-- 22. MOVIMIENTOS DE PUNTOS (programa de fidelización)
-- 1€ = 10 puntos; 100 puntos = 1€ de descuento
-- ============================================================
INSERT INTO movimiento_puntos (cliente_id, tipo, puntos, pedido_id, fecha, descripcion) VALUES
-- Cliente 1: ganó 15000 puntos (1500€ pedido) y los tiene intactos
(1, 'ganado',  14999, 1, '2024-11-29 10:15:00', 'Puntos por pedido #1 - ASUS ROG Strix'),
-- Cliente 2: ganó 9999 puntos
(2, 'ganado',   9999, 2, '2024-11-30 14:22:00', 'Puntos por pedido #2 - MSI Katana'),
-- Cliente 3: ganó puntos y luego canjeó 500
(3, 'ganado',  13499, 3, '2024-12-05 09:00:00', 'Puntos por pedido #3 - Samsung Galaxy S24'),
(3, 'canjeado',  500, 3, '2024-12-05 09:00:00', 'Canjeo en pedido #3 - 500 pts = 5€ dto'),
-- Cliente 4
(4, 'ganado',   8499, 4, '2024-12-20 16:30:00', 'Puntos por pedido #4 - Dell Latitude'),
-- Cliente 5: ganó y canjeó 1000
(5, 'ganado',  12199, 5, '2025-01-10 11:45:00', 'Puntos por pedido #5 - LG Gram + Teclado'),
(5, 'canjeado', 1000, 5, '2025-01-10 11:45:00', 'Canjeo en pedido #5 - 1000 pts = 10€ dto'),
-- Cliente 6
(6, 'ganado',  11999, 6, '2025-01-15 20:00:00', 'Puntos por pedido #6 - iPhone 16 Pro'),
-- Cliente 10
(10,'ganado',   6499,11, '2025-03-10 15:20:00', 'Puntos por pedido #11 - Lavadora Bosch'),
-- Cliente 1 acumula más puntos con un pedido anterior presencial
(1, 'ganado',    999, NULL, '2024-10-15 11:30:00', 'Puntos por venta presencial #1 - MX Master 3S');
