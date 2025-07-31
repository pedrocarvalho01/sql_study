/*
QUESTION 01

Perfeito, Pedro. Abaixo está a **primeira pergunta técnica** que eu — como entrevistadora sênior de dados para uma posição de **Data Analyst Specialist ou Lead** — faria para validar sua capacidade de análise com SQL avançado, modelagem lógica e clareza de raciocínio.

---

## 🧪 **Entrevista Técnica – Desafio SQL 01**

**Nível:** Avançado
**Foco:** Lógica analítica, performance, entendimento de negócios
**Contexto:** *E-commerce com milhões de transações por mês*

---

### 📦 **Cenário de Negócio**

Você trabalha para uma plataforma de e-commerce internacional. Seu time está revisando os KPIs de *Customer Engagement* e *Purchase Behavior*. O Product Manager quer entender melhor:

> “Quais clientes tiveram comportamento de recompra consistente nos **últimos 12 meses**, comprando pelo menos uma vez por **três meses consecutivos**?”

---

### 🛠️ **Objetivo Técnico**

Você precisa construir uma query que identifique **clientes com comportamento de recompra recorrente**, baseado na seguinte definição:

* **Considerar somente os últimos 12 meses a partir da data mais recente da tabela de pedidos.**
* O cliente deve ter realizado **pelo menos uma compra por mês**, durante **três meses consecutivos** (ex: jan-fev-mar ou nov-dez-jan).

---

### 🗂️ **Estrutura de Dados**

#### 🧱 Tabela: `orders`

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    amount DECIMAL(10, 2)
);
```

#### 📥 Dados de Exemplo:

```sql
INSERT INTO orders (order_id, customer_id, order_date, amount) VALUES
(1, 101, '2024-07-12', 120.00),
(2, 102, '2024-08-05', 89.90),
(3, 101, '2024-08-15', 230.00),
(4, 103, '2024-10-01', 50.00),
(5, 101, '2024-09-01', 100.00),
(6, 104, '2024-07-01', 75.00),
(7, 104, '2024-08-01', 75.00),
(8, 104, '2024-09-01', 75.00),
(9, 104, '2024-12-01', 80.00),
(10, 102, '2025-05-01', 199.00),
(11, 102, '2025-06-01', 300.00),
(12, 102, '2025-07-01', 310.00),
(13, 105, '2025-01-01', 60.00),
(14, 105, '2025-01-15', 120.00),
(15, 105, '2025-02-10', 60.00);
```

---

### 📌 **Instruções**

1. Crie e popule a tabela no seu ambiente.

2. Escreva uma query que retorne:

   ```
   customer_id | first_consecutive_month | last_consecutive_month | total_consecutive_months
   ```

   ...para todos os clientes que atendem à definição de recompra consistente (mínimo 3 meses consecutivos com pelo menos uma compra em cada mês).

3. Use funções de janela, CTEs ou quaisquer construções SQL que achar mais eficazes. Foque na legibilidade, escalabilidade e lógica do tempo.

---

### 📤 **Após Resolver**

Por favor, me envie:

* A **explicação da lógica que você usou**, passo a passo.
* O **código SQL completo**.
* Se quiser ir além: análise de possíveis otimizações ou edge cases.

Assim validaremos sua capacidade de pensar em múltiplos níveis: negócio, modelagem temporal e escrita SQL.

Quando estiver pronto, me envie sua resposta.

*/



-- MY ORIGINAL CODE

with _cte as (
    SELECT 
        customer_id,
        order_date,
        LEAD(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS NEXT_order_date
        ,LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS PREV_order_date
    from 
        orders
    -- WHERE
    --     order_date >= DATEADD(MONTH, -12, (select max(order_date) from orders)) -- This retrieves customer orders from the last 12 months
), _month_next_order as (
    SELECT 
        customer_id,
        order_date, NEXT_order_date, PREV_order_date
        ,CASE 
            WHEN DATEDIFF(month, order_date, NEXT_order_date) = 1 THEN 1
            WHEN DATEDIFF(month, PREV_order_date, order_date) = 1 THEN 1
            ELSE 0
        END AS months_to_next_order  
    FROM 
        _cte
), _result as (
    select
        customer_id
        ,order_date, months_to_next_order
        ,(select min(o.order_date) from _month_next_order o where o.customer_id = o1.customer_id and o.months_to_next_order = 1) as first_consecutive_month 
        ,(select max(o.order_date) from _month_next_order o where o.customer_id = o1.customer_id and o.months_to_next_order = 1) as last_consecutive_month 
        ,count(*) over (partition by customer_id, months_to_next_order) as total_consecutive_months
    from _month_next_order as o1
)
select
    customer_id, 
    max(first_consecutive_month) as first_consecutive_month, 
    max(last_consecutive_month) as last_consecutive_month, 
    max(total_consecutive_months) as total_consecutive_months
from _result
where total_consecutive_months >= 3
GROUP BY 
    customer_id
;













-- CHAT GPT ANSWER


WITH normalized_orders AS (
    SELECT DISTINCT
        customer_id,
        -- Normaliza para o primeiro dia do mês, garantindo granularidade mensal
        DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS order_month
    FROM orders
    -- WHERE 
    --     order_date >= DATEADD(MONTH, -12, (SELECT MAX(order_date) FROM orders))
),
ranked_orders AS (
    SELECT
        customer_id,
        order_month,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_month) AS rn
    FROM normalized_orders
)
,
grouped_sequences AS (
    SELECT
        customer_id,
        order_month,
        -- Chave de agrupamento: diferença entre mês e ranking
        DATEDIFF(MONTH, '2000-01-01', order_month) - rn AS grp_key
    FROM ranked_orders
) 
,
sequence_summary AS (
    SELECT
        customer_id,
        MIN(order_month) AS first_consecutive_month,
        MAX(order_month) AS last_consecutive_month,
        COUNT(*) AS total_consecutive_months
    FROM grouped_sequences
    GROUP BY customer_id, grp_key
    HAVING COUNT(*) >= 3
)
-- Resultado final
SELECT 
    customer_id,
    first_consecutive_month,
    last_consecutive_month,
    total_consecutive_months
FROM sequence_summary
ORDER BY customer_id;
