# SQL Interview Exercise Generator Prompt

This repository contains a ready-to-use prompt for ChatGPT that generates intermediate to advanced SQL exercises tailored for **data analysts, BI developers, data integration specialists, analytics engineers, and SQL specialists**.

---

## 🎯 Purpose

The prompt is designed to help users practice SQL for **interviews, skill sharpening, or exam preparation**. Each execution generates a **unique, realistic exercise** with:

- Context-specific schema and tables, using **short randomized schema names** (contextXYZ).  
- Realistic sample data, including **duplicates, NULLs, and tricky edge cases**.  
- Exercises requiring **1–2 SQL techniques only** (CTEs, Window Functions, Aggregates, Subqueries, JOINs).  
- Narrative problem statements written as if requested by a client.  
- **Expected Results** displayed as mock tables with representative rows and column types.

---

## 🛠 How to Use

1. Open a new ChatGPT session.  
2. Copy and paste the full prompt into the session.  
3. ChatGPT will generate a **complete SQL exercise**, including:

   - **DDL**: Table creation with primary keys, foreign keys, and **idempotent DROP/DELETE commands**.  
   - **DML**: Sample data populated with realistic logic traps.  
   - **Problem Statement**: Written as a narrative for practical context.  
   - **Expected Results**: Mock table layout reflecting the final output.

4. Run the SQL code in any **SQL Server-compatible environment**, such as:

   - SQL Server (on-premises)  
   - SQL Server Management Studio (SSMS)  
   - Visual Studio Code with Jupyter Notebook integration  

The exercises are **idempotent**, so running the code multiple times will **not produce duplicates or errors**.

---

## 🔄 Variability

Each execution of the prompt generates a **different exercise**, varying:

- Number of tables (1–2)  
- SQL techniques required (maximum 2 per exercise)  
- Table structures and Expected Results layouts  
- Sample data and business scenarios, including edge cases  

This ensures **daily practice with unique, realistic challenges**.

---

## ⚠ Notes

- The prompt is designed for **intermediate to advanced SQL practice**.  
- Each exercise is solvable within **15–30 minutes**.  
- Only **1–2 tasks/questions** per exercise are included, focusing on a **single SQL problem or clear combination of techniques**.  
- **Schema, table, and column names are randomized** to avoid collisions with previous exercises.  

### The prompt:

see https://github.com/pedrocarvalho01/sql_study/blob/main/chatgpt_prompt.txt