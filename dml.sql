CREATE TABLE modelos(
    idModelo INT AUTO_INCREMENT,
    nombre VARCHAR(30),
    CONSTRAINT pk_idModelo PRIMARY KEY(idModelo)
);

CREATE TABLE marcas(
    idMarca INT AUTO_INCREMENT,
    nombre VARCHAR(30),
    CONSTRAINT pk_idMarca PRIMARY KEY(idMarca)
);

CREATE TABLE bicicletas(
    idBici INT AUTO_INCREMENT,
    precio DECIMAL(10,2),
    stock INT,
    idModelo INT,
    idMarca INT, 
    CONSTRAINT pk_idBicicleta PRIMARY KEY(idBici),
    CONSTRAINT fk_bicicletas_modelos  FOREIGN KEY(idModelo) REFERENCES modelos(idModelo),
    CONSTRAINT fk_bicicletas_marcas FOREIGN KEY(idMarca) REFERENCES marcas(idMarca)
);
CREATE TABLE clientes(
    idCliente VARCHAR(10),
    nombre VARCHAR(30),
    Correo VARCHAR(30) UNIQUE,
    idCiudad INT,
    CONSTRAINT pk_idCliente PRIMARY KEY(idCliente),
    CONSTRAINT fk_clientes_ciudades  FOREIGN KEY(idCiudad) REFERENCES ciudades(idCiudad)
);

CREATE TABLE telefonos(
    idTel INT AUTO_INCREMENT,
    tel VARCHAR(10),
    idCliente VARCHAR(10),
    CONSTRAINT pk_idTel PRIMARY KEY(idTel),
    CONSTRAINT fk_telefonos_clientes  FOREIGN KEY(idCliente) REFERENCES clientes(idCliente)
);

CREATE TABLES ventas(
    idVenta INT AUTO_INCREMENT,
    fecha DATE,
    total DECIMAL(10,2),
    idCliente VARCHAR(10)
    CONSTRAINT pk_idVenta PRIMARY KEY(idVenta),
    CONSTRAINT fk_ventas_clientes  FOREIGN KEY(idCliente) REFERENCES clientes(idCliente)
);

CREATE TABLE detalles_ventas(
    idDetalle INT AUTO_INCREMENT,
    cantidad INT,
    precioUni DECIMAL(10,2),
    idVenta INT,
    idBici INT,
    CONSTRAINT pk_idDetalle PRIMARY KEY(idDetalle),
    CONSTRAINT fk_detalles_ventas_ventas FOREIGN KEY(idVenta) REFERENCES ventas(idVenta),
    CONSTRAINT fk_detalles_ventas_bicicletas FOREIGN KEY(idBici) REFERENCES bicicletas(idBici)
);

