--Triggers

use NORTHWND

--de la base de datos Northwind. Supongamos que queremos enmascarar las columnas de número de teléfono (HomePhone y Extension) para proteger la privacidad de los clientes:
CREATE TRIGGER MaskSensitiveColumnsTrigger
ON Employees
INSTEAD OF SELECT
AS
BEGIN
    SET NOCOUNT ON;

    -- Consulta original
SELECT 
    CustomerID,
    CompanyName,
    ContactName,
    CASE 
        WHEN ISNULL(Phone, '') <> '' THEN '***-***-' + RIGHT(Phone, 4) -- Enmascarar los últimos 4 dígitos del número de teléfono
        ELSE ''
    END AS Phone,
    Country,
    City,
    CASE 
        WHEN ISNULL(Fax, '') <> '' THEN '***-***-' + RIGHT(Fax, 4) -- Enmascarar los últimos 4 dígitos del número de fax
        ELSE ''
    END AS Fax
FROM 
    Customers;

--registra las modificaciones realizadas en la tabla Products de la base de datos Northwind en una tabla de registro llamada ProductAuditLog
CREATE TRIGGER ProductAuditTrigger
ON Products
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Action NVARCHAR(10);
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        IF EXISTS (SELECT * FROM deleted)
            SET @Action = 'UPDATE';
        ELSE
            SET @Action = 'INSERT';
    END
    ELSE
        SET @Action = 'DELETE';

    INSERT INTO ProductAuditLog (ProductId, Action, AuditDateTime, UserName)
    SELECT 
        CASE @Action
            WHEN 'INSERT' THEN i.ProductId
            WHEN 'UPDATE' THEN d.ProductId
            ELSE i.ProductId
        END,
        @Action,
        GETDATE(),
        SUSER_SNAME()
    FROM 
        inserted i
    FULL OUTER JOIN 
        deleted d ON i.ProductId = d.ProductId;
END;

--Supongamos que queremos mantener un registro de las modificaciones realizadas en la tabla Orders de la base de datos Northwind. Crearemos un trigger que registre cada vez que se modifique una orden en una tabla de auditoría llamada OrderAuditLog. El registro contendrá detalles como el número de orden, la acción realizada (insertar, actualizar o eliminar), la fecha y hora de la acción, y el nombre de usuario que realizó la acción.
CREATE TRIGGER OrderAuditTrigger
ON Orders
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Action NVARCHAR(10);
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        IF EXISTS (SELECT * FROM deleted)
            SET @Action = 'UPDATE';
        ELSE
            SET @Action = 'INSERT';
    END
    ELSE
        SET @Action = 'DELETE';

    INSERT INTO OrderAuditLog (OrderID, Action, AuditDateTime, UserName)
    SELECT 
        CASE @Action
            WHEN 'INSERT' THEN i.OrderID
            WHEN 'UPDATE' THEN d.OrderID
            ELSE i.OrderID
        END,
        @Action,
        GETDATE(),
        SUSER_SNAME()
    FROM 
        inserted i
    FULL OUTER JOIN 
        deleted d ON i.OrderID = d.OrderID;
END;

--Supongamos que necesitas implementar una funcionalidad en tu base de datos para asegurarte de que cada vez que se inserta un nuevo empleado, se actualice automáticamente el campo LastUpdated en una tabla llamada EmployeeMetadata. Además, deseas que cuando se elimine un empleado, se registre esta acción en una tabla de registro llamada EmployeeDeletionLog.
-- Trigger para actualizar EmployeeMetadata cuando se inserta un nuevo empleado
CREATE TRIGGER UpdateEmployeeMetadata
ON Employees
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE EmployeeMetadata
    SET LastUpdated = GETDATE()
    WHERE EmployeeID IN (SELECT EmployeeID FROM inserted);
END;

-- Trigger para registrar eliminaciones de empleados en EmployeeDeletionLog
CREATE TRIGGER LogEmployeeDeletion
ON Employees
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO EmployeeDeletionLog (EmployeeID, DeletionDateTime, DeletedBy)
    SELECT EmployeeID, GETDATE(), SUSER_SNAME()
    FROM deleted;
END;

--Supongamos que necesitas mantener un contador de la cantidad de veces que se actualiza una columna específica en una tabla llamada Product, y deseas almacenar esta información en una tabla de auditoría llamada ColumnUpdateAudit.
CREATE TRIGGER ColumnUpdateCounter
ON Product
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UpdatedColumn NVARCHAR(50) = 'Price'; -- Columna que se está actualizando
    DECLARE @AuditCount INT;

    -- Obtener la cantidad de actualizaciones anteriores para la columna
    SELECT @AuditCount = AuditCount 
    FROM ColumnUpdateAudit 
    WHERE UpdatedColumn = @UpdatedColumn;

    -- Incrementar el contador de actualizaciones
    IF @AuditCount IS NOT NULL
    BEGIN
        SET @AuditCount = @AuditCount + 1;
        UPDATE ColumnUpdateAudit 
        SET AuditCount = @AuditCount 
        WHERE UpdatedColumn = @UpdatedColumn;
    END
    ELSE
    BEGIN
        SET @AuditCount = 1;
        INSERT INTO ColumnUpdateAudit (UpdatedColumn, AuditCount) 
        VALUES (@UpdatedColumn, @AuditCount);
    END;
END;


--Supongamos que tienes una tabla llamada Orders que registra todas las ventas realizadas en tu tienda en línea. Quieres implementar un sistema que aplique automáticamente un descuento del 10% en el total de cada venta si el cliente ha gastado más de $100 en una sola compra.
CREATE TRIGGER ApplyDiscount
ON Orders
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Actualizar el total con descuento si el monto es mayor a $100
    UPDATE o
    SET TotalAmount = TotalAmount * 0.9 -- Aplicar descuento del 10%
    FROM Orders o
    JOIN inserted i ON o.OrderID = i.OrderID
    WHERE o.TotalAmount > 100;
END;

-- Supongamos que tienes una tabla llamada Employee y deseas mantener un registro de cada vez que se actualiza el campo Salary en esa tabla en una tabla de auditoría llamada SalaryAuditLog.
CREATE TRIGGER SalaryUpdateTrigger
ON Employee
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @OldSalary DECIMAL(10, 2);
    DECLARE @NewSalary DECIMAL(10, 2);
    DECLARE @EmployeeID INT;

    SELECT @OldSalary = d.Salary, @NewSalary = i.Salary, @EmployeeID = i.EmployeeID
    FROM inserted i
    INNER JOIN deleted d ON i.EmployeeID = d.EmployeeID;

    IF @OldSalary <> @NewSalary
    BEGIN
        INSERT INTO SalaryAuditLog (EmployeeID, OldSalary, NewSalary, UpdateDateTime)
        VALUES (@EmployeeID, @OldSalary, @NewSalary, GETDATE());
    END;
END;

--un trigger que verifica si se ha insertado un nuevo producto con un precio inferior a un valor mínimo especificado en la tabla Products. Si se inserta un producto con un precio inferior, se mostrará un mensaje de advertencia.
CREATE TRIGGER VerificarPrecioProducto
ON Products
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MinPrice DECIMAL(10, 2) = 10.00; -- Precio mínimo permitido

    IF EXISTS (SELECT * FROM inserted WHERE UnitPrice < @MinPrice)
    BEGIN
        PRINT '¡ADVERTENCIA! Se ha insertado un producto con un precio inferior al mínimo permitido.';
    END;
END;

--Supongamos que tenemos una tabla llamada Products que almacena información sobre los productos en nuestra base de datos, y queremos registrar cada vez que se elimine un producto en una tabla de auditoría llamada ProductDeletionLog.
CREATE TRIGGER LogProductDeletion
ON Products
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO ProductDeletionLog (ProductID, ProductName, DeletionDateTime)
    SELECT d.ProductID, d.ProductName, GETDATE()
    FROM deleted d;
END;

--Supongamos que queremos crear un trigger que, cada vez que se inserta un nuevo pedido en la tabla Orders, verifique si todos los productos en ese pedido están en stock. Si algún producto no está en stock, queremos actualizar el estado del pedido a "Pendiente" en la tabla Orders.
CREATE TRIGGER UpdateOrderStatus
ON Orders
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar si hay productos fuera de stock en el pedido recién insertado
    IF EXISTS (
        SELECT od.OrderID
        FROM inserted i
        JOIN [Order Details] od ON i.OrderID = od.OrderID
        JOIN Products p ON od.ProductID = p.ProductID
        WHERE p.UnitsInStock < od.Quantity
    )
    BEGIN
        -- Actualizar el estado del pedido a "Pendiente"
        UPDATE o
        SET o.OrderStatus = 'Pendiente'
        FROM [Order Status] o
        JOIN inserted i ON o.OrderID = i.OrderID;
    END;
END;





