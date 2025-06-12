-- Step 1: SQL Commands to Create and Populate Tables

create schema assignment;
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


