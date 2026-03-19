
SELECT 
      {{surrogate_hash_key('CONVERT(VARCHAR(10), p.[ProductID])')}} as ProductHashKey  
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
  FROM {{ref('Silver__common__product')}} as p
