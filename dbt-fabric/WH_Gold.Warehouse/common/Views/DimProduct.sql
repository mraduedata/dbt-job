-- Auto Generated (Do not modify) 4C7E9A8EA3443D82AD82F03B928C0F0A77F03D4040F3CD9B2C53B4F843DED0D8
create view "common"."DimProduct" as SELECT 
      HASHBYTES('SHA2_256', CONVERT(VARCHAR(10), p.[ProductID])) as ProductHashKey  
      ,p.[ProductID]
      ,p.[Name]
      ,p.[ProductNumber]
      ,p.[Color]
      ,p.[StandardCost]
      ,p.[ListPrice]
      ,p.[Size]
      ,p.[Weight]
	  ,p.[ProductCategory]
	  ,p.[ProductCatalogDescription]
  FROM "WH_Silver"."common"."product" as p;