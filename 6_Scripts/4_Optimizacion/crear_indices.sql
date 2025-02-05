USE FERRETERIA;

-- Índices en Campos de Búsqueda Frecuente
CREATE INDEX idx_cedula ON personas(cedula);
SHOW INDEXES FROM personas;
DROP INDEX idx_cedula ON personas;

CREATE INDEX idx_productos_nombres ON productos(nombre);
SHOW INDEXES FROM productos;

CREATE INDEX idx_categoria ON categorias(nombre);
SHOW INDEXES FROM categorias;

-- Índices en Campos de compuestos
CREATE UNIQUE INDEX idx_persona_email ON personas(email);
SHOW INDEXES FROM personas;

-- Índices Compuestos para Consultas con Múltiples Condiciones
CREATE INDEX idx_detalle_venta ON detalle_venta (id_venta, id_producto);


