

-- Q1. Create a simple countries table.
CREATE TABLE countries (
    country_id INT,
    country_name VARCHAR(50),
    region_id INT
);

-- Q2. Create countries only if it does not already exist.
CREATE TABLE IF NOT EXISTS countries (
    country_id INT,
    country_name VARCHAR(50),
    region_id INT
);

-- Q3. Create only the structure of dup_countries, copying countries' columns.
CREATE TABLE dup_countries LIKE countries;

-- Q4. Copy both structure and data from countries to dup_countries.
-- Run this instead of Q3 if you want the table to contain the data too.
CREATE TABLE dup_countries AS
SELECT * FROM countries;

-- Q5. Create a countries table with a column that allows NULL values.
-- (The question's wording, "set a constraint NULL", is ambiguous; this shows
-- an explicit NULL-allowing column.)
CREATE TABLE countries_null_example (
    country_id INT NULL,
    country_name VARCHAR(50),
    region_id INT
);

-- Q6. Ensure max_salary does not exceed 25000.
CREATE TABLE jobs_check (
    job_id VARCHAR(10),
    job_title VARCHAR(35),
    min_salary DECIMAL(6,0),
    max_salary DECIMAL(6,0),
    CHECK (max_salary <= 25000)
);

-- Q7. Allow only Italy, India, and China.
CREATE TABLE countries_allowed (
    country_id INT,
    country_name VARCHAR(50),
    region_id INT,
    CHECK (country_name IN ('Italy', 'India', 'China'))
);

-- Q8. Store end_date as a date. Use a DATE value such as '2026-10-27'
-- when inserting; display formatting is handled by SELECT, not by the column.
CREATE TABLE job_histry (
    employee_id INT,
    start_date DATE,
    end_date DATE,
    job_id VARCHAR(10),
    department_id INT
);

-- Q9. Disallow duplicate country_id values.
CREATE TABLE countries_unique (
    country_id INT UNIQUE,
    country_name VARCHAR(50),
    region_id INT
);

-- Q10. Set defaults for job_title, min_salary, and max_salary.
CREATE TABLE jobs_defaults (
    job_id VARCHAR(10),
    job_title VARCHAR(35) NOT NULL DEFAULT '',
    min_salary DECIMAL(6,0) DEFAULT 8000,
    max_salary DECIMAL(6,0) DEFAULT NULL
);

-- Q11. Make country_id the primary key.
CREATE TABLE countries_pk (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(50),
    region_id INT
);

-- Q12. Unique, automatically generated country_id (MySQL).
CREATE TABLE countries_auto (
    country_id INT NOT NULL AUTO_INCREMENT UNIQUE,
    country_name VARCHAR(50),
    region_id INT
);

-- Q13. Make the combination of country_id and region_id unique.
CREATE TABLE countries_composite_unique (
    country_id INT,
    country_name VARCHAR(50),
    region_id INT,
    UNIQUE (country_id, region_id)
);

-- Q14. employee_id must be unique and job_id must exist in jobs.
-- Requires jobs(job_id) to exist and be a primary/unique key.
CREATE TABLE job_history (
    employee_id INT UNIQUE,
    start_date DATE,
    end_date DATE,
    job_id VARCHAR(10),
    department_id INT,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
) ENGINE=InnoDB;

-- Q15. Composite foreign key (department_id, manager_id) references
-- the matching composite key in departments. The parent table must have
-- UNIQUE/PRIMARY KEY (department_id, manager_id).
-- NOTE: The question's supplied departments structure marks both columns PRI.
CREATE TABLE employees_composite_fk (
    employee_id INT UNIQUE,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id VARCHAR(10),
    salary DECIMAL(8,2),
    commission DECIMAL(4,2),
    manager_id DECIMAL(6,0),
    department_id DECIMAL(4,0),
    FOREIGN KEY (department_id, manager_id)
        REFERENCES departments(department_id, manager_id)
) ENGINE=InnoDB;

-- Q16. employee_id unique; department_id and job_id reference parent tables.
CREATE TABLE employees_fk (
    employee_id INT UNIQUE,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id VARCHAR(10),
    salary DECIMAL(8,2),
    commission DECIMAL(4,2),
    manager_id INT,
    department_id DECIMAL(4,0),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
) ENGINE=InnoDB;

-- Q17. ON UPDATE CASCADE; ON DELETE RESTRICT.
-- Assumes jobs.job_id is INT and is a primary/unique key as in the question.
CREATE TABLE employees_update_cascade (
    employee_id INT UNIQUE,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    job_id INT,
    salary DECIMAL(8,2),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Q18. ON DELETE CASCADE; ON UPDATE RESTRICT.
CREATE TABLE employees_delete_cascade (
    employee_id INT UNIQUE,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    job_id INT,
    salary DECIMAL(8,2),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
) ENGINE=InnoDB;

-- Q19. ON DELETE SET NULL; ON UPDATE SET NULL.
-- job_id must allow NULL.
CREATE TABLE employees_set_null (
    employee_id INT UNIQUE,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    job_id INT NULL,
    salary DECIMAL(8,2),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
        ON DELETE SET NULL
        ON UPDATE SET NULL
) ENGINE=InnoDB;

-- Q20. ON DELETE NO ACTION; ON UPDATE NO ACTION.
CREATE TABLE employees_no_action (
    employee_id INT UNIQUE,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    job_id INT,
    salary DECIMAL(8,2),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE=InnoDB;
