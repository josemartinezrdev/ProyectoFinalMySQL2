-- Inserts para la tabla paises
INSERT INTO paises (idPais, nombre) VALUES
('USA', 'Estados Unidos'),
('CAN', 'Canadá'),
('MEX', 'México'),
('BRA', 'Brasil'),
('ARG', 'Argentina'),
('CHL', 'Chile'),
('COL', 'Colombia'),
('PER', 'Perú'),
('VEN', 'Venezuela'),
('URU', 'Uruguay');

-- Inserts para la tabla ciudades
INSERT INTO ciudades (idCiudad, nombre, idPais) VALUES
('NYC', 'Nueva York', 'USA'),
('LAX', 'Los Ángeles', 'USA'),
('TOR', 'Toronto', 'CAN'),
('MTL', 'Montreal', 'CAN'),
('MEX', 'Ciudad de México', 'MEX'),
('GDL', 'Guadalajara', 'MEX'),
('RJO', 'Río de Janeiro', 'BRA'),
('SAO', 'Sao Paulo', 'BRA'),
('BUE', 'Buenos Aires', 'ARG'),
('SCL', 'Santiago', 'CHL');

-- Inserts para la tabla compras
INSERT INTO compras (fecha, total) VALUES
('2023-01-01', 1000.00),
('2023-02-01', 1500.00),
('2023-03-01', 2000.00),
('2023-04-01', 2500.00),
('2023-05-01', 3000.00),
('2023-06-01', 3500.00),
('2023-07-01', 4000.00),
('2023-08-01', 4500.00),
('2023-09-01', 5000.00),
('2023-10-01', 5500.00);

-- Inserts para la tabla proveedores
INSERT INTO proveedores (idProveedor, nombre, correo, idCiudad) VALUES
('P001', 'Proveedor 1', 'prov1@example.com', 'NYC'),
('P002', 'Proveedor 2', 'prov2@example.com', 'LAX'),
('P003', 'Proveedor 3', 'prov3@example.com', 'TOR'),
('P004', 'Proveedor 4', 'prov4@example.com', 'MTL'),
('P005', 'Proveedor 5', 'prov5@example.com', 'MEX'),
('P006', 'Proveedor 6', 'prov6@example.com', 'GDL'),
('P007', 'Proveedor 7', 'prov7@example.com', 'RJO'),
('P008', 'Proveedor 8', 'prov8@example.com', 'SAO'),
('P009', 'Proveedor 9', 'prov9@example.com', 'BUE'),
('P010', 'Proveedor 10', 'prov10@example.com', 'SCL');

-- Inserts para la tabla telefonos_proveedores
INSERT INTO telefonos_proveedores (tel, idProveedor) VALUES
('1234567890', 'P001'),
('1234567891', 'P002'),
('1234567892', 'P003'),
('1234567893', 'P004'),
('1234567894', 'P005'),
('1234567895', 'P006'),
('1234567896', 'P007'),
('1234567897', 'P008'),
('1234567898', 'P009'),
('1234567899', 'P010');

-- Inserts para la tabla repuestos
INSERT INTO repuestos (nombre, descripcion, precio, stock, idProveedor) VALUES
('Repuesto 1', 'Descripción del Repuesto 1', 100.00, 10, 'P001'),
('Repuesto 2', 'Descripción del Repuesto 2', 150.00, 15, 'P002'),
('Repuesto 3', 'Descripción del Repuesto 3', 200.00, 20, 'P003'),
('Repuesto 4', 'Descripción del Repuesto 4', 250.00, 25, 'P004'),
('Repuesto 5', 'Descripción del Repuesto 5', 300.00, 30, 'P005'),
('Repuesto 6', 'Descripción del Repuesto 6', 350.00, 35, 'P006'),
('Repuesto 7', 'Descripción del Repuesto 7', 400.00, 40, 'P007'),
('Repuesto 8', 'Descripción del Repuesto 8', 450.00, 45, 'P008'),
('Repuesto 9', 'Descripción del Repuesto 9', 500.00, 50, 'P009'),
('Repuesto 10', 'Descripción del Repuesto 10', 550.00, 55, 'P010');

-- Inserts para la tabla detalles_compras
INSERT INTO detalles_compras (idCompra, idRepuesto, cantidad) VALUES
(1, 1, 2),
(2, 2, 3),
(3, 3, 4),
(4, 4, 5),
(5, 5, 6),
(6, 6, 7),
(7, 7, 8),
(8, 8, 9),
(9, 9, 10),
(10, 10, 11);

-- Inseres para la tabla modelos
INSERT INTO modelos (nombre) VALUES
('Modelo 1'),
('Modelo 2'),
('Modelo 3'),
('Modelo 4'),
('Modelo 5'),
('Modelo 6'),
('Modelo 7'),
('Modelo 8'),
('Modelo 9'),
('Modelo 10');

-- Inserts para la tabla marcas
INSERT INTO marcas (nombre) VALUES
('Marca 1'),
('Marca 2'),
('Marca 3'),
('Marca 4'),
('Marca 5'),
('Marca 6'),
('Marca 7'),
('Marca 8'),
('Marca 9'),
('Marca 10');

-- Inserts para la tabla bicicletas
INSERT INTO bicicletas (precio, stock, idModelo, idMarca) VALUES
(1000.00, 10, 1, 1),
(1500.00, 15, 2, 2),
(2000.00, 20, 3, 3),
(2500.00, 25, 4, 4),
(3000.00, 30, 5, 5),
(3500.00, 35, 6, 6),
(4000.00, 40, 7, 7),
(4500.00, 45, 8, 8),
(5000.00, 50, 9, 9),
(5500.00, 55, 10, 10);

-- Inserts para la tabla clientes
INSERT INTO clientes (idCliente, nombre, correo, idCiudad) VALUES
('C001', 'Cliente 1', 'cliente1@example.com', 'NYC'),
('C002', 'Cliente 2', 'cliente2@example.com', 'LAX'),
('C003', 'Cliente 3', 'cliente3@example.com', 'TOR'),
('C004', 'Cliente 4', 'cliente4@example.com', 'MTL'),
('C005', 'Cliente 5', 'cliente5@example.com', 'MEX'),
('C006', 'Cliente 6', 'cliente6@example.com', 'GDL'),
('C007', 'Cliente 7', 'cliente7@example.com', 'RJO'),
('C008', 'Cliente 8', 'cliente8@example.com', 'SAO'),
('C009', 'Cliente 9', 'cliente9@example.com', 'BUE'),
('C010', 'Cliente 10', 'cliente10@example.com', 'SCL');

-- Inserts para la tabla telefonos
INSERT INTO telefonos_clientes (tel, idCliente) VALUES
('1234567890', 'C001'),
('1234567891', 'C002'),
('1234567892', 'C003'),
('1234567893', 'C004'),
('1234567894', 'C005'),
('1234567895', 'C006'),
('1234567896', 'C007'),
('1234567897', 'C008'),
('1234567898', 'C009'),
('1234567899', 'C010');

-- Inserts para la tabla ventas
INSERT INTO ventas (fecha, total, idCliente) VALUES
('2023-01-10', 500.00, 'C001'),
('2023-02-10', 1000.00, 'C002'),
('2023-03-10', 1500.00, 'C003'),
('2023-04-10', 2000.00, 'C004'),
('2023-05-10', 2500.00, 'C005'),
('2023-06-10', 3000.00, 'C006'),
('2023-07-10', 3500.00, 'C007'),
('2023-08-10', 4000.00, 'C008'),
('2023-09-10', 4500.00, 'C009'),
('2023-10-10', 5000.00, 'C010');

-- Inserts para la tabla detalles_ventas
INSERT INTO detalles_ventas (cantidad, precioUni, idVenta, idBici) VALUES
(1, 500.00, 1, 1),
(2, 750.00, 2, 2),
(3, 1000.00, 3, 3),
(4, 1250.00, 4, 4),
(5, 1500.00, 5, 5),
(6, 1750.00, 6, 6),
(7, 2000.00, 7, 7),
(8, 2250.00, 8, 8),
(9, 2500.00, 9, 9),
(10, 2750.00, 10, 10);
