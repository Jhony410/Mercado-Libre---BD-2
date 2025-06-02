USE mercado_libre;

# ----------------------------> 4.2 
-- Crear usuarios
CREATE USER 'admin'@'%' IDENTIFIED BY 'admin_password';
CREATE USER 'vendedor'@'%' IDENTIFIED BY 'vendedor_password';
CREATE USER 'comprador'@'%' IDENTIFIED BY 'comprador_password';
CREATE USER 'usuario_general'@'%' IDENTIFIED BY 'usuario_password';

-- Asignar privilegios al administrador
GRANT ALL PRIVILEGES ON mercado_libre.* TO 'admin'@'%';

-- Privilegios para vendedores
GRANT SELECT, INSERT, UPDATE ON mercado_libre.productos TO 'vendedor'@'%';
GRANT SELECT ON mercado_libre.ventas TO 'vendedor'@'%';
GRANT SELECT, INSERT, UPDATE ON mercado_libre.ofertas_promociones TO 'vendedor'@'%';

-- Privilegios para compradores
GRANT SELECT ON mercado_libre.productos TO 'comprador'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON mercado_libre.carrito TO 'comprador'@'%';
GRANT INSERT ON mercado_libre.ventas TO 'comprador'@'%';
GRANT INSERT ON mercado_libre.resenas_calificaciones TO 'comprador'@'%';

-- Privilegios para usuario general (solo lectura)
GRANT SELECT ON mercado_libre.* TO 'usuario_general'@'%';

-- Aplicar cambios
FLUSH PRIVILEGES;


# ----------------------------> 4.3
CREATE INDEX idx_usuarios_email ON usuarios(email);
CREATE INDEX idx_productos_categoria ON productos(id_categoria);
CREATE INDEX idx_productos_nombre ON productos(nombre_producto);
CREATE INDEX idx_productos_precio ON productos(precio);
CREATE INDEX idx_ventas_comprador ON ventas(id_comprador);
CREATE INDEX idx_ventas_vendedor ON ventas(id_vendedor);
CREATE INDEX idx_ventas_estado ON ventas(estado);
CREATE INDEX idx_pagos_metodo_estado ON pagos(metodo_pago, estado);
CREATE INDEX idx_envios_venta ON envios(id_venta);
CREATE INDEX idx_devoluciones_estado ON devoluciones(estado);
CREATE INDEX idx_devoluciones_producto ON devoluciones(id_producto);


# ----------------------------> 4.4

-- a. FUNCIONES PERSONALIZADAS

-- 1. Verificacion de Disponibilidad de Stock
DELIMITER //
CREATE FUNCTION verificar_disponibilidad_stock(
    p_id_producto INT,
    p_cantidad_solicitada INT
) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE stock_actual INT;

    SELECT cantidad INTO stock_actual
    FROM productos
    WHERE id_producto = p_id_producto;

    RETURN IF(stock_actual >= p_cantidad_solicitada, TRUE, FALSE);
END //
DELIMITER ;

-- 2. Calculo del total vendido por vendedor (considerando pagos completados)
DELIMITER //
CREATE FUNCTION calcular_total_vendido_vendedor(
    p_id_vendedor INT
) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_vendido DECIMAL(10,2);

    SELECT IFNULL(SUM(v.total),0) INTO total_vendido
    FROM ventas v
    JOIN productos p ON v.id_producto = p.id_producto
    JOIN pagos pg ON pg.id_venta = v.id_venta
    WHERE p.id_vendedor = p_id_vendedor
      AND pg.estado = 'completado';

    RETURN total_vendido;
END //
DELIMITER ;

-- 3. Obtencion del promedio de calificacion de un producto
DELIMITER //
CREATE FUNCTION obtener_promedio_calificacion_producto(
    p_id_producto INT
) RETURNS DECIMAL(3,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(3,2);

    SELECT IFNULL(AVG(rc.calificacion), 0) INTO promedio
    FROM resenas_calificaciones rc
    JOIN ventas v ON rc.id_venta = v.id_venta
    WHERE v.id_producto = p_id_producto;

    RETURN promedio;
END //
DELIMITER ;

-- 4. Verificar vigencia de promocion
DELIMITER //
CREATE FUNCTION verificar_vigencia_promocion(
    p_id_oferta INT
) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE fecha_ini TIMESTAMP;
    DECLARE fecha_fin TIMESTAMP;
    DECLARE fecha_actual TIMESTAMP;

    SET fecha_actual = NOW();

    SELECT fecha_inicio, fecha_fin INTO fecha_ini, fecha_fin
    FROM ofertas_promociones
    WHERE id_oferta = p_id_oferta;

    RETURN IF(fecha_actual BETWEEN fecha_ini AND fecha_fin, TRUE, FALSE);
END //
DELIMITER ;


-- b. TRIGGERS
-- 1. Actualizacion automatica del stock tras venta
DELIMITER //
CREATE TRIGGER trg_actualizar_stock_despues_venta
AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
    UPDATE productos
    SET cantidad = cantidad - NEW.cantidad
    WHERE id_producto = NEW.id_producto;
END //
DELIMITER ;

-- 2. Generacion automatica de fecha de publicacion en productos
DELIMITER //
CREATE TRIGGER trg_asignar_fecha_publicacion
BEFORE INSERT ON productos
FOR EACH ROW
BEGIN
    IF NEW.fecha_publicacion IS NULL THEN
        SET NEW.fecha_publicacion = NOW();
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_asignar_fecha_publicacion_update
BEFORE UPDATE ON productos
FOR EACH ROW
BEGIN
    IF NEW.fecha_publicacion IS NULL THEN
        SET NEW.fecha_publicacion = NOW();
    END IF;
END //
DELIMITER ;

-- 3. Cambio de estado de venta tras confirmacion de pago
DELIMITER //
CREATE TRIGGER trg_actualizar_estado_venta_pago
AFTER INSERT ON pagos
FOR EACH ROW
BEGIN
    IF NEW.estado = 'completado' THEN
        UPDATE ventas
        SET total = total, -- Sin cambio, solo para evitar errores de sintaxis
            -- No hay campo estado en ventas en esquema, asumiremos que hay que agregarlo o no
            -- Pero según tablas, no hay estado en ventas, se podría agregar un campo estado en ventas para esto.
            -- Por ahora se asume que no existe, así que no se puede actualizar estado.
            -- Se puede agregar estado en ventas, si quieres te ayudo.
            -- O no hacemos nada aquí.
            -- Para cumplir el requisito, agregaremos campo estado en ventas.
            estado = 'completada' 
        WHERE id_venta = NEW.id_venta;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_actualizar_estado_venta_pago_update
AFTER UPDATE ON pagos
FOR EACH ROW
BEGIN
    IF NEW.estado = 'completado' AND OLD.estado <> 'completado' THEN
        UPDATE ventas
        SET estado = 'completada'
        WHERE id_venta = NEW.id_venta;
    END IF;
END //
DELIMITER ;

-- 4. Registro automático en historial de actividades
DELIMITER //
CREATE TRIGGER trg_historial_actividad_venta
AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
    INSERT INTO historial_actividades (id_usuario, actividad, fecha_actividad)
    VALUES (NEW.id_usuario, CONCAT('Registro venta ID: ', NEW.id_venta), NOW());
END //

CREATE TRIGGER trg_historial_actividad_pago
AFTER INSERT ON pagos
FOR EACH ROW
BEGIN
    INSERT INTO historial_actividades (id_usuario, actividad, fecha_actividad)
    -- Obtener usuario vía venta
    VALUES (
        (SELECT id_usuario FROM ventas WHERE id_venta = NEW.id_venta),
        CONCAT('Registro pago ID: ', NEW.id_pago),
        NOW()
    );
END //

CREATE TRIGGER trg_historial_actividad_producto
AFTER INSERT ON productos
FOR EACH ROW
BEGIN
    INSERT INTO historial_actividades (id_usuario, actividad, fecha_actividad)
    VALUES (
        (SELECT id_usuario FROM vendedores WHERE id_vendedor = NEW.id_vendedor),
        CONCAT('Registro producto ID: ', NEW.id_producto),
        NOW()
    );
END //
DELIMITER ;


-- c. PROCEDIMIENTOS ALMACENADOS
-- 1. Registro completo de venta (venta + pago + envío + actualización stock)
DELIMITER //
CREATE PROCEDURE registrar_venta_completa(
    IN p_id_usuario INT,
    IN p_id_producto INT,
    IN p_cantidad INT,
    IN p_monto_pago DECIMAL(10,2),
    IN p_metodo_pago ENUM('debito', 'credito', 'transferencia'),
    IN p_direccion_envio TEXT
)
BEGIN
    DECLARE v_id_venta INT;
    DECLARE v_stock_actual INT;

    START TRANSACTION;

    -- Verificar stock disponible
    SELECT cantidad INTO v_stock_actual FROM productos WHERE id_producto = p_id_producto FOR UPDATE;

    IF v_stock_actual < p_cantidad THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock insuficiente para el producto solicitado.';
    ELSE
        -- Insertar venta
        INSERT INTO ventas (id_usuario, id_producto, cantidad, total)
        VALUES (p_id_usuario, p_id_producto, p_cantidad, p_cantidad * (SELECT precio FROM productos WHERE id_producto = p_id_producto));

        SET v_id_venta = LAST_INSERT_ID();

        -- Insertar pago
        INSERT INTO pagos (id_venta, monto, metodo_pago, estado)
        VALUES (v_id_venta, p_monto_pago, p_metodo_pago, 'completado');

        -- Insertar envío
        INSERT INTO envios (id_venta, direccion_envio)
        VALUES (v_id_venta, p_direccion_envio);

        -- Actualizar stock (trigger lo hará automáticamente pero para seguridad)
        UPDATE productos
        SET cantidad = cantidad - p_cantidad
        WHERE id_producto = p_id_producto;

    END IF;

    COMMIT;
END //
DELIMITER ;

-- 2. Generación automática de facturas mensuales para vendedores
DELIMITER //
CREATE PROCEDURE generar_facturas_mensuales(
    IN p_id_vendedor INT,
    IN p_anio INT,
    IN p_mes INT
)
BEGIN
    DECLARE v_inicio_fecha DATE;
    DECLARE v_fin_fecha DATE;
    DECLARE v_total DECIMAL(10,2);
    DECLARE v_id_venta INT;

    SET v_inicio_fecha = MAKEDATE(p_anio, 1) + INTERVAL (p_mes - 1) MONTH;
    SET v_fin_fecha = v_inicio_fecha + INTERVAL 1 MONTH;

    -- Obtener total vendido en el mes (ventas con pagos completados)
    SELECT IFNULL(SUM(v.total),0) INTO v_total
    FROM ventas v
    JOIN productos p ON v.id_producto = p.id_producto
    JOIN pagos pg ON pg.id_venta = v.id_venta
    WHERE p.id_vendedor = p_id_vendedor
      AND pg.estado = 'completado'
      AND v.fecha_venta >= v_inicio_fecha
      AND v.fecha_venta < v_fin_fecha;

    -- Insertar factura para cada venta (simplificado: una factura total por mes)
    INSERT INTO facturas (id_venta, monto_total)
    VALUES (NULL, v_total); -- id_venta NULL porque es factura global mensual, se puede adaptar
END //
DELIMITER ;

-- 3. Gestión de devoluciones y reembolso
DELIMITER //
CREATE PROCEDURE gestionar_devolucion(
    IN p_id_devolucion INT,
    IN p_nuevo_estado ENUM('pendiente', 'aprobada', 'rechazada'),
    IN p_reembolso BOOLEAN
)
BEGIN
    DECLARE v_id_venta INT;
    DECLARE v_id_producto INT;
    DECLARE v_cantidad INT;
    DECLARE v_id_pago INT;

    -- Obtener detalles devolución
    SELECT id_venta, id_producto INTO v_id_venta, v_id_producto
    FROM devoluciones
    WHERE id_devolucion = p_id_devolucion;

    -- Actualizar estado devolución
    UPDATE devoluciones
    SET estado = p_nuevo_estado
    WHERE id_devolucion = p_id_devolucion;

    IF p_nuevo_estado = 'aprobada' THEN
        -- Obtener cantidad vendida para devolver stock
        SELECT cantidad INTO v_cantidad FROM ventas WHERE id_venta = v_id_venta;

        -- Devolver stock
        UPDATE productos
        SET cantidad = cantidad + v_cantidad
        WHERE id_producto = v_id_producto;

        -- Procesar reembolso si aplica
        IF p_reembolso THEN
            -- Obtener pago relacionado
            SELECT id_pago INTO v_id_pago FROM pagos WHERE id_venta = v_id_venta LIMIT 1;

            IF v_id_pago IS NOT NULL THEN
                UPDATE pagos
                SET estado = 'reembolsado'
                WHERE id_pago = v_id_pago;
            END IF;
        END IF;
    END IF;
END //
DELIMITER ;

-- 4. Actualización masiva de estados de ventas pendientes
DELIMITER //
CREATE PROCEDURE actualizar_estados_ventas_pendientes(
    IN p_plazo_dias INT
)
BEGIN
    UPDATE ventas v
    JOIN pagos p ON p.id_venta = v.id_venta
    SET v.estado = 'cancelada'
    WHERE p.estado = 'pendiente'
      AND v.fecha_venta <= NOW() - INTERVAL p_plazo_dias DAY;
END //
DELIMITER ;



# ----------------------------> 4.5

-- 1. Registro completo de una venta (venta, pago, envío y actualización de stock)
START TRANSACTION;
-- Verificar stock (para evitar vender más del disponible)
SELECT cantidad FROM productos WHERE id_producto = 1 FOR UPDATE;
-- Si stock suficiente, ejecutar:
INSERT INTO ventas (id_usuario, id_producto, cantidad, total)
VALUES (10, 1, 3, 3 * (SELECT precio FROM productos WHERE id_producto = 1));
SET @id_venta = LAST_INSERT_ID();
INSERT INTO pagos (id_venta, monto, metodo_pago, estado)
VALUES (@id_venta, 150.00, 'credito', 'completado');
INSERT INTO envios (id_venta, direccion_envio)
VALUES (@id_venta, 'Av. Siempre Viva 123');
UPDATE productos
SET cantidad = cantidad - 3
WHERE id_producto = 1;
COMMIT;

-- 2. Gestión de devolución (actualizar estado, devolver stock, marcar reembolso)
START TRANSACTION;
UPDATE devoluciones
SET estado = 'aprobada'
WHERE id_devolucion = 5;
-- Obtener datos para devolución
SELECT id_venta, id_producto FROM devoluciones WHERE id_devolucion = 5;
-- Devolver stock (supón cantidad de venta conocida)
UPDATE productos
SET cantidad = cantidad + 3
WHERE id_producto = 2;
-- Marcar pago como reembolsado
UPDATE pagos
SET estado = 'reembolsado'
WHERE id_venta = (SELECT id_venta FROM devoluciones WHERE id_devolucion = 5);
COMMIT;

-- 3. Actualizacion masiva de ventas pendientes a canceladas
START TRANSACTION;
UPDATE ventas v
JOIN pagos p ON p.id_venta = v.id_venta
SET v.estado = 'cancelada'
WHERE p.estado = 'pendiente'
  AND v.fecha_venta <= NOW() - INTERVAL 7 DAY;
COMMIT;



# ----------------------------> 4.6
-- INSERT: Registrar un nuevo usuario como comprador
INSERT INTO usuarios (email, nombres, telefono, contrasena, tipo_usuario)
VALUES ('nuevousuario@example.com', 'Carlos Mendoza', '987654321', 'passwordhashdelcarlos', 'comprador');

-- SELECT: Verificar el nuevo usuario
SELECT * FROM usuarios WHERE email = 'nuevousuario@example.com';

-- SELECT: Simular inicio de sesión (buscar por email y contraseña hash)
-- En una app real, se verificaría el hash de la contraseña
SELECT id_usuario, nombres, email, tipo_usuario
FROM usuarios
WHERE email = 'juan.perez@example.com' AND contrasena = 'passwordhashdeljuan'; -- Asume que 'passwordhashdeljuan' es el hash real

-- SELECT: Ver detalles de su perfil (ej. id_usuario = 1)
SELECT u.nombres, u.email, u.telefono, u.tipo_usuario,
       d.direccion, d.ciudad, d.provincia, d.pais, d.codigo_postal, d.tipo
FROM usuarios u
LEFT JOIN direcciones d ON u.id_usuario = d.id_usuario
WHERE u.id_usuario = 1;

-- SELECT: Buscar productos por palabra clave (ej. 'smartphone')
SELECT p.nombre, p.descripcion, p.precio, p.cantidad AS stock,
       c.nombre AS categoria,
       u.nombres AS nombre_vendedor
FROM productos p
JOIN categorias c ON p.id_categoria = c.id_categoria
JOIN vendedores v ON p.id_vendedor = v.id_vendedor
JOIN usuarios u ON v.id_usuario = u.id_usuario
WHERE p.nombre LIKE '%Smartphone%' AND p.cantidad > 0;

-- SELECT: Ver productos en una categoría específica (ej. 'Tecnología')
SELECT p.nombre, p.descripcion, p.precio, p.cantidad AS stock,
       u.nombres AS nombre_vendedor
FROM productos p
JOIN categorias c ON p.id_categoria = c.id_categoria
JOIN vendedores v ON p.id_vendedor = v.id_vendedor
JOIN usuarios u ON v.id_usuario = u.id_usuario
WHERE c.nombre = 'Tecnología' AND p.cantidad > 0
ORDER BY p.precio DESC;

-- INSERT: Añadir producto 1 (Smartphone Ultra X) al carrito del usuario 1
INSERT INTO carrito (id_usuario, id_producto, cantidad)
VALUES (1, 1, 1)
ON DUPLICATE KEY UPDATE cantidad = cantidad + 1; -- Si ya existe, incrementa la cantidad

-- SELECT: Verificar el contenido del carrito del usuario 1
SELECT c.id_carrito, p.nombre, p.precio, c.cantidad, (p.precio * c.cantidad) AS subtotal
FROM carrito c
JOIN productos p ON c.id_producto = p.id_producto
WHERE c.id_usuario = 1;

-- UPDATE: Cambiar la cantidad del producto 1 (Smartphone Ultra X) en el carrito del usuario 1 a 2
UPDATE carrito
SET cantidad = 2
WHERE id_usuario = 1 AND id_producto = 1;

-- SELECT: Verificar el carrito actualizado
SELECT c.id_carrito, p.nombre, p.precio, c.cantidad, (p.precio * c.cantidad) AS subtotal
FROM carrito c
JOIN productos p ON c.id_producto = p.id_producto
WHERE c.id_usuario = 1 AND c.id_producto = 1;

-- DELETE: Eliminar producto 10 (Cafetera Expreso Automática) del carrito del usuario 1
DELETE FROM carrito
WHERE id_usuario = 1 AND id_producto = 10;

-- SELECT: Verificar que el producto fue eliminado (o que el carrito ahora tiene menos ítems)
SELECT c.id_carrito, p.nombre
FROM carrito c
JOIN productos p ON c.id_producto = p.id_producto
WHERE c.id_usuario = 1;

-- SELECT: Ver el historial de compras del usuario 1
SELECT v.id_venta, p.nombre AS producto, v.cantidad, v.total, v.estado AS estado_venta, v.fecha_venta
FROM ventas v
JOIN productos p ON v.id_producto = p.id_producto
WHERE v.id_usuario = 1
ORDER BY v.fecha_venta DESC;

-- INSERT: Dejar una reseña para el producto 2 (Laptop Gaming Pro) por el usuario 4
INSERT INTO resenas_calificaciones (id_producto, id_usuario, calificacion, comentario)
VALUES (2, 4, 4, 'La laptop es muy potente, ideal para mis necesidades, aunque la batería no dura tanto como esperaba.');

-- SELECT: Ver las reseñas de un producto (ej. producto 2)
SELECT rc.calificacion, rc.comentario, u.nombres AS nombre_comprador, rc.fecha_resena
FROM resenas_calificaciones rc
JOIN usuarios u ON rc.id_usuario = u.id_usuario
WHERE rc.id_producto = 2;

-- INSERT: Solicitar devolución para la venta 1 (Smartphone Ultra X), producto 1, por el usuario 1
INSERT INTO devoluciones (id_venta, id_producto, id_comprador, motivo, estado)
VALUES (1, 1, 1, 'El producto no cumple con las especificaciones descritas.', 'pendiente');

-- SELECT: Ver las solicitudes de devolución del usuario 1
SELECT d.id_devolucion, v.id_venta, p.nombre AS producto, d.motivo, d.estado, d.fecha_devolucion
FROM devoluciones d
JOIN ventas v ON d.id_venta = v.id_venta
JOIN productos p ON d.id_producto = p.id_producto
WHERE d.id_comprador = 1;

-- INSERT: Un usuario existente (ej. id_usuario = 18, Benjamín Gómez) se registra como vendedor
-- Esto ya lo hicimos en el paso de poblar la tabla vendedores
-- SELECT: Verificar que el usuario 18 es un vendedor
SELECT u.nombres, u.email, v.id_vendedor
FROM usuarios u
JOIN vendedores v ON u.id_usuario = v.id_usuario
WHERE u.id_usuario = 18;

-- INSERT: Publicar un nuevo producto por el vendedor 1 (Luis Torres) en la categoría 1 (Tecnología)
INSERT INTO productos (id_vendedor, id_categoria, nombre, descripcion, precio, cantidad)
VALUES (1, 1, 'Teclado Mecánico RGB', 'Teclado mecánico para gaming, switches clicky, retroiluminación RGB personalizable.', 75.99, 150);

-- SELECT: Ver los productos del vendedor 1
SELECT p.nombre, p.precio, p.cantidad, c.nombre AS categoria
FROM productos p
JOIN categorias c ON p.id_categoria = c.id_categoria
WHERE p.id_vendedor = 1
ORDER BY p.fecha_publicacion DESC;

-- UPDATE: Actualizar el precio y la cantidad de un producto (ej. Smartphone Ultra X, id_producto = 1) por el vendedor 1
UPDATE productos
SET precio = 950.00, cantidad = 45
WHERE id_producto = 1 AND id_vendedor = 1; -- Se asegura que el vendedor sea el dueño del producto

-- SELECT: Verificar el producto actualizado
SELECT nombre, precio, cantidad FROM productos WHERE id_producto = 1;

-- INSERT: Crear una oferta del 20% para el producto 2 (Laptop Gaming Pro) por el vendedor 2
INSERT INTO ofertas_promociones (id_producto, id_vendedor, tipo_oferta, valor, fecha_inicio, fecha_fin, estado)
VALUES (2, 2, 'porcentaje', 20.00, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY), 'activa');

-- SELECT: Ver las ofertas activas del vendedor 2
SELECT op.tipo_oferta, op.valor, p.nombre AS nombre_producto, op.fecha_inicio, op.fecha_fin, op.estado
FROM ofertas_promociones op
JOIN productos p ON op.id_producto = p.id_producto
WHERE op.id_vendedor = 2 AND op.estado = 'activa';

-- SELECT: Ver todas las ventas completadas del vendedor 2
SELECT v.id_venta, p.nombre AS producto, v.cantidad, v.total, v.fecha_venta, v.estado
FROM ventas v
JOIN productos p ON v.id_producto = p.id_producto
WHERE v.id_vendedor = 2
ORDER BY v.fecha_venta DESC;

-- SELECT: Ver solicitudes de devolución pendientes para los productos del vendedor 2
SELECT d.id_devolucion, p.nombre AS producto, u.nombres AS comprador, d.motivo, d.estado, d.fecha_devolucion
FROM devoluciones d
JOIN productos p ON d.id_producto = p.id_producto
JOIN usuarios u ON d.id_comprador = u.id_usuario
WHERE p.id_vendedor = 2 AND d.estado = 'pendiente';

-- SELECT: Contar usuarios por tipo
SELECT tipo_usuario, COUNT(*) AS total_usuarios
FROM usuarios
GROUP BY tipo_usuario;

-- SELECT: Ver todos los envíos pendientes
SELECT e.id_envio, v.id_venta, p.nombre AS producto, u.nombres AS comprador,
       e.direccion_envio, e.estado, e.fecha_envio
FROM envios e
JOIN ventas v ON e.id_venta = v.id_venta
JOIN productos p ON v.id_producto = p.id_producto
JOIN usuarios u ON v.id_usuario = u.id_usuario
WHERE e.estado = 'pendiente';

-- UPDATE: Actualizar el estado de un envío (ej. de 'pendiente' a 'en_transito')
UPDATE envios
SET estado = 'en_transito'
WHERE id_envio = 1; -- Asumiendo id_envio 1 es el primero de la lista

-- SELECT: Verificar el envío actualizado
SELECT * FROM envios WHERE id_envio = 1;

-- SELECT: Top 5 productos más vendidos (por cantidad)
SELECT p.nombre, SUM(v.cantidad) AS total_vendido, SUM(v.total) AS ingresos_generados
FROM ventas v
JOIN productos p ON v.id_producto = p.id_producto
WHERE v.estado = 'completada'
GROUP BY p.nombre
ORDER BY total_vendido DESC
LIMIT 5;

-- SELECT: Ingresos totales por categoría
SELECT c.nombre AS categoria, SUM(v.total) AS ingresos_totales
FROM ventas v
JOIN productos p ON v.id_producto = p.id_producto
JOIN categorias c ON p.id_categoria = c.id_categoria
WHERE v.estado = 'completada'
GROUP BY c.nombre
ORDER BY ingresos_totales DESC;

-- UPDATE: Desactivar ofertas cuya fecha_fin ya pasó y aún están 'activa'
UPDATE ofertas_promociones
SET estado = 'inactiva'
WHERE fecha_fin < NOW() AND estado = 'activa';

-- SELECT: Verificar ofertas inactivas (ej. las que acaban de expirar)
SELECT id_oferta, id_producto, fecha_fin, estado FROM ofertas_promociones WHERE estado = 'inactiva' AND fecha_fin < NOW();

DELETE FROM carrito
WHERE fecha_agregado < DATE_SUB(NOW(), INTERVAL 30 DAY);



# ----------------------------> 4.7
-- 1. PRUEBA DE ÍNDICES (EXPLAIN para ver uso de índices)

EXPLAIN SELECT * FROM usuarios WHERE email = 'usuario1@example.com';
EXPLAIN SELECT * FROM usuarios WHERE tipo_usuario = 'vendedor';
EXPLAIN SELECT * FROM productos WHERE id_categoria = 1 AND nombre LIKE '%Smartphone%';
EXPLAIN SELECT * FROM productos WHERE precio BETWEEN 100 AND 1000 AND cantidad > 10;
EXPLAIN SELECT * FROM ofertas_promociones WHERE NOW() BETWEEN fecha_inicio AND fecha_fin;
EXPLAIN SELECT * FROM ventas WHERE estado = 'completada' AND fecha_venta >= '2025-01-01';
EXPLAIN SELECT * FROM pagos WHERE estado = 'completado' AND metodo_pago = 'credito';
EXPLAIN SELECT * FROM envios WHERE id_venta = 1;
EXPLAIN SELECT * FROM devoluciones WHERE estado = 'pendiente' AND id_producto = 1;


-- 2. PRUEBA DE FUNCIONES PERSONALIZADAS

SELECT verificar_disponibilidad_stock(1, 5) AS stock_disponible; -- Producto id=1, solicitar 5
SELECT calcular_total_vendido_vendedor(2) AS total_vendido; -- Vendedor id=2 (Luis Torres)
SELECT obtener_promedio_calificacion_producto(1) AS promedio_calificacion; -- Producto id=1
SELECT verificar_vigencia_promocion(1) AS promocion_vigente; -- Oferta id=1


-- 3. PRUEBA DE TRIGGERS

-- Insertar venta para disparar actualización de stock y registro historial
INSERT INTO ventas (id_usuario, id_producto, cantidad, total, estado)
VALUES (1, 1, 1, 999.99, 'pendiente');

-- Insertar pago completado para disparar actualización estado venta y registro historial
INSERT INTO pagos (id_venta, monto, metodo_pago, estado)
VALUES (LAST_INSERT_ID(), 999.99, 'credito', 'completado');

-- Insertar producto sin fecha_publicacion para disparar trigger fecha actual
INSERT INTO productos (id_vendedor, id_categoria, nombre, descripcion, precio, cantidad)
VALUES (2, 1, 'Producto Test Trigger', 'Descripción test', 100.00, 10);

-- Verificar que fecha_publicacion fue asignada
SELECT id_producto, fecha_publicacion FROM productos WHERE nombre = 'Producto Test Trigger';


-- 4. PRUEBA DE PROCEDIMIENTOS ALMACENADOS

-- Registrar venta completa
CALL registrar_venta_completa(1, 1, 2, 1999.98, 'debito', 'Av. Test 123');

-- Generar facturas mensuales
CALL generar_facturas_mensuales(2, 2025, 6);

-- Gestionar devolución aprobada con reembolso
CALL gestionar_devolucion(1, 'aprobada', TRUE);

-- Actualizar estados de ventas pendientes (plazo 7 días)
CALL actualizar_estados_ventas_pendientes(7);


-- 5. PRUEBA DE TRANSACCIONES SIMPLES

START TRANSACTION;
SELECT cantidad FROM productos WHERE id_producto = 1 FOR UPDATE;
INSERT INTO ventas (id_usuario, id_producto, cantidad, total, estado)
VALUES (1, 1, 3, 2999.97, 'pendiente');
SET @venta_id = LAST_INSERT_ID();
INSERT INTO pagos (id_venta, monto, metodo_pago, estado)
VALUES (@venta_id, 2999.97, 'credito', 'completado');
INSERT INTO envios (id_venta, direccion_envio)
VALUES (@venta_id, 'Calle Prueba 456');
UPDATE productos SET cantidad = cantidad - 3 WHERE id_producto = 1;
COMMIT;

