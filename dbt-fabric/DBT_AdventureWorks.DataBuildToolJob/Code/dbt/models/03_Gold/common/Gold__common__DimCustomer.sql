SELECT 
      {{surrogate_hash_key('CONVERT(VARCHAR(10), c.[CustomerID])')}} as CustomerHashKey
      ,c.[CustomerID]
      ,c.[NameStyle]
      ,c.[Title]
      ,c.[FirstName]
      ,c.[MiddleName]
      ,c.[LastName]
      ,c.[Suffix]
      ,c.[CompanyName]
      ,c.[SalesPerson]
      ,c.[EmailAddress]
      ,c.[Phone]
  FROM {{ref('Silver__common__customer')}} as c
