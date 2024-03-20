CREATE PROCEDURE spVentasTotalesPorEmpleadoYAnio
    @NombreEmpleado NVARCHAR(50),
    @AnioInicial INT,
    @AnioFinal INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Obtener las ventas totales por empleado y año
    SELECT 
        e.EmployeeID,
        CONCAT(e.FirstName, ' ', e.LastName) AS 'NombreEmpleado',
        YEAR(o.OrderDate) AS 'Año',
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS 'VentasTotales'
    FROM Employees AS e
    INNER JOIN Orders AS o ON e.EmployeeID = o.EmployeeID
    INNER JOIN [Order Details] AS od ON o.OrderID = od.OrderID
    WHERE CONCAT(e.FirstName, ' ', e.LastName) = @NombreEmpleado
      AND YEAR(o.OrderDate) BETWEEN @AnioInicial AND @AnioFinal
    GROUP BY e.EmployeeID, CONCAT(e.FirstName, ' ', e.LastName), YEAR(o.OrderDate);
END;

EXEC spVentasTotalesPorEmpleadoYAnio 
    @NombreEmpleado = 'Robert King', 
    @AnioInicial = 1995, 
    @AnioFinal = 1997;

	CREATE PROCEDURE spPrecioPromedioPorCategoria
    @PrecioMinimo MONEY
AS
BEGIN
    SET NOCOUNT ON;

    -- Obtener el precio promedio por categoría
    SELECT 
        c.CategoryID,
        c.CategoryName,
        AVG(p.UnitPrice) AS 'PrecioPromedio'
    FROM Categories AS c
    INNER JOIN Products AS p ON c.CategoryID = p.CategoryID
    GROUP BY c.CategoryID, c.CategoryName
    HAVING AVG(p.UnitPrice) > @PrecioMinimo;
END;

EXEC spPrecioPromedioPorCategoria @PrecioMinimo = 20.0;