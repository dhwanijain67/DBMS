

-- 1. Number of jobs available in the employees table
SELECT COUNT(DISTINCT job_id) AS number_of_jobs
FROM employees;

-- 2. Total salaries payable to employees
SELECT SUM(salary) AS total_salary
FROM employees;

-- 3. Minimum salary from employees table
SELECT MIN(salary) AS min_salary
FROM employees;

-- 4. Maximum salary of an employee working as a Programmer
SELECT MAX(salary) AS max_salary
FROM employees
WHERE job_id = 'IT_PROG';

-- 5. Average salary and number of employees in department 90
SELECT AVG(salary) AS avg_salary, COUNT(*) AS num_employees
FROM employees
WHERE department_id = 90;

-- 6. Highest, lowest, sum and average salary of all employees
SELECT MAX(salary) AS highest_salary,
       MIN(salary) AS lowest_salary,
       SUM(salary) AS total_salary,
       AVG(salary) AS average_salary
FROM employees;

-- 7. Number of employees with the same job
SELECT job_id, COUNT(*) AS num_employees
FROM employees
GROUP BY job_id;

-- 8. Difference between the highest and lowest salaries
SELECT MAX(salary) - MIN(salary) AS salary_difference
FROM employees;

-- 9. Manager ID and salary of the lowest-paid employee for that manager
SELECT manager_id, MIN(salary) AS lowest_salary
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id;

-- 10. Department ID and total salary payable in each department
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id;

-- 11. Average salary for each job ID excluding Programmer
SELECT job_id, AVG(salary) AS avg_salary
FROM employees
WHERE job_id <> 'IT_PROG'
GROUP BY job_id;

-- 12. Total, maximum, minimum and average salary job ID wise, for department 90 only
SELECT job_id,
       SUM(salary) AS total_salary,
       MAX(salary) AS max_salary,
       MIN(salary) AS min_salary,
       AVG(salary) AS avg_salary
FROM employees
WHERE department_id = 90
GROUP BY job_id;

-- 13. Job ID and maximum salary where the maximum salary is >= 4000
SELECT job_id, MAX(salary) AS max_salary
FROM employees
GROUP BY job_id
HAVING MAX(salary) >= 4000;

-- 14. Average salary for all departments employing more than 10 employees
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 10;
