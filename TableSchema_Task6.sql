-- create departments table
CREATE TABLE departments
(
  id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  location VARCHAR(30)
);

-- create employees table
CREATE TABLE employees
(
  id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  salary DECIMAL(10,2),
  dep_id  INT,
  FOREIGN KEY (dep_id) REFERENCES departments(id)
);

-- create optional project table

CREATE TABLE projects
(
  id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  manager_id INT,
  FOREIGN KEY (manager_id) REFERENCES employees(id)
);