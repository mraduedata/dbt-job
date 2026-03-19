SELECT {{surrogate_hash_key('CONVERT(VARCHAR(10), a.[AddressID])')}} as AddressHashKey
      ,[AddressID]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[City]
      ,[StateProvince]
      ,[CountryRegion]
      ,[PostalCode]
  FROM {{ref('Silver__common__address')}} a
