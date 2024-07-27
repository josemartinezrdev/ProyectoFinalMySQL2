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

Este caso de uso describe cómo el sistema registra una nueva venta, incluyendo la
creación de la venta y la inserción de los detalles de la venta.

```sql
INSERT INTO ventas(fecha,total, idCliente) VALUES ( '2024-02-10',0, 'C002');
```

```sql
SELECT idVenta FROM ventas WHERE idCliente = 'C002' AND fecha = '2024-02-10';
```

```sql
INSERT INTO detalles_ventas(cantidad, precioUni, idVenta, idBici) VALUES (5, 0,16,5);
```

```sql
SELECT precio FROM bicicletas WHERE idBici = 5;
```

```sql
UPDATE detalles_ventas SET precioUni = 3000 WHERE  idVenta= 16 AND idBici = 5;
```

```sql
UPDATE ventas SET total = 3000*5 WHERE idVenta = 16;
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

### Caso de Uso 4: Consulta de Historial de Ventas por Cliente

Descripción: Este caso de uso describe cómo el sistema permite a un usuario consultar el
historial de ventas de un cliente específico, mostrando todas las compras realizadas por el cliente
y los detalles de cada venta.

```sql
SELECT idVenta, fecha, total, idCliente FROM ventas
WHERE idCliente ='C002';
```

```sql
SELECT idDetalle, cantidad, precioUni, idVenta, idBici FROM detalles_ventas
WHERE idVenta IN (2,16);
```

```sql
SELECT idBici, precio, stock, idMarca, idModelo FROM bicicletas
WHERE idBici IN(2,5);
```

### Caso de Uso 5: Compras de Repuestos a Proveedores

```sql
INSERT INTO compras (fecha, total) VALUES ('2024-07-25', 1500.07);
    INSERT INTO detalles_compras (idCompra, idRepuesto, cantidad) VALUES (1, 11, 100);
    UPDATE repuestos SET stock = stock + 100 WHERE idRepuesto = 11;

```

## SUBCONSULTAS

### Caso de Uso 6: Consulta de Bicicletas Más Vendidas por Marca

Descripción: Este caso de uso describe cómo el sistema permite a un usuario consultar las
bicicletas más vendidas por cada marca.

```sql
SELECT idMarca,
		idModelo,
       idBici,
       total_vendido
FROM (
    SELECT idMarca,
			idModelo,
           idBici,
           (SELECT SUM(cantidad)
            FROM detalles_ventas
            WHERE idBici = bicicletas.idBici) AS total_vendido
    FROM bicicletas
) AS ventas_por_bici
WHERE total_vendido = (
    SELECT MAX(total_vendido)
    FROM (
        SELECT idMarca,
               (SELECT SUM(cantidad)
                FROM detalles_ventas
                WHERE idBici = bicicletas.idBici) AS total_vendido
        FROM bicicletas
    ) AS ventas_por_marca
    WHERE ventas_por_marca.idMarca = ventas_por_bici.idMarca
);
```

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

### Caso de Uso 8: Proveedores con Más Compras en el Último Mes

Descripción: Este caso de uso describe cómo el sistema permite consultar los proveedores que
han recibido más compras en el último mes.

```sql
SELECT p.idProveedor, p.nombre,
    (
        SELECT COUNT(c.idCompra)
        FROM compras c
        WHERE c.idCompra IN (
            SELECT dc.idCompra
            FROM detalles_compras dc
            WHERE dc.idRepuesto IN (
                SELECT r.idRepuesto
                FROM repuestos r
                WHERE r.idProveedor = p.idProveedor
            )
        )
        AND c.fecha BETWEEN '2024-07-01' AND '2024-07-31'
    ) AS numero_compras
FROM proveedores p
WHERE p.idProveedor IN (
    SELECT r.idProveedor
    FROM repuestos r
    WHERE r.idRepuesto IN (
        SELECT dc.idRepuesto
        FROM detalles_compras dc
        WHERE dc.idCompra IN (
            SELECT c.idCompra
            FROM compras c
            WHERE c.fecha BETWEEN '2024-07-01' AND '2024-07-31'
        )
    )
)
ORDER BY numero_compras DESC;


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

### Caso de Uso 10: Ciudades con Más Ventas Realizadas

Descripción: Este caso de uso describe cómo el sistema permite consultar las ciudades donde se
han realizado más ventas de bicicletas.

```sql
SELECT c.idCiudad, c.nombre,
    (
        SELECT COUNT(*)
        FROM ventas v
        WHERE v.idCliente IN (
            SELECT cl.idCliente
            FROM clientes cl
            WHERE cl.idCiudad = c.idCiudad
        )
    ) AS cantidad_ventas
FROM ciudades c
ORDER BY cantidad_ventas DESC;
```

## Casos de Uso con Joins

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

## Caso de Uso 12: Consulta de Proveedores por País

Descripción: Este caso de uso describe cómo el sistema permite consultar los proveedores
agrupados por país.

```sql
SELECT p.idPais, p.nombre, pr.idProveedor, pr.nombre AS nombre_proveedor
FROM paises p
JOIN ciudades c ON p.idPais = c.idPais
JOIN proveedores pr ON c.idCiudad = pr.idCiudad;
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

### Caso de Uso 14: Clientes con Ventas en un Rango de Fechas

Descripción: Este caso de uso describe cómo el sistema permite consultar los clientes que han
realizado compras dentro de un rango de fechas específico.

```sql
SELECT c.idCliente, c.nombre, v.idVenta, v.fecha
FROM clientes c
JOIN ventas v ON c.idCliente = v.idCliente
WHERE v.fecha BETWEEN '2024-07-01' AND '2024-10-30';
```

## PROCEDIMIENTOS

### Caso de Uso 1: Actualización de Inventario de Bicicletas

Descripción: Este caso de uso describe cómo el sistema actualiza el inventario de bicicletas
cuando se realiza una venta.

```sql

```

### Caso de Uso 2: Registro de Nueva Venta

Descripción: Este caso de uso describe cómo el sistema registra una nueva venta, incluyendo la
creación de la venta y la inserción de los detalles de la venta.

```sql

```

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
DELIMITER $$
CREATE PROCEDURE descuento(
	IN idVenta_ven INT,
    IN descuento_ven INT
)
BEGIN
	UPDATE ventas
    SET total = total * (1 - descuento_ven / 100)
    WHERE idVenta = idVenta_ven;
END $$
DELIMITER ;

CALL descuento(2, 50);
```

## FUNCIONES DE RESUMEN

### Caso de Uso 1: Calcular el Total de Ventas Mensuales

```sql
DELIMITER $$
CREATE PROCEDURE total_ventas_mes()
BEGIN
    SELECT MONTHNAME(fecha) AS mes, SUM(total) as total_mes
	FROM ventas
	GROUP BY mes;
END $$
DELIMITER ;

CALL total_ventas_mes();
```

### Caso de Uso 3: Contar el Número de Ventas Realizadas en un Rango de Fechas

```sql
DELIMITER $$
CREATE PROCEDURE ventas_rango_fecha(inicio DATE, fin DATE)
BEGIN
    SELECT COUNT(idVenta) AS total FROM ventas
    WHERE fecha BETWEEN inicio AND fin;
END $$
DELIMITER ;

CALL ventas_rango_fecha('2023-01-10', '2023-05-10');
```

### Caso de Uso 5: Calcular el Ingreso Total por Año

```sql
DELIMITER $$
CREATE PROCEDURE calcular_total_año()
BEGIN
SELECT YEAR(fecha) AS año, SUM(total) AS total_año
FROM ventas
GROUP BY YEAR(fecha);
END $$
DELIMITER ;

CALL calcular_total_año();
```

### Caso de Uso 7: Calcular el Promedio de Compras por Proveedor

```sql
DELIMITER $$
CREATE PROCEDURE promedio_proveedor()
BEGIN
SELECT
	prov.idProveedor,
    AVG(comp.total)
FROM compras comp
INNER JOIN detalles_compras det ON comp.idCompra = det.idCompra
INNER JOIN repuestos rep ON det.idRepuesto = rep.idRepuesto
INNER JOIN proveedores prov ON rep.idProveedor = prov.idProveedor
GROUP BY prov.idProveedor
END $$
DELIMITER ;

CALL promedio_proveedor();
```

### Caso de Uso 9: Calcular el Promedio de Precios de Bicicletas por Marca

```sql
DELIMITER $$

CREATE PROCEDURE promedio_precio_bici()
BEGIN
    SELECT
        mar.idMarca,
        mar.nombre AS nombre_marca,
        ROUND(AVG(bi.precio), 2) AS promedio_precio
    FROM bicicletas bi
    INNER JOIN marcas mar ON bi.idMarca = mar.idMarca
    GROUP BY mar.idMarca, mar.nombre;
END $$

DELIMITER ;

CALL promedio_precio_bici();
```

### Caso de Uso 11: Calcular el Total de Ingresos por Cliente

```sql
DELIMITER $$
CREATE PROCEDURE total_ingresos_cliente()
BEGIN
SELECT cli.nombre, SUM(ven.total) FROM ventas ven
INNER JOIN clientes cli ON ven.idCliente = cli.idCliente
GROUP BY cli.nombre;
END $$
DELIMITER ;

CALL total_ingresos_cliente();
```

### Caso de Uso 13: Calcular el Total de Ventas por Día de la Semana

```sql
DELIMITER $$
CREATE PROCEDURE total_dias()
BEGIN
SELECT DAYNAME(fecha) AS dia, SUM(total) AS total
FROM ventas
GROUP BY dia;
END $$
DELIMITER ;

CALL total_dias();
```

### Caso de Uso 15: Calcular el Total de Ventas por Año y Mes

```sql
DELIMITER $$
CREATE PROCEDURE total_ventas_año_mes()
BEGIN
SELECT 
	CONCAT(YEAR(fecha), '-' ,MONTH(fecha)) AS año_mes,
	SUM(total) AS total
FROM ventas
GROUP BY año_mes;
END $$
DELIMITER ;

CALL total_ventas_año_mes();
```
