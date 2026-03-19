-- Auto Generated (Do not modify) 6B1CA3C0272C6A2296D82B96F2AC4DEEE7193214BF974D467CD88E14E4538304
create view "sales"."FactSalesDetail" as 
SELECT 
      --troubleshooting keys
      CONVERT(INT, CONVERT(VARCHAR(4), DATEPART(yyyy, sd.[OrderDate])) + 
    RIGHT('0'+ CONVERT(VARCHAR(2), DATEPART(mm, sd.[OrderDate])), 2) + 
    RIGHT('0'+ CONVERT(VARCHAR(2), DATEPART(dd, sd.[OrderDate])), 2)) as OrderDateKey
      ,CONVERT(INT, CONVERT(VARCHAR(4), DATEPART(yyyy, sd.[DueDate])) + 
    RIGHT('0'+ CONVERT(VARCHAR(2), DATEPART(mm, sd.[DueDate])), 2) + 
    RIGHT('0'+ CONVERT(VARCHAR(2), DATEPART(dd, sd.[DueDate])), 2)) as DueDateKey
      ,CONVERT(INT, CONVERT(VARCHAR(4), DATEPART(yyyy, sd.[ShipDate])) + 
    RIGHT('0'+ CONVERT(VARCHAR(2), DATEPART(mm, sd.[ShipDate])), 2) + 
    RIGHT('0'+ CONVERT(VARCHAR(2), DATEPART(dd, sd.[ShipDate])), 2)) as ShipDateKey
      ,HASHBYTES('SHA2_256', CONVERT(VARCHAR(10), sd.[ShipToAddressID])) as ShipToAddressHashKey
      ,HASHBYTES('SHA2_256', CONVERT(VARCHAR(10), sd.[BillToAddressID])) as BillToAddressHashKey
      ,HASHBYTES('SHA2_256', CONVERT(VARCHAR(10), sd.[CustomerID])) as CustomerHashKey
      ,HASHBYTES('SHA2_256', CONVERT(VARCHAR(10), sd.[ProductID])) as ProductHashKey
      ,[SalesOrderDetailID]
      ,[ProductID]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[CustomerID]
      ,[ShipToAddressID]
      ,[BillToAddressID]
      --measures
      ,[OrderQty]
      ,[UnitPrice]
      ,[UnitPriceDiscount]
      ,[LineTotal]
  FROM "WH_Silver"."sales"."sales_detail" as sd;