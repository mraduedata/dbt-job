-- Auto Generated (Do not modify) F06EE60F1F2FEF50B55B3C234AB1AF0F62C8BA365D6D3B9C75580415B9166614
create view "common"."customer" as SELECT [CustomerID]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[CompanyName]
      ,[SalesPerson]
      ,[EmailAddress]
      ,[Phone]
  FROM "LH_Bronze"."dbo"."customer";