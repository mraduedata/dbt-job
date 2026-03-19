SELECT 
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
  FROM {{source('AdventureWorks', 'product')}} as p
  LEFT JOIN {{source('AdventureWorks', 'productcategory')}}  as pc
	ON pc.[ProductCategoryID] = p.ProductCategoryID
  LEFT JOIN {{source('AdventureWorks', 'productmodelproductdescription')}} as pmd
	ON pmd.ProductModelID = p.[ProductModelID]
    AND pmd.Culture = 'en'
  LEFT JOIN  {{source('AdventureWorks', 'productdescription')}} as pd
	ON pd.[ProductDescriptionID] = pmd.[ProductDescriptionID]