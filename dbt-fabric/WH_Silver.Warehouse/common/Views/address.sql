-- Auto Generated (Do not modify) B5AB634967E9935E934A337494FCE678691225B7AA323966204B46A7B72A620D
create view "common"."address" as SELECT [AddressID]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[City]
      ,[StateProvince]
      ,[CountryRegion]
      ,[PostalCode]
  FROM "LH_Bronze"."dbo"."address";