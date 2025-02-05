-- INSERCION DE DATOS
USE FERRETERIA;

ALTER TABLE ciudades MODIFY COLUMN id INT AUTO_INCREMENT;
ALTER TABLE categorias MODIFY COLUMN id INT AUTO_INCREMENT;
ALTER TABLE sucursales MODIFY COLUMN id INT AUTO_INCREMENT;
ALTER TABLE marcas MODIFY COLUMN id INT AUTO_INCREMENT;
ALTER TABLE proveedores MODIFY COLUMN id INT AUTO_INCREMENT;
ALTER TABLE personas MODIFY COLUMN id INT AUTO_INCREMENT;
ALTER TABLE clientes MODIFY COLUMN id INT AUTO_INCREMENT;
ALTER TABLE empleados MODIFY COLUMN id INT AUTO_INCREMENT;
ALTER TABLE productos MODIFY COLUMN id INT AUTO_INCREMENT;
ALTER TABLE pedidos MODIFY COLUMN id INT AUTO_INCREMENT;
ALTER TABLE detalle_pedido MODIFY COLUMN id INT AUTO_INCREMENT;
ALTER TABLE ventas MODIFY COLUMN id INT AUTO_INCREMENT;
ALTER TABLE detalle_venta MODIFY COLUMN id INT AUTO_INCREMENT;
ALTER TABLE devoluciones MODIFY COLUMN id INT AUTO_INCREMENT;
ALTER TABLE usuarios MODIFY COLUMN id INT AUTO_INCREMENT;


-- Insertar datos en la tabla categorias
INSERT INTO categorias (nombre, descripcion) VALUES
('Herramientas manuales', 'Herramientas que no requieren electricidad para su funcionamiento'),
('Herramientas eléctricas', 'Herramientas que funcionan con electricidad'),
('Materiales de construcción', 'Materiales básicos para construcción y reparación'),
('Plomería', 'Artículos relacionados con sistemas de agua y desagüe'),
('Electricidad', 'Productos para instalaciones y reparaciones eléctricas'),
('Pintura', 'Pinturas, barnices y accesorios'),
('Jardinería', 'Herramientas y productos para el cuidado del jardín'),
('Seguridad', 'Equipos y accesorios de seguridad personal y del hogar'),
('Cliente frecuente', 'Clientes que compran regularmente'),
('Cliente ocasional', 'Clientes que compran esporádicamente'),
('Gerente', 'Puesto de gerencia'),
('Vendedor', 'Puesto de ventas'),
('Cajero', 'Puesto de caja'),
('Almacén', 'Departamento de almacén'),
('Ventas', 'Departamento de ventas'),
('Administración', 'Departamento administrativo');

-- Insertar datos en la tabla ciudades
INSERT INTO ciudades (nombre) VALUES
('Quito'),
('Guayaquil'),
('Cuenca'),
('Ambato'),
('Manta');

-- Insertar datos en la tabla sucursales
INSERT INTO sucursales (nombre, telefono, id_ciudad) VALUES
('Ferretería Central Quito', 022345678, 1),
('Ferretería Norte Guayaquil', 042345678, 2),
('Ferretería Sur Cuenca', 072345678, 3),
('Ferretería Este Ambato', 032345678, 4),
('Ferretería Oeste Manta', 052345678, 5);

-- Insertar datos en la tabla marcas
INSERT INTO marcas (nombre, pais_origen) VALUES
('DeWalt', 'Estados Unidos'),
('Bosch', 'Alemania'),
('Stanley', 'Estados Unidos'),
('Truper', 'México'),
('3M', 'Estados Unidos'),
('Sika', 'Suiza'),
('Pintuco', 'Colombia'),
('Edesa', 'Ecuador');

-- Insertar datos en la tabla proveedores
INSERT INTO proveedores (nombre, direccion, telefono, email) VALUES
('Distribuidora Nacional S.A.', 'Av. 10 de Agosto N34-45, Quito', 022567890, 'ventas@disnacional.com'),
('Importadora del Pacífico', 'Av. 9 de Octubre 123, Guayaquil', 042678901, 'pedidos@impacífico.com'),
('Materiales Ecuador', 'Calle Larga 67-89, Cuenca', 072789012, 'info@matecuador.com'),
('Herramientas y Más', 'Av. Cevallos 456, Ambato', 032890123, 'ventas@herramientasymas.com'),
('Ferretería Mayorista', 'Av. 4 de Noviembre 789, Manta', 052901234, 'mayorista@ferreteriamayor.com');

-- Insertar datos en la tabla personas
INSERT INTO personas (nombre, apellido_paterno, apellido_materno, cedula, fecha_nacimiento, direccion, telefono, email) VALUES
('Juan', 'Pérez', 'Gómez', 1712345678, '1985-05-15', 'Calle A N45-67, Quito', 0991234567, 'juan.perez@email.com'),
('María', 'López', 'Rodríguez', 0923456789, '1990-08-22', 'Av. B 123, Guayaquil', 0982345678, 'maria.lopez@email.com'),
('Carlos', 'Martínez', 'Vargas', 0103456789, '1988-03-10', 'Calle C 456, Cuenca', 0973456789, 'carlos.martinez@email.com'),
('Ana', 'García', 'Flores', 1803456789, '1992-11-30', 'Av. D 789, Ambato', 0964567890, 'ana.garcia@email.com'),
('Luis', 'Sánchez', 'Mora', 1303456789, '1987-07-05', 'Calle E 012, Manta', 0955678901, 'luis.sanchez@email.com'),
('Elena', 'Ramírez', 'Castro', 1712345679, '1995-02-18', 'Av. F 345, Quito', 0946789012, 'elena.ramirez@email.com'),
('Pedro', 'González', 'Díaz', 0923456790, '1989-09-25', 'Calle G 678, Guayaquil', 0937890123, 'pedro.gonzalez@email.com'),
('Laura', 'Hernández', 'Ruiz', 0103456790, '1993-06-12', 'Av. H 901, Cuenca', 0928901234, 'laura.hernandez@email.com'),
('Miguel', 'Torres', 'Lara', 1803456790, '1986-12-08', 'Calle I 234, Ambato', 0919012345, 'miguel.torres@email.com'),
('Sofía', 'Mendoza', 'Paredes', 1303456790, '1991-04-20', 'Av. J 567, Manta', 0910123456, 'sofia.mendoza@email.com');

-- Insertar datos en la tabla clientes
INSERT INTO clientes (id_persona, fecha_registro, id_tipoCliente) VALUES
(1, '2022-01-15', 9),
(2, '2022-02-20', 10),
(3, '2022-03-10', 9),
(4, '2022-04-05', 10),
(5, '2022-05-22', 9);

-- Insertar datos en la tabla empleados
INSERT INTO empleados (id_persona, id_puesto, id_departamento, id_sucursal, fecha_contrato, salario) VALUES
(6, 11, 16, 1, '2021-01-10', 2000.00),
(7, 12, 15, 2, '2021-02-15', 800.00),
(8, 13, 15, 3, '2021-03-20', 600.00),
(9, 12, 15, 4, '2021-04-25', 800.00),
(10, 13, 15, 5, '2021-05-30', 600.00);

-- Insertar datos en la tabla productos
INSERT INTO productos (nombre, descripcion, precio, stock, id_categoria, id_marca, id_proveedor) VALUES
('Martillo de carpintero', 'Martillo de acero con mango de madera', 15.99, 100, 1, 3, 1),
('Taladro eléctrico', 'Taladro percutor de 750W', 89.99, 50, 2, 1, 2),
('Cemento gris 50kg', 'Saco de cemento Portland tipo I', 7.50, 200, 3, 6, 3),
('Tubo PVC 1/2 pulgada', 'Tubo de PVC para agua fría, 3 metros', 3.25, 150, 4, 8, 4),
('Cable eléctrico 12 AWG', 'Rollo de 100 metros, color negro', 45.00, 30, 5, 5, 5),
('Pintura látex blanca', 'Balde de 4 litros, acabado mate', 18.75, 80, 6, 7, 1),
('Pala de jardín', 'Pala con mango de madera', 12.50, 60, 7, 4, 2),
('Casco de seguridad', 'Casco de polietileno con suspensión ajustable', 8.99, 40, 8, 5, 3);

-- Insertar datos en la tabla pedidos
INSERT INTO pedidos (fecha_compra, fecha_entrega, codigo_factura, total, id_proveedor, id_sucursal) VALUES
('2023-01-05', '2023-01-10', 'PED-001', 1500.00, 1, 1),
('2023-02-10', '2023-02-15', 'PED-002', 2000.00, 2, 2),
('2023-03-15', '2023-03-20', 'PED-003', 1800.00, 3, 3),
('2023-04-20', '2023-04-25', 'PED-004', 2200.00, 4, 4),
('2023-05-25', '2023-05-30', 'PED-005', 1700.00, 5, 5);

-- Insertar datos en la tabla detalle_pedido
INSERT INTO detalle_pedido (id_pedido, id_producto, stock, precio_unitario, precio_total) VALUES
(1, 1, 50, 12.00, 600.00),
(1, 2, 20, 75.00, 1500.00),
(2, 3, 100, 6.00, 600.00),
(2, 4, 200, 2.50, 500.00),
(3, 5, 10, 40.00, 400.00),
(3, 6, 40, 15.00, 600.00),
(4, 7, 30, 10.00, 300.00),
(4, 8, 50, 7.00, 350.00),
(5, 1, 30, 12.00, 360.00),
(5, 5, 15, 40.00, 600.00);

-- Insertar datos en la tabla ventas
INSERT INTO ventas (id_cliente, id_empleado, id_sucursal, fecha_venta, total) VALUES
(1, 2, 1, '2023-06-01', 150.75),
(2, 3, 2, '2023-06-02', 89.99),
(3, 4, 3, '2023-06-03', 37.50),
(4, 5, 4, '2023-06-04', 65.00),
(5, 2, 5, '2023-06-05', 112.50);

-- Insertar datos en la tabla detalle_venta
INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, precio_total) VALUES
(1, 1, 2, 15.99, 31.98),
(1, 6, 1, 18.75, 18.75),
(2, 2, 1, 89.99, 89.99),
(3, 3, 5, 7.50, 37.50),
(4, 4, 20, 3.25, 65.00),
(5, 7, 3, 12.50, 37.50),
(5, 8, 5, 8.99, 44.95);

-- Insertar datos en la tabla devoluciones
INSERT INTO devoluciones (id_venta, id_producto, fecha_devolucion, motivo) VALUES
(1, 1, '2023-06-03', 'Producto defectuoso'),
(3, 3, '2023-06-05', 'Error en el pedido'),
(5, 8, '2023-06-07', 'Tamaño incorrecto');

-- Insertar datos en la tabla usuarios
INSERT INTO usuarios (nameUser, password, id_empleado) VALUES
('jperez', 'contraseña123', 1),
('mlopez', 'segura456', 2),
('cmartinez', 'acceso789', 3),
('agarcia', 'clave2023', 4),
('lsanchez', 'usuario555', 5);

SELECT * FROM USUARIOS;


