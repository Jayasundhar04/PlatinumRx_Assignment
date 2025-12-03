-- Q1: Revenue by channel
SELECT sales_channel, SUM(amount) AS revenue
FROM Clinic_Sales
WHERE YEAR(datetime)=2021
GROUP BY sales_channel;

-- Q2: Top 10 most valuable customers

SELECT 
    c.uid,
    c.name,
    SUM(s.amount) AS total_spent
FROM Clinic_Sales s
JOIN Customer c ON s.uid = c.uid
WHERE YEAR(s.datetime)=2021
GROUP BY c.uid, c.name
ORDER BY total_spent DESC
LIMIT 10;


-- Q3
WITH rev AS (
    SELECT 
        MONTH(datetime) AS month_no,
        SUM(amount) AS revenue
    FROM Clinic_Sales
    WHERE YEAR(datetime)=2021
    GROUP BY MONTH(datetime)
),
exp AS (
    SELECT 
        MONTH(datetime) AS month_no,
        SUM(amount) AS expense
    FROM Expenses
    WHERE YEAR(datetime)=2021
    GROUP BY MONTH(datetime)
),
all_months AS (
    SELECT month_no FROM rev
    UNION
    SELECT month_no FROM exp
)
SELECT 
    am.month_no,
    COALESCE(r.revenue,0) AS revenue,
    COALESCE(e.expense,0) AS expense,
    COALESCE(r.revenue,0) - COALESCE(e.expense,0) AS profit,
    CASE 
        WHEN COALESCE(r.revenue,0) - COALESCE(e.expense,0) > 0 
             THEN 'PROFIT' 
        ELSE 'LOSS' 
    END AS status
FROM all_months am
LEFT JOIN rev r ON am.month_no = r.month_no
LEFT JOIN exp e ON am.month_no = e.month_no
ORDER BY am.month_no;

-- Q4

WITH clinic_profit AS (
    SELECT 
        c.cid,
        c.city,
        SUM(s.amount) AS revenue,
        (SELECT SUM(amount) FROM Expenses WHERE cid=c.cid AND YEAR(datetime)=2021) AS expense
    FROM Clinics c
    LEFT JOIN Clinic_Sales s ON c.cid = s.cid AND YEAR(s.datetime)=2021
    GROUP BY c.cid, c.city
),
final AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY city ORDER BY (revenue - expense) DESC) AS rn
    FROM clinic_profit
)
SELECT cid, city, revenue, expense, (revenue-expense) AS profit
FROM final
WHERE rn = 1;

-- Q5

WITH cp AS (
    SELECT 
        c.cid,
        c.state,
        SUM(s.amount) AS revenue,
        (
            SELECT SUM(amount) 
            FROM Expenses 
            WHERE cid = c.cid 
              AND YEAR(datetime) = 2021
        ) AS expense
    FROM Clinics c
    LEFT JOIN Clinic_Sales s 
        ON c.cid = s.cid 
       AND YEAR(s.datetime) = 2021
    GROUP BY c.cid, c.state
),
ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY state 
            ORDER BY (revenue - COALESCE(expense,0)) ASC
        ) AS rn
    FROM cp
)
SELECT *
FROM ranked
WHERE rn = 2;




