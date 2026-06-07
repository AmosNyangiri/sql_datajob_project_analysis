/*
    Question: what are the top most paying data Analyst jobs?
    -identify the top 10 highest-paying Data Analyst roles that are available remotely.
    -focus on job postings with specified salaries (no nulls).
    -why? Highlight the top-paying opportunities for Data Analyst, offering insights into emp 
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date::DATE,
    name AS Company_name
FROM
    job_postings_fact AS job_facts
LEFT JOIN company_dim  ON job_facts.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10