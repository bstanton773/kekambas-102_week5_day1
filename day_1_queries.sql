-- "Hello World" of SQL - SELECT all records from a table
SELECT * -- * means ALL columns
FROM actor;


-- Query specific columns - SELECT column_name, ... FROM table_name
SELECT last_name, first_name
FROM actor;


-- Get all rows and columns from the film table
SELECT *
FROM film;


-- Filter rows - use the WHERE clause - always comes after the FROM 
SELECT *
FROM actor 
WHERE first_name = 'Nick';

-- Using the LIKE operator
SELECT *
FROM actor 
WHERE first_name LIKE 'Nick';

-- Using the LIKE operator with % - % acts as a wildcard - can be any number of characters (0-infinty)
SELECT *
FROM actor 
WHERE first_name LIKE 'J%'; -- RETURN ANY record that has a first_name that starts WITH J

-- Using the LIKE operator with _ - _ acts as a wildcard for 1 and only 1 character
SELECT *
FROM actor 
WHERE first_name LIKE '_i_'; -- ANY record that has a first_name OF 3 letters WITH the 2nd letter being an i

-- Use % and _ in same pattern
SELECT *
FROM actor 
WHERE first_name LIKE '_i%';


-- Using AND and OR in our WHERE clause
-- OR - only one needs to be TRUE 
SELECT *
FROM actor 
WHERE first_name LIKE 'N%' OR last_name LIKE 'W%';

-- AND - all conditions need to be TRUE 
SELECT *
FROM actor 
WHERE first_name LIKE 'N%' AND last_name LIKE 'W%';


-- Comparing Operators in SQL:
-- Greater Than (>) - Less Than (<)
-- Greater Than or Equal (>=) -- Less Than or Equal (<=)
-- Equal (=) -- Not Equal (<>)


-- Explore data or new table with SELECT *
SELECT *
FROM payment;


-- Query for all payments that are GREAT THAN $4.00
SELECT customer_id, amount
FROM payment 
WHERE amount > 4;

SELECT customer_id, amount
FROM payment 
WHERE amount > '4';


-- Query for all payments that are NOT 7.99
SELECT customer_id, amount
FROM payment 
WHERE amount <> '7.99';

-- Get all the payments between $3 and $8 (inclusive)
SELECT *
FROM payment 
WHERE amount >= 3 AND amount <= 8;

-- BETWEEN/AND clause
SELECT *
FROM payment 
WHERE amount BETWEEN 3 AND 8;


-- Order our rows of data by using the ORDER BY clause (default ascending)
SELECT *
FROM payment 
WHERE amount BETWEEN 3 AND 8
ORDER BY payment_date;

-- To order in descending order use the ORDER BY clause + DESC
SELECT *
FROM payment 
WHERE amount BETWEEN 3 AND 8
ORDER BY amount DESC;

-- Ordering by Strings - Alphabetical
SELECT *
FROM actor 
ORDER BY last_name;




-- SQL Aggregations => SUM(), AVG(), COUNT(), MIN(), MAX()
-- takes in a column_name as an argument and returns a value

-- Get the sum of all of the payments
SELECT SUM(amount)
FROM payment;


-- Get the sum of all payments of more than $5
SELECT SUM(amount)
FROM payment 
WHERE amount > 5;

-- Get the average of all payments of more than $5
SELECT AVG(amount)
FROM payment 
WHERE amount > 5;


-- Get the count of all payments of more than $5
SELECT COUNT(*)
FROM payment 
WHERE amount > 5;


-- Get the min and max of payments - also alias the column name 
SELECT MIN(amount) AS lowest_amount_paid
FROM payment;


SELECT MAX(amount) AS highest_amount_paid
FROM payment;


-- Calcualte a column based on two other columns 
SELECT payment_id, rental_id, payment_id - rental_id AS difference
FROM payment;



-- Query the number of payments per amount
SELECT COUNT(*)
FROM payment 
WHERE amount = 4.99;

-- GROUP BY clause - used with Aggregations
SELECT amount, COUNT(*), SUM(amount), AVG(amount)
FROM payment
GROUP BY amount;


-- columns from the table must also be used in the GROUP BY
SELECT amount, customer_id, COUNT(*)
FROM payment
GROUP BY amount; -- ERROR: column "payment.customer_id" must appear in the GROUP BY clause or be used in an aggregate FUNCTION

-- Query the payment table to display the customers who have spent the most (aka order by sum(amount))
SELECT customer_id, SUM(amount)
FROM payment 
GROUP BY customer_id
ORDER BY SUM(amount) DESC;

-- Alias our aggregation column and use aliased name in ORDER BY
SELECT customer_id, SUM(amount) AS total_spent
FROM payment 
GROUP BY customer_id
ORDER BY total_spent DESC;


-- HAVING clause => HAVING is to GROUP BY/Aggregations as WHERE is to SELECT 

--Query the payment table to display the customers who have spent the most having made at least 40 payments
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING COUNT(*) >= 40
ORDER BY total_spent DESC;


--LIMIT and OFFSET clause

-- LIMIT - limit the number of rows that are returned
SELECT *
FROM film
LIMIT 10;

-- OFFSET - start your rows after a certain amount using OFFSET
SELECT *
FROM actor
OFFSET 10; -- SKIP OVER THE FIRST 10 ROWS

-- Put together
SELECT *
FROM actor 
OFFSET 10
LIMIT 5;


-- Putting all the clauses into one query
-- Display customers 11-20 who have spent the most most in under 20 payments and has a customer_id > 350
SELECT customer_id, SUM(amount), COUNT(*)
FROM payment 
WHERE customer_id > 350
GROUP BY customer_id 
HAVING COUNT(*) < 20
ORDER BY SUM(amount)
OFFSET 10
LIMIT 10;



-- Syntax Order: (SELECT and FROM are the only mandatory keywords)
--SELECT
--FROM 
--JOIN
--ON
--WHERE 
--GROUP BY 
--HAVING 
--ORDER BY 
--OFFSET
--LIMIT 
