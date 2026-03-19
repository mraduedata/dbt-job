SELECT DISTINCT
      sod.[SalesOrderDetailID] --primary Key
      ,sod.[ProductID]
      ,soh.[OrderDate]
      ,soh.[DueDate]
      ,soh.[ShipDate]
      ,soh.[CustomerID]
      ,soh.[ShipToAddressID]
      ,soh.[BillToAddressID]
      --measures
      ,sod.[OrderQty]      
      ,sod.[UnitPrice]
      ,sod.[UnitPriceDiscount]
      ,sod.[LineTotal]
  FROM {{source('AdventureWorks', 'salesorderdetail')}} as sod
  JOIN {{source('AdventureWorks', 'salesorderheader')}} as soh 
    ON sod.SalesOrderID = soh.SalesOrderID