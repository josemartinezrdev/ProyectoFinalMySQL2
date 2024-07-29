-- Inserts para la tabla paises
INSERT INTO paises (idPais, nombre) VALUES
('USA', 'Estados Unidos'),
('CAN', 'Canadá'),
('MEX', 'México'),
('BRA', 'Brasil'),
('ARG', 'Argentina');

-- Inserts para la tabla ciudades
INSERT INTO ciudades (idCiudad, nombre, idPais) VALUES
('NYC', 'Nueva York', 'USA'),
('LAX', 'Los Ángeles', 'USA'),
('TOR', 'Toronto', 'CAN'),
('MEX', 'Ciudad de México', 'MEX'),
('GDL', 'Guadalajara', 'MEX');

-- Inserts para la tabla compras
INSERT INTO compras (fecha, total) VALUES
('2023-01-01', 1025.50),
('2023-02-01', 1540.00),
('2023-03-01', 2300.75),
('2023-04-01', 2800.30),
('2023-05-01', 3100.60);

-- Inserts para la tabla proveedores
INSERT INTO proveedores (idProveedor, nombre, correo, idCiudad) VALUES
('P001', 'BiciProveeduría', 'contacto@biciproveeduria.com', 'NYC'),
('P002', 'RuedaSuplidores', 'ventas@ruedasuplidores.com', 'LAX'),
('P003', 'Componentes del Norte', 'info@componentesdelnorte.ca', 'TOR'),
('P004', 'MTL Parts', 'service@mtlparts.ca', 'GDL'),
('P005', 'Refacciones Mexicanas', 'ventas@refmex.com', 'MEX');

-- Inserts para la tabla telefonos_proveedores
INSERT INTO telefonos_proveedores (tel, idProveedor) VALUES
('1234567890', 'P001'),
('2345678901', 'P002'),
('3456789012', 'P003'),
('4567890123', 'P004'),
('5678901234', 'P005');

-- Inserts para la tabla repuestos
INSERT INTO repuestos (nombre, descripcion, precio, stock, idProveedor) VALUES
('Cadena Shimano', 'Cadena de bicicleta de alta calidad Shimano', 25.50, 100, 'P001'),
('Pedal Wellgo', 'Pedal ergonómico y resistente Wellgo', 45.00, 200, 'P002'),
('Sillin Prologo', 'Sillín de bicicleta cómodo Prologo', 60.00, 150, 'P003'),
('Manillar Ritchey', 'Manillar de aluminio Ritchey', 75.00, 120, 'P004'),
('Llantas Continental', 'Llantas de alta durabilidad Continental', 80.00, 300, 'P005');

-- Inserts para la tabla detalles_compras
INSERT INTO detalles_compras (idCompra, idRepuesto, cantidad) VALUES
(1, 1, 5),
(1, 2, 3),
(2, 3, 10),
(2, 4, 4),
(3, 5, 6);

-- Inserts para la tabla modelos
INSERT INTO modelos (nombre) VALUES
('Mountain Bike X1'),
('Road Bike Y2'),
('Hybrid Bike Z3'),
('Electric Bike E4'),
('Folding Bike F5');

-- Inserts para la tabla marcas
INSERT INTO marcas (nombre) VALUES
('Trek'),
('Specialized'),
('Giant'),
('Cannondale'),
('Bianchi');

-- Inserts para la tabla bicicletas
INSERT INTO bicicletas (precio, stock, idModelo, idMarca) VALUES
(1500.00, 15, 1, 1),
(2000.00, 20, 2, 2),
(1800.00, 18, 3, 3),
(2500.00, 25, 4, 4),
(1300.00, 13, 5, 5);

-- Inserts para la tabla clientes
INSERT INTO clientes (idCliente, nombre, correo, idCiudad) VALUES
('C001', 'Juan Perez', 'juan.perez@gmail.com', 'NYC'),
('C002', 'Maria Lopez', 'maria.lopez@gmail.com', 'LAX'),
('C003', 'Carlos Garcia', 'carlos.garcia@gmail.com', 'TOR'),
('C004', 'Ana Martinez', 'ana.martinez@gmail.com', 'MEX'),
('C005', 'Luis Hernandez', 'luis.hernandez@gmail.com', 'GDL');

-- Inserts para la tabla telefonos_clientes
INSERT INTO telefonos_clientes (tel, idCliente) VALUES
('3216549870', 'C001'),
('6549873210', 'C002'),
('9873216540', 'C003'),
('1239874560', 'C004'),
('4563217890', 'C005');

-- Inserts para la tabla ventas
INSERT INTO ventas (fecha, total, idCliente) VALUES
('2023-01-15', 1500.00, 'C001'),
('2023-02-20', 2000.00, 'C002'),
('2023-03-25', 1800.00, 'C003'),
('2023-04-30', 2500.00, 'C004'),
('2023-05-05', 3000.00, 'C005');

-- Inserts para la tabla detalles_ventas
INSERT INTO detalles_ventas (idVenta, idBici, cantidad) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1);
