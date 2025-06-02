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

-- 1. Verificación de Disponibilidad de Stock
DELIMITER //
CREATE FUNCTION verificar_stock(id_prod INT, cantidad_solicitada INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE stock_actual INT;
    SELECT stock INTO stock_actual FROM productos WHERE id_producto = id_prod;
    RETURN (stock_actual >= cantidad_solicitada);
END //
DELIMITER ;

-- 2. Cálculo del Total Vendido por Vendedor
DELIMITER //
CREATE FUNCTION total_vendido_vendedor(id_ven INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT IFNULL(SUM(total),0) INTO total FROM ventas WHERE id_vendedor = id_ven AND estado = 'completada';
    RETURN total;
END //
DELIMITER ;

-- 3. Obtención del Promedio de Calificación de un Producto
DELIMITER //
CREATE FUNCTION promedio_calificacion(id_prod INT)
RETURNS DECIMAL(3,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(3,2);
    SELECT IFNULL(AVG(calificacion),0) INTO promedio
    FROM resenas_calificaciones rc
    JOIN ventas v ON rc.id_venta = v.id_venta
    WHERE v.id_producto = id_prod;
    RETURN promedio;
END //
DELIMITER ;

-- 4. Verificar Vigencia de Promoción
DELIMITER //
CREATE FUNCTION promocion_vigente(id_oferta INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE vigente BOOLEAN;
    SELECT (CURRENT_TIMESTAMP BETWEEN fecha_inicio AND fecha_fin) INTO vigente
    FROM ofertas_promociones WHERE id_oferta = id_oferta;
    RETURN vigente;
END //
DELIMITER ;


-- 1. Actualización Automática del Stock tras Venta
DELIMITER //
CREATE TRIGGER after_insert_venta
AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
    UPDATE productos
    SET stock = stock - NEW.cantidad
    WHERE id_producto = NEW.id_producto;
END //
DELIMITER ;

-- 2. Generación Automática de la Fecha de Publicación en Productos
DELIMITER //
CREATE TRIGGER before_insert_producto
BEFORE INSERT ON productos
FOR EACH ROW
BEGIN
    IF NEW.fecha_publicacion IS NULL THEN
        SET NEW.fecha_publicacion = CURRENT_TIMESTAMP;
    END IF;
END //
DELIMITER ;

-- 3. Cambio de Estado de Venta tras Confirmación de Pago
DELIMITER //
CREATE TRIGGER after_insert_pago
AFTER INSERT ON pagos
FOR EACH ROW
BEGIN
    IF NEW.estado = 'completado' THEN
        UPDATE ventas
        SET estado = 'completada'
        WHERE id_venta = NEW.id_venta;
    END IF;
END //
DELIMITER ;

-- 4. Registro Automático en Historial de Actividades
DELIMITER //
CREATE TRIGGER after_insert_venta_historial
AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
    INSERT INTO historial_actividades(id_usuario, actividad, fecha_actividad)
    VALUES (NEW.id_comprador, CONCAT('Realizó una compra, id_venta: ', NEW.id_venta), CURRENT_TIMESTAMP);
END //
DELIMITER ;


-- 1. Registro Completo de Venta con Pago y Envío
DELIMITER //
CREATE PROCEDURE registrar_venta_completa(
    IN p_id_comprador INT,
    IN p_id_vendedor INT,
    IN p_id_producto INT,
    IN p_cantidad INT,
    IN p_total DECIMAL(10,2),
    IN p_metodo_pago ENUM('tarjeta','transferencia','efectivo'),
    IN p_direccion_envio TEXT
)
BEGIN
    DECLARE v_id_venta INT;

    START TRANSACTION;

    -- Insertar venta
    INSERT INTO ventas(id_comprador, id_vendedor, id_producto, cantidad, total, estado)
    VALUES (p_id_comprador, p_id_vendedor, p_id_producto, p_cantidad, p_total, 'pendiente');
    SET v_id_venta = LAST_INSERT_ID();

    -- Insertar pago
    INSERT INTO pagos(id_venta, monto, metodo_pago, estado)
    VALUES (v_id_venta, p_total, p_metodo_pago, 'pendiente');

    -- Insertar envío
    INSERT INTO envios(id_venta, direccion_envio)
    VALUES (v_id_venta, p_direccion_envio);

    -- Actualizar stock
    UPDATE productos SET stock = stock - p_cantidad WHERE id_producto = p_id_producto;

    COMMIT;
END //
DELIMITER ;

-- 2. Generación Automática de Facturas Mensuales para Vendedores
DELIMITER //
CREATE PROCEDURE generar_facturas_mensuales(
    IN p_id_vendedor INT,
    IN p_anno INT,
    IN p_mes INT
)
BEGIN
    DECLARE v_total_mes DECIMAL(10,2);

    SELECT IFNULL(SUM(total), 0) INTO v_total_mes
    FROM ventas
    WHERE id_vendedor = p_id_vendedor
      AND estado = 'completada'
      AND YEAR(fecha_venta) = p_anno
      AND MONTH(fecha_venta) = p_mes;

    IF v_total_mes > 0 THEN
        INSERT INTO facturas(id_venta, monto_total, fecha_emision)
        SELECT id_venta, total, NOW()
        FROM ventas
        WHERE id_vendedor = p_id_vendedor
          AND estado = 'completada'
          AND YEAR(fecha_venta) = p_anno
          AND MONTH(fecha_venta) = p_mes;
    END IF;
END //
DELIMITER ;

-- 3. Gestión de Devoluciones y Reembolso
DELIMITER //
CREATE PROCEDURE gestionar_devolucion(
    IN p_id_devolucion INT,
    IN p_estado ENUM('pendiente', 'aprobada', 'rechazada')
)
BEGIN
    DECLARE v_id_venta INT;
    DECLARE v_id_producto INT;
    DECLARE v_cantidad INT;
    DECLARE v_id_comprador INT;

    START TRANSACTION;

    -- Actualizar estado de la devolución
    UPDATE devoluciones SET estado = p_estado WHERE id_devolucion = p_id_devolucion;

    IF p_estado = 'aprobada' THEN
        -- Obtener datos para reversión
        SELECT id_venta, id_producto, id_comprador
        INTO v_id_venta, v_id_producto, v_id_comprador
        FROM devoluciones WHERE id_devolucion = p_id_devolucion;

        -- Actualizar stock (aumentar)
        UPDATE productos SET stock = stock + 1 WHERE id_producto = v_id_producto;

        -- Registrar devolución en ventas (opcional: actualizar cantidad)
        UPDATE ventas SET cantidad = cantidad - 1 WHERE id_venta = v_id_venta AND id_producto = v_id_producto;

        -- Procesar reembolso (simplificado)
        INSERT INTO pagos(id_venta, monto, metodo_pago, estado)
        VALUES (v_id_venta, - (SELECT total FROM ventas WHERE id_venta = v_id_venta), 'efectivo', 'completado');
    END IF;

    COMMIT;
END //
DELIMITER ;

-- 4. Actualización Masiva de Estados de Ventas Pendientes
DELIMITER //
CREATE PROCEDURE cancelar_ventas_pendientes()
BEGIN
    START TRANSACTION;

    UPDATE ventas v
    LEFT JOIN pagos p ON v.id_venta = p.id_venta
    SET v.estado = 'cancelada'
    WHERE v.estado = 'pendiente'
      AND (p.estado IS NULL OR p.estado <> 'completado')
      AND v.fecha_venta < DATE_SUB(NOW(), INTERVAL 7 DAY);

    COMMIT;
END //
DELIMITER ;


# ----------------------------> 4.5
# 1
START TRANSACTION;

-- Insertar venta
INSERT INTO ventas (id_comprador, id_vendedor, id_producto, cantidad, total, estado)
VALUES (1, 2, 10, 1, 150.00, 'pendiente');

SET @id_venta = LAST_INSERT_ID();

-- Insertar pago
INSERT INTO pagos (id_venta, monto, metodo_pago, estado)
VALUES (@id_venta, 150.00, 'tarjeta', 'pendiente');

-- Insertar envío
INSERT INTO envios (id_venta, direccion_envio)
VALUES (@id_venta, 'Av. Comercio 123');

-- Actualizar stock
UPDATE productos SET stock = stock - 1 WHERE id_producto = 10;

COMMIT;

# 2
START TRANSACTION;

-- Actualizar estado de devolución
UPDATE devoluciones SET estado = 'aprobada' WHERE id_devolucion = 5;

-- Aumentar stock
UPDATE productos SET stock = stock + 1
WHERE id_producto = (SELECT id_producto FROM devoluciones WHERE id_devolucion = 5);

-- Reembolsar
INSERT INTO pagos (id_venta, monto, metodo_pago, estado)
VALUES (
  (SELECT id_venta FROM devoluciones WHERE id_devolucion = 5),
  -150.00, 'efectivo', 'completado'
);

COMMIT;

# 3
START TRANSACTION;

UPDATE ventas v
LEFT JOIN pagos p ON v.id_venta = p.id_venta
SET v.estado = 'cancelada'
WHERE v.estado = 'pendiente'
  AND (p.estado IS NULL OR p.estado <> 'completado')
  AND v.fecha_venta < DATE_SUB(NOW(), INTERVAL 7 DAY);

COMMIT;

# 4
START TRANSACTION;

INSERT INTO facturas (id_venta, monto_total)
SELECT id_venta, total
FROM ventas
WHERE id_vendedor = 2
  AND estado = 'completada'
  AND MONTH(fecha_venta) = MONTH(CURRENT_DATE());

COMMIT;
