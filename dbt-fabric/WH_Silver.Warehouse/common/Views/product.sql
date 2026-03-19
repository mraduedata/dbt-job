-- Auto Generated (Do not modify) 5C1EF3195A05C8B4030100A1CF58B11FC29165B93C1FFC33D22304B5ECF82209
create view "common"."product" as SELECT 
      p.[ProductID]
      ,p.[Name]
      ,p.[ProductNumber]
      ,p.[Color]
      ,p.[StandardCost]
      ,p.[ListPrice]
      ,p.[Size]
      ,p.[Weight]
	  ,pc.Name as ProductCategory
    ,CONVERT(VARCHAR(1000), pd.Description) as ProductCatalogDescription
  FROM "LH_Bronze"."dbo"."product" as p
  LEFT JOIN "LH_Bronze"."dbo"."productcategory"  as pc
	ON pc.[ProductCategoryID] = p.ProductCategoryID
  LEFT JOIN "LH_Bronze"."dbo"."productmodelproductdescription" as pmd
	ON pmd.ProductModelID = p.[ProductModelID]
    AND pmd.Culture = 'en'
  LEFT JOIN  "LH_Bronze"."dbo"."productdescription" as pd
	ON pd.[ProductDescriptionID] = pmd.[ProductDescriptionID];