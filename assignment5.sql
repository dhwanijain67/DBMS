-- 1. Employees with a higher salary than the employee whose last_name = 'Bull'
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT salary FROM employees WHERE last_name = 'Bull');

-- 2. Employees who work in the IT department
SELECT first_name, last_name
FROM employees
WHERE department_id IN (SELECT department_id FROM departments WHERE department_name = 'IT');

-- 3. Employees who have a manager and work in a USA-based department
SELECT first_name, last_name
FROM employees
WHERE manager_id IN (SELECT employee_id FROM employees)
  AND department_id IN (
      SELECT department_id FROM departments
      WHERE location_id IN (SELECT location_id FROM locations WHERE country_id = 'US'));

-- 4. Employees who are managers
SELECT first_name, last_name
FROM employees
WHERE employee_id IN (SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL);

-- 5. Employees whose salary is greater than the average salary
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 6. Employees whose salary equals the minimum salary for their job grade
SELECT first_name, last_name, salary
FROM employees e
WHERE salary = (SELECT min_salary FROM jobs j WHERE j.job_id = e.job_id);

-- 7. Employees earning more than the average salary and working in any IT department
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
  AND department_id IN (SELECT department_id FROM departments WHERE department_name LIKE 'IT%');

-- 8. Employees who earn more than Mr. Bell
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT salary FROM employees WHERE last_name = 'Bell');

-- 9. Employees who earn the same salary as the minimum salary of any department
SELECT first_name, last_name, salary
FROM employees
WHERE salary IN (SELECT MIN(salary) FROM employees GROUP BY department_id);

-- 10. Employees whose salary is greater than the average salary of all departments
SELECT first_name, last_name, salary
FROM employees
WHERE salary > ALL (SELECT AVG(salary) FROM employees GROUP BY department_id);

-- 11. Employees earning more than all Shipping Clerks (SH_CLERK), sorted low to high
SELECT first_name, last_name, salary
FROM employees
WHERE salary > ALL (SELECT salary FROM employees WHERE job_id = 'SH_CLERK')
ORDER BY salary;

-- 12. Employees who are not supervisors
SELECT first_name, last_name
FROM employees
WHERE employee_id NOT IN (SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL);

-- 13. Employee ID, first name, last name and department name of all employees
SELECT employee_id, first_name, last_name,
       (SELECT department_name FROM departments d WHERE d.department_id = e.department_id) AS department_name
FROM employees e
ORDER BY department_name;

-- 14. Employees whose salary is above the average for their own department
SELECT employee_id, first_name, last_name, salary
FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id);

-- 15. Even-numbered records (MySQL 8.0+)
SELECT *
FROM (SELECT e.*, ROW_NUMBER() OVER (ORDER BY employee_id) AS rn FROM employees e) t
WHERE rn % 2 = 0;

-- 15 (alternative, older MySQL without window functions)
-- SELECT * FROM employees WHERE MOD(employee_id, 2) = 0;

-- 16. 5th maximum salary
SELECT DISTINCT salary
FROM employees e1
WHERE 4 = (SELECT COUNT(DISTINCT salary) FROM employees e2 WHERE e2.salary > e1.salary);

-- 17. 4th minimum salary
SELECT DISTINCT salary
FROM employees e1
WHERE 3 = (SELECT COUNT(DISTINCT salary) FROM employees e2 WHERE e2.salary < e1.salary);

-- 18. Last 10 records
SELECT *
FROM (SELECT * FROM employees ORDER BY employee_id DESC LIMIT 10) t
ORDER BY employee_id;

-- 19. Departments where no employee is working
SELECT department_id, department_name
FROM departments d
WHERE NOT EXISTS (SELECT 1 FROM employees e WHERE e.department_id = d.department_id);

-- 20. 3 maximum salaries
SELECT DISTINCT salary
FROM employees a
WHERE 3 > (SELECT COUNT(DISTINCT salary) FROM employees b WHERE b.salary > a.salary)
ORDER BY salary DESC;

-- 21. 3 minimum salaries
SELECT DISTINCT salary
FROM employees a
WHERE 3 > (SELECT COUNT(DISTINCT salary) FROM employees b WHERE b.salary < a.salary)
ORDER BY salary;

-- 22. nth maximum salary (replace n with a number, e.g. 5)
SELECT DISTINCT salary
FROM employees e1
WHERE (n - 1) = (SELECT COUNT(DISTINCT salary) FROM employees e2 WHERE e2.salary > e1.salary);
