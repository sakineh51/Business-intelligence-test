---question 1 -------
SELECT SUM(quantity*unitprice) as TotalSale
FROM SaleTABLE;

--- question 2 -------
SELECT COUNT(DISTINCT customer) as total_customer FROM SaleTABLE;

--- question 3 -------
SELECT product, sum(quantity) as Total_sale
FROM SaleTABLE 
GROUP BY product;


--- question 4 -------
SELECT  a1.customer,sum(a1.purchase_sum) as purchase_sum,COUNT(a1.customer) as Factor_count,
		sum(a1.purchase_count) as purchase_count
        from (SELECT customer,sum(quantity) as purchase_count,sum(quantity*unitprice) as purchase_sum
        FROM SaleTABLE
        GROUP BY orderid
        HAVING sum(quantity*unitprice)>1500) a1
        GROUP BY a1.customer
        

--- question 5 -------
 SELECT sum(a1.profit_percent) as profit_percent ,sum(a1.profit_amount) as profit_amount 
 		from (SELECT sum(SaleTABLE.quantity)* (SaleProfit.ProfitRatio)/100.0 as profit_percent,
        sum(SaleTABLE.quantity*SaleTABLE.unitprice)* (SaleProfit.ProfitRatio)/100.0 as profit_amount
        FROM SaleTABLE
        INNER JOIN SaleProfit
        ON SaleTABLE.product=SaleProfit.Product
        GROUP BY SaleTABLE.Product) a1  


 --- question 6 -------       
SELECT COUNT(a1.customer) as customers from (SELECT customer, date FROM SaleTABLE
GROUP BY date, customer) a1


--- last -------

CREATE TABLE 'Organization_chart' ('Id' INTEGER,'name' TEXT,'manager' TEXT,'Manager_Id' INTEGER)


WITH cte (EmpId, EmpName, ManagerName, LEVEL) AS (
SELECT id, name, CAST('' AS VARCHAR) as ManagerName, 1 AS LEVEL
FROM Organization_chart
WHERE manager_id IS NULL

UNION ALL

SELECT e1.id, e1.name, CAST(cte.EmpName AS VARCHAR) ManagerName, (cte.LEVEL + 1) AS LEVEL
FROM Organization_chart e1
    JOIN cte ON e1.manager_id = cte.EmpId    
)
SELECT EmpName, ManagerName, LEVEL FROM cte
ORDER BY EmpName            
