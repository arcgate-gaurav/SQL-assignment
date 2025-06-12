#  BookHub SQL Assignment

##  Overview

This project is a beginner-level SQL assignment simulating the operations of an online bookstore — **BookHub**. It involves setting up the database schema, inserting data, and writing SQL queries to extract insights.

---

## Database Schema

The database consists of four tables:

- **Authors**
- **Books**
- **Customers**
- **Orders**

These tables represent a normalized structure to track book inventory, customers, and purchases.

---

## Setup Instructions

1. Create and use the database:
   ```sql
   CREATE DATABASE assignment;
   USE assignment;

2. Run the provided SQL setup script:
        mysql -u username -p < assignment.sql

This will create and populate the database with sample data.

# SQL Query Solutions
## 1. Basic Queries
### 1. Write a query to display all the authors in the database.

SELECT name FROM assignment.Authors;

### 2. Retrieve the names and emails of all customers who joined after February 1, 2023.

Select name,email from assignment.Customers where JoinDate > 2023-02-01


### 3. Find all books in the 'Fantasy' genre.

Select title FROM assignment.Books where Genre = 'Fantasy'

### 4. Display the total number of books available in stock.

SELECT SUM(Stock) AS TotalBooksInStock FROM assignment.Books;

## 2. Intermediate Queries

### 5. Show the total revenue generated from all orders.

Select SUM(Totalprice) as total_revenue from assignment.Orders 

### 6. List the details of orders placed by the customer named 'Alice Johnson.'

Select * from assignment.Orders 

join Customers on Customers.CustomerID = Orders.CustomerID

where Customers.Name = 'Alice Johnson';

### 7. Identify the book with the highest price.

SELECT TITLE
FROM   assignment.Books
WHERE  PRICE = (SELECT max(PRICE)
FROM   assignment.Books); 

### 8. Retrieve the details of books that have less than 50 units in stock.

Select * from assignment.Books where stock < 50


## 3. Joins

### 9. Write a query to list all books along with their author's name.

use assignment;
Select B.Title, A.Name from Books as B
join Authors as A on A.AuthorID = B.AuthorID;

### 10. Display all orders with the customer name and book title included.

use assignment;
Select C.Name as customer_name, B.Title as book_title, O.OrderID, O.OrderDate, O.Quantity, O.TotalPrice from Orders as O
join Customers as C on C.CustomerID = O.CustomerID
join Books as B on B.BookID = O.BookID;

## 4. Aggregations

### 11. Calculate the total number of orders placed by each customer.

Select Count(CustomerID) from assignment.Orders group by CustomerID

### 12. Find the average price of books in the 'Fiction' genre.

Select AVG(Price) from assignment.Books where Genre = 'Fiction';

### 13. Determine the author whose books have the highest combined stock.

USE assignment;
SELECT Name
FROM Authors
JOIN Books ON Books.AuthorID = Authors.AuthorID
WHERE Authors.AuthorID = (
    SELECT AuthorID as author
    FROM Books
    GROUP BY AuthorID
    ORDER BY SUM(Stock) DESC
    LIMIT 1
);

## 5. Filtering

### 14. Retrieve the names of authors born before 1950.

USE assignment;
Select Name from Authors where BirthYear < 1950

### 15. Find all customers from the 'United Kingdom.'

USE assignment;
Select * from Customers where Country = 'United Kingdom'

## 6. Advanced Queries

### 16. Write a query to list all books that have been ordered more than once.

SELECT B.BookID, B.Title, COUNT(O.BookID) AS OrderCount
FROM Books B
JOIN Orders O ON B.BookID = O.BookID
GROUP BY B.BookID, B.Title
HAVING COUNT(O.BookID) > 1;


### 17. Identify the top-selling book based on the quantity sold.

use assignment;

Select Title from assignment.Books 

join Orders on Orders.BookID = Books.BookID

Where Books.BookID = (Select BookID from Orders group by BookID order by Sum(Quantity) desc limit 1)

### 18. Calculate the total stock value for each book (price * stock).

Select price * stock as total_stock, Title from Books

## 7. Subqueries
### 19. Write a query to find the name of the customer who placed the most expensive order.

Select name from Customers 

join Orders on Orders.CustomerID = Customers.CustomerID

where TotalPrice = (Select max(TotalPrice) from Orders)

### 20. Retrieve all books that have not been ordered yet.

Select Title from Books 

WHERE BookID NOT IN (
    SELECT BookID
    FROM Orders
);