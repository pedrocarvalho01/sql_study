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

see https://github.com/pedrocarvalho01/sql_study/blob/main/chatgpt_prompt.txt