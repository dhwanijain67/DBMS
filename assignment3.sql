-- 1.
SELECT first_name, last_name, salary
FROM employees
WHERE salary NOT BETWEEN 10000 AND 15000;
--2.
SELECT first_name, last_name, department_id
FROM employees
WHERE department_id IN (30, 100)
ORDER BY department_id ASC;
--3
SELECT first_name, last_name, salary
FROM employees
WHERE salary NOT BETWEEN 10000 AND 15000
AND department_id IN (30, 100);
--4
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '1987-01-01'
AND hire_date < '1988-01-01';
--5.
SELECT e.last_name, j.job_title, e.salary
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
WHERE j.job_title IN ('Programmer', 'Shipping Clerk')
AND e.salary NOT IN (4500, 10000, 15000);

SELECT last_name
FROM employees
WHERE CHAR_LENGTH(last_name) = 6;

SELECT last_name
FROM employees
WHERE CHAR_LENGTH(last_name) = 6;

SELECT last_name
FROM employees
WHERE last_name LIKE '__e%';

SELECT DISTINCT j.job_title
FROM employees e
JOIN jobs j ON e.job_id = j.job_id;

SELECT first_name, last_name, salary,
       salary * 0.15 AS PF
FROM employees;

SELECT *
FROM employees
WHERE UPPER(last_name) IN ('BLAKE', 'SCOTT', 'KING', 'FORD');
