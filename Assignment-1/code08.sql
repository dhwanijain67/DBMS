CREATE TABLE job_histry (
    employee_id INT,
    start_date DATE,
    end_date DATE CHECK (TO_CHAR(end_date, 'DD/MM/YY') IS NOT NULL),
    job_id VARCHAR(10),
    department_id INT
);

INSERT INTO job_histry
VALUES (101, TO_DATE('01/01/25', 'DD/MM/YY'),
        TO_DATE('27/10/26', 'DD/MM/YY'), 'IT_PROG', 10);
