-- SEGURIDAD
USE FERRETERIA;

-- CREACION DE ROLES SOLO SE CREAN UNA VEZ | IMPORTANTE ESTOS NO CON USUARIOS SOLO SON ROLES
CREATE ROLE 'admin', 'usuario', 'auditor';

-- AGREGAMOS PERMISOS A LOS ROLES
GRANT ALL PRIVILEGES ON ferreteria.* TO 'admin';
GRANT SELECT, INSERT, UPDATE, DELETE ON ferreteria.* TO 'usuario';
GRANT SELECT ON ferreteria.* TO 'auditor';



-- CREAR USUARIOS Y CONTRASEÑAS
CREATE USER  'admin'@'localhost' IDENTIFIED BY 'admin';
CREATE USER  'usuario'@'localhost' IDENTIFIED BY 'usuario';
CREATE USER  'auditor'@'localhost' IDENTIFIED BY 'auditor';

-- ASIGNAR LOS ROLES
GRANT 'admin' TO 'admin'@'localhost';
GRANT 'usuario' TO 'usuario'@'localhost';
GRANT 'auditor' TO 'auditor'@'localhost';

-- MOSTRAR LOS PERMISOS DE CADA ROL
SHOW GRANTS FOR 'admin';
SHOW GRANTS FOR 'usuario';
SHOW GRANTS FOR 'auditor';










