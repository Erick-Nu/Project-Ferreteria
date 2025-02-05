USE FERRETERIA;

-- 1. Vista de información completa de clientes
CREATE VIEW v_info_clientes AS
SELECT c.id, p.nombre, p.apellido_paterno, p.apellido_materno, p.cedula, p.telefono, p.email, c.fecha_registro, cat.nombre AS tipo_cliente
FROM clientes c
JOIN personas p ON c.id_persona = p.id
JOIN categorias cat ON c.id_tipoCliente = cat.id;

-- Verificacion de la vista
SELECT * FROM v_info_clientes;

-- 2. Vista de empleados con información detallada
CREATE VIEW v_info_empleados AS
SELECT e.id, p.nombre, p.apellido_paterno, p.apellido_materno, p.cedula, p.telefono, p.email, 
       cat_puesto.nombre AS puesto, cat_dep.nombre AS departamento, s.nombre AS sucursal, e.fecha_contrato, e.salario
FROM empleados e
JOIN personas p ON e.id_persona = p.id
JOIN categorias cat_puesto ON e.id_puesto = cat_puesto.id
JOIN categorias cat_dep ON e.id_departamento = cat_dep.id
JOIN sucursales s ON e.id_sucursal = s.id;

-- Verificacion de la vista
SELECT * FROM v_info_empleados;

-- 3. Vista de productos con detalles
CREATE VIEW v_info_productos AS
SELECT p.id, p.nombre, p.descripcion, p.precio, p.stock, c.nombre AS categoria, m.nombre AS marca, prov.nombre AS proveedor
FROM productos p 
JOIN categorias c ON p.id_categoria = c.id
JOIN marcas m ON p.id_marca = m.id
JOIN proveedores prov ON p.id_proveedor = prov.id
ORDER BY p.id asc;

-- Verificacion de la vista
SELECT * FROM v_info_productos;

-- 4. Vista de ventas detalladas
CREATE VIEW v_ventas_detalladas AS
SELECT v.id, v.fecha_venta, v.total, 
       CONCAT(pc.nombre, ' ', pc.apellido_paterno) AS cliente,
       CONCAT(pe.nombre, ' ', pe.apellido_paterno) AS empleado,
       s.nombre AS sucursal
FROM ventas v
JOIN clientes c ON v.id_cliente = c.id
JOIN personas pc ON c.id_persona = pc.id
JOIN empleados e ON v.id_empleado = e.id
JOIN personas pe ON e.id_persona = pe.id
JOIN sucursales s ON v.id_sucursal = s.id;

-- Verificacion de la vista
SELECT * FROM v_ventas_detalladas;

-- 5. Vista de inventario actual
CREATE VIEW v_inventario_actual AS
SELECT p.id, p.nombre, p.stock, p.precio, c.nombre AS categoria
FROM productos p
JOIN categorias c ON p.id_categoria = c.id;

-- Verificacion de la vista
SELECT * FROM v_inventario_actual;

-- 6. Vista de productos más vendidos
CREATE VIEW v_productos_mas_vendidos AS
SELECT p.id, p.nombre, SUM(dv.cantidad) AS total_vendido
FROM productos p
JOIN detalle_venta dv ON p.id = dv.id_producto
GROUP BY p.id, p.nombre
ORDER BY total_vendido DESC;

-- Verificacion de la vista
SELECT * FROM v_productos_mas_vendidos;

-- 7. Vista de ventas por sucursal
CREATE VIEW v_ventas_por_sucursal AS
SELECT s.id, s.nombre, COUNT(v.id) AS total_ventas, SUM(v.total) AS monto_total
FROM sucursales s
LEFT JOIN ventas v ON s.id = v.id_sucursal
GROUP BY s.id, s.nombre;

-- Verificacion de la vista
SELECT * FROM v_ventas_por_sucursal;

-- 8. Vista de proveedores y sus productos
CREATE VIEW v_proveedores_productos AS
SELECT prov.id, prov.nombre AS proveedor, p.nombre AS producto, p.stock
FROM proveedores prov
JOIN productos p ON prov.id = p.id_proveedor;

-- Verificacion de la vista
SELECT * FROM v_proveedores_productos;

-- 9. Vista de clientes frecuentes
CREATE VIEW v_clientes_frecuentes AS
SELECT c.id, CONCAT(p.nombre, ' ', p.apellido_paterno) AS cliente, COUNT(v.id) AS total_compras
FROM clientes c
JOIN personas p ON c.id_persona = p.id
LEFT JOIN ventas v ON c.id = v.id_cliente
GROUP BY c.id, cliente
ORDER BY total_compras DESC;

-- Verificacion de la vista
SELECT * FROM v_clientes_frecuentes;

-- 10. Vista de productos por categoría
CREATE VIEW v_productos_por_categoria AS
SELECT c.id, c.nombre AS categoria, COUNT(p.id) AS total_productos
FROM categorias c
LEFT JOIN productos p ON c.id = p.id_categoria
GROUP BY c.id, c.nombre;

-- Verificacion de la vista
SELECT * FROM v_productos_por_categoria;

-- 11. Vista de empleados por departamento
CREATE VIEW v_empleados_por_departamento AS
SELECT c.id, c.nombre AS departamento, COUNT(e.id) AS total_empleados
FROM categorias c
LEFT JOIN empleados e ON c.id = e.id_departamento
GROUP BY c.id, c.nombre;

-- Verificacion de la vista
SELECT * FROM v_empleados_por_departamento;


-- 12. Vista de productos con bajo stock
CREATE VIEW v_productos_bajo_stock AS
SELECT id, nombre, stock, precio
FROM productos
WHERE stock < 100;

DROP VIEW v_productos_bajo_stock;

-- Verificacion de la vista
SELECT * FROM v_productos_bajo_stock;

-- 13. Vista de devoluciones con detalles
CREATE VIEW v_devoluciones_detalladas AS
SELECT d.id, d.fecha_devolucion, p.nombre AS producto, v.total AS monto_venta, d.motivo
FROM devoluciones d
JOIN productos p ON d.id_producto = p.id
JOIN ventas v ON d.id_venta = v.id;

-- Verificacion de la vista
SELECT * FROM v_devoluciones_detalladas;

-- 14. Vista de productos por marca
CREATE VIEW v_productos_por_marca AS
SELECT m.id, m.nombre AS marca, COUNT(p.id) AS total_productos
FROM marcas m
LEFT JOIN productos p ON m.id = p.id_marca
GROUP BY m.id, m.nombre;

-- Verificacion de la vista
SELECT * FROM v_productos_por_marca;


-- 15. Vista de productos más devueltos
CREATE VIEW v_productos_mas_devueltos AS
SELECT p.id, p.nombre, COUNT(d.id) AS total_devoluciones
FROM productos p
JOIN devoluciones d ON p.id = d.id_producto
GROUP BY p.id, p.nombre
ORDER BY total_devoluciones DESC;

-- Verificacion de la vista
SELECT * FROM v_productos_mas_devueltos;

-- 16. Vista de empleados por sucursal
CREATE VIEW v_empleados_por_sucursal AS
SELECT s.id, s.nombre AS sucursal, COUNT(e.id) AS total_empleados
FROM sucursales s
LEFT JOIN empleados e ON s.id = e.id_sucursal
GROUP BY s.id, s.nombre;

-- Verificacion de la vista
SELECT * FROM v_empleados_por_sucursal;


-- 17. Vista de ventas por categoría de producto
CREATE VIEW v_ventas_por_categoria AS
SELECT c.id, c.nombre AS categoria, COUNT(dv.id) AS total_ventas, SUM(dv.precio_total) AS monto_total
FROM categorias c
JOIN productos p ON c.id = p.id_categoria
JOIN detalle_venta dv ON p.id = dv.id_producto
GROUP BY c.id, c.nombre
ORDER BY monto_total DESC;

-- Verificacion de la vista
SELECT * FROM v_ventas_por_categoria;
