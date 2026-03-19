SELECT 
       [SalesOrderID] -- Primary key
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[SalesOrderNumber] -- degenerate keys
      ,[PurchaseOrderNumber] -- degenerate keys
      ,[AccountNumber] -- degenerate keys
      ,[CustomerID]
      ,[ShipToAddressID]
      ,[BillToAddressID]
      --Total Measures
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
      ,[TotalDue]
  FROM {{source('AdventureWorks', 'salesorderheader')}} 
