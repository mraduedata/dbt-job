-- Auto Generated (Do not modify) 00D6C6616A0144ED1669BEC8700D69182406FC6C0418D608B40A05B18DDAAA86
create view "common"."DimCustomer" as SELECT 
      HASHBYTES('SHA2_256', CONVERT(VARCHAR(10), c.[CustomerID])) as CustomerHashKey
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
  FROM "WH_Silver"."common"."customer" as c;