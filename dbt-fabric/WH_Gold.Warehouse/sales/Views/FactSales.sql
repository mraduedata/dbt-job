-- Auto Generated (Do not modify) 851A9C12173D14113B7E04F03298663FF12488545388A0752683D1A16F004A00
create view "sales"."FactSales" as SELECT

      CONVERT(INT, CONVERT(VARCHAR(4), DATEPART(yyyy, soh.[OrderDate])) + 
    RIGHT('0'+ CONVERT(VARCHAR(2), DATEPART(mm, soh.[OrderDate])), 2) + 
    RIGHT('0'+ CONVERT(VARCHAR(2), DATEPART(dd, soh.[OrderDate])), 2)) as OrderDateKey
      ,CONVERT(INT, CONVERT(VARCHAR(4), DATEPART(yyyy, soh.[DueDate])) + 
    RIGHT('0'+ CONVERT(VARCHAR(2), DATEPART(mm, soh.[DueDate])), 2) + 
    RIGHT('0'+ CONVERT(VARCHAR(2), DATEPART(dd, soh.[DueDate])), 2)) as DueDateKey
      ,CONVERT(INT, CONVERT(VARCHAR(4), DATEPART(yyyy, soh.[ShipDate])) + 
    RIGHT('0'+ CONVERT(VARCHAR(2), DATEPART(mm, soh.[ShipDate])), 2) + 
    RIGHT('0'+ CONVERT(VARCHAR(2), DATEPART(dd, soh.[ShipDate])), 2)) as ShipDateKey
      ,HASHBYTES('SHA2_256', CONVERT(VARCHAR(10), soh.[ShipToAddressID])) as ShipToAddressHashKey
      ,HASHBYTES('SHA2_256', CONVERT(VARCHAR(10), soh.[BillToAddressID])) as BillToAddressHashKey
      ,HASHBYTES('SHA2_256', CONVERT(VARCHAR(10), soh.[CustomerID])) as CustomerHashKey
      --For troubleshooting
      ,soh.[SalesOrderID] -- Primary key
      ,soh.[OrderDate]
      ,soh.[DueDate]
      ,soh.[ShipDate]
      ,soh.[SalesOrderNumber] -- degenerate keys
      ,soh.[PurchaseOrderNumber] -- degenerate keys
      ,soh.[AccountNumber] -- degenerate keys
      ,soh.[CustomerID]
      ,soh.[ShipToAddressID]
      ,soh.[BillToAddressID]
      --Total Measures
      ,soh.[SubTotal]
      ,soh.[TaxAmt]
      ,soh.[Freight]
      ,soh.[TotalDue]
  FROM "WH_Silver"."sales"."sales_order_header" as soh;