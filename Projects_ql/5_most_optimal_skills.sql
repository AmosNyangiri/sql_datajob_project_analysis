/*
    QUESTION: what is the most optimal skill to learn
    - identify skills in high demand and associate with high average salaries for data Analyst roles
    - concentrate on remote positions with specified salaries
    - why? Targets skills that offer job security(high demand) and financial benefits (high salaries)
      offering strategic insights for carrer development in data analysis
*/
WITH skills_demand AS(
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) As demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
),

Average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND (AVG(salary_year_avg), 0) AS Average_sal
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY 
        skills_job_dim.skill_id
) 
SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    Average_sal
FROM 
    skills_demand
INNER JOIN  Average_salary ON skills_demand.skill_id = Average_salary.skill_id
WHERE demand_count > 10
ORDER BY
    demand_count DESC
LIMIT 25

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) As demand_count,
    ROUND (AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY 
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC
LIMIT 25
