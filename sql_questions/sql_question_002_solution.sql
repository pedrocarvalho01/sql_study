/*

🧩 Pergunta Técnica 02 – SQL (nível sênior)
🎯 Objetivo:
Para cada produto vendido, calcular:

O número total de unidades vendidas.

O primeiro mês em que foi vendido.

O número de meses com vendas acima de €500.

O maior intervalo em meses entre duas vendas consecutivas do mesmo produto.

📁 Tabelas
sql
Copy
Edit
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    sale_date DATE,
    units_sold INT,
    total_amount DECIMAL(10,2)
);
🧪 DML de exemplo (inserção de dados)
sql
Copy
Edit
INSERT INTO sales (sale_id, product_id, sale_date, units_sold, total_amount) VALUES
(1, 1, '2024-01-05', 10, 400.00),
(2, 1, '2024-02-10', 20, 600.00),
(3, 1, '2024-04-10', 30, 700.00),
(4, 2, '2024-01-15', 15, 300.00),
(5, 2, '2024-05-15', 10, 520.00),
(6, 2, '2024-07-20', 5, 280.00),
(7, 3, '2024-03-01', 25, 800.00),
(8, 3, '2024-04-01', 10, 200.00),
(9, 3, '2024-06-01', 15, 600.00),
(10, 3, '2024-10-01', 5, 180.00);
📌 Regras e observações:
Agrupar por product_id.

Os meses são considerados no nível de ano+mês (FORMAT(sale_date, 'yyyy-MM') no SQL Server).

O maior intervalo entre duas vendas consecutivas deve ser em número de meses inteiros. Use funções como DATEDIFF(MONTH, ...).

Se o produto tiver apenas uma venda, o maior intervalo será NULL.

📤 Output esperado (exemplo)
product_id	total_units	first_sale_month	high_value_months	max_gap_months
1	60	2024-01	2	2
2	30	2024-01	1	2
3	55	2024-03	2	4

✅ Entrega esperada:
Você deve me retornar apenas a explicação da query e a query completa em SQL Server, como se estivesse em uma entrevista técnica formal.

Se desejar variações da questão (com CTEs obrigatórias, janelas obrigatórias, performance constraints, etc.), posso adaptar.

Pode ir em frente.

*/
use sql_study;
GO


-- MY PROPOSED SOLUTION
with _cte as (
SELECT 
    s.product_id
    ,SUM(units_sold) OVER (PARTITION BY s.product_id) AS total_units
    ,MIN(FORMAT(s.sale_date, 'yyyy-MM')) OVER (PARTITION BY s.product_id) AS first_sale_month
    ,COUNT(CASE WHEN s.total_amount > 500 THEN 1 END) OVER (PARTITION BY s.product_id) AS sales_over_500
    ,LAG(s.sale_date) OVER (PARTITION BY s.product_id ORDER BY s.sale_date) AS last_sale_date
    ,DATEDIFF(MONTH, LAG(s.sale_date) OVER (PARTITION BY s.product_id ORDER BY s.sale_date), s.sale_date) AS gap_months
FROM 
    sales s
)
SELECT 
    product_id,
    total_units,
    first_sale_month,
    sales_over_500,
    MAX(gap_months) AS max_gap_months
FROM 
    _cte
GROUP BY 
    product_id, total_units, first_sale_month, sales_over_500;









-- CHAT GPT SUGGESTED SOLUTION

-- Step 1: Create a CTE to add the previous sale date per product
WITH sales_with_lag AS (
    SELECT 
        s.product_id,
        s.sale_date,
        s.units_sold,
        s.total_amount,
        
        -- Retrieve the previous sale date for each product, ordered by sale_date
        LAG(s.sale_date) OVER (
            PARTITION BY s.product_id 
            ORDER BY s.sale_date
        ) AS previous_sale_date
        
    FROM sales s
),

-- Step 2: Aggregate results per product
aggregated AS (
    SELECT 
        product_id,
        
        -- Total number of units sold across all sales
        SUM(units_sold) AS total_units,
        
        -- Month of the first recorded sale (formatted as YYYY-MM)
        FORMAT(MIN(sale_date), 'yyyy-MM') AS first_sale_month,
        
        -- Number of sales where total_amount exceeded 500 EUR
        COUNT(CASE WHEN total_amount > 500 THEN 1 END) AS sales_over_500,
        
        -- Maximum gap in months between consecutive sales
        MAX(DATEDIFF(MONTH, previous_sale_date, sale_date)) AS max_gap_months
        
    FROM sales_with_lag
    GROUP BY product_id
)

-- Step 3: Return final output
SELECT * FROM aggregated;
