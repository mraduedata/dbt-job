
SELECT

      {{surrogate_date_key('soh.[OrderDate]')}} as OrderDateKey
      ,{{surrogate_date_key('soh.[DueDate]')}} as DueDateKey
      ,{{surrogate_date_key('soh.[ShipDate]')}} as ShipDateKey
      ,{{surrogate_hash_key('CONVERT(VARCHAR(10), soh.[ShipToAddressID])')}} as ShipToAddressHashKey
      ,{{surrogate_hash_key('CONVERT(VARCHAR(10), soh.[BillToAddressID])')}} as BillToAddressHashKey
      ,{{surrogate_hash_key('CONVERT(VARCHAR(10), soh.[CustomerID])')}} as CustomerHashKey
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
  FROM {{ref('Silver__sales__sales_order_header')}} as soh 

