CREATE TABLE job_histry (
    employee_id INT,
    start_date DATE,
    end_date DATE CHECK (TO_CHAR(end_date, 'DD/MM/YY') IS NOT NULL),
    job_id VARCHAR(10),
    department_id INT
);
