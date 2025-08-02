USE sql_study;
GO

DROP SCHEMA IF EXISTS sql_study;
GO

CREATE SCHEMA sql_study;
GO

DROP TABLE IF EXISTS sql_study.orders;
GO

CREATE TABLE sql_study.orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL
);

-- Customer 101: frequent buyer (within 30-day intervals)
INSERT INTO sql_study.orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 101, '2024-01-01', 120.00),
(2, 101, '2024-01-20', 90.00),
(3, 101, '2024-02-10', 85.00),
(4, 101, '2024-03-01', 100.00);

-- Customer 102: occasional buyer (between 31 and 90 days)
INSERT INTO sql_study.orders (order_id, customer_id, order_date, total_amount) VALUES
(5, 102, '2024-01-10', 250.00),
(6, 102, '2024-03-15', 300.00),
(7, 102, '2024-06-01', 150.00);

-- Customer 103: rare buyer (> 90 days)
INSERT INTO sql_study.orders (order_id, customer_id, order_date, total_amount) VALUES
(8, 103, '2023-01-01', 400.00),
(9, 103, '2023-10-15', 180.00),
(10, 103, '2024-08-01', 220.00);

-- Customer 104: only 1 order (should be skipped or flagged accordingly)
INSERT INTO sql_study.orders (order_id, customer_id, order_date, total_amount) VALUES
(11, 104, '2024-04-01', 500.00);

-- Customer 105: frequent again
INSERT INTO sql_study.orders (order_id, customer_id, order_date, total_amount) VALUES
(12, 105, '2024-02-05', 75.00),
(13, 105, '2024-03-01', 85.00),
(14, 105, '2024-03-25', 95.00),
(15, 105, '2024-04-20', 80.00);

-- Customer 106: orders exactly 30, 31 and 90 days apart
INSERT INTO sql_study.orders (order_id, customer_id, order_date, total_amount) VALUES
(16, 106, '2024-01-01', 100.00),   -- base
(17, 106, '2024-01-31', 105.00),   -- 30 days
(18, 106, '2024-03-02', 110.00),   -- 31 days
(19, 106, '2024-05-31', 115.00);   -- 90 days

-- Customer 107: two orders on the same day (should be treated as zero-day interval)
INSERT INTO sql_study.orders (order_id, customer_id, order_date, total_amount) VALUES
(20, 107, '2024-02-15', 200.00),
(21, 107, '2024-02-15', 250.00),
(22, 107, '2024-03-01', 190.00);

-- Customer 108: multiple small gaps, then one large gap
INSERT INTO sql_study.orders (order_id, customer_id, order_date, total_amount) VALUES
(23, 108, '2024-01-01', 90.00),
(24, 108, '2024-01-15', 95.00),   -- 14 days
(25, 108, '2024-01-30', 100.00),  -- 15 days
(26, 108, '2024-06-01', 110.00);  -- 123 days gap

-- Customer 109: decreasing gaps (rare > occasional > frequent)
INSERT INTO sql_study.orders (order_id, customer_id, order_date, total_amount) VALUES
(27, 109, '2023-01-01', 300.00),
(28, 109, '2023-05-01', 310.00),  -- 120 days
(29, 109, '2023-07-01', 320.00),  -- 61 days
(30, 109, '2023-07-20', 330.00);  -- 19 days

-- Customer 110: mixed exact thresholds (30, 90), and >90
INSERT INTO sql_study.orders (order_id, customer_id, order_date, total_amount) VALUES
(31, 110, '2023-01-01', 50.00),
(32, 110, '2023-01-31', 60.00),   -- 30 days
(33, 110, '2023-05-01', 70.00),   -- 90 days
(34, 110, '2023-09-15', 80.00);   -- > 90 days

-- Customer 111: 10+ frequent purchases to test row_number windowing
INSERT INTO sql_study.orders (order_id, customer_id, order_date, total_amount) VALUES
(35, 111, '2024-01-01', 100.00),
(36, 111, '2024-01-05', 102.00),
(37, 111, '2024-01-10', 105.00),
(38, 111, '2024-01-15', 108.00),
(39, 111, '2024-01-20', 110.00),
(40, 111, '2024-01-25', 112.00),
(41, 111, '2024-02-01', 115.00),
(42, 111, '2024-02-10', 118.00),
(43, 111, '2024-02-20', 120.00),
(44, 111, '2024-03-01', 122.00),
(45, 111, '2024-03-10', 125.00);
