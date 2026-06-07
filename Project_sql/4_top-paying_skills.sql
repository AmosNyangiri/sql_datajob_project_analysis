/*
    QUESTION: what are the top skills based on salary?
    - look at average salary associated ithach skill for Data analyst positions
    - focuses on roles ith specified salaries, regardless of location
    - why? It reveals how different skills impact salary levels for data analyst and
      helps identify the most financially rearding skills to acquire or improve
*/

SELECT 
    skills,
    ROUND (AVG(salary_year_avg), 0) AS Average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY 
    Average_salary DESC
LIMIT 25