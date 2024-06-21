IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Author')
BEGIN
    CREATE TABLE Author (
        author_id INT PRIMARY KEY,
        author_name VARCHAR(255)
    );
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Book')
BEGIN
    CREATE TABLE Book (
        book_id INT PRIMARY KEY,
        title VARCHAR(255),
        publisher VARCHAR(255),
        publication_date DATE,
        price DECIMAL(10, 2),
        quantity_in_stock INT,
        author_id INT,
        FOREIGN KEY (author_id) REFERENCES Author(author_id)
    );
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Customer')
BEGIN
    CREATE TABLE Customer (
        customer_id INT PRIMARY KEY,
        customer_name VARCHAR(255),
        address VARCHAR(255),
        email VARCHAR(255)
    );
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Order')
BEGIN
    CREATE TABLE [Order] (
        order_id INT PRIMARY KEY,
        order_date TIMESTAMP,
        customer_id INT,
        FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
    );
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Order_Detail')
BEGIN
    CREATE TABLE Order_Detail (
        order_detail_id INT PRIMARY KEY,
        order_id INT,
        book_id INT,
        quantity_ordered INT,
        price DECIMAL(10, 2),
        FOREIGN KEY (order_id) REFERENCES [Order](order_id),
        FOREIGN KEY (book_id) REFERENCES Book(book_id)
    );
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_book_title')
BEGIN
    CREATE INDEX idx_book_title ON Book(title);
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_order_customer_id')
BEGIN
    CREATE INDEX idx_order_customer_id ON [Order](customer_id);
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_order_detail_book_id')
BEGIN
    CREATE INDEX idx_order_detail_book_id ON Order_Detail(book_id);
END;
