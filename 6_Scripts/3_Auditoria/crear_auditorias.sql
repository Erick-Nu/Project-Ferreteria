USE FERRETERIA;

-- Auditorias unitarias

-- Tabla Personas auditorias CRUD

/*  AUDITORIA AL INGRESAR UNA PERSONA */
CREATE TABLE auditoria_personas_insert (
    id INT AUTO_INCREMENT PRIMARY KEY,
    persona_id INT,
    accion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    usuario VARCHAR(50)
);

DELIMITER $$

CREATE TRIGGER insert_persona_after
AFTER INSERT ON personas
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_personas_insert(persona_id, accion, descripcion, usuario)
    VALUES(NEW.id, 'INSERT', CONCAT('Nueva persona: ID ', NEW.id, ', Nombre: ', NEW.nombre, ' ', NEW.apellido_paterno), USER());
END$$

DELIMITER ;

/*  AUDITORIA AL ACTUALIAZAR UNA PERSONA */

CREATE TABLE auditoria_personas_update (
    id INT AUTO_INCREMENT PRIMARY KEY,
    persona_id INT,
    accion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    usuario VARCHAR(50)
);

DELIMITER $$

CREATE TRIGGER update_persona_after
AFTER UPDATE ON personas
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_personas_update(persona_id, accion, descripcion, usuario)
    VALUES(NEW.id, 'UPDATE', CONCAT('Actualización de persona: ID ', NEW.id, ', Nombre: ', NEW.nombre, ' ', NEW.apellido_paterno), USER());
END$$

DELIMITER ;

/*  AUDITORIA AL ELIMINAR UNA PERSONA */

CREATE TABLE auditoria_personas_delete (
    id INT AUTO_INCREMENT PRIMARY KEY,
    persona_id INT,
    accion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    usuario VARCHAR(50)
);

DELIMITER $$

CREATE TRIGGER delete_persona_after
BEFORE DELETE ON personas
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_personas_delete(persona_id, accion, descripcion, usuario)
    VALUES(OLD.id, 'DELETE', CONCAT('Persona eliminada: ID ', OLD.id, ', Nombre: ', OLD.nombre, ' ', OLD.apellido_paterno), USER());
END$$

DELIMITER ;

-- Tabla Clientes

-- Auditoría para la tabla clientes

/*  AUDITORIA AL INSERTAR UN CLIENTE */
CREATE TABLE auditoria_clientes_insert (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    accion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    usuario VARCHAR(50)
);

DELIMITER $$
CREATE TRIGGER insert_cliente_after
AFTER INSERT ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_clientes_insert(cliente_id, accion, descripcion, usuario)
    VALUES(NEW.id, 'INSERT', CONCAT('Nuevo cliente: ID ', NEW.id, ', ID Persona: ', NEW.id_persona), USER());
END$$
DELIMITER ;

/*  AUDITORIA AL ACTUALIZAR UN CLIENTE */
CREATE TABLE auditoria_clientes_update (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    accion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    usuario VARCHAR(50)
);

DELIMITER $$
CREATE TRIGGER update_cliente_after
AFTER UPDATE ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_clientes_update(cliente_id, accion, descripcion, usuario)
    VALUES(NEW.id, 'UPDATE', CONCAT('Cliente actualizado: ID ', NEW.id, ', ID Persona: ', NEW.id_persona), USER());
END$$
DELIMITER ;

/*  AUDITORIA AL ELIMINAR UN CLIENTE */
CREATE TABLE auditoria_clientes_delete (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    accion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    usuario VARCHAR(50)
);

DELIMITER $$
CREATE TRIGGER delete_cliente_before
BEFORE DELETE ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_clientes_delete(cliente_id, accion, descripcion, usuario)
    VALUES(OLD.id, 'DELETE', CONCAT('Cliente eliminado: ID ', OLD.id, ', ID Persona: ', OLD.id_persona), USER());
END$$
DELIMITER ;

-- Auditoría para la tabla empleados

/* AUDITORIA AL ingresar un empleado */
CREATE TABLE auditoria_empleados_insert (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empleado_id INT,
    accion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    usuario VARCHAR(50)
);

DELIMITER $$
CREATE TRIGGER insert_empleado_after
AFTER INSERT ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_empleados_insert(empleado_id, accion, descripcion, usuario)
    VALUES(NEW.id, 'INSERT', CONCAT('Nuevo empleado: ID ', NEW.id, ', ID Persona: ', NEW.id_persona), USER());
END$$
DELIMITER ;

/* AUDITORIA AL ACTUALIZAR UN EMPLEADO */
CREATE TABLE auditoria_empleados_update (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empleado_id INT,
    accion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    usuario VARCHAR(50)
);

DELIMITER $$
CREATE TRIGGER update_empleado_after
AFTER UPDATE ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_empleados_update(empleado_id, accion, descripcion, usuario)
    VALUES(NEW.id, 'UPDATE', CONCAT('Empleado actualizado: ID ', NEW.id, ', ID Persona: ', NEW.id_persona), USER());
END$$
DELIMITER ;

/* AUDITORIA AL ELIMINAR UN EMPLEADO */
CREATE TABLE auditoria_empleados_delete (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empleado_id INT,
    accion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    usuario VARCHAR(50)
);

DELIMITER $$
CREATE TRIGGER delete_empleado_before
BEFORE DELETE ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_empleados_delete(empleado_id, accion, descripcion, usuario)
    VALUES(OLD.id, 'DELETE', CONCAT('Empleado eliminado: ID ', OLD.id, ', ID Persona: ', OLD.id_persona), USER());
END$$
DELIMITER ;


-- Tabla Productos auditorias CRUD

/* AUDITORIA AL INGRESAR UN PRODUCTO */
CREATE TABLE auditoria_productos_insert (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT,
    accion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    usuario VARCHAR(50)
);

DELIMITER $$

CREATE TRIGGER insert_producto_after
AFTER INSERT ON productos
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_productos_insert(producto_id, accion, descripcion, usuario)
    VALUES(NEW.id, 'INSERT', CONCAT('Nuevo producto: ID ', NEW.id, ', Nombre: ', NEW.nombre, ', Precio: ', NEW.precio), USER());
END$$

DELIMITER ;

/* AUDITORIA AL ACTUALIZAR UN PRODUCTO */
CREATE TABLE auditoria_productos_update (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT,
    accion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    usuario VARCHAR(50)
);

DELIMITER $$

CREATE TRIGGER update_producto_after
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_productos_update(producto_id, accion, descripcion, usuario)
    VALUES(NEW.id, 'UPDATE', CONCAT('Actualización de producto: ID ', NEW.id, 
                                    ', Nombre: ', NEW.nombre, 
                                    ', Precio anterior: ', OLD.precio, 
                                    ', Precio nuevo: ', NEW.precio), USER());
END$$

DELIMITER ;

/* AUDITORIA AL ELIMINAR UN PRODUCTO */
CREATE TABLE auditoria_productos_delete (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT,
    accion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    usuario VARCHAR(50)
);

DELIMITER $$

CREATE TRIGGER delete_producto_after
BEFORE DELETE ON productos
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_productos_delete(producto_id, accion, descripcion, usuario)
    VALUES(OLD.id, 'DELETE', CONCAT('Producto eliminado: ID ', OLD.id, ', Nombre: ', OLD.nombre, ', Precio: ', OLD.precio), USER());
END$$

DELIMITER ;

-- Auditorias Generales

--  Auditoría de ventas
CREATE TABLE auditoria_ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    venta_id INT,
    accion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    usuario VARCHAR(50)
);

DELIMITER $$
CREATE TRIGGER insert_venta_after
AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_ventas(venta_id, accion, descripcion, usuario)
    VALUES(NEW.id, 'INSERT', CONCAT('Nueva venta registrada: ', 
                                    'Cliente: ', NEW.id_cliente, ', ',
                                    'Total: ', NEW.total), USER());
END$$
DELIMITER ;

--  Auditoría de nuevos pedidos
CREATE TABLE auditoria_pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    accion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    usuario VARCHAR(50)
);

DELIMITER $$
CREATE TRIGGER insert_pedido_after
AFTER INSERT ON pedidos
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_pedidos(pedido_id, accion, descripcion, usuario)
    VALUES(NEW.id, 'INSERT', CONCAT('Nuevo pedido: ', 
                                    'Proveedor: ', NEW.id_proveedor, ', ',
                                    'Total: ', NEW.total), USER());
END$$
DELIMITER ;

--  Auditoría de cambios en proveedores
CREATE TABLE auditoria_proveedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    proveedor_id INT,
    accion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    usuario VARCHAR(50)
);

DELIMITER $$
CREATE TRIGGER update_proveedor_after
AFTER UPDATE ON proveedores
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_proveedores(proveedor_id, accion, descripcion, usuario)
    VALUES(OLD.id, 'UPDATE', CONCAT('Cambio en proveedor: ', 
                                    'Nombre: ', OLD.nombre, ' -> ', NEW.nombre, ', ',
                                    'Teléfono: ', OLD.telefono, ' -> ', NEW.telefono), USER());
END$$
DELIMITER ;

--  Auditoría de nuevas categorías
CREATE TABLE auditoria_categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    categoria_id INT,
    accion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    usuario VARCHAR(50)
);

DELIMITER $$
CREATE TRIGGER insert_categoria_after
AFTER INSERT ON categorias
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_categorias(categoria_id, accion, descripcion, usuario)
    VALUES(NEW.id, 'INSERT', CONCAT('Nueva categoría: ', NEW.nombre), USER());
END$$
DELIMITER ;

-- Auditoría de cambios en sucursales
CREATE TABLE auditoria_sucursales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sucursal_id INT,
    accion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    usuario VARCHAR(50)
);

DELIMITER $$
CREATE TRIGGER update_sucursal_after
AFTER UPDATE ON sucursales
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_sucursales(sucursal_id, accion, descripcion, usuario)
    VALUES(OLD.id, 'UPDATE', CONCAT('Cambio en sucursal: ', 
                                    'Nombre: ', OLD.nombre, ' -> ', NEW.nombre, ', ',
                                    'Teléfono: ', OLD.telefono, ' -> ', NEW.telefono), USER());
END$$
DELIMITER ;

--  Auditoría de nuevos usuarios
CREATE TABLE auditoria_usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    accion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    usuario VARCHAR(50)
);

DELIMITER $$
CREATE TRIGGER insert_usuario_after
AFTER INSERT ON usuarios
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_usuarios(usuario_id, accion, descripcion, usuario)
    VALUES(NEW.id, 'INSERT', CONCAT('Nuevo usuario: ', NEW.nameUser), USER());
END$$
DELIMITER ;

-- Auditoría de cambios en marcas
CREATE TABLE auditoria_marcas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    marca_id INT,
    accion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    usuario VARCHAR(50)
);

DELIMITER $$
CREATE TRIGGER update_marca_after
AFTER UPDATE ON marcas
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_marcas(marca_id, accion, descripcion, usuario)
    VALUES(OLD.id, 'UPDATE', CONCAT('Cambio en marca: ', 
                                    'Nombre: ', OLD.nombre, ' -> ', NEW.nombre, ', ',
                                    'País: ', OLD.pais_origen, ' -> ', NEW.pais_origen), USER());
END$$
DELIMITER ;

-- Auditoría de devoluciones
CREATE TABLE auditoria_devoluciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    devolucion_id INT,
    accion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    usuario VARCHAR(50)
);

DELIMITER $$
CREATE TRIGGER insert_devolucion_after
AFTER INSERT ON devoluciones
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_devoluciones(devolucion_id, accion, descripcion, usuario)
    VALUES(NEW.id, 'INSERT', CONCAT('Nueva devolución: Venta ID ', NEW.id_venta, ', Producto ID ', NEW.id_producto), USER());
END$$
DELIMITER ;

-- Verificar las tablas de auditoría creadas
SHOW TABLES LIKE 'auditoria%';



