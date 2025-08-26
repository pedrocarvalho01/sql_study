## SQL Interview Exercise Generator Prompt

This repository contains a **ready-to-use prompt for ChatGPT** that generates **intermediate to advanced SQL exercises** tailored for **data analysts, BI developers, data integration specialists, analytics engineers, and SQL specialists**.

### Purpose

The prompt is designed to help users practice SQL for **interviews, skill sharpening, or exam preparation**. Each execution generates a **unique exercise** with:

* Context-specific schema and tables
* Realistic sample data with potential logic traps
* Varying combinations of SQL techniques (CTEs, Window Functions, Aggregates, Subqueries, JOINs)
* Narrative problem statements (as if requested by a client)
* Expected Results displayed as **mock tables** with representative rows and column types

### How to Use

1. Open a **new ChatGPT session**.

2. Copy and paste the full prompt into the session.

3. ChatGPT will generate a **complete SQL exercise**, including:

   * **DDL**: Table creation with primary keys, foreign keys, and idempotent DROP/TRUNCATE commands
   * **DML**: Sample data populated with realistic logic traps
   * **Problem statement**: Written as a narrative for practical context
   * **Expected Results**: Mock table layout reflecting the final output structure

4. You can run the SQL code in:

   * **SQL Server (on-premises)**
   * **SQL Server Management Studio (SSMS)**
   * **Visual Studio Code with Jupyter Notebook integration**
   * Or any other SQL Server-compatible environment

5. The exercises are designed to be **idempotent**, so running the code multiple times will **not produce duplicates or errors**.

6. Each execution of the prompt generates a **different exercise**, varying:

   * Number of tables (1–3)
   * SQL techniques required
   * Table structures and Expected Results layouts
   * Sample data and business scenarios

### Notes

* Users can reuse this prompt as many times as needed to generate **daily SQL practice exercises**.
* The schema for each exercise is **randomized** (`contextXYZ`) to avoid collisions with previous exercises.
* The prompt encourages **creative, realistic, and challenging SQL scenarios**, suitable for practical learning and interview preparation.

### The prompt:

I want you to act as an SQL exercise generator for interview preparation. Generate **one exercise per request** for **intermediate to advanced SQL level**, focusing on **data analysis, business intelligence, and data integration**.

Important: Each exercise must be **significantly different from previous ones**, using new table structures, different column names, alternative business scenarios, and new tricky data combinations. Randomize dates, quantities, categories, and customer/product names each time.

Requirements:

1. **Do not provide the solution or hints** — only give the problem statement, the schema (DDL), and the sample data (DML).
2. Use **T-SQL syntax compatible with SQL Server**.
3. Use a **short, context-specific SQL schema name**, generated as the **exercise context name followed by three random digits** (e.g., if the exercise is about sales, the schema could be `sales123`). Each exercise must have a unique schema.
4. Include **primary keys, foreign keys, and realistic relationships** between tables.
5. Generate a **random number of tables for each exercise**, between 1 and 3. For each table, use meaningful column names, data types, and constraints. Randomly vary the number of tables each time so that some exercises may have only 1 table, some 2 tables, and some 3 tables.
6. Populate tables with **sample data large enough to create potential logic traps**, such as:
   - Duplicate records for the same entity
   - NULL values in optional fields
   - Missing or mismatched foreign keys
   - Overlapping date ranges
   - Multiple entries per customer or order
7. Make DDL/DML **idempotent**:
   - Drop tables if they exist before creating
   - Truncate tables before inserting data
   - Ensure that running the code multiple times will not generate duplicates or errors
8. Focus on queries that require **SQL techniques appropriate for intermediate to advanced level**, suitable for senior or SQL specialist interviews. Randomly vary which techniques are required per exercise:
   - Some exercises may only require a CTE
   - Some may only require Window Functions
   - Some may require Aggregates
   - Some may require Subqueries
   - Some may require combinations (CTE + Aggregates, Window Functions + CTE, Aggregates + Window Functions, or all together)
8.1 Ensure that **each exercise has a different combination of techniques**, so exercises are varied and unpredictable.
9. Keep the problem **realistic for roles such as Data Analyst, BI Developer, Data Integration Specialist, Data Analytics Engineer, or Analytics Engineer**. Do not restrict the scenario to specific departments or table examples; allow the exercise context to vary widely.
10. Provide the **problem statement as a narrative/enunciado**, as if a client is requesting the analysis.
11. Include **Expected Results** as a **visual table**, showing columns and a few rows of **representative mock data**, reflecting the final output structure without giving the solution.
12. Ensure the **DDL and DML are self-contained** — the user can copy them into SQL Server or a Jupyter Notebook and run immediately.
13. Include **at least one tricky scenario per table** to require careful thinking.
14. Keep the output **concise but challenging**, suitable for a 20–40 minute practice session.
15. Provide **everything in a single block**, structured as follows:

-- DDL  
[SQL code to drop/truncate and create tables with constraints]

-- DML  
[SQL code to insert sample data with logic traps]

-- Exercise  
[Narrative problem statement as a client request]  
[Expected Results: visual table mock, showing columns and representative rows]

Notes:
- Always generate **new random schema digits** per exercise to avoid collisions.
- Randomize table and column names, data values, and business scenarios each time.
- Randomly vary SQL techniques required (aggregates, window functions, subqueries, CTEs, JOINs) to maximize diversity.

More notes:
- Randomize the structure of the Expected Results table. Vary:
  - Number of columns (minimum 3, maximum 8)
  - Column names and types (text, number, date, boolean, status)
  - Metrics (aggregates, counts, averages, flags, ratios)
- Ensure each exercise produces a **unique table layout** in Expected Results, avoiding repeated default structures.
- Randomly choose business domains, table types, and metrics to make the exercise more fluid and less predictable.
