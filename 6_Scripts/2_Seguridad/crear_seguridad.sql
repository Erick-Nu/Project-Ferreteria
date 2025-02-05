USE FERRETERIA;

-- SEGURIDAD

-- MODIFICAMOS LA TABLA USUARIOS

ALTER TABLE USUARIOS
MODIFY password VARBINARY(255) NOT NULL COMMENT 'Contraseña cifrada con AES.';

INSERT INTO USUARIOS (nameUser, password, id_empleado)
VALUES (
    'usuario123',
    -- Esta funcion requiere dos parametros
    AES_ENCRYPT('mi_contraseña_segura', 'clave_secreta'),
    5
);

SELECT * FROM USUARIOS;

-- DESENCRIPTAR CONTRASEÑA
SELECT 
    id, 
    nameUser, 
    CAST(AES_DECRYPT(password, 'clave_secreta') AS CHAR) AS contraseña_descifrada, 
    id_empleado
FROM USUARIOS;