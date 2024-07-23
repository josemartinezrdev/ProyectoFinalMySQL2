-- USAR ESTO SOLO SI LA DB ES LOCAL

DROP DATABASE IF exists campusbike;
CREATE DATABASE campusbike;
use campusbike;

-- DE AQUI PARA ABAJO ES LA BASE DE DATOS RAILWAY

CREATE TABLE paises(
    idPais VARCHAR(3),
    nombre VARCHAR(30),
    CONSTRAINT pk_idPais PRIMARY KEY(idPais)
);

CREATE TABLE ciudades(
    idCiudad VARCHAR(3),
    nombre VARCHAR(25),
    idPais VARCHAR(3),

    CONSTRAINT pk_idCiudad PRIMARY KEY(idCiudad),
    CONSTRAINT fk_ciudades_paises FOREIGN KEY (idPais) REFERENCES paises (idPais)
);

CREATE TABLE compras(
    idCompra INT AUTO_INCREMENT,
    fecha DATE,
    total DECIMAL(10, 2),

    CONSTRAINT pk_idCompra PRIMARY KEY (idCompra)
);


CREATE TABLE proveedores(
    idProveedor VARCHAR(10),
    nombre VARCHAR(30),
    correo VARCHAR(30) UNIQUE,
    idCiudad VARCHAR(3),

    CONSTRAINT pk_idProveedor PRIMARY KEY (idProveedor),
    CONSTRAINT fk_proveedores_ciudades FOREIGN KEY (idCiudad) REFERENCES ciudades (idCiudad)
);

CREATE TABLE telefonos_proveedores(
    idTel INT AUTO_INCREMENT,
    tel VARCHAR(10),
    idProveedor VARCHAR(10),
    CONSTRAINT pk_idTel PRIMARY KEY(idTel),
    CONSTRAINT fk_telefonos_proveedores_proveedores FOREIGN KEY (idProveedor) REFERENCES proveedores (idProveedor)
);

CREATE TABLE repuestos (
    idRepuesto INT AUTO_INCREMENT,
    nombre VARCHAR(30),
    descripcion TEXT,
    precio DECIMAL(10, 2),
    stock INT,
    idProveedor VARCHAR(10),

    CONSTRAINT pk_idRepuesto PRIMARY KEY (idRepuesto),
    CONSTRAINT fk_repuestos_proveedores FOREIGN KEY (idProveedor) REFERENCES proveedores (idProveedor)
);

CREATE TABLE detalles_compras(
    idDetalle INT AUTO_INCREMENT,
    idCompra INT,
    idRepuesto INT,
    cantidad INT,

    CONSTRAINT idDetalle PRIMARY KEY (idDetalle),
    CONSTRAINT fk_detalles_compras_compras FOREIGN KEY (idCompra) REFERENCES compras (idCompra),
    CONSTRAINT fk_detalles_compras_repuestos FOREIGN KEY (idRepuesto) REFERENCES repuestos (idRepuesto)
);
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
    idCiudad VARCHAR(3),
    CONSTRAINT pk_idCliente PRIMARY KEY(idCliente),
    CONSTRAINT fk_clientes_ciudades  FOREIGN KEY(idCiudad) REFERENCES ciudades(idCiudad)
);

CREATE TABLE telefonos_clientes(
    idTel INT AUTO_INCREMENT,
    tel VARCHAR(10),
    idCliente VARCHAR(10),
    CONSTRAINT pk_idTel PRIMARY KEY(idTel),
    CONSTRAINT fk_telefonos_clientes  FOREIGN KEY(idCliente) REFERENCES clientes(idCliente)
);

CREATE TABLE ventas(
    idVenta INT AUTO_INCREMENT,
    fecha DATE,
    total DECIMAL(10,2),
    idCliente VARCHAR(10),
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

