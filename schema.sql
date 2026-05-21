CREATE DATABASE LIB;

USE LIB;

-- =========================
-- BRANCH TABLE
-- =========================

DROP TABLE IF EXISTS branch;

CREATE TABLE branch (
    branch_id VARCHAR(10) PRIMARY KEY,
    manager_id VARCHAR(10),
    branch_address VARCHAR(60),
    contact_no VARCHAR(40)
);

-- =========================
-- EMPLOYEES TABLE
-- =========================

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    emp_id VARCHAR(10) PRIMARY KEY,
    emp_name VARCHAR(26),
    position VARCHAR(26),
    salary DECIMAL(14,2),
    branch_id VARCHAR(26),

    CONSTRAINT fk_branch
    FOREIGN KEY (branch_id)
    REFERENCES branch(branch_id)
);

-- =========================
-- BOOKS TABLE
-- =========================

DROP TABLE IF EXISTS books;

CREATE TABLE books (
    isbn VARCHAR(26) PRIMARY KEY,
    book_title VARCHAR(80),
    category VARCHAR(20),
    rental_price DECIMAL(4,2),
    status VARCHAR(15),
    author VARCHAR(35),
    publisher VARCHAR(56)
);

-- =========================
-- MEMBERS TABLE
-- =========================

DROP TABLE IF EXISTS members;

CREATE TABLE members (
    member_id VARCHAR(6) PRIMARY KEY,
    member_name VARCHAR(35),
    member_address VARCHAR(40),
    reg_date DATE
);

-- =========================
-- ISSUED STATUS TABLE
-- =========================

DROP TABLE IF EXISTS issued_status;

CREATE TABLE issued_status (
    issued_id VARCHAR(15) PRIMARY KEY,
    issued_member_id VARCHAR(15),
    issued_book_name VARCHAR(80),
    issued_date DATE,
    issued_book_isbn VARCHAR(27),
    issued_emp_id VARCHAR(15),

    CONSTRAINT fk_member_id
    FOREIGN KEY (issued_member_id)
    REFERENCES members(member_id),

    CONSTRAINT fk_books
    FOREIGN KEY (issued_book_isbn)
    REFERENCES books(isbn),

    CONSTRAINT fk_employees
    FOREIGN KEY (issued_emp_id)
    REFERENCES employees(emp_id)
);

-- =========================
-- RETURN STATUS TABLE
-- =========================

DROP TABLE IF EXISTS return_status;

CREATE TABLE return_status (
    return_id VARCHAR(15) PRIMARY KEY,
    issued_id VARCHAR(15),
    return_book_name VARCHAR(80),
    return_date DATE,
    return_book_isbn VARCHAR(40),

    CONSTRAINT fk_issued_status
    FOREIGN KEY (issued_id)
    REFERENCES issued_status(issued_id)
);