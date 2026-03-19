-- Auto Generated (Do not modify) 87D044274C18756C764019EE7EEBF2BA98A583DE5A0E4C50D1FF222C5FF1B6E5
create view "common"."DimAddress" as SELECT HASHBYTES('SHA2_256', CONVERT(VARCHAR(10), a.[AddressID])) as AddressHashKey
      ,[AddressID]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[City]
      ,[StateProvince]
      ,[CountryRegion]
      ,[PostalCode]
  FROM "WH_Silver"."common"."address" a;