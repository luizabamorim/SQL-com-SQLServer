USE [ContosoRetailDW]

/*Exerc�cios

Resumo da qtde vendida  de acordo com o canal de vendas*/

SELECT TOP(100) * FROM FactSales

SELECT channelKey AS 'Canal de Vendas',
SUM(SalesQuantity) AS 'Total'
FROM FactSales
GROUP BY channelKey

/* Agrupamento mostrando a quantidade total vendida e quantidade total devolvida de acordo com os ID's das lojas */

SELECT storeKey AS Loja,
SUM(SalesQuantity) AS 'Total vendido',
SUM(ReturnQuantity) AS 'Total Devolvido'
FROM FactSales
GROUP BY StoreKey


/* Resumo do Total vendido para cada canal de venda no ano 2007 */

SELECT channelKey AS 'Canal de Vendas',
SUM (SalesAmount) AS 'Faturamento'
FROM FactSales 
WHERE DateKey> 
GROUP BY channelKey

/* Voc� precisa fazer uma an�lise de vendas por produtos.
O objetivo final � descobrir o valor total vendido (SalesAmount) por produto (ProductKey). 
a) A tabela final dever� estar ordenada de acordo com a quantidade vendida e, al�m disso, 
mostrar apenas os produtos que tiveram um resultado final de vendas maior do que $5.000.000.  */

SELECT  TOP(100) * FROM Factsales

SELECT ProductKey AS 'ID do Produto',
SUM(SalesAmount)  AS 'Faturamento'
FROM FactSales 
GROUP BY ProductKey 
HAVING SUM(salesAmount)>5000000
ORDER BY SUM(SalesAmount) DESC

/* b) Fa�a uma adapta��o no exerc�cio anterior e mostre os Top 10 produtos com mais vendas. 
Desconsidere o filtro de $5.000.000 aplicado. */

SELECT  TOP(10) ProductKey AS 'Produto',
SUM(SalesAmount) AS 'faturamento'
FROM FactSales
GROUP BY ProductKey
ORDER BY SUM(SalesAmount) DESC

/* Exerc�cio: 
Voc� deve fazer uma consulta � tabela FactOnlineSales e descobrir qual � o ID (CustomerKey) do cliente que mais realizou compras online 
(de acordo com a coluna SalesQuantity). */

SELECT TOP (100) * FROM FactOnlineSales

SELECT CustomerKey AS 'ID Cliente',
SUM(SalesQuantity) AS 'Faturamento'
FROM FactOnlineSales
GROUP BY CustomerKey
ORDER BY SUM(SalesQuantity) DESC


/*Feito isso, fa�a um agrupamento de total vendido (SalesQuantity) por ID do produto e descubra quais foram os top 3 
produtos mais comprados pelo cliente da letra a).*/

SELECT TOP(3) ProductKey AS 'ID Produto',
SUM(SalesQuantity) AS 'Total Vendido'
FROM  FactOnlineSales
WHERE CustomerKey = 19037
GROUP BY ProductKey
ORDER BY SUM(SalesQuantity) DESC

/*
Fa�a um agrupamento e descubra a quantidade total de produtos por marca.
*/

SELECT Brandname AS 'Marca',
COUNT(BrandName)  AS 'Produto'
FROM DimProduct
GROUP BY BrandName


/*
Determine a m�dia do pre�o unit�rio (UnitPrice) para cada ClassName.
*/
SELECT ClassName as'CLASSE',
AVG(UnitPrice) AS 'M�dia de Pre�o'
FROM DimProduct
GROUP BY (ClassName)

/*
Voc� dever� descobrir o peso total para cada tipo de produto (StockTypeName). 
A tabela final deve considerar apenas a marca �Contoso� e ter os seus valores classificados em ordem decrescente.
*/

SELECT TOP(100) * FROM DimProduct

SELECT StockTypeName AS 'Tipo de Produto',
SUM(Weight) AS 'Peso'
FROM DimProduct
GROUP BY StockTypeName


/* Voc� seria capaz de confirmar se todas as marcas dos produtos possuem � disposi��o todas as 16 op��es de cores? */

SELECT BrandName,
COUNT(DISTINCT(ColorName)) AS 'Cores'
FROM DimProduct
GROUP BY BrandName

SELECT DISTINCT(ColorName)
FROM DimProduct

/*
Fa�a um agrupamento para descobrir a quantidade total de clientes e a m�dia salarial de acordo com o seu n�vel escolar. 
Utilize a coluna Education da tabela DimCustomer para fazer esse agrupamento. 
*/

SELECT TOP(100) *FROM DimCustomer

SELECT Education AS 'N�vel Escolar',
COUNT(Education) AS 'Qtde',
AVG(YearlyIncome) AS 'M�dia Salarial'
FROM DimCustomer
WHERE Education IS NOT NULL
GROUP BY Education


/*
Fa�a uma tabela resumo mostrando a quantidade total 
de funcion�rios de acordo com o Departamento (DepartmentName). 
Importante: Voc� dever� considerar apenas os funcion�rios ativos. 
*/


SELECT TOP(100) * FROM DimEmployee

SELECT DepartmentName,
COUNT (FirstName) AS 'Qtde'
FROM DimEmployee
WHERE EndDate IS NULL
GROUP BY DepartmentName
