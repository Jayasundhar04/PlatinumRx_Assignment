Phase 1 – SQL Proficiency

In the first phase, I worked on two systems: a Hotel Management System and a Clinic Management System. I began by creating all the required tables for both systems using SQL Server. After setting up the database skeleton, I inserted sample data to make sure the queries could be tested realistically.
Once the data was in place, I wrote multiple SQL queries to analyze different aspects of the systems. For the Hotel system, I identified the most recently booked room for each user, calculated billing amounts for specific months, filtered bills above certain thresholds, and even used window functions to determine the most and least ordered items. I also wrote a query to find the second-highest bill for each month, which required using ranking functions.

Phase 2 – Spreadsheet Proficiency

The second phase focused entirely on Excel skills. I created a new Excel workbook with two sheets: “ticket” and “feedbacks,” and filled them with sample data as instructed.
The main task here was to bring ticket information (specifically, the created_at timestamp) into the feedback sheet using the common field, cms_id. I used the INDEX–MATCH formula for this because it is more flexible than VLOOKUP and avoids many lookup issues.
After linking the data, I performed a time-based analysis. I added helper columns that checked whether tickets were created and closed on the same day or during the same hour. These were done using Excel’s INT(), HOUR(), and IF() functions. Once the helper fields were ready, I created flags for easier summarization and used a Pivot Table to count the number of same-day and same-hour closures for each outlet.

Phase 3 – Python Proficiency

The final phase involved writing two simple Python functions. The first function converts total minutes into a human-readable format like “2 hrs 10 minutes,” which required only basic arithmetic but needed careful formatting.
The second function was more logic-based. It removes duplicate characters from a string using only loops—no Python sets or shortcuts—ensuring only the first occurrence of each character is kept. 
