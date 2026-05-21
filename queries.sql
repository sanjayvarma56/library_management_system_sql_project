-- =========================================
-- VIEW ALL TABLES DATA
-- =========================================

SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM members;
SELECT * FROM return_status;



-- =========================================
-- TASK 1: ADD NEW BOOK
-- =========================================

INSERT INTO books VALUES
('978-1-60129-456-2',
'To Kill a Mockingbird',
'Classic',
6.00,
'yes',
'Harper Lee',
'J.B. Lippincott & Co.');



-- =========================================
-- TASK 2: UPDATE MEMBER ADDRESS
-- =========================================

UPDATE members
SET member_address = '125 Oak St'
WHERE member_id = 'C103';



-- =========================================
-- TASK 3: DELETE ISSUED RECORD
-- =========================================

DELETE FROM issued_status
WHERE issued_id = 'IS121';



-- =========================================
-- TASK 4: BOOKS ISSUED BY EMPLOYEE
-- =========================================

SELECT *
FROM issued_status
WHERE issued_emp_id = 'E101';



-- =========================================
-- TASK 5: MEMBERS WHO ISSUED MORE THAN ONE BOOK
-- =========================================

SELECT
    issued_emp_id,
    COUNT(*) AS total_books_issued
FROM issued_status
GROUP BY issued_emp_id
HAVING COUNT(*) > 1;



-- =========================================
-- TASK 6: BOOK ISSUE COUNT
-- =========================================

CREATE TABLE book_cnts AS
SELECT
    b.isbn,
    b.book_title,
    COUNT(ist.issued_id) AS no_of_issued
FROM books AS b
JOIN issued_status AS ist
ON ist.issued_book_isbn = b.isbn
GROUP BY b.isbn, b.book_title;

SELECT * FROM book_cnts;



-- =========================================
-- TASK 7: BOOKS BY CATEGORY
-- =========================================

SELECT *
FROM books
WHERE category = 'Fiction';

SELECT
    category,
    COUNT(*) AS no_cate
FROM books
WHERE category IN ('Classic', 'Fantasy')
GROUP BY category;



-- =========================================
-- TASK 8: TOTAL RENTAL INCOME BY CATEGORY
-- =========================================

SELECT
    b.category,
    SUM(b.rental_price) AS total_rental_income,
    COUNT(*) AS total_books_issued
FROM books AS b
JOIN issued_status AS ist
ON ist.issued_book_isbn = b.isbn
GROUP BY b.category;



-- =========================================
-- TASK 9: MEMBERS REGISTERED IN LAST 180 DAYS
-- =========================================

SELECT *
FROM members
WHERE reg_date >= CURDATE() - INTERVAL 180 DAY;



-- =========================================
-- TASK 10: EMPLOYEES WITH BRANCH DETAILS
-- =========================================

SELECT
    e1.emp_id,
    e1.emp_name,
    e1.position,
    e1.salary,
    b.branch_address,
    b.contact_no,
    e2.emp_name AS manager
FROM employees AS e1
JOIN branch AS b
ON e1.branch_id = b.branch_id
JOIN employees AS e2
ON e2.emp_id = b.manager_id;



-- =========================================
-- TASK 11: EXPENSIVE BOOKS TABLE
-- =========================================

CREATE TABLE expensive_books AS
SELECT *
FROM books
WHERE rental_price > 6.50;

SELECT * FROM expensive_books;



-- =========================================
-- TASK 12: BOOKS NOT YET RETURNED
-- =========================================

SELECT *
FROM issued_status AS ist
LEFT JOIN return_status AS rs
ON rs.issued_id = ist.issued_id
WHERE rs.return_id IS NULL;