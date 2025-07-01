-- Insert sample departments
INSERT INTO departments (id, name, location) VALUES
(1, 'HR', 'New York'),
(2, 'Engineering', 'San Jose'),
(3, 'Sales', 'New York'),
(4, 'Finance', 'Chicago');

-- Insert sample employees
INSERT INTO employees (id, name, salary, dep_id) VALUES
(1, 'Alice', 70000, 1),
(2, 'Bob', 50000, 2),
(3, 'Charlie', 60000, 1),
(4, 'Diana', 80000, 3),
(5, 'Eve', 55000, 2),
(6, 'Frank', 75000, 3),
(7, 'Grace', 65000, NULL); -- No department

-- Insert sample projects
INSERT INTO projects (id, name, manager_id) VALUES
(1, 'Project Alpha', 1),
(2, 'Project Beta', 2),
(3, 'Project Gamma', 4);

SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM projects;


-- 1. Use Scalar and Correlated Subqueries
-- Q1: Employees earning more than the average salary 
-- (Scaler subquery)

SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- (Correlated subquery) -- Returns employees who earn more than the average salary of their department.

SELECT name
FROM employees e1
WHERE salary > (SELECT AVG(salary) FROM employees e2
               	WHERE e1.dep_id = e2.dep_id);
                
--  2. Subqueries inside IN, EXISTS, =
-- Q2: Departments that have employees
-- (EXISTS) -- For each department, check if at least one employee has e.dep_id = d.id.

 SELECT name
 FROM departments d
 WHERE EXISTS (SELECT 1 FROM employees e WHERE e.dep_id = d.id);

-- (IN) -- can Returns multiple values
 SELECT name
 FROM departments
 WHERE id IN (SELECT dep_id FROM employees);
 
-- =` (scaler) -- Returns only department name (single value) where employee name is 'Alice'.

SELECT name
FROM departments
WHERE id = (SELECT dep_id FROM employees WHERE name = 'Alice');

-- Q3. Names of employees who work in ‘New York’
-- (IN) -- subqury returns all dep_id which has location 'New York'
SELECT name
FROM employees
WHERE dep_id IN (SELECT id FROM departments WHERE location = 'New York');

-- (EXISTS) -- subqury returns 'true' for that has been location 'New York' and employees dep_id and departments id has been match
SELECT name
FROM employees e
WHERE EXISTS (SELECT 1 FROM departments d WHERE e.dep_id = d.id AND location = 'New York');

-- (= `Scaler) -- here can not use scaler oprator '=' because subqury returns multiple recordes/result but scaler operator accept only one.
-- SELECT name
-- FROM employees
-- WHERE dep_id = (SELECT dep_id FROM departments WHERE location = 'New York');

-- Q4: For each employee, find their salary vs department average (Correlated)

-- (Correlated subqury) -- It's used when need to compair a result of subquery with its self 
SELECT e1.name, salary, d.name AS dep_name
FROM employees e1
JOIN departments d ON e1.dep_id = d.id
WHERE salary > (SELECT AVG(salary) FROM employees e2 WHERE e1.dep_id = e2.dep_id);

-- Q5: Highest paid employee
-- (= `scaler)-- Here subquery return only one value 'Maximum salary' So, Scaler oprator can use in subquery
SELECT name
FROM employees 
WHERE salary = (SELECT MAX(salary) FROM employees);

-- Q6: List departments with no employees

-- This will return nothing because of NULL

-- SELECT name
-- FROM departments
-- WHERE id NOT IN (SELECT dep_id FROM employees);

-- (EXISTS) -- Here subquery retuens 'true' by NOT EXISTS that has no recordes/ rows
SELECT name
FROM departments d
WHERE NOT EXISTS (SELECT 1 FROM employees e WHERE d.id = e.dep_id );


-- Q7. List Employees who made at least one project
SELECT name
FROM employees e
WHERE EXISTS (SELECT 1 FROM projects p WHERE p.manager_id = e.id);

