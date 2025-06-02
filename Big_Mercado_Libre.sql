-- Creación de la Base de Datos
CREATE DATABASE mercado_libre;
USE mercado_libre;

-- 1. Tabla de Usuarios
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) UNIQUE NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    contrasena VARCHAR(255) NOT NULL,
    tipo_usuario ENUM('comprador', 'vendedor', 'ambos') NOT NULL,
    INDEX(email)  -- Índice en el campo email para búsquedas rápidas
);

-- 2. Tabla de Vendedores
CREATE TABLE vendedores (
    id_vendedor INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    INDEX(id_usuario)  -- Índice en id_usuario para agilizar búsquedas de vendedores por usuario
);

-- 3. Tabla de Categorías
CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    INDEX(nombre)  -- Índice en nombre de categoría para búsquedas rápidas
);

-- 4. Tabla de Productos
CREATE TABLE productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    id_vendedor INT,
    id_categoria INT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    cantidad INT NOT NULL,
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    INDEX(id_vendedor),  -- Índice en id_vendedor para consultas por vendedor
    INDEX(id_categoria),  -- Índice en id_categoria para consultas por categoría
    INDEX(nombre)  -- Índice en nombre para búsquedas rápidas
);

-- 5. Tabla de Ventas
CREATE TABLE ventas (
    id_venta INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    id_producto INT,
    cantidad INT NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    INDEX(id_usuario),  -- Índice en id_usuario para consultas por usuario
    INDEX(id_producto)  -- Índice en id_producto para consultas por producto
);

-- 6. Tabla de Pagos 
CREATE TABLE pagos (
    id_pago INT PRIMARY KEY AUTO_INCREMENT,
    id_venta INT,
    monto DECIMAL(10, 2) NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metodo_pago ENUM('debito', 'credito', 'transferencia') NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    INDEX(id_venta),  -- Índice en id_venta para consultas por venta
    INDEX(metodo_pago)  -- Índice en metodo_pago para consultas por tipo de pago
);


-- 7. Tabla de Envíos
CREATE TABLE envios (
    id_envio INT PRIMARY KEY AUTO_INCREMENT,
    id_venta INT,
    direccion_envio TEXT NOT NULL,
    fecha_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    INDEX(id_venta)  -- Índice en id_venta para consultas por venta
);

-- 8. Tabla de Reseñas y Calificaciones
CREATE TABLE resenas_calificaciones (
    id_resena INT PRIMARY KEY AUTO_INCREMENT,
    id_venta INT,
    calificacion INT,
    comentario TEXT,
    fecha_resena TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    INDEX(id_venta),  -- Índice en id_venta para consultas por venta
    INDEX(calificacion)  -- Índice en calificacion para búsquedas por calificación
);

-- 9. Tabla de Carrito de Compras
CREATE TABLE carrito (
    id_carrito INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    id_producto INT,
    cantidad INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    INDEX(id_usuario),  -- Índice en id_usuario para consultas por usuario
    INDEX(id_producto)  -- Índice en id_producto para consultas por producto
);

-- 10. Tabla de Ofertas y Promociones
CREATE TABLE ofertas_promociones (
    id_oferta INT PRIMARY KEY AUTO_INCREMENT,
    id_producto INT,
    descuento DECIMAL(5, 2),
    fecha_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_fin TIMESTAMP,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    INDEX(id_producto)  -- Índice en id_producto para búsquedas de promociones por producto
);

-- 11. Tabla de Mensajes
CREATE TABLE mensajes (
    id_mensaje INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    id_vendedor INT,
    mensaje TEXT,
    fecha_mensaje TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_vendedor) REFERENCES usuarios(id_usuario),
    INDEX(id_usuario),  -- Índice en id_usuario para consultas por usuario
    INDEX(id_vendedor)  -- Índice en id_vendedor para consultas por vendedor
);

-- 12. Tabla de Historial de Actividades
CREATE TABLE historial_actividades (
    id_actividad INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    actividad TEXT,
    fecha_actividad TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    INDEX(id_usuario)  -- Índice en id_usuario para consultas por usuario
);

-- 13. Tabla de Devoluciones
CREATE TABLE devoluciones (
    id_devolucion INT PRIMARY KEY AUTO_INCREMENT,
    id_venta INT,
    id_producto INT,
    id_comprador INT,
    motivo TEXT,
    estado ENUM('pendiente', 'aprobada', 'rechazada') NOT NULL,
    fecha_devolucion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_comprador) REFERENCES usuarios(id_usuario),
    INDEX(id_venta),  -- Índice en id_venta para consultas por venta
    INDEX(id_producto),  -- Índice en id_producto para consultas por producto
    INDEX(id_comprador)  -- Índice en id_comprador para consultas por comprador
);

-- 14. Tabla de Direcciones
CREATE TABLE direcciones (
    id_direccion INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    direccion TEXT,
    ciudad VARCHAR(100),
    provincia VARCHAR(100),
    pais VARCHAR(100),
    codigo_postal VARCHAR(20),
    tipo ENUM('envio', 'facturacion') NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    INDEX(id_usuario)  -- Índice en id_usuario para consultas por usuario
);

-- 15. Tabla de Facturas
CREATE TABLE facturas (
    id_factura INT PRIMARY KEY AUTO_INCREMENT,
    id_venta INT,
    monto_total DECIMAL(10, 2),
    fecha_emision TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    INDEX(id_venta)  -- Índice en id_venta para consultas por venta
);