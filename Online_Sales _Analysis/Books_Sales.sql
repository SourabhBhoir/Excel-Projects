use books_selling;

-- Create Database
CREATE DATABASE OnlineBookstore;

use  OnlineBookstore;

-- Create Tables
DROP TABLE IF EXISTS Books;

CREATE TABLE Books (
    Book_ID Int PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

-- 1) Retrieve all books in the "Fiction" genre:
select * from books 
where Genre ="Fiction" ;

-- 2) Find books published after the year 1950:
select * from books
where Published_Year >1950 ;

-- 3) List all customers from the Canada:
select * from customers
where City ="Canada";

-- 4) Show orders placed in November 2023:
select * from orders 
where Order_Date between '11/01/2023' and '11/30/2023';

-- 5) Retrieve the total stock of books available:
select count(Stock) as Total_Stock
from books;

-- 6) Find the details of the most expensive book:
select * from books 
order by Price
limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from orders
where Quantity >1;

-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders
where Total_Amount >20;


-- 9) List all genres available in the Books table:
select distinct Genre from books;

-- 10) Find the book with the lowest stock:
select * from books 
order by Price;

-- Advance Questions : 

-- Advance Questions : 
-- 1) Retrieve the total number of books sold for each genre:
select * from orders;

select b.Genre, sum(o.Quantity) as Revenue
from orders o
join books b on o.Order_ID = b.Book_ID
group by Genre;

-- 2) Find the average price of books in the "Fantasy" genre:
select avg(Price) as Avg_Price from books
where Genre="Fantasy"

-- 3) List customers who have placed at least 2 orders:
select o.Customer_ID ,c.Name,sum(o.Order_ID) as Total_Order_Count
from orders o
join customers c on o.Customer_ID = c.Customer_ID
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >=2;

-- 4) Find the most frequently ordered book:
SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM books
WHERE genre ='Fantasy'
ORDER BY price DESC LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:

SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;

-- 7) List the cities where customers who spent over $30 are located:

SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.total_amount > 30;

-- 8) Find the customer who spent the most on orders:
SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc LIMIT 1;


-- 9) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;

SELECT * FROM Books limit 1;
SELECT * FROM customers limit 1;
SELECT * FROM Orders limit 1;


