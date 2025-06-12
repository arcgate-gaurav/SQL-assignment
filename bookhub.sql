-- Step 1: SQL Commands to Create and Populate Tables

create DATABASE bookhub;
use bookhub;
-- 1. Create Tables

-- Authors Table
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Country VARCHAR(50),
    BirthYear INT
);

-- Books Table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT,
    Genre VARCHAR(50),
    Price DECIMAL(10, 2),
    Stock INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    JoinDate DATE,
    Country VARCHAR(50)
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    BookID INT,
    OrderDate DATE,
    Quantity INT,
    TotalPrice DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- 2. Insert Sample Data

-- Insert data into Authors
INSERT INTO Authors (AuthorID, Name, Country, BirthYear) VALUES
(1, 'J.K. Rowling', 'United Kingdom', 1965),
(2, 'George R.R. Martin', 'United States', 1948),
(3, 'Haruki Murakami', 'Japan', 1949);

-- Insert data into Books
INSERT INTO Books (BookID, Title, AuthorID, Genre, Price, Stock) VALUES
(1, 'Harry Potter and the Sorcerer''s Stone', 1, 'Fantasy', 19.99, 120),
(2, 'A Game of Thrones', 2, 'Fantasy', 24.99, 80),
(3, 'Norwegian Wood', 3, 'Fiction', 14.99, 50);

-- Insert data into Customers
INSERT INTO Customers (CustomerID, Name, Email, JoinDate, Country) VALUES
(1, 'Alice Johnson', 'alice@example.com', '2023-01-15', 'United States'),
(2, 'Bob Smith', 'bob@example.com', '2023-02-20', 'Canada'),
(3, 'Charlie Brown', 'charlie@example.com', '2023-03-05', 'United Kingdom');

-- Insert data into Orders
INSERT INTO Orders (OrderID, CustomerID, BookID, OrderDate, Quantity, TotalPrice) VALUES
(1, 1, 1, '2023-03-10', 2, 39.98),
(2, 2, 2, '2023-03-15', 1, 24.99),
(3, 3, 3, '2023-03-20', 3, 44.97);


-- # SQL Query Solutions
-- ## 1. Basic Queries
-- ### 1. Write a query to display all the authors in the database.


SELECT name FROM Authors;

-- ### 2. Retrieve the names and emails of all customers who joined after February 1, 2023.

Select name,email from Customers where JoinDate > '2023-02-01';


-- ### 3. Find all books in the 'Fantasy' genre.

Select title FROM Books where Genre = 'Fantasy';

-- ### 4. Display the total number of books available in stock.

SELECT SUM(Stock) AS TotalBooksInStock FROM Books;

-- ## 2. Intermediate Queries

-- ### 5. Show the total revenue generated from all orders.

Select SUM(Totalprice) as total_revenue from Orders;

-- ### 6. List the details of orders placed by the customer named 'Alice Johnson.'

Select * from Orders 

join Customers on Customers.CustomerID = Orders.CustomerID

where Customers.Name = 'Alice Johnson';

-- ### 7. Identify the book with the highest price.

SELECT TITLE
FROM   Books
WHERE  PRICE = (SELECT max(PRICE)
FROM   Books); 

-- ### 8. Retrieve the details of books that have less than 50 units in stock.

Select * from Books where stock < 50;


-- ## 3. Joins

-- ### 9. Write a query to list all books along with their author's name.

Select B.Title, A.Name from Books as B
join Authors as A on A.AuthorID = B.AuthorID;

-- ### 10. Display all orders with the customer name and book title included.

Select C.Name as customer_name, B.Title as book_title, O.OrderID, O.OrderDate, O.Quantity, O.TotalPrice from Orders as O
join Customers as C on C.CustomerID = O.CustomerID
join Books as B on B.BookID = O.BookID;

-- ## 4. Aggregations

-- ### 11. Calculate the total number of orders placed by each customer.

Select Count(CustomerID) from Orders group by CustomerID;

-- ### 12. Find the average price of books in the 'Fiction' genre.

Select AVG(Price) from Books where Genre = 'Fiction';

-- ### 13. Determine the author whose books have the highest combined stock.

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

-- ## 5. Filtering

-- ### 14. Retrieve the names of authors born before 1950.

Select Name from Authors where BirthYear < 1950;

-- ### 15. Find all customers from the 'United Kingdom.'

Select * from Customers where Country = 'United Kingdom';

-- ## 6. Advanced Queries

-- ### 16. Write a query to list all books that have been ordered more than once.

SELECT B.BookID, B.Title, COUNT(O.BookID) AS OrderCount
FROM Books B
JOIN Orders O ON B.BookID = O.BookID
GROUP BY B.BookID, B.Title
HAVING COUNT(O.BookID) > 1;


-- ### 17. Identify the top-selling book based on the quantity sold.

Select Title from Books

join Orders on Orders.BookID = Books.BookID

Where Books.BookID = (Select BookID from Orders group by BookID order by Sum(Quantity) desc limit 1);

-- ### 18. Calculate the total stock value for each book (price * stock).

Select price * stock as total_stock, Title from Books;

-- ## 7. Subqueries
-- ### 19. Write a query to find the name of the customer who placed the most expensive order.

Select name from Customers 

join Orders on Orders.CustomerID = Customers.CustomerID

where TotalPrice = (Select max(TotalPrice) from Orders);

-- ### 20. Retrieve all books that have not been ordered yet.

Select Title from Books 

WHERE BookID NOT IN (
    SELECT BookID
    FROM Orders
);