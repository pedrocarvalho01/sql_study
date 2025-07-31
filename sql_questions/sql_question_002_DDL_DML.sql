CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    sale_date DATE,
    units_sold INT,
    total_amount DECIMAL(10,2)
);

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

-- Produto 4: só uma venda
INSERT INTO sales (sale_id, product_id, sale_date, units_sold, total_amount) VALUES
(11, 4, '2024-06-15', 12, 450.00);

-- Produto 5: vendas em meses consecutivos, todas abaixo de €500
INSERT INTO sales (sale_id, product_id, sale_date, units_sold, total_amount) VALUES
(12, 5, '2024-01-01', 5, 300.00),
(13, 5, '2024-02-01', 6, 280.00),
(14, 5, '2024-03-01', 7, 490.00);

-- Produto 6: vendas com grandes gaps (6 meses+), com alguns valores > €500
INSERT INTO sales (sale_id, product_id, sale_date, units_sold, total_amount) VALUES
(15, 6, '2023-01-01', 20, 550.00),
(16, 6, '2023-08-01', 10, 600.00),
(17, 6, '2024-04-01', 5, 510.00);

-- Produto 7: vendas em meses aleatórios com valores alternando < e > €500
INSERT INTO sales (sale_id, product_id, sale_date, units_sold, total_amount) VALUES
(18, 7, '2024-01-10', 10, 490.00),
(19, 7, '2024-03-15', 8, 520.00),
(20, 7, '2024-05-20', 6, 480.00),
(21, 7, '2024-06-25', 7, 530.00),
(22, 7, '2024-09-01', 5, 300.00);

-- Produto 8: vendas no mesmo mês (repetição dentro do mês)
INSERT INTO sales (sale_id, product_id, sale_date, units_sold, total_amount) VALUES
(23, 8, '2024-02-01', 5, 200.00),
(24, 8, '2024-02-10', 10, 700.00),
(25, 8, '2024-02-28', 15, 600.00);
