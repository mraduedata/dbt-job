-- Auto Generated (Do not modify) AEBAC6628ABD525396A95447B453BBCD2982990146B63B7BBDA8A00C9703F380
create view "sales"."sales_order_header" as SELECT 
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
  FROM "LH_Bronze"."dbo"."salesorderheader";