{{config(alias='FactSalesDetail')}}
SELECT 
      --troubleshooting keys
      {{surrogate_date_key('sd.[OrderDate]')}} as OrderDateKey
      ,{{surrogate_date_key('sd.[DueDate]')}} as DueDateKey
      ,{{surrogate_date_key('sd.[ShipDate]')}} as ShipDateKey
      ,{{surrogate_hash_key('CONVERT(VARCHAR(10), sd.[ShipToAddressID])')}} as ShipToAddressHashKey
      ,{{surrogate_hash_key('CONVERT(VARCHAR(10), sd.[BillToAddressID])')}} as BillToAddressHashKey
      ,{{surrogate_hash_key('CONVERT(VARCHAR(10), sd.[CustomerID])')}} as CustomerHashKey
      ,{{surrogate_hash_key('CONVERT(VARCHAR(10), sd.[ProductID])')}} as ProductHashKey
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
  FROM {{ref('Silver__sales__sales_detail')}} as sd
