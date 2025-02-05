USE ferreteria;

--------------------------------------------

/* FUNCIONES PARA LA TABLA CLIENTES */

--------------------------------------------

-- Agregar un nuevo cliente

DELIMITER $$
CREATE PROCEDURE agregar_cliente(
    IN p_nombre VARCHAR(45),
    IN p_apellido_paterno VARCHAR(45),
    IN p_apellido_materno VARCHAR(45),
    IN p_cedula INT,
    IN p_fecha_nacimiento DATE,
    IN p_direccion MEDIUMTEXT,
    IN p_telefono INT,
    IN p_email VARCHAR(50),
    IN p_id_tipoCliente INT
)
BEGIN
    DECLARE v_id_persona INT;
    
    -- Insert into personas table
    INSERT INTO personas (nombre, apellido_paterno, apellido_materno, cedula, fecha_nacimiento, direccion, telefono, email)
    VALUES (p_nombre, p_apellido_paterno, p_apellido_materno, p_cedula, p_fecha_nacimiento, p_direccion, p_telefono, p_email);
    
    -- obtenemos el ultimo id generado automaticamente
    SET v_id_persona = LAST_INSERT_ID();
    
    -- Insert into clientes table
    INSERT INTO clientes (id_persona, fecha_registro, id_tipoCliente)
    VALUES (v_id_persona, CURDATE(), p_id_tipoCliente);
END $$
DELIMITER ;

/*
CALL agregar_cliente(
    'Juan',               -- p_nombre
    'Pérez',              -- p_apellido_paterno
    'Gómez',              -- p_apellido_materno
    12345678,             -- p_cedula
    '1990-05-15',         -- p_fecha_nacimiento
    'Av. Siempre Viva 123', -- p_direccion
    987654321,            -- p_telefono
    'juan.perez@email.com', -- p_email
    2                     -- p_id_tipoCliente
);
*/

-- Actualizar Cliente

DELIMITER $$

CREATE PROCEDURE actualizar_cliente(
    IN p_cedula INT,                
    IN p_nombre VARCHAR(45),
    IN p_apellido_paterno VARCHAR(45),
    IN p_apellido_materno VARCHAR(45),
    IN p_fecha_nacimiento DATE,
    IN p_direccion MEDIUMTEXT,
    IN p_telefono INT,
    IN p_email VARCHAR(50),
    IN p_id_tipoCliente INT
)
BEGIN
    DECLARE v_id_persona INT;
    
    -- Get the id_persona for the client using the cedula
    SELECT id_persona INTO v_id_persona 
    FROM clientes 
    WHERE id_persona IN (SELECT id_persona FROM personas WHERE cedula = p_cedula);
    
    -- Check if client exists
    IF v_id_persona IS NOT NULL THEN
        -- Update personas table
        UPDATE personas
        SET nombre = p_nombre,
            apellido_paterno = p_apellido_paterno,
            apellido_materno = p_apellido_materno,
            cedula = p_cedula,
            fecha_nacimiento = p_fecha_nacimiento,
            direccion = p_direccion,
            telefono = p_telefono,
            email = p_email
        WHERE id = v_id_persona;
        
        -- Update clientes table
        UPDATE clientes
        SET id_tipoCliente = p_id_tipoCliente
        WHERE id_persona = v_id_persona;
        
    ELSE
        -- If no client found with the given cedula, return an error
        SELECT ' El cliente no existe ' AS mensaje;
    END IF;
END $$

DELIMITER ;

/*
CALL actualizar_cliente(
    87654321,           -- p_cedula (cédula del cliente a actualizar)
    'María',            -- p_nombre (nuevo nombre)
    'López',            -- p_apellido_paterno (nuevo apellido paterno)
    'Ramírez',          -- p_apellido_materno (nuevo apellido materno)
    '1985-08-22',       -- p_fecha_nacimiento (nueva fecha de nacimiento)
    'Calle Falsa 456',  -- p_direccion (nueva dirección)
    555123456,          -- p_telefono (nuevo teléfono)
    'maria.lopez@email.com', -- p_email (nuevo correo electrónico)
    2                   -- p_id_tipoCliente (nuevo tipo de cliente)
);
*/

SELECT * FROM PERSONAS;

-- Eliminar un cliente

DELIMITER $$
CREATE PROCEDURE eliminar_cliente(IN cedula_cliente INT)
BEGIN
    DECLARE id_persona_cli INT;
    DECLARE id_cliente INT;

    -- Buscar el ID de la persona y el ID del cliente
    SELECT p.id, c.id INTO id_persona_cli, id_cliente
    FROM personas p
    JOIN clientes c ON p.id = c.id_persona
    WHERE p.cedula = cedula_cliente;

    -- Si se encuentra el cliente, eliminarlo
    IF id_cliente IS NOT NULL THEN
        -- Eliminar el cliente
        DELETE FROM clientes WHERE id = id_cliente;
        
        -- Eliminar la persona asociada
        DELETE FROM personas WHERE id = id_persona_cli;
        
        SELECT 'Cliente eliminado con éxito.' AS mensaje;
    ELSE
        SELECT 'No se encontró un cliente con esa cédula.' AS mensaje;
    END IF;
END $$
DELIMITER ;

/* CALL eliminar_cliente(987654321); */

--------------------------------------------

/* FUNCIONES PARA LA TABLA EMPLEADOS */

--------------------------------------------

-- Agregar un nuevo empleado

DELIMITER $$
CREATE PROCEDURE agregar_empleado(
    IN p_nombre VARCHAR(45),
    IN p_apellido_paterno VARCHAR(45),
    IN p_apellido_materno VARCHAR(45),
    IN p_cedula INT,
    IN p_fecha_nacimiento DATE,
    IN p_direccion MEDIUMTEXT,
    IN p_telefono INT,
    IN p_email VARCHAR(50),
    IN p_id_puesto INT,
    IN p_id_departamento INT,
    IN p_id_sucursal INT,
    IN p_salario DECIMAL(10,2)
)
BEGIN
    DECLARE v_id_persona INT;
    
    -- Insert into personas table
    INSERT INTO personas (nombre, apellido_paterno, apellido_materno, cedula, fecha_nacimiento, direccion, telefono, email)
    VALUES (p_nombre, p_apellido_paterno, p_apellido_materno, p_cedula, p_fecha_nacimiento, p_direccion, p_telefono, p_email);
    
    -- Get the last inserted ID
    SET v_id_persona = LAST_INSERT_ID();
    
    -- Insert into empleados table
    INSERT INTO empleados (id_persona, id_puesto, id_departamento, id_sucursal, fecha_contrato, salario)
    VALUES (v_id_persona, p_id_puesto, p_id_departamento, p_id_sucursal, CURDATE(), p_salario);
END $$
DELIMITER ;

/*
CALL agregar_empleado(
    'Carlos',              -- p_nombre
    'Martínez',            -- p_apellido_paterno
    'Sánchez',             -- p_apellido_materno
    23456789,              -- p_cedula
    '1988-10-15',          -- p_fecha_nacimiento
    'Calle Ejemplo 456',   -- p_direccion
    912345678,             -- p_telefono
    'carlos.martinez@email.com', -- p_email
    1,                     -- p_id_puesto (ID del puesto en la tabla `puestos`)
    2,                     -- p_id_departamento (ID del departamento en la tabla `departamentos`)
    3,                     -- p_id_sucursal (ID de la sucursal en la tabla `sucursales`)
    2500.00                -- p_salario (salario del nuevo empleado)
);

*/

-- Actualizar empleado
DELIMITER $$
CREATE PROCEDURE actualizar_empleado(
    IN p_id INT,
    IN p_nombre VARCHAR(45),
    IN p_apellido_paterno VARCHAR(45),
    IN p_apellido_materno VARCHAR(45),
    IN p_cedula INT,
    IN p_fecha_nacimiento DATE,
    IN p_direccion MEDIUMTEXT,
    IN p_telefono INT,
    IN p_email VARCHAR(50),
    IN p_id_puesto INT,
    IN p_id_departamento INT,
    IN p_id_sucursal INT,
    IN p_salario DECIMAL(10,2)
)
BEGIN
    DECLARE v_id_persona INT;
    
    -- Get the id_persona for the employee
    SELECT id_persona INTO v_id_persona FROM empleados WHERE id = p_id;
    
    -- Update personas table
    UPDATE personas
    SET nombre = p_nombre,
        apellido_paterno = p_apellido_paterno,
        apellido_materno = p_apellido_materno,
        cedula = p_cedula,
        fecha_nacimiento = p_fecha_nacimiento,
        direccion = p_direccion,
        telefono = p_telefono,
        email = p_email
    WHERE id = v_id_persona;
    
    -- Update empleados table
    UPDATE empleados
    SET id_puesto = p_id_puesto,
        id_departamento = p_id_departamento,
        id_sucursal = p_id_sucursal,
        salario = p_salario
    WHERE id = p_id;
END $$
DELIMITER ;

/*
CALL actualizar_empleado(
    1,                  -- p_id (ID del empleado en la tabla empleados)
    'Ana',              -- p_nombre (nuevo nombre)
    'Gómez',            -- p_apellido_paterno (nuevo apellido paterno)
    'Lopez',            -- p_apellido_materno (nuevo apellido materno)
    1716373939,           -- p_cedula (nueva cédula)
    '1990-02-28',       -- p_fecha_nacimiento (nueva fecha de nacimiento)
    'Calle Ejemplo 789',-- p_direccion (nueva dirección)
    987654321,          -- p_telefono (nuevo teléfono)
    'ana.gomez@email.com', -- p_email (nuevo correo electrónico)
    2,                  -- p_id_puesto (nuevo ID de puesto en la tabla `puestos`)
    3,                  -- p_id_departamento (nuevo ID de departamento en la tabla `departamentos`)
    1,                  -- p_id_sucursal (nuevo ID de sucursal en la tabla `sucursales`)
    3000.00             -- p_salario (nuevo salario)
);
*/

-- Eliminar Empleado

DELIMITER //
CREATE PROCEDURE eliminar_empleado(IN cedula_empleado INT)
BEGIN
    DECLARE id_persona_emp INT;
    DECLARE id_empleado INT;

    -- Buscar el ID de la persona y el ID del empleado
    SELECT p.id, e.id INTO id_persona_emp, id_empleado
    FROM personas p
    JOIN empleados e ON p.id = e.id_persona
    WHERE p.cedula = cedula_empleado;

    -- Si se encuentra el empleado, eliminarlo
    IF id_empleado IS NOT NULL THEN
        -- Eliminar el empleado
        DELETE FROM empleados WHERE id = id_empleado;
        
        -- Eliminar la persona asociada
        DELETE FROM personas WHERE id = id_persona_emp;
        
        SELECT 'Empleado eliminado con éxito.' AS mensaje;
    ELSE
        SELECT 'No se encontró un empleado con esa cédula.' AS mensaje;
    END IF;
END //
DELIMITER ;


/* CALL eliminar_empleado(123456789); */


--------------------------------------------

/* FUNCIONES PARA LA TABLA PRODUCTOS */

--------------------------------------------


-- Agregar un nuevo producto

DELIMITER $$
CREATE PROCEDURE agregar_producto(
    IN p_nombre VARCHAR(45),
    IN p_descripcion LONGTEXT,
    IN p_precio DECIMAL(10,2),
    IN p_stock INT,
    IN p_id_categoria INT,
    IN p_id_marca INT,
    IN p_id_proveedor INT
)
BEGIN
    INSERT INTO productos (nombre, descripcion, precio, stock, id_categoria, id_marca, id_proveedor)
    VALUES (p_nombre, p_descripcion, p_precio, p_stock, p_id_categoria, p_id_marca, p_id_proveedor);
END $$
DELIMITER ;


/*
CALL agregar_producto(
    'Cemento',               -- p_nombre
    'Cemento de alta resistencia',  -- p_descripcion
    150.50,                  -- p_precio
    100,                     -- p_stock
    1,                       -- p_id_categoria
    2,                       -- p_id_marca
    3                        -- p_id_proveedor
);
*/

-- Actualizar Producto

DELIMITER $$
CREATE PROCEDURE actualizar_producto(
    IN p_nombre_actual VARCHAR(45),  -- El nombre actual del producto (para identificar cuál actualizar)
    IN p_descripcion LONGTEXT,       -- Nueva descripción
    IN p_precio DECIMAL(10,2),       -- Nuevo precio
    IN p_stock INT,                  -- Nuevo stock
    IN p_id_categoria INT,           -- Nuevo ID de categoría
    IN p_id_marca INT,               -- Nuevo ID de marca
    IN p_id_proveedor INT            -- Nuevo ID de proveedor
)
BEGIN
    -- Verifica si el producto con el nombre actual existe
    IF NOT EXISTS (SELECT 1 FROM productos WHERE nombre = p_nombre_actual) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El producto no existe';
    ELSE
        -- Actualiza el producto si existe
        UPDATE productos
        SET descripcion = p_descripcion,
            precio = p_precio,
            stock = p_stock,
            id_categoria = p_id_categoria,
            id_marca = p_id_marca,
            id_proveedor = p_id_proveedor
        WHERE nombre = p_nombre_actual;
    END IF;
END $$
DELIMITER ;

/*
CALL actualizar_producto(
    'Cemento',                    -- p_nombre_actual (nombre del producto a actualizar)
    'Cemento de la mejor calidad para construcción',  -- p_descripcion (nueva descripción)
    200.00,                        -- p_precio (nuevo precio)
    150,                           -- p_stock (nuevo stock)
    1,                             -- p_id_categoria (ID de la categoría)
    2,                             -- p_id_marca (ID de la marca)
    3                              -- p_id_proveedor (ID del proveedor)
);
*/

-- Eliminar producto

DELIMITER $$
CREATE PROCEDURE eliminar_producto(
    IN p_nombre VARCHAR(45)  -- Nombre del producto a eliminar
)
BEGIN
    -- Verifica si el producto existe
    IF NOT EXISTS (SELECT 1 FROM productos WHERE nombre = p_nombre) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El producto no existe';
    ELSE
        -- Si el producto existe, lo elimina
        DELETE FROM productos WHERE nombre = p_nombre;
    END IF;
END $$
DELIMITER ;

/* CALL eliminar_producto('Cemento'); */

--------------------------------------------

/* FUNCIONES PARA LA TABLA VENTAS Y DETALLE VENTA */

--------------------------------------------

-- Registrar una venta
DELIMITER $$
CREATE PROCEDURE ingresar_venta(
    IN p_id_cliente INT,
    IN p_id_empleado INT,
    IN p_id_sucursal INT,
    IN p_total DECIMAL(10,2)
)
BEGIN
    INSERT INTO ventas (id_cliente, id_empleado, id_sucursal, fecha_venta, total)
    VALUES (p_id_cliente, p_id_empleado, p_id_sucursal, CURDATE(), p_total);
    
    SELECT LAST_INSERT_ID() AS id_venta;
END $$
DELIMITER ;

/* CALL ingresar_venta(1, 2, 3, 150.75); */

-- Ingresar un detalle venta

DELIMITER $$
CREATE PROCEDURE ingresar_detalle_venta(
    IN p_id_venta INT,
    IN p_id_producto INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE v_stock_actual INT;
    DECLARE v_precio_unitario DECIMAL(10,2);
    DECLARE v_precio_total DECIMAL(10,2);
    DECLARE v_total_venta DECIMAL(10,2);

    -- Iniciar transacción
    START TRANSACTION;

    -- Obtener el stock actual y el precio unitario del producto
    SELECT stock, precio INTO v_stock_actual, v_precio_unitario 
    FROM productos 
    WHERE id = p_id_producto;
    
    IF v_stock_actual >= p_cantidad THEN
        -- Calcular el precio total del detalle
        SET v_precio_total = p_cantidad * v_precio_unitario;

        -- Insertar el detalle de venta
        INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, precio_total)
        VALUES (p_id_venta, p_id_producto, p_cantidad, v_precio_unitario, v_precio_total);

        -- Actualizar el stock del producto
        UPDATE productos SET stock = stock - p_cantidad WHERE id = p_id_producto;

        -- Actualizar el total de la venta
        SELECT SUM(precio_total) INTO v_total_venta FROM detalle_venta WHERE id_venta = p_id_venta;
        UPDATE ventas SET total = v_total_venta WHERE id = p_id_venta;

        -- Confirmar la transacción
        COMMIT;

        SELECT 'Detalle de venta ingresado correctamente' AS mensaje;
    ELSE
        -- Revertir la transacción si no hay suficiente stock
        ROLLBACK;
        SELECT 'Error: Stock insuficiente' AS mensaje;
    END IF;

END $$
DELIMITER ;

/* CALL ingresar_detalle_venta(6, 5, 3);
   CALL ingresar_detalle_venta(6, 2, 1); */

-- Eliminar venta

DELIMITER $$
CREATE PROCEDURE eliminar_venta(
    IN p_id INT
)
BEGIN
    -- Delete related records in detalle_venta
    DELETE FROM detalle_venta WHERE id_venta = p_id;
    
    -- Delete the sale
    DELETE FROM ventas WHERE id = p_id;
END $$
DELIMITER ;

/* CALL eliminar_venta(6); */



-- FUNCIONES COMPLEMANTARIAS

-- Función para contar la cantidad de clientes
DELIMITER $$
CREATE PROCEDURE contar_clientes()
BEGIN
    SELECT COUNT(*) AS total_clientes FROM clientes;
END$$
DELIMITER ;

/* CALL ContarClientes(); */

-- Función para obtener datos de un cliente por cédula
DELIMITER $$
CREATE PROCEDURE obtener_cliente_cedula(
    IN p_cedula INT
)
BEGIN
    SELECT p.*, c.fecha_registro, cat.nombre AS tipo_cliente
    FROM personas p
    JOIN clientes c ON p.id = c.id_persona
    JOIN categorias cat ON c.id_tipoCliente = cat.id
    WHERE p.cedula = p_cedula;
END$$
DELIMITER ;

/* CALL obtener_cliente_cedula(1712345678); */

-- Obtener producto por nombre
DELIMITER $$

CREATE PROCEDURE obtener_producto_nombre(
    IN p_nombre VARCHAR(100)
)
BEGIN
    SELECT prod.*, cat.nombre AS categoria, mar.nombre AS marca, prov.nombre AS proveedor
    FROM productos prod
    JOIN categorias cat ON prod.id_categoria = cat.id
    JOIN marcas mar ON prod.id_marca = mar.id
    JOIN proveedores prov ON prod.id_proveedor = prov.id
    WHERE prod.nombre = p_nombre;
END$$

DELIMITER ;

/* CALL  obtener_producto_nombre("Cemento gris 50kg"); */

-- Obtener clientes por tipo de cliente

DELIMITER $$

CREATE PROCEDURE obtener_clientes_tipo(
    IN p_tipo_cliente VARCHAR(50)
)
BEGIN
    SELECT p.*, c.fecha_registro, cat.nombre AS tipo_cliente
    FROM personas p
    JOIN clientes c ON p.id = c.id_persona
    JOIN categorias cat ON c.id_tipoCliente = cat.id
    WHERE cat.nombre = p_tipo_cliente;
END$$

DELIMITER ;

/* CALL obtener_clientes_tipo("Cliente Frecuente"); */