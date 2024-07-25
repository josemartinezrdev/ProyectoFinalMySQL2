# Campusbike

## Caso de Uso 1: Gestión de Inventario de Bicicletas

Descripción: Este caso de uso describe cómo el sistema gestiona el inventario de bicicletas,
permitiendo agregar nuevas bicicletas, actualizar la información existente y eliminar bicicletas que
ya no están disponibles.

### Agregar nueva bicicleta

#### ADD

```sql
INSERT INTO bicicletas ( precio, stock, idModelo, idMarca ) VALUES ( 1400, 140, 1, 2 );
```

#### UPDATE

```sql
UPDATE bicicletas SET precio = 3000, stock = 560, idModelo = 2, idMarca = 3
WHERE idBici = 5;
```

#### DELETE

```sql
DELETE FROM bicicletas WHERE idBici = 4;
```

## Caso de Uso 2: Registro de Ventas

### creación de una nueva venta

```sql
DELIMITER $$

CREATE PROCEDURE registrar_venta(
    IN p_idCliente VARCHAR(10),
    IN p_fecha DATE,
    IN p_total DECIMAL(10,2),
    IN p_idCliente VC()
)





DELIMITER;
```

### selección de las bicicletas vendidas

### Caso de Uso 3: Proveedores y Repuestos

#### ADD Proveedor

```sql
INSERT INTO proveedores ( idProveedor, nombre, correo, idCiudad) VALUES
("PROV001", "Proveedor 1", "prov1@gmail.com", "TOR" );
```

#### UPDATE Proveedor

```sql
UPDATE proveedores SET nombre = "Proveedor Act", correo = "provact@gmail.com", idCiudad = "MEX"
WHERE idProveedor = "PROV001";
```

#### DELETE Proveedor

```sql
DELETE FROM proveedores WHERE idProveedor = "PROV001";
```

#### ADD Repuesto

```sql
INSERT INTO repuestos ( nombre, descripcion, precio, stock, idProveedor )
VALUES ( "Repuesto 0", "Descripcion Repuesto", 1400.09, 140, "PROV001" );
```

#### UPDATE Repuesto

```sql
UPDATE repuestos
        SET nombre = "Repuesto 1",
        descripcion = "Descripcion del repuesto 1",
        precio = 1250,
        stock = 143,
        idProveedor = "PROV001"
        WHERE idRepuesto = 11;
```

#### DELETE Repuesto

```sql

DELETE FROM repuestos WHERE idRepuesto = 11
```

### Caso de Uso 5: Compras de Repuestos a Proveedores

```sql
INSERT INTO compras (fecha, total) VALUES ('2024-07-25', 1500.07);
    INSERT INTO detalles_compras (idCompra, idRepuesto, cantidad) VALUES (1, 11, 100);
    UPDATE repuestos SET stock = stock + 100 WHERE idRepuesto = 11;

```

### Caso de Uso 6: Consulta de Bicicletas Más Vendidas por Marca

## SUBCONSULTAS

### Caso de Uso 7: Clientes con Mayor Gasto en un Año Específico

```sql
DELIMITER $$

CREATE PROCEDURE clientes_gastos(
	IN año VARCHAR(4)
)
BEGIN
	SELECT
    idCliente,
    nombre,
    (SELECT SUM(total)
     FROM ventas ven
     WHERE ven.idCliente = c.idCliente
       AND ven.fecha LIKE CONCAT(año, '%')) AS total_gastado
FROM
    clientes c
WHERE (SELECT SUM(total)
     FROM ventas ven
     WHERE ven.idCliente = c.idCliente
     AND ven.fecha LIKE CONCAT(año, '%')) IS NOT NULL
ORDER BY
    total_gastado DESC;
END $$
DELIMITER ;

CALL clientes_gastos('2023');
```

### Caso de Uso 9: Repuestos con Menor Rotación en el Inventario

```sql
SELECT
	idRepuesto,
    nombre,
    (SELECT SUM(cantidad) FROM detalles_compras det
		WHERE det.idRepuesto = rep.idRepuesto) AS total_comprado
FROM repuestos rep
ORDER BY total_comprado ASC;
```

### Caso de Uso 11: Consulta de Ventas por Ciudad

```sql
SELECT
	ciu.idCiudad,
    ciu.nombre,
    COUNT(det.idVenta) as numero_compras
FROM ciudades ciu
INNER JOIN clientes cli ON ciu.idCiudad = cli.idCiudad
INNER JOIN ventas ven ON cli.idCliente = ven.idCliente
INNER JOIN detalles_ventas det ON ven.idVenta = det.idVenta
GROUP BY det.idventa
ORDER BY numero_compras DESC;
```

### Caso de Uso 13: Compras de Repuestos por Proveedor

```sql
SELECT
	prov.idProveedor,
    prov.nombre,
    COUNT(rep.idRepuesto) as numero_compras
FROM proveedores prov
INNER JOIN repuestos rep ON prov.idProveedor = rep.idProveedor
INNER JOIN detalles_compras det ON rep.idRepuesto = det.idRepuesto
GROUP BY rep.idRepuesto
ORDER BY numero_compras DESC;
```

## PROCEDIMIENTOS

### Caso de Uso 1: Actualización de Inventario de Bicicletas

### Caso de Uso 3: Generación de Reporte de Ventas por Cliente

```sql
DELIMITER $$
CREATE PROCEDURE reporte_cliente(
	IN idCliente_cli VARCHAR(10)
)
BEGIN
	SELECT
		cli.idCliente,
        cli.nombre,
        ven.fecha,
        ven.total,
        det.cantidad,
        det.precioUni,
        det.idBici

	FROM clientes cli
    INNER JOIN ventas ven ON cli.idCliente = ven.idCliente
    INNER JOIN detalles_ventas det ON ven.idVenta = det.idVenta
    WHERE cli.idCliente = idCliente_cli;
END $$
DELIMITER ;

CALL reporte_cliente('C001');
```

### Caso de Uso 5: Generación de Reporte de Inventario

```sql
DELIMITER $$
CREATE PROCEDURE informe_inventario()
BEGIN
SELECT 'Bicicleta:' AS tipo, bi.idBici AS id, bi.precio, bi.stock FROM bicicletas bi
UNION ALL
SELECT 'Repuesto:' AS tipo, re.idRepuesto, re.precio, re.stock FROM repuestos re;
END $$
DELIMITER ;

CALL informe_inventario();
```

### Caso de Uso 7: Generación de Reporte de Clientes por Ciudad

```sql
DELIMITER $$
CREATE PROCEDURE clientes_ciudades()
BEGIN
SELECT cli.idCiudad, ciu.nombre, COUNT(*) AS total_clientes
FROM clientes cli
INNER JOIN ciudades ciu ON cli.idCiudad = ciu.idCiudad
GROUP BY cli.idCiudad
ORDER BY total_clientes DESC;
END $$
DELIMITER ;

CALL clientes_ciudades();
```

### Caso de Uso 9: Registro de Devoluciones

```sql
DELIMITER $$
CREATE PROCEDURE devolver(
	IN idVenta_ven INT
)
BEGIN
UPDATE ventas SET total = 0 WHERE idVenta = idVenta_ven;
UPDATE detalles_ventas SET cantidad = 0, precioUni = 0 WHERE idVenta = idVenta_ven;
END $$
DELIMITER ;

CALL devolver(1);
```

### Caso de Uso 11: Calculadora de Descuentos en Ventas

```sql

```
