-- Inserción de datos simulados para la base de datos 'mercado_libre'
USE mercado_libre;

-- Paso 1:
INSERT INTO usuarios (email, nombres, telefono, contrasena, tipo_usuario)
VALUES
('usuario1@example.com', 'Ana García', '912345671', 'pass_ana123', 'comprador'),
('usuario2@example.com', 'Luis Torres', '912345672', 'pass_luis123', 'vendedor'),
('usuario3@example.com', 'Marta Soto', '912345673', 'pass_marta123', 'ambos'),
('usuario4@example.com', 'Pedro Castro', '912345674', 'pass_pedro123', 'comprador'),
('usuario5@example.com', 'Sofía Vargas', '912345675', 'pass_sofia123', 'vendedor'),
('usuario6@example.com', 'Diego Morales', '912345676', 'pass_diego123', 'comprador'),
('usuario7@example.com', 'Laura Fernández', '912345677', 'pass_laura123', 'vendedor'),
('usuario8@example.com', 'Javier Ramos', '912345678', 'pass_javier123', 'ambos'),
('usuario9@example.com', 'Elena Jiménez', '912345679', 'pass_elena123', 'comprador'),
('usuario10@example.com', 'Ricardo Ruiz', '912345680', 'pass_ricardo123', 'vendedor'),
('usuario11@example.com', 'Gabriela Díaz', '912345681', 'pass_gabriela123', 'comprador'),
('usuario12@example.com', 'Andrés Herrera', '912345682', 'pass_andres123', 'vendedor'),
('usuario13@example.com', 'Isabel Núñez', '912345683', 'pass_isabel123', 'ambos'),
('usuario14@example.com', 'Daniel Salazar', '912345684', 'pass_daniel123', 'comprador'),
('usuario15@example.com', 'Valeria Rojas', '912345685', 'pass_valeria123', 'vendedor'),
('usuario16@example.com', 'Sergio Pizarro', '912345686', 'pass_sergio123', 'comprador'),
('usuario17@example.com', 'Mariana Bustamante', '912345687', 'pass_mariana123', 'vendedor'),
('usuario18@example.com', 'Felipe Ortiz', '912345688', 'pass_felipe123', 'ambos'),
('usuario19@example.com', 'Natalia Castillo', '912345689', 'pass_natalia123', 'comprador'),
('usuario20@example.com', 'Roberto Mendoza', '912345690', 'pass_roberto123', 'vendedor'),
('usuario21@example.com', 'Carolina Cárdenas', '912345691', 'pass_carolina123', 'comprador'),
('usuario22@example.com', 'Jorge Salas', '912345692', 'pass_jorge123', 'vendedor'),
('usuario23@example.com', 'Patricia Vega', '912345693', 'pass_patricia123', 'ambos'),
('usuario24@example.com', 'Gustavo Reyes', '912345694', 'pass_gustavo123', 'comprador'),
('usuario25@example.com', 'Paola Espinoza', '912345695', 'pass_paola123', 'vendedor'),
('usuario26@example.com', 'Martín Quispe', '912345696', 'pass_martin123', 'comprador'),
('usuario27@example.com', 'Alejandra Córdova', '912345697', 'pass_alejandra123', 'vendedor'),
('usuario28@example.com', 'Fernando Benítez', '912345698', 'pass_fernando123', 'ambos'),
('usuario29@example.com', 'Andrea Torres', '912345699', 'pass_andrea123', 'comprador'),
('usuario30@example.com', 'Benjamín Gómez', '912345700', 'pass_benjamin123', 'vendedor');


-- Paso 2:
INSERT INTO vendedores (id_usuario)
VALUES
(2),  -- Luis Torres (vendedor)
(3),  -- Marta Soto (ambos)
(5),  -- Sofía Vargas (vendedor)
(7),  -- Laura Fernández (vendedor)
(8),  -- Javier Ramos (ambos)
(10), -- Ricardo Ruiz (vendedor)
(12), -- Andrés Herrera (vendedor)
(13), -- Isabel Núñez (ambos)
(15), -- Valeria Rojas (vendedor)
(17), -- Mariana Bustamante (vendedor)
(18), -- Felipe Ortiz (ambos)
(20), -- Roberto Mendoza (vendedor)
(22), -- Jorge Salas (vendedor)
(23), -- Patricia Vega (ambos)
(25), -- Paola Espinoza (vendedor)
(27), -- Alejandra Córdova (vendedor)
(28), -- Fernando Benítez (ambos)
(30); -- Benjamín Gómez (vendedor)


-- Paso 3:
INSERT INTO categorias (nombre)
VALUES
('Tecnología'),
('Electrodomésticos'),
('Hogar y Muebles'),
('Deportes y Fitness'),
('Mascotas'),
('Belleza y Cuidado personal'),
('Herramientas'),
('Construcción'),
('Industrias y Oficinas'),
('Juegos y Juguetes'),
('Bebés'),
('Accesorios para Vehículos'),
('Moda'),
('Salud y Equipamiento Médico'),
('Vehículos'),
('Inmuebles');


-- Paso 4:

-- Productos para 'Tecnología' (id_categoria = 1)
INSERT INTO productos (id_vendedor, id_categoria, nombre, descripcion, precio, cantidad)
VALUES
(1, 1, 'Smartphone Ultra X', 'El último modelo con cámara de 108MP y procesador de última generación.', 999.99, 50),
(2, 1, 'Laptop Gaming Pro', 'Potente laptop para juegos y diseño gráfico, con RTX 4080.', 1899.00, 25),
(3, 1, 'Auriculares Inalámbricos HD', 'Sonido de alta fidelidad con cancelación de ruido activa.', 149.50, 150),
(1, 1, 'Smartwatch Deportivo', 'Monitorea tu actividad física y salud 24/7.', 219.99, 80),
(2, 1, 'Tablet Pro M1', 'Pantalla Retina de 12.9 pulgadas y chip M1 para máxima potencia.', 789.00, 40);

-- Productos para 'Electrodomésticos' (id_categoria = 2)
INSERT INTO productos (id_vendedor, id_categoria, nombre, descripcion, precio, cantidad)
VALUES
(4, 2, 'Refrigerador Inverter Smart', 'Consumo eficiente y control inteligente vía app.', 1200.00, 30),
(5, 2, 'Lavadora Carga Frontal 12kg', 'Tecnología de vapor para una limpieza profunda.', 650.00, 45),
(6, 2, 'Horno Microondas Digital 30L', 'Con funciones preestablecidas y cocción rápida.', 120.00, 100),
(4, 2, 'Aspiradora Robot Inteligente', 'Limpieza automática con mapeo de habitaciones.', 350.00, 60),
(5, 2, 'Cafetera Expreso Automática', 'Prepara tu café favorito con solo un botón.', 280.00, 70);

-- Productos para 'Hogar y Muebles' (id_categoria = 3)
INSERT INTO productos (id_vendedor, id_categoria, nombre, descripcion, precio, cantidad)
VALUES
(7, 3, 'Sofá Seccional Moderno', 'Cómodo sofá en forma de L, ideal para sala de estar.', 850.00, 15),
(8, 3, 'Mesa de Comedor de Madera Maciza', 'Diseño rústico y duradero para 6 personas.', 520.00, 20),
(7, 3, 'Juego de Sábanas de Algodón Egipcio', 'Suavidad y confort para un descanso placentero.', 75.00, 200),
(8, 3, 'Lámpara de Pie LED Regulable', 'Iluminación ambiental con control táctil.', 95.00, 90),
(9, 3, 'Set de Utensilios de Cocina 10 Pz', 'Acero inoxidable de alta calidad, resistente al calor.', 60.00, 120);

-- Productos para 'Deportes y Fitness' (id_categoria = 4)
INSERT INTO productos (id_vendedor, id_categoria, nombre, descripcion, precio, cantidad)
VALUES
(10, 4, 'Bicicleta de Montaña Aro 29', 'Ideal para trail y caminos difíciles, suspensión delantera.', 450.00, 30),
(11, 4, 'Set de Mancuernas Ajustables', 'Pesas de 2.5kg a 24kg, para entrenamiento de fuerza.', 200.00, 50),
(10, 4, 'Cinta de Correr Plegable', 'Pantalla LCD, varios programas de entrenamiento, fácil de guardar.', 580.00, 20),
(11, 4, 'Esterilla de Yoga Antideslizante', 'Material ecológico, ideal para yoga, pilates y estiramientos.', 25.00, 300),
(12, 4, 'Monitor de Ritmo Cardíaco GPS', 'Seguimiento preciso de tu rendimiento en tiempo real.', 110.00, 100);

-- Productos para 'Mascotas' (id_categoria = 5)
INSERT INTO productos (id_vendedor, id_categoria, nombre, descripcion, precio, cantidad)
VALUES
(13, 5, 'Alimento Premium para Perro Adulto', 'Nutrición balanceada con ingredientes naturales, 15kg.', 60.00, 250),
(14, 5, 'Rascador para Gatos de Múltiples Niveles', 'Con juguetes colgantes y postes de sisal.', 85.00, 70),
(13, 5, 'Cama Ortopédica para Mascotas Grandes', 'Soporte cómodo para articulaciones, lavable.', 70.00, 80),
(14, 5, 'Juguetes Interactivos para Gatos', 'Set de 5 juguetes variados para estimular el juego.', 15.00, 400),
(15, 5, 'Correa Retráctil para Perros Grandes', 'Seguridad y libertad de movimiento, hasta 50kg.', 30.00, 150);

-- Productos para 'Belleza y Cuidado personal' (id_categoria = 6)
INSERT INTO productos (id_vendedor, id_categoria, nombre, descripcion, precio, cantidad)
VALUES
(16, 6, 'Set de Maquillaje Profesional', 'Paleta de sombras, brochas y labiales de alta calidad.', 90.00, 110),
(17, 6, 'Crema Hidratante Facial con Ácido Hialurónico', 'Antiedad, para todo tipo de piel, 50ml.', 45.00, 220),
(16, 6, 'Secador de Pelo Iónico Potente', 'Secado rápido y sin frizz, varias velocidades.', 70.00, 95),
(17, 6, 'Perfume Eau de Parfum para Mujer 100ml', 'Fragancia floral y duradera.', 120.00, 85),
(18, 6, 'Kit de Afeitado Clásico para Hombre', 'Brocha, jabón y navaja de seguridad.', 55.00, 130);

-- Productos para 'Herramientas' (id_categoria = 7)
INSERT INTO productos (id_vendedor, id_categoria, nombre, descripcion, precio, cantidad)
VALUES
(1, 7, 'Taladro Percutor Inalámbrico', 'Batería de litio, mandril de 13mm, estuche incluido.', 150.00, 60),
(2, 7, 'Set de Herramientas Completo 120 Pz', 'Para uso doméstico y profesional, maletín resistente.', 80.00, 100),
(3, 7, 'Sierra Circular Eléctrica 7-1/4"', 'Cortes precisos en madera y plástico, 1500W.', 110.00, 40),
(1, 7, 'Llave Inglesa Ajustable de Acero', '12 pulgadas, alta resistencia y durabilidad.', 20.00, 300),
(2, 7, 'Nivel Láser Autonivelante', 'Precisión para trabajos de construcción y diseño.', 75.00, 75);

-- Productos para 'Construcción' (id_categoria = 8)
INSERT INTO productos (id_vendedor, id_categoria, nombre, descripcion, precio, cantidad)
VALUES
(4, 8, 'Caja de Herramientas Grande con Ruedas', 'Organizador de herramientas con gran capacidad.', 90.00, 50),
(5, 8, 'Martillo de Uña Forjado', 'Mango ergonómico y cabeza balanceada.', 18.00, 200),
(6, 8, 'Set de Brocas para Concreto y Metal', 'Variedad de tamaños, para taladro percutor.', 35.00, 150),
(4, 8, 'Guantes de Trabajo Reforzados', 'Protección contra cortes y abrasiones, talla L.', 10.00, 500),
(5, 8, 'Flexómetro Retráctil 5 Metros', 'Medición precisa con cinta de acero.', 12.00, 400);

-- Productos para 'Industrias y Oficinas' (id_categoria = 9)
INSERT INTO productos (id_vendedor, id_categoria, nombre, descripcion, precio, cantidad)
VALUES
(7, 9, 'Impresora Multifuncional Láser', 'Imprime, escanea y copia, alta velocidad.', 280.00, 35),
(8, 9, 'Silla Ergonómica de Oficina', 'Soporte lumbar, ajustable en altura y reposabrazos.', 180.00, 55),
(7, 9, 'Destructora de Papel de Alta Seguridad', 'Corte en micro-partículas, para documentos confidenciales.', 95.00, 40),
(8, 9, 'Proyector Full HD para Presentaciones', 'Alta luminosidad y contraste, ideal para salas de reuniones.', 450.00, 25),
(9, 9, 'Pack de Papel Bond A4 500 Hojas', 'Papel de alta blancura para impresiones de calidad.', 8.00, 800);

-- Productos para 'Juegos y Juguetes' (id_categoria = 10)
INSERT INTO productos (id_vendedor, id_categoria, nombre, descripcion, precio, cantidad)
VALUES
(10, 10, 'Consola de Videojuegos Next-Gen', '4K, 120fps, con 2 mandos y 3 juegos.', 550.00, 30),
(11, 10, 'Set de Bloques de Construcción Gigantes', 'Creatividad sin límites para niños y adultos.', 70.00, 120),
(10, 10, 'Muñeca Interactiva con Sonidos', 'Dice frases y reacciona al tacto.', 40.00, 150),
(12, 10, 'Dron con Cámara HD para Niños', 'Fácil de volar, ideal para principiantes.', 65.00, 90),
(10, 10, 'Juego de Mesa Estratégico', 'Para 2-4 jugadores, diversión garantizada.', 30.00, 180);

-- Productos para 'Bebés' (id_categoria = 11)
INSERT INTO productos (id_vendedor, id_categoria, nombre, descripcion, precio, cantidad)
VALUES
(13, 11, 'Cochecito de Bebé Convertible 3 en 1', 'Desde recién nacido hasta niño pequeño, sistema de viaje.', 380.00, 25),
(14, 11, 'Silla de Auto para Bebé con ISOFIX', 'Máxima seguridad y confort, grupos 0+/1/2/3.', 220.00, 40),
(13, 11, 'Pañales Desechables Talla M (100 Unidades)', 'Absorción máxima, hipoalergénicos.', 30.00, 300),
(15, 11, 'Monitor de Bebé con Cámara y Audio', 'Visión nocturna, sensor de temperatura, comunicación bidireccional.', 90.00, 70),
(13, 11, 'Extractor de Leche Eléctrico Doble', 'Portátil y eficiente, con varios niveles de succión.', 110.00, 50);

-- Productos para 'Accesorios para Vehículos' (id_categoria = 12)
INSERT INTO productos (id_vendedor, id_categoria, nombre, descripcion, precio, cantidad)
VALUES
(16, 12, 'Radio de Coche con Pantalla Táctil', 'Compatible con Apple CarPlay y Android Auto.', 180.00, 60),
(17, 12, 'Cargador de Batería de Coche Inteligente', 'Mantenimiento y carga lenta, para 12V.', 45.00, 150),
(16, 12, 'Funda de Asiento Universal para Coche', 'Protección y estilo, material transpirable.', 70.00, 100),
(18, 12, 'Kit de Herramientas de Emergencia para Coche', 'Incluye cables de batería, chaleco reflectante, etc.', 35.00, 200),
(16, 12, 'Sistema de Cámara de Reversa con Monitor', 'Visión nocturna, gran angular, fácil instalación.', 80.00, 90);

-- Productos para 'Moda' (id_categoria = 13)
INSERT INTO productos (id_vendedor, id_categoria, nombre, descripcion, precio, cantidad)
VALUES
(1, 13, 'Jeans Slim Fit para Hombre', 'Denim elástico, corte moderno, varios colores.', 55.00, 250),
(2, 13, 'Vestido de Noche Elegante para Mujer', 'Diseño de corte sirena, encaje y pedrería.', 130.00, 80),
(3, 13, 'Zapatillas Deportivas Urbanas Unisex', 'Comodidad y estilo para el día a día.', 80.00, 300),
(1, 13, 'Reloj de Pulsera Clásico de Acero Inoxidable', 'Movimiento de cuarzo, resistente al agua.', 95.00, 120),
(2, 13, 'Bolso de Cuero Genuino para Mujer', 'Estilo tote, gran capacidad, múltiples compartimentos.', 110.00, 70);

-- Productos para 'Salud y Equipamiento Médico' (id_categoria = 14)
INSERT INTO productos (id_vendedor, id_categoria, nombre, descripcion, precio, cantidad)
VALUES
(4, 14, 'Tensiómetro Digital de Brazo', 'Medición precisa de la presión arterial, fácil de usar.', 60.00, 100),
(5, 14, 'Oxímetro de Pulso de Dedo', 'Monitorea la saturación de oxígeno y el pulso.', 30.00, 200),
(6, 14, 'Termómetro Infrarrojo Sin Contacto', 'Lectura rápida y precisa de la temperatura corporal.', 25.00, 250),
(4, 14, 'Mascarillas Quirúrgicas Desechables (50 Unidades)', 'Protección de 3 capas, cómoda y transpirable.', 15.00, 500),
(5, 14, 'Kit de Primeros Auxilios Completo', 'Esencial para el hogar, coche o viajes.', 40.00, 180);

-- Productos para 'Vehículos' (id_categoria = 15)
INSERT INTO productos (id_vendedor, id_categoria, nombre, descripcion, precio, cantidad)
VALUES
(7, 15, 'Motocicleta Deportiva 250cc', 'Alta velocidad, diseño aerodinámico, ideal para carretera.', 4500.00, 10),
(8, 15, 'Scooter Eléctrico Plegable', 'Movilidad urbana, autonomía de 30km, velocidad 25km/h.', 380.00, 25),
(9, 15, 'Neumático de Coche All-Season', 'Alto rendimiento en cualquier clima, R16 205/55.', 90.00, 100),
(7, 15, 'Casco de Moto Integral Homologado', 'Protección total, ventilación optimizada.', 160.00, 40),
(8, 15, 'Batería de Auto 12V 60Ah', 'Para todo tipo de vehículos, libre de mantenimiento.', 75.00, 80);

-- Productos para 'Inmuebles' (id_categoria = 16)
INSERT INTO productos (id_vendedor, id_categoria, nombre, descripcion, precio, cantidad)
VALUES
(10, 16, 'Apartamento de Lujo en Zona Residencial', '3 dormitorios, 2 baños, piscina, gimnasio.', 250000.00, 1),
(11, 16, 'Casa Familiar con Jardín Grande', '4 habitaciones, 3 baños, ideal para familias, 500m² terreno.', 320000.00, 1),
(12, 16, 'Local Comercial en Centro Urbano', 'Gran visibilidad, 120m², ideal para negocio.', 180000.00, 1),
(10, 16, 'Terreno Rústico con Vista al Mar', 'Perfecto para inversión o construcción de casa de campo.', 75000.00, 1),
(11, 16, 'Oficina Moderna en Edificio Corporativo', 'Espacios flexibles, seguridad 24h, acceso a transporte público.', 120000.00, 1);

-- Paso 5.
-- Ventas para 'Tecnología' (Productos 1-5, Vendedores 1,2,3)
INSERT INTO ventas (id_usuario, id_producto, cantidad, total)
VALUES
(1, 1, 1, 999.99), -- Juan Perez compra Smartphone Ultra X
(4, 2, 1, 1899.00), -- Pedro Castro compra Laptop Gaming Pro
(9, 3, 2, 299.00), -- Elena Jiménez compra 2 Auriculares Inalámbricos HD
(1, 4, 1, 219.99), -- Juan Perez compra Smartwatch Deportivo
(6, 5, 1, 789.00); -- Diego Morales compra Tablet Pro M1

-- Ventas para 'Electrodomésticos' (Productos 6-10, Vendedores 4,5,6)
INSERT INTO ventas (id_usuario, id_producto, cantidad, total)
VALUES
(11, 6, 1, 1200.00), -- Gabriela Díaz compra Refrigerador Inverter Smart
(14, 7, 1, 650.00),  -- Daniel Salazar compra Lavadora
(19, 8, 1, 120.00), -- Natalia Castillo compra Horno Microondas
(1, 9, 1, 350.00),  -- Juan Perez compra Aspiradora Robot
(4, 10, 1, 280.00);  -- Pedro Castro compra Cafetera Expreso

-- Ventas para 'Hogar y Muebles' (Productos 11-15, Vendedores 7,8,9)
INSERT INTO ventas (id_usuario, id_producto, cantidad, total)
VALUES
(9, 11, 1, 850.00), -- Elena Jiménez compra Sofá Seccional
(11, 12, 1, 520.00), -- Gabriela Díaz compra Mesa de Comedor
(14, 13, 1, 75.00), -- Daniel Salazar compra Sábanas de Algodón
(19, 14, 1, 95.00), -- Natalia Castillo compra Lámpara de Pie
(21, 15, 1, 60.00);  -- Carolina Cárdenas compra Set de Utensilios

-- Ventas para 'Deportes y Fitness' (Productos 16-20, Vendedores 10,11,12)
INSERT INTO ventas (id_usuario, id_producto, cantidad, total)
VALUES
(24, 16, 1, 450.00), -- Gustavo Reyes compra Bicicleta de Montaña
(26, 17, 1, 200.00), -- Martín Quispe compra Mancuernas Ajustables
(29, 18, 1, 580.00), -- Andrea Torres compra Cinta de Correr
(1, 19, 2, 50.00),  -- Juan Perez compra 2 Esterillas de Yoga
(4, 20, 1, 110.00);  -- Pedro Castro compra Monitor de Ritmo Cardíaco

-- Ventas para 'Mascotas' (Productos 21-25, Vendedores 13,14,15)
INSERT INTO ventas (id_usuario, id_producto, cantidad, total)
VALUES
(6, 21, 1, 60.00),  -- Diego Morales compra Alimento para Perro
(9, 22, 1, 85.00),   -- Elena Jiménez compra Rascador para Gatos
(11, 23, 1, 70.00), -- Gabriela Díaz compra Cama Ortopédica
(14, 24, 1, 15.00), -- Daniel Salazar compra Juguetes Interactivos
(19, 25, 1, 30.00);  -- Natalia Castillo compra Correa Retráctil

-- Ventas para 'Belleza y Cuidado personal' (Productos 26-30, Vendedores 16,17,18)
INSERT INTO ventas (id_usuario, id_producto, cantidad, total)
VALUES
(21, 26, 1, 90.00), -- Carolina Cárdenas compra Set de Maquillaje
(24, 27, 1, 45.00),  -- Gustavo Reyes compra Crema Hidratante
(26, 28, 1, 70.00), -- Martín Quispe compra Secador de Pelo
(29, 29, 1, 120.00), -- Andrea Torres compra Perfume
(1, 30, 1, 55.00);   -- Juan Perez compra Kit de Afeitado

-- Paso 6:
-- Pagos para las ventas completadas (ejemplos)
-- (id_venta, monto, metodo_pago, estado)

-- Ventas de Tecnología (Productos 1-5)
INSERT INTO pagos (id_venta, monto, metodo_pago, estado)
VALUES
(1, 999.99, 'credito', 'completado'),    -- Pago para Venta ID 1 (Smartphone Ultra X)
(3, 299.00, 'debito', 'completado'),     -- Pago para Venta ID 3 (Auriculares Inalámbricos HD)
(4, 219.99, 'transferencia', 'completado'); -- Pago para Venta ID 4 (Smartwatch Deportivo)

-- Ventas de Electrodomésticos (Productos 6-10)
INSERT INTO pagos (id_venta, monto, metodo_pago, estado)
VALUES
(6, 1200.00, 'credito', 'completado'),   -- Pago para Venta ID 6 (Refrigerador Inverter Smart)
(8, 120.00, 'debito', 'completado');      -- Pago para Venta ID 8 (Horno Microondas Digital 30L)

-- Ventas de Hogar y Muebles (Productos 11-15)
INSERT INTO pagos (id_venta, monto, metodo_pago, estado)
VALUES
(11, 850.00, 'credito', 'completado'),   -- Pago para Venta ID 11 (Sofá Seccional Moderno)
(13, 75.00, 'debito', 'completado'),     -- Pago para Venta ID 13 (Juego de Sábanas de Algodón Egipcio)
(14, 95.00, 'transferencia', 'completado'); -- Pago para Venta ID 14 (Lámpara de Pie LED Regulable)

-- Ventas de Deportes y Fitness (Productos 16-20)
INSERT INTO pagos (id_venta, monto, metodo_pago, estado)
VALUES
(16, 450.00, 'credito', 'completado'),   -- Pago para Venta ID 16 (Bicicleta de Montaña Aro 29)
(18, 580.00, 'debito', 'completado'),    -- Pago para Venta ID 18 (Cinta de Correr Plegable)
(19, 50.00, 'transferencia', 'completado'); -- Pago para Venta ID 19 (Esterilla de Yoga Antideslizante)

-- Ventas de Mascotas (Productos 21-25)
INSERT INTO pagos (id_venta, monto, metodo_pago, estado)
VALUES
(21, 60.00, 'credito', 'completado'),   -- Pago para Venta ID 21 (Alimento Premium para Perro Adulto)
(23, 70.00, 'debito', 'completado'),    -- Pago para Venta ID 23 (Cama Ortopédica para Mascotas Grandes)
(24, 15.00, 'transferencia', 'completado'); -- Pago para Venta ID 24 (Juguetes Interactivos para Gatos)

-- Ventas de Belleza y Cuidado personal (Productos 26-30)
INSERT INTO pagos (id_venta, monto, metodo_pago, estado)
VALUES
(26, 90.00, 'credito', 'completado'),   -- Pago para Venta ID 26 (Set de Maquillaje Profesional)
(28, 70.00, 'debito', 'completado'),    -- Pago para Venta ID 28 (Secador de Pelo Iónico Potente)
(29, 120.00, 'transferencia', 'completado'); -- Pago para Venta ID 29 (Perfume Eau de Parfum para Mujer 100ml)

-- Algunos pagos adicionales para ventas que quedaron como 'pendiente' para simular su procesamiento
-- Nota: Si la venta ya está "completada" en la tabla ventas, insertar un pago "completado" aquí no la cambiará.
-- Si la venta está "pendiente", este pago la cambiará a "completada" gracias al trigger.
INSERT INTO pagos (id_venta, monto, metodo_pago, estado)
VALUES
(2, 1899.00, 'credito', 'completado'), -- Pago para Venta ID 2 (Laptop Gaming Pro)
(5, 789.00, 'debito', 'completado'),   -- Pago para Venta ID 5 (Tablet Pro M1)
(7, 650.00, 'transferencia', 'completado'), -- Pago para Venta ID 7 (Lavadora Carga Frontal 12kg)
(10, 280.00, 'credito', 'completado'),  -- Pago para Venta ID 10 (Cafetera Expreso Automática)
(12, 520.00, 'debito', 'completado');   -- Pago para Venta ID 12 (Mesa de Comedor de Madera Maciza)

-- Paso 7:
-- Inserción de 30 datos de ejemplo en la tabla envios
-- id_envio (AUTO_INCREMENT), id_venta, direccion_envio, estado (DEFAULT 'pendiente'), fecha_envio (DEFAULT CURRENT_TIMESTAMP)

-- Envíos para las primeras ventas
INSERT INTO envios (id_venta, direccion_envio)
VALUES
(1, 'Av. Las Palmeras 123, Lima'),         -- Venta ID 1 (Smartphone Ultra X)
(2, 'Calle Los Rosales 45, Cusco'),        -- Venta ID 2 (Laptop Gaming Pro)
(3, 'Jirón La Unión 789, Arequipa'),       -- Venta ID 3 (Auriculares Inalámbricos HD)
(4, 'Jr. Bolívar 101, Trujillo'),          -- Venta ID 4 (Smartwatch Deportivo)
(5, 'Av. Salaverry 202, Piura');           -- Venta ID 5 (Tablet Pro M1)

-- Más envíos para las ventas siguientes
INSERT INTO envios (id_venta, direccion_envio)
VALUES
(6, 'Calle Independencia 303, Chiclayo'),  -- Venta ID 6 (Refrigerador Inverter Smart)
(7, 'Av. La Paz 404, Iquitos'),            -- Venta ID 7 (Lavadora Carga Frontal 12kg)
(8, 'Psje. San Martín 505, Huancayo'),     -- Venta ID 8 (Horno Microondas Digital 30L)
(9, 'Urb. Santa Rosa 606, Tacna'),         -- Venta ID 9 (Aspiradora Robot Inteligente)
(10, 'Jr. Arequipa 707, Puno');            -- Venta ID 10 (Cafetera Expreso Automática)

-- Continuamos con más envíos
INSERT INTO envios (id_venta, direccion_envio)
VALUES
(11, 'Av. Pardo 808, Huaraz'),             -- Venta ID 11 (Sofá Seccional Moderno)
(12, 'Calle Real 909, Ayacucho'),          -- Venta ID 12 (Mesa de Comedor de Madera Maciza)
(13, 'Jr. Garcilaso 111, Tarapoto'),       -- Venta ID 13 (Juego de Sábanas de Algodón Egipcio)
(14, 'Av. El Sol 222, Nazca'),             -- Venta ID 14 (Lámpara de Pie LED Regulable)
(15, 'Calle Grau 333, Moquegua');          -- Venta ID 15 (Set de Utensilios de Cocina 10 Pz)

-- Y más envíos para cubrir las 30 ventas anteriores
INSERT INTO envios (id_venta, direccion_envio)
VALUES
(16, 'Urb. Primavera 444, Cajamarca'),     -- Venta ID 16 (Bicicleta de Montaña Aro 29)
(17, 'Av. Brasil 555, Chimbote'),          -- Venta ID 17 (Set de Mancuernas Ajustables)
(18, 'Calle Colón 666, Abancay'),          -- Venta ID 18 (Cinta de Correr Plegable)
(19, 'Jr. Puno 777, Puerto Maldonado'),    -- Venta ID 19 (Esterilla de Yoga Antideslizante)
(20, 'Av. Los Incas 888, Tumbes');         -- Venta ID 20 (Monitor de Ritmo Cardíaco GPS)

INSERT INTO envios (id_venta, direccion_envio)
VALUES
(21, 'Jr. Huascarán 999, Cerro de Pasco'), -- Venta ID 21 (Alimento Premium para Perro Adulto)
(22, 'Calle Dos de Mayo 110, Huánuco'),    -- Venta ID 22 (Rascador para Gatos de Múltiples Niveles)
(23, 'Av. San Juan 221, Ica'),             -- Venta ID 23 (Cama Ortopédica para Mascotas Grandes)
(24, 'Urb. La Molina 332, La Merced'),     -- Venta ID 24 (Juguetes Interactivos para Gatos)
(25, 'Jr. Tupac Amaru 443, Chachapoyas');  -- Venta ID 25 (Correa Retráctil para Perros Grandes)

INSERT INTO envios (id_venta, direccion_envio)
VALUES
(26, 'Av. Arica 554, Pisco'),              -- Venta ID 26 (Set de Maquillaje Profesional)
(27, 'Calle El Sol 665, Barranca'),        -- Venta ID 27 (Crema Hidratante Facial con Ácido Hialurónico)
(28, 'Jr. Manco Capac 776, Tarma'),        -- Venta ID 28 (Secador de Pelo Iónico Potente)
(29, 'Av. Panamericana 887, Mollendo'),    -- Venta ID 29 (Perfume Eau de Parfum para Mujer 100ml)
(30, 'Calle Libertad 998, Jaén');          -- Venta ID 30 (Kit de Afeitado Clásico para Hombre)


-- Paso 8:
-- Inserción de 30 datos de ejemplo en la tabla resenas_calificaciones
-- (id_venta, calificacion, comentario)

INSERT INTO resenas_calificaciones (id_venta, calificacion, comentario)
VALUES
(1, 5, 'Excelente smartphone, muy rápido y con una cámara impresionante.'), -- Reseña para Venta ID 1
(2, 4, 'La laptop es potente, pero el teclado se calienta un poco con uso intenso.'),   -- Reseña para Venta ID 2
(3, 5, 'Auriculares de gran calidad de sonido, cómodos y la cancelación de ruido es efectiva.'), -- Reseña para Venta ID 3
(4, 4, 'El smartwatch funciona bien, pero la batería podría durar un poco más.'),     -- Reseña para Venta ID 4
(5, 5, 'Tablet muy fluida y con una pantalla vibrante, ideal para trabajar y ver contenido.'),     -- Reseña para Venta ID 5

(6, 5, 'El refrigerador es espacioso y muy eficiente energéticamente. Me encanta el control inteligente.'), -- Reseña para Venta ID 6
(7, 3, 'La lavadora es buena, pero hace un poco de ruido durante el centrifugado.'),     -- Reseña para Venta ID 7
(8, 4, 'Horno microondas práctico y fácil de usar, calienta muy rápido.'),   -- Reseña para Venta ID 8
(9, 5, 'Esta aspiradora robot me ha cambiado la vida, limpia muy bien y es silenciosa.'),   -- Reseña para Venta ID 9
(10, 4, 'Cafetera rápida y con un buen diseño. El café sale delicioso.'),    -- Reseña para Venta ID 10

(11, 5, 'Sofá muy cómodo y con un diseño moderno, se ve genial en mi sala.'), -- Reseña para Venta ID 11
(12, 4, 'Mesa de comedor sólida y elegante, fácil de armar.'),     -- Reseña para Venta ID 12
(13, 5, 'Las sábanas son súper suaves y frescas, duermo como un bebé.'), -- Reseña para Venta ID 13
(14, 4, 'Lámpara de pie con buena iluminación y las opciones de regulación son útiles.'),     -- Reseña para Venta ID 14
(15, 5, 'Set de utensilios de cocina de excelente calidad, no se pegan y son fáciles de limpiar.'), -- Reseña para Venta ID 15

(16, 5, 'La bicicleta es robusta y muy divertida para paseos por la montaña.'), -- Reseña para Venta ID 16
(17, 4, 'Las mancuernas son muy versátiles, aunque un poco grandes para guardar.'), -- Reseña para Venta ID 17
(18, 5, 'Cinta de correr muy completa y plegable, perfecta para espacios pequeños.'), -- Reseña para Venta ID 18
(19, 5, 'Esterilla de yoga con buen agarre, no se resbala y es muy cómoda.'), -- Reseña para Venta ID 19
(20, 3, 'El monitor de ritmo cardíaco es preciso, pero la app a veces falla la sincronización.'), -- Reseña para Venta ID 20

(21, 5, 'A mi perro le encanta este alimento, se ve más activo y con el pelo brillante.'), -- Reseña para Venta ID 21
(22, 4, 'Rascador para gatos resistente, mis gatos lo usan todo el tiempo.'), -- Reseña para Venta ID 22
(23, 5, 'Cama ortopédica para mascotas, mi perro ya no se queja de sus articulaciones.'), -- Reseña para Venta ID 23
(24, 5, 'Los juguetes interactivos mantienen a mis gatos entretenidos por horas.'), -- Reseña para Venta ID 24
(25, 4, 'Correa retráctil resistente y segura, buen control para perros grandes.'), -- Reseña para Venta ID 25

(26, 5, 'El set de maquillaje tiene colores vibrantes y de larga duración.'), -- Reseña para Venta ID 26
(27, 4, 'La crema hidratante es ligera y deja la piel muy suave. Me gusta.'), -- Reseña para Venta ID 27
(28, 5, 'Secador de pelo potente y rápido, el cabello queda suave y sin frizz.'), -- Reseña para Venta ID 28
(29, 5, 'Este perfume tiene una fragancia exquisita y duradera, muy recomendable.'), -- Reseña para Venta ID 29
(30, 4, 'El kit de afeitado clásico es muy completo, aunque requiere práctica para usar la navaja.'); -- Reseña para Venta ID 30

SELECT id_venta FROM ventas ORDER BY id_venta;
-- Paso 9:
-- Inserción de 35 datos de ejemplo en la tabla carrito

INSERT INTO carrito (id_usuario, id_producto, cantidad)
VALUES
-- Usuario 1 (comprador)
(1, 1, 1),   -- Smartphone Ultra X
(1, 10, 1),  -- Cafetera Expreso Automática
(1, 15, 2),  -- Set de Utensilios de Cocina 10 Pz
(1, 25, 1),  -- Correa Retráctil para Perros Grandes

-- Usuario 4 (comprador)
(4, 2, 1),   -- Laptop Gaming Pro
(4, 7, 1),   -- Lavadora Carga Frontal 12kg
(4, 18, 1),  -- Cinta de Correr Plegable
(4, 28, 1),  -- Secador de Pelo Iónico Potente

-- Usuario 6 (comprador)
(6, 5, 1),   -- Tablet Pro M1
(6, 21, 1),  -- Alimento Premium para Perro Adulto
(6, 31, 1),  -- Taladro Percutor Inalámbrico (Producto de Herramientas)
(6, 40, 1),  -- Juego de Mesa Estratégico (Producto de Juegos y Juguetes)

-- Usuario 9 (ambos)
(9, 3, 2),   -- Auriculares Inalámbricos HD
(9, 12, 1),  -- Mesa de Comedor de Madera Maciza
(9, 22, 1),  -- Rascador para Gatos de Múltiples Niveles
(9, 33, 1),  -- Sierra Circular Eléctrica 7-1/4" (Producto de Herramientas)

-- Usuario 11 (comprador)
(11, 6, 1),   -- Refrigerador Inverter Smart
(11, 11, 1),  -- Sofá Seccional Moderno
(11, 23, 1),  -- Cama Ortopédica para Mascotas Grandes
(11, 41, 1),  -- Cochecito de Bebé Convertible 3 en 1 (Producto de Bebés)

-- Usuario 14 (comprador)
(14, 13, 1),  -- Juego de Sábanas de Algodón Egipcio
(14, 24, 1),  -- Juguetes Interactivos para Gatos
(14, 34, 1),  -- Llave Inglesa Ajustable de Acero (Producto de Herramientas)
(14, 43, 1),  -- Pañales Desechables Talla M (Producto de Bebés)

-- Usuario 19 (comprador)
(19, 8, 1),   -- Horno Microondas Digital 30L
(19, 14, 1),  -- Lámpara de Pie LED Regulable
(19, 36, 1),  -- Martillo de Uña Forjado (Producto de Construcción)
(19, 46, 1),  -- Radio de Coche con Pantalla Táctil (Producto de Accesorios para Vehículos)

-- Usuario 21 (comprador)
(21, 16, 1),  -- Bicicleta de Montaña Aro 29
(21, 26, 1),  -- Set de Maquillaje Profesional
(21, 38, 1),  -- Guantes de Trabajo Reforzados (Producto de Construcción)
(21, 48, 1),  -- Funda de Asiento Universal para Coche (Producto de Accesorios para Vehículos)

-- Usuario 24 (comprador)
(24, 17, 1),  -- Set de Mancuernas Ajustables
(24, 27, 1),  -- Crema Hidratante Facial con Ácido Hialurónico
(24, 49, 1)   -- Jeans Slim Fit para Hombre (Producto de Moda)
;

-- Paso 10:
-- Inserción de 15 datos de ejemplo en la tabla ofertas_promociones

INSERT INTO ofertas_promociones (id_producto, descuento, fecha_inicio, fecha_fin)
VALUES
(1, 10.00, '2025-06-01 00:00:00', '2025-06-15 23:59:59'), -- Smartphone Ultra X (10% Dcto)
(2, 150.00, '2025-06-05 09:00:00', '2025-06-30 23:59:59'), -- Laptop Gaming Pro (150.00 Dcto)
(6, 5.00, '2025-05-28 00:00:00', '2025-06-10 23:59:59'),  -- Refrigerador Inverter Smart (5% Dcto)
(11, 50.00, '2025-06-01 00:00:00', '2025-06-07 23:59:59'), -- Sofá Seccional Moderno (50.00 Dcto)
(16, 12.00, '2025-06-03 12:00:00', '2025-06-20 23:59:59'), -- Bicicleta de Montaña Aro 29 (12% Dcto)
(21, 8.00, '2025-06-01 00:00:00', '2025-06-30 23:59:59'),  -- Alimento Premium para Perro Adulto (8% Dcto)
(26, 10.00, '2025-06-02 00:00:00', '2025-06-09 23:59:59'),  -- Set de Maquillaje Profesional (10.00 Dcto)
(31, 7.50, '2025-06-01 00:00:00', '2025-06-14 23:59:59'),  -- Taladro Percutor Inalámbrico (7.5% Dcto)
(36, 5.00, '2025-06-01 00:00:00', '2025-06-10 23:59:59'),  -- Martillo de Uña Forjado (5.00 Dcto)
(41, 15.00, '2025-06-01 00:00:00', '2025-06-25 23:59:59'); -- Cochecito de Bebé Convertible 3 en 1 (15% Dcto)

-- Ofertas futuras (aún no activas)
INSERT INTO ofertas_promociones (id_producto, descuento, fecha_inicio, fecha_fin)
VALUES
(7, 10.00, '2025-07-01 00:00:00', '2025-07-15 23:59:59'),  -- Lavadora Carga Frontal 12kg
(12, 20.00, '2025-07-10 00:00:00', '2025-07-31 23:59:59');  -- Mesa de Comedor de Madera Maciza

-- Ofertas pasadas (ya no activas)
INSERT INTO ofertas_promociones (id_producto, descuento, fecha_inicio, fecha_fin)
VALUES
(3, 10.00, '2025-05-01 00:00:00', '2025-05-31 23:59:59'),  -- Auriculares Inalámbricos HD
(8, 15.00, '2025-04-15 00:00:00', '2025-05-15 23:59:59'),  -- Horno Microondas Digital 30L
(18, 5.00, '2025-05-10 00:00:00', '2025-05-20 23:59:59');  -- Cinta de Correr Plegable


-- Paso 11:
-- Inserción de 20 datos de ejemplo en la tabla mensajes

INSERT INTO mensajes (id_usuario, id_vendedor, mensaje)
VALUES
-- Mensajes relacionados con ventas
(1, 2, 'Hola, ¿el Smartphone Ultra X tiene garantía?'), -- Comprador 1 a Vendedor 1 (sobre Venta 1) - Asumiendo que Vendedor 1 es usuario 2
(2, 1, 'Sí, tiene 1 año de garantía directamente con el fabricante.'),
(4, 5, 'Quisiera saber el estado de mi envío de la Laptop Gaming Pro.'), -- Comprador 4 a Vendedor 2 (sobre Venta 2) - Asumiendo que Vendedor 2 es usuario 5
(5, 4, 'Su envío está en camino, se espera para el 05/06/2025.'),
(9, 3, 'Los auriculares son fantásticos, ¡muchas gracias!'), -- Comprador 9 a Vendedor 3 (sobre Venta 3) - Asumiendo que Vendedor 3 es usuario 3
(3, 9, '¡De nada! Me alegra que le gusten.'),
(6, 2, '¿La Tablet Pro M1 incluye lápiz digital?'), -- Comprador 6 a Vendedor 2 (sobre Venta 5) - Asumiendo que Vendedor 2 es usuario 2
(2, 6, 'No, el lápiz se vende por separado.'),
(11, 4, 'El refrigerador llegó con un pequeño golpe en la puerta.'), -- Comprador 11 a Vendedor 4 (sobre Venta 6) - Asumiendo que Vendedor 4 es usuario 4
(4, 11, 'Lamentamos el inconveniente, nos pondremos en contacto para gestionar la devolución.'),

-- Mensajes generales (no necesariamente ligados a una venta específica aún)
(1, 7, '¿Tienen este sofá en otros colores disponibles?'),
(7, 1, 'Sí, tenemos en gris oscuro y beige. ¿Le gustaría ver fotos?'),
(14, 10, '¿Tienen más unidades de la Bicicleta de Montaña Aro 29?'),
(10, 14, 'Sí, tenemos 30 unidades en stock.'),
(19, 13, '¿El alimento premium para perros es apto para cachorros?'),
(13, 19, 'No, este alimento es solo para perros adultos.'),
(21, 16, '¿La oferta del set de maquillaje dura hasta fin de mes?'),
(16, 21, 'Sí, la oferta es válida hasta el 30 de junio.'),
(24, 17, '¿Tienen este producto en presentación más grande?'),
(17, 24, 'Por el momento solo esta presentación. Próximamente.');

-- Paso 12:
-- Inserción de 35 datos de ejemplo en la tabla historial_actividades

INSERT INTO historial_actividades (id_usuario, actividad)
VALUES
-- Actividades de Usuarios Compradores
(1, 'inicio_sesion: Inicio de sesión exitoso desde IP 192.168.1.100'),
(1, 'busqueda_producto: Búsqueda de "smartwatch deportivo"'),
(1, 'agregar_carrito: Añadió Smartphone Ultra X al carrito'),
(1, 'compra: Realizó la compra de 2 productos (Venta ID 1)'),
(4, 'inicio_sesion: Inicio de sesión exitoso desde IP 10.0.0.5'),
(4, 'busqueda_producto: Búsqueda de "laptop gaming"'),
(4, 'agregar_carrito: Añadió Laptop Gaming Pro al carrito'),
(4, 'compra: Realizó la compra de 2 productos (Venta ID 2)'),
(9, 'inicio_sesion: Inicio de sesión exitoso desde IP 172.16.0.2'),
(9, 'agregar_carrito: Añadió Auriculares Inalámbricos HD al carrito'),
(9, 'reseña_producto: Dejó una reseña para Auriculares Inalámbricos HD'),
(11, 'inicio_sesion: Inicio de sesión exitoso desde IP 192.168.1.101'),
(11, 'busqueda_producto: Búsqueda de "refrigerador inverter"'),
(14, 'ver_perfil: Visitó el perfil del vendedor 10'),
(19, 'cambio_contrasena: Cambió su contraseña de usuario'),

-- Actividades de Usuarios Vendedores
(2, 'inicio_sesion: Inicio de sesión de vendedor (Marta Soto)'),
(2, 'publicacion_producto: Publicó el producto "Laptop Gaming Pro"'),
(2, 'actualizacion_producto: Actualizó el precio de Tablet Pro M1'),
(5, 'inicio_sesion: Inicio de sesión de vendedor (Sofía Vargas)'),
(5, 'actualizacion_producto: Actualizó la cantidad de Cafetera Expreso Automática'),
(7, 'inicio_sesion: Inicio de sesión de vendedor (Laura Fernández)'),
(7, 'publicacion_oferta: Creó una oferta para Sofá Seccional Moderno'),
(10, 'inicio_sesion: Inicio de sesión de vendedor (Ricardo Ruiz)'),
(10, 'actualizacion_oferta: Actualizó la fecha de fin de la oferta de Bicicleta de Montaña'),
(13, 'inicio_sesion: Inicio de sesión de vendedor (Isabel Núñez)'),
(13, 'respuesta_mensaje: Respondió un mensaje sobre alimento para perros'),

-- Actividades de Usuarios con rol 'ambos' (comprador y vendedor)
(3, 'inicio_sesion: Inicio de sesión de usuario con doble rol (Marta Soto)'),
(3, 'navegacion_ventas: Consultó su historial de ventas'),
(3, 'reseña_producto: Dejó una reseña para Auriculares Inalámbricos HD'), -- Como comprador
(8, 'inicio_sesion: Inicio de sesión de usuario con doble rol (Javier Ramos)'),
(8, 'publicacion_producto: Publicó el producto "Mesa de Comedor de Madera Maciza"'),
(8, 'busqueda_producto: Búsqueda de "cama para perros"'), -- Como comprador

-- Otros tipos de actividades
(1, 'actualizacion_perfil: Actualizó su número de teléfono'),
(29, 'registro_usuario: Nuevo usuario registrado como Andrea Torres'), -- Aunque ya los insertamos, simula un registro
(15, 'recuperacion_contrasena: Solicitó recuperación de contraseña');

-- Paso 13:
-- Inserción de 15 datos de ejemplo en la tabla devoluciones

INSERT INTO devoluciones (id_venta, id_producto, id_comprador, motivo, estado)
VALUES
-- Devoluciones para ventas de tecnología
(1, 1, 1, 'El producto llegó dañado.', 'pendiente'),            -- Venta ID 1 (Smartphone Ultra X)
(2, 2, 4, 'No era el modelo que esperaba.', 'aprobada'),         -- Venta ID 2 (Laptop Gaming Pro)
(4, 4, 1, 'Problemas de compatibilidad con mi dispositivo.', 'rechazada'), -- Venta ID 4 (Smartwatch Deportivo)

-- Devoluciones para ventas de electrodomésticos
(7, 7, 14, 'El tamaño no se ajusta a mi espacio.', 'pendiente'),    -- Venta ID 7 (Lavadora Carga Frontal 12kg)
(10, 10, 4, 'Funcionamiento intermitente de la cafetera.', 'aprobada'), -- Venta ID 10 (Cafetera Expreso Automática)

-- Devoluciones para ventas de hogar y muebles
(12, 12, 11, 'Color diferente al de la foto.', 'pendiente'),     -- Venta ID 12 (Mesa de Comedor de Madera Maciza)
(15, 15, 21, 'Pieza faltante en el set de utensilios.', 'aprobada'), -- Venta ID 15 (Set de Utensilios de Cocina 10 Pz)

-- Devoluciones para ventas de deportes y fitness
(17, 17, 26, 'Las mancuernas son muy voluminosas.', 'pendiente'),  -- Venta ID 17 (Set de Mancuernas Ajustables)
(20, 20, 4, 'Lecturas inconsistentes del monitor cardíaco.', 'rechazada'), -- Venta ID 20 (Monitor de Ritmo Cardíaco GPS)

-- Devoluciones para ventas de mascotas
(22, 22, 9, 'Mi gato no usa el rascador.', 'pendiente'),         -- Venta ID 22 (Rascador para Gatos de Múltiples Niveles)

-- Devoluciones para ventas de belleza y cuidado personal
(27, 27, 24, 'Reacción alérgica al producto.', 'aprobada'),      -- Venta ID 27 (Crema Hidratante Facial con Ácido Hialurónico)
(30, 30, 1, 'No cumplió mis expectativas.', 'pendiente'),       -- Venta ID 30 (Kit de Afeitado Clásico para Hombre)

-- Otras devoluciones
(5, 5, 6, 'La batería dura menos de lo indicado.', 'aprobada'), -- Venta ID 5 (Tablet Pro M1)
(25, 25, 19, 'La correa es demasiado corta para mi perro.', 'pendiente'), -- Venta ID 25 (Correa Retráctil para Perros Grandes)
(18, 18, 29, 'Ruido excesivo al usar la cinta de correr.', 'aprobada'); -- Venta ID 18 (Cinta de Correr Plegable)

-- Paso 14:
-- Inserción de 25 datos de ejemplo en la tabla direcciones

INSERT INTO direcciones (id_usuario, direccion, ciudad, provincia, pais, codigo_postal, tipo)
VALUES
-- Direcciones para usuarios compradores
(1, 'Av. Los Libertadores 123', 'Lima', 'Lima', 'Perú', '15001', 'envio'),
(1, 'Jr. Garcilaso de la Vega 456', 'Lima', 'Lima', 'Perú', '15001', 'facturacion'),
(4, 'Calle Las Acacias 789', 'Cusco', 'Cusco', 'Perú', '08000', 'envio'),
(4, 'Av. El Sol 101', 'Cusco', 'Cusco', 'Perú', '08000', 'facturacion'),
(6, 'Psje. Los Pinos 202', 'Arequipa', 'Arequipa', 'Perú', '04001', 'envio'),
(9, 'Urb. Santa Catalina 303', 'Trujillo', 'La Libertad', 'Perú', '13001', 'envio'),
(9, 'Av. España 404', 'Trujillo', 'La Libertad', 'Perú', '13001', 'facturacion'),
(11, 'Jr. Bolognesi 505', 'Piura', 'Piura', 'Perú', '20001', 'envio'),
(14, 'Calle El Commercio 606', 'Chiclayo', 'Lambayeque', 'Perú', '14001', 'envio'),
(19, 'Av. La Marina 707', 'Iquitos', 'Loreto', 'Perú', '16001', 'envio'),
(21, 'Jr. Dos de Mayo 808', 'Huancayo', 'Junín', 'Perú', '12001', 'envio'),
(24, 'Calle Zela 909', 'Tacna', 'Tacna', 'Perú', '23001', 'envio'),
(26, 'Av. Pardo 110', 'Huaraz', 'Áncash', 'Perú', '02001', 'envio'),

-- Direcciones para usuarios vendedores
(2, 'Jr. San Martín 221', 'Lima', 'Lima', 'Perú', '15002', 'facturacion'),
(5, 'Calle Tarapacá 332', 'Lima', 'Lima', 'Perú', '15003', 'envio'),
(7, 'Av. Abancay 443', 'Arequipa', 'Arequipa', 'Perú', '04002', 'facturacion'),
(10, 'Jr. Junín 554', 'Cusco', 'Cusco', 'Perú', '08001', 'envio'),
(13, 'Calle Manco Capac 665', 'Trujillo', 'La Libertad', 'Perú', '13002', 'facturacion'),
(16, 'Av. Aviación 776', 'Piura', 'Piura', 'Perú', '20002', 'envio'),
(18, 'Psje. Bolognesi 887', 'Chiclayo', 'Lambayeque', 'Perú', '14002', 'facturacion'),

-- Direcciones para usuarios 'ambos'
(3, 'Urb. El Bosque 998', 'Lima', 'Lima', 'Perú', '15004', 'envio'),
(3, 'Av. Arenales 109', 'Lima', 'Lima', 'Perú', '15004', 'facturacion'),
(8, 'Calle San Juan 110', 'Arequipa', 'Arequipa', 'Perú', '04003', 'envio'),
(8, 'Jr. Arequipa 121', 'Arequipa', 'Arequipa', 'Perú', '04003', 'facturacion'),
(12, 'Av. La Paz 132', 'Cusco', 'Cusco', 'Perú', '08002', 'envio')
;

-- Paso 15:
-- Inserción de 18 datos de ejemplo en la tabla facturas

INSERT INTO facturas (id_venta, monto_total)
VALUES
-- Facturas para ventas de Tecnología (Productos 1-5)
(1, 999.99),  -- Venta ID 1 (Smartphone Ultra X)
(3, 299.00),  -- Venta ID 3 (Auriculares Inalámbricos HD)
(4, 219.99),  -- Venta ID 4 (Smartwatch Deportivo)

-- Facturas para ventas de Electrodomésticos (Productos 6-10)
(6, 1200.00), -- Venta ID 6 (Refrigerador Inverter Smart)
(8, 120.00),  -- Venta ID 8 (Horno Microondas Digital 30L)
(10, 280.00), -- Venta ID 10 (Cafetera Expreso Automática)

-- Facturas para ventas de Hogar y Muebles (Productos 11-15)
(11, 850.00), -- Venta ID 11 (Sofá Seccional Moderno)
(13, 75.00),  -- Venta ID 13 (Juego de Sábanas de Algodón Egipcio)
(14, 95.00),  -- Venta ID 14 (Lámpara de Pie LED Regulable)

-- Facturas para ventas de Deportes y Fitness (Productos 16-20)
(16, 450.00), -- Venta ID 16 (Bicicleta de Montaña Aro 29)
(18, 580.00), -- Venta ID 18 (Cinta de Correr Plegable)
(19, 50.00),  -- Venta ID 19 (Esterilla de Yoga Antideslizante)

-- Facturas para ventas de Mascotas (Productos 21-25)
(21, 60.00),  -- Venta ID 21 (Alimento Premium para Perro Adulto)
(23, 70.00),  -- Venta ID 23 (Cama Ortopédica para Mascotas Grandes)
(24, 15.00),  -- Venta ID 24 (Juguetes Interactivos para Gatos)

-- Facturas para ventas de Belleza y Cuidado personal (Productos 26-30)
(26, 90.00),  -- Venta ID 26 (Set de Maquillaje Profesional)
(28, 70.00),  -- Venta ID 28 (Secador de Pelo Iónico Potente)
(29, 120.00)  -- Venta ID 29 (Perfume Eau de Parfum para Mujer 100ml)
;