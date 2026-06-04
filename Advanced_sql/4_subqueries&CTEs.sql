SELECT * FROM
( --subquery starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;
-- subquery ends here


---------------------------------
---- CTE
---------------------------------
WITH january_jobs AS(
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)
SELECT * FROM january_jobs;

-----------------------------------

WITH company_job_count AS (
    SELECT company_id, 
    COUNT(*) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)

SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count
ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC