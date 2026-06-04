SELECT 
    COUNT(job_id) AS Total,
    EXTRACT(MONTH FROM job_posted_date) As Month
FROM
    job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY
    Month
ORDER BY Month ASC;