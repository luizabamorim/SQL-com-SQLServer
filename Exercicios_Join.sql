/* JOINS */

USE [ContosoRetailDW]

/* EXERCÍCIOS  */

/* 1)Utilize o INNER JOIN para trazer os nomes das subcategorias dos produtos, da tabela DimProductSubcategory para a tabela DimProduct. */

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory


SELECT 
	ProductName AS 'Produto',
	ProductSubcategoryName AS 'Subcategoria'
FROM 
	DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
	
	
/* 2) Identifique uma coluna em comum entre as tabelas DimProductSubcategory e DimProductCategory. 
Utilize essa coluna para complementar informações na tabela DimProductSubcategory a partir da 
DimProductCategory. Utilize o LEFT JOIN. */

SELECT TOP(100) * FROM DimProductSubcategory
SELECT TOP(100) * FROM DimProductCategory

SELECT 
	ProductSubcategoryKey AS 'ID da Categoria',
	ProductCategoryDescription AS 'Categoria',
	ProductSubcategoryDescription AS 'Subcategoria'
FROM
	DimProductSubcategory
LEFT JOIN DimProductCategory
	ON DimProductSubcategory.ProductCategoryKey=DimProductCategory.ProductCategoryKey


/*	3) Para cada loja da tabela DimStore, descubra qual o Continente e o Nome do País associados (de acordo com DimGeography). 
Seu SELECT final deve conter apenas as seguintes colunas: StoreKey, StoreName, EmployeeCount, ContinentName e RegionCountryName. */

SELECT TOP(100) * FROM DimStore
SELECT TOP(100) * FROM  DimGeography

SELECT 
	StoreKey AS 'ID',
	StoreName AS'Loja',
	EmployeeCount AS 'Qtde Funcionários',
	ContinentName AS 'Continente',
	RegionCountryName AS 'País'
FROM 
	DimStore
LEFT JOIN DimGeography
	ON DimStore.GeographyKey=DimGeography.GeographyKey

	
/* 4) Complemente a tabela DimProduct com a informação de ProductCategoryDescription. */

SELECT TOP(100) * FROM DimProduct
SELECT TOP(100) * FROM DimProductCategory
SELECT TOP(100) * FROM DimProductSubcategory

SELECT 
	ProductName AS 'Nome',
	ProductDescription AS 'Descrição',
	ProductCategoryDescription  AS 'Categoria'
FROM DimProduct
LEFT JOIN DimProductSubcategory
	ON DimProductSubcategory.ProductSubcategoryKey=DimProduct.ProductSubcategoryKey
		LEFT JOIN DimProductCategory
			ON	DimProductCategory.ProductCategoryKey= DimProductSubcategory.ProductCategoryKey



/*SELECT 
	ProductCategoryName,
	ProductCategoryDescription,
	   ProductSubcategoryName
FROM DimProductCategory
LEFT JOIN DimProductSubcategory
	ON	DimProductCategory.ProductCategoryKey= DimProductSubcategory.ProductCategoryKey */

/* 5) A tabela FactStrategyPlan resume o planejamento estratégico da empresa.
Cada linha representa um montante destinado a uma determinada AccountKey.

Faça um INNER JOIN para criar uma tabela contendo o AccountName para cada AccountKey da tabela FactStrategyPlan. 
O seu SELECT final deve conter as colunas:
• StrategyPlanKey
• DateKey
• AccountName
• Amount
*/

SELECT TOP(100) * FROM FactStrategyPlan
SELECT TOP(100) * FROM DimAccount

SELECT 
	AccountName,
	StrategyPlanKey,
	Datekey,
	Amount
FROM FactStrategyPlan
INNER JOIN DimAccount
	ON DimAccount.AccountKey=FactStrategyPlan.AccountKey


--* 6) Algumas subcategorias não possuem nenhum exemplar de produto. Identifique que subcategorias são essas.

SELECT TOP(100) * FROM DimProduct
SELECT TOP(100) * FROM DimProductSubcategory

SELECT 
	ProductName,
	ProductSubcategoryName
FROM DimProduct
RIGHT JOIN DimProductSubcategory
	ON  DimProduct.ProductSubcategoryKey=DimProductSubcategory.ProductCategoryKey
WHERE ProductName IS NULL


/* 7) Crie uma tabela que mostre a combinação entre Marca e Canal de Venda, para as marcas Contoso, Fabrikam e Litware. */

SELECT 
	DISTINCT BrandName,
	ChannelName
FROM
	DimProduct CROSS JOIN DimChannel
WHERE BrandName IN ('Contoso','Fabrikam', 'Litware')

/* 8)Neste exercício, você deverá relacionar as tabelas FactOnlineSales com DimPromotion. 
Identifique a coluna que as duas tabelas têm em comum e utilize-a para criar esse relacionamento.
Retorne uma tabela contendo as seguintes colunas:
• OnlineSalesKey
• DateKey
• PromotionName
• SalesAmount
*/

SELECT TOP(100) * FROM FactOnlineSales
SELECT TOP(100) * FROM DimPromotion

SELECT 
	OnlineSalesKey,
	DateKey,
	PromotionName,
	SalesAmount
FROM DimPromotion
INNER JOIN FactOnlineSales
	ON DimPromotion.PromotionKey=FactOnlineSales.PromotionKey


/* A sua consulta deve considerar apenas as linhas de vendas referentes a produtos com desconto (PromotionName <> ‘No Discount’).
Além disso, você deverá ordenar essa tabela de acordo com a coluna DateKey, em ordem crescente. */

SELECT TOP(1000)
	OnlineSalesKey,
	DateKey,
	PromotionName,
	SalesAmount
FROM DimPromotion
INNER JOIN FactOnlineSales
	ON DimPromotion.PromotionKey=FactOnlineSales.PromotionKey
WHERE PromotionName <>'No Discount'
ORDER BY DateKey ASC
