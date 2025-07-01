# ElevateLabs_Task6_sql
Author- Darji Chintankumar Dineshchandra
<br>
# Task 6: Subqueries and Nested Queries in SQL

## Objective
To gain hands-on experience using subqueries within `SELECT`, `WHERE`, and `FROM` clauses to build advanced query logic.

---

## Tools Used
- [DB Browser for SQLite]
- [MySQL Workbench]
- SQL language for RDBMS

---

## Tables Used
### 1. departments
```sql
CREATE TABLE departments (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    location TEXT
);
```
### 2. employees
``` sql
CREATE TABLE employees
(
  id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  salary DECIMAL(10,2),
  dep_id  INT,
  FOREIGN KEY (dep_id) REFERENCES departments(id)
);
```

### 3. projects (Optional)
```sql
CREATE TABLE projects
(
  id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  manager_id INT,
  FOREIGN KEY (manager_id) REFERENCES employees(id)
);
```
## Queries

### 1. Use Scalar and Correlated Subqueries
<br>

> Q1: Employees earning more than the average salary
<br>
-(Scaler subquery)
-(Correlated subquery) -- Returns employees who earn more than the average salary of their department.

###  2. Subqueries inside IN, EXISTS, =
<br>

> Q2: Departments that have employees
<br>
- (`EXISTS`) -- For each department, check if at least one employee has e.`dep_id` = d.`id`.
- (`IN`) -- can Returns multiple values
- `=` (scalar) -- Returns only department name (single value) where employee name is 'Alice'.
<br>

> Q3. Names of employees who work in ‘New York’
<br>
- (`IN`) -- subqury returns all `dep_id` which has `location` 'New York'
- (`EXISTS`) -- subqury returns 'true' for that has been `location` 'New York' and `employees` `dep_id` and `departments` `id` has been match
- -- (`=`scaler) -- here can not use scaler operator '=' because subqury returns multiple recordes/result but scaler oprator accept only one.

> Q4: For each employee, find their salary vs department average (Correlated)
- (Correlated subqury) -- It's used when need to compair a result of subquery with its self

> Q5: Highest paid employee
- (`= `scaler)-- Here subquery return only one value 'Maximum salary' So, Scaler oprator can use in subquery

> Q6: List departments with no employees
- for `IN` oprator, return nothing because of NULL, present in `employees` table
- (EXISTS) -- Here subquery retuens 'true' by `NOT EXISTS` that has no recordes/ rows

> Q7. List Employees who made at least one project
- (EXISTS) -- Returns employees name whose `id` presents in `projects` table
