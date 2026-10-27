CREATE TABLE jobs (
    job_id INT,
    job_title VARCHAR(50) DEFAULT '',
    min_salary DECIMAL(10,2) DEFAULT 8000,
    max_salary DECIMAL(10,2) DEFAULT NULL
);

INSERT INTO jobs (job_id)
VALUES (101);
