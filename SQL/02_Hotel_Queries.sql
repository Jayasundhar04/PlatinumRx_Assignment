-- Q1 — Last booked room for every user
SELECT 
    u.user_id,
    b.room_no,
    b.booking_date
FROM Users u
LEFT JOIN (
    SELECT 
        user_id,
        room_no,
        booking_date
    FROM Bookings b1
    WHERE booking_date = (
        SELECT MAX(booking_date)
        FROM Bookings b2
        WHERE b2.user_id = b1.user_id
    )
) b ON u.user_id = b.user_id;


-- Q2 — November 2021 booking total bill

SELECT 
    b.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_amount
FROM Bookings b
JOIN Booking_Commercials bc ON b.booking_id = bc.booking_id
JOIN Items i ON bc.item_id = i.item_id
WHERE MONTH(b.booking_date)=11 AND YEAR(b.booking_date)=2021
GROUP BY b.booking_id;

-- Q3 — Bills in October 2021 having amount > 1000

SELECT 
    bc.bill_id,
    SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM Booking_Commercials bc
JOIN Items i ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date)=10 AND YEAR(bc.bill_date)=2021
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;

-- Q4 — Monthly most & least ordered items (Window Functions)

WITH Monthly AS (
    SELECT 
        YEAR(bc.bill_date) AS year,
        MONTH(bc.bill_date) AS month,
        bc.item_id,
        i.item_name,
        SUM(bc.item_quantity) AS total_qty
    FROM Booking_Commercials bc
    JOIN Items i ON bc.item_id = i.item_id
    GROUP BY YEAR(bc.bill_date), MONTH(bc.bill_date), bc.item_id, i.item_name
),
Ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY year, month ORDER BY total_qty DESC) AS rn_desc,
        ROW_NUMBER() OVER (PARTITION BY year, month ORDER BY total_qty ASC) AS rn_asc
    FROM Monthly
)
(
    SELECT 
        year,
        month,
        item_name AS most_ordered_item
    FROM Ranked
    WHERE rn_desc = 1

    UNION ALL

    SELECT 
        year,
        month,
        item_name AS least_ordered_item
    FROM Ranked
    WHERE rn_asc = 1
);


-- Q5 — Second highest bill per month

WITH BillTotals AS (
    SELECT 
        bc.bill_id,
        YEAR(bc.bill_date) AS year,
        MONTH(bc.bill_date) AS month,
        SUM(bc.item_quantity * i.item_rate) AS bill_amount
    FROM Booking_Commercials bc
    JOIN Items i ON bc.item_id = i.item_id
    GROUP BY bc.bill_id, YEAR(bc.bill_date), MONTH(bc.bill_date)
),
Ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY year, month ORDER BY bill_amount DESC) AS rn
    FROM BillTotals
)
SELECT *
FROM Ranked
WHERE rn = 2;

