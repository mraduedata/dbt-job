-- Auto Generated (Do not modify) 884E345D9C5489B27CDDB7D3BFCB8B3409CF0A47E6D2068FA2372ED083CA07B5
create view "sales"."sales_detail" as SELECT DISTINCT
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
  FROM "LH_Bronze"."dbo"."salesorderdetail" as sod
  JOIN "LH_Bronze"."dbo"."salesorderheader" as soh 
    ON sod.SalesOrderID = soh.SalesOrderID;