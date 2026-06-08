# Introduction
This project focuses on the Data Analytics role. It explores the 💸 top paying jobs, 🔥 in-demand skills and where 📈 high demand meets high salary

🔍 For the sql queries chech them out here [project_sql](/Project_sql/)
# Background
This project as motivated by the quest to navigate the Data Analytics job market effectively and eficiently. The desire for the top-paying skill and in-demand skill are essential when finding an optimal job

A combination of rich datasets were used together to make the project come along. [Datasets](/csv_files/)

### The questions answerd by the project are as follows
1. what are the top most paying data Analyst jobs
2. what skills are required for th top paying data analyst jobs
3. What are the most in-demand skills for data analysts
4. what are the top skills based on salary
5. what is the most optimal skill to learn

# Tools used
Several tools were used to complete the entire project

- **SQL**: The core of the analysis that alloed me to query the database and identify critical insights
- **Postgres**: This as the chooses database management system 
- **Git & Github** : Essential for version control and sharing my sql scripts and analysis, ensuring project tracking
- **Excel**: This was used to for visualization

# Analysis
The different queries for this project aimed at investigating specific aspects of the data analyst job market by answering different questions

### 1. what are the top most paying data Analyst jobs
To identify the top-paying data Analyst role, I filtered the data analyst position by focusing only on remote jobs.

The query below highlights the high paying opportunities in the field and companies associated with them

```sql
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
```
Here are some key results from the analysis

**Wide Salary Range :** 
The salary range for the top 10 roles span from 184,000 to 650,000 indicating significant salary potential which might be influenced by skills and company

**Variety job titles :**
Their is a wide range of job titles under the data Analyst role showing a broad interest across different industries

![Top paying roles](Assets\Pic1.png)
*Bar graph for the average salary distribution for the top 10 data analyst roles*

**Diverse Employers :** 

This analysis identifies companies offering the highest salaries for Data Analyst positions.

| Company Name | Max Salary ($) | Min Salary ($) | Job Count |
|:------------|---------------:|---------------:|----------:|
| Mantys | 650,000 | 650,000 | 1 |
| Meta | 336,500 | 336,500 | 1 |
| AT&T | 255,830 | 255,830 | 1 |
| Pinterest Job Advertisements | 232,423 | 232,423 | 1 |
| Uclahealthcareers | 217,000 | 217,000 | 1 |
| SmartAsset | 205,000 | 186,000 | 2 |
| Inclusively | 189,309 | 189,309 | 1 |
| Motional | 189,000 | 189,000 | 1 |
| Get It Recruit - Information Technology | 184,000 | 36,000 | 131 |
| A-Line Staffing Solutions | 170,000 | 170,000 | 1 |

**Key Insights**
- Mantys offered the highest reported Data Analyst salary at **$650,000**.
- Meta ranked second with a salary of **$336,500**.
- Most top-paying companies had only one posting, suggesting these are highly specialized positions.
- SmartAsset and Get it Recruit were the only company among the top salary group with multiple high-paying postings.

### 2. Top skills for data analyst jobs
To undersand the skills required for the top paying roles, the query below was used to combine multiple tables to provide insights

```sql
WITH top_paying_jobs AS(
SELECT
    job_id,
    job_title,
    salary_year_avg,
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
)

SELECT 
    top_paying_jobs.*,
    skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```
![Top paying roles](Assets\Pic2.png)
*Bar graph visualizing count of skills for the top 10 data analyst roles*

#### Key Takeaway
The highest-paying Data Analyst roles increasingly require a combination of:
- Data querying (SQL)
- Programming (Python/R)
- Data visualization (Tableau)
- Cloud platforms (Snowflake)
- Data cleaning and validation (Excel)

This suggests that employers value analysts who can work across the entire analytics workflow—from data extraction and transformation to visualization and decision-making.

### 3. Most Demanded skills for data analysts
To identify what skills are mostly required in the entire data analysis job, the following query was used.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) As demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5
```
| Skills | Demand count |
|:------------|---------------:|
|SQL | 7291 |
|Excel | 4611 |
|Python | 4330 |
|Tableau | 3745 |
|Power bi | 2609 |

#### Key Takeaway

- SQL is the most in-demand skill, appearing in 7291 job postings for remote jobs, making it the foundational skill for Data Analyst roles. 

- Excel remains highly relevant, demonstrating that traditional spreadsheet analysis is still widely used alongside modern analytics tools.
- Python ranks third highlighting the growing importance of programming, automation, and advanced data analysis in the analytics profession.
- Data visualization skills are highly valued, with Tableau  and Power BI appearing frequently in job postings. Employers increasingly expect analysts to communicate insights through interactive dashboards and reports.
- The combined demand for Tableau and Power BI (6354 mentions) indicates that visualization and business intelligence skills are nearly as important as core analytical skills.
- The results reveal a balanced skill profile for successful Data Analysts:

1. Data Extraction: SQL
2. Data Analysis & Automation: Python
3. Business Analysis: Excel
4. Data Visualization: Tableau and Power BI

### 4. Top skills based on salary
Associating skills to average salaries showcased which skills are highly paying

```sql

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
LIMIT 20
```
|skills | Average salary($) |
|:------------|---------------:|
pyspark|208172
bitbucket|189155
watson|160515
couchbase|160515
datarobot|155486
gitlab|154500
swift|153750
jupyter|152777
pandas|151821
elasticsearch|145000
golang|145000
numpy|143513
databricks|141907
linux|136508
kubernetes|132500
atlassian|131162
twilio|127000
airflow|126103
scikit-learn||125781
jenkins|125436

### Key Insights

The highest-paying skills for Data Analysts in 2023 were heavily concentrated in data engineering, machine learning, and cloud technologies.

- PySpark ($208K) was the highest-paying skill.
- Big data tools such as Databricks and Airflow were associated with premium salaries.
- Python ecosystem tools (Pandas, NumPy, Jupyter) consistently appeared among top-paying skills.
- Machine learning skills such as DataRobot and Scikit-Learn significantly increased earning potential.
- DevOps technologies including GitLab, Kubernetes, Jenkins, and Bitbucket were linked to higher salaries.

#### Key Takeaway
While SQL, Excel, and Tableau remain the most in-demand skills, the highest salaries are earned by professionals who combine analytics expertise with data engineering, cloud and machine learning capabilities.

### 5. what is the most optimal skill to learn
To determine the most optimal skill, I compared both skill demand and average salary.

```sql
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
```
### Key Findings
The analysis compared skill demand with average salary to identify the most valuable skills in the Data Analyst job market.

- Python remained the most requested skill across job postings.
- SAS offered the highest average salary while maintaining strong demand.
- Python combined high demand with strong compensation, making it one of the most versatile skills.
- Specialized tools tended to command higher salaries but appeared in fewer job postings.

SAS emerged as the highest-value skill in the dataset because it combines premium compensation with substantial employer demand. While Python and Tableau remain foundational skills for entering the field, SAS expertise may provide a significant salary advantage for analysts working in specialized industries.


![Most Demanded Skills](Assets\Pic3.png)
*Bar graph visualizing Most Demanded Skills*

![Most Demanded Skills](Assets\Pic4.png)
*Bar graph visualizing Highest Paying Skills*

# Conclusion
1. **Top-Paying Data Analysis Jobs :** The highest paying remote jobs for data analysis offer a wide range of salaries toping at $650,000 yearly average pay

2. **Skills For Top-Paying Jobs :**
High paying data analytic jobs equire advanced poficiency in SQL ,suggesting that its a crusial skill for a top salary.

3. **Most In Demand Skills :**
SQL is also the most demanded skill in the data analystic job market, thus making it essential for job seekers.
4. **Skills With High Salaries :**
Specialized skills such as solidity, are associated with the highest average salaries indicating a premium on niche expertise.

5. **Optimal Skills For Job Market :**
SQL leads in demand and offers a high average salary, positioning it as one of the most optimal skills for data analysts to learn to marximize their market value

Working on this project significantly strengthened my SQL abilities while offering meaningful insights into the job landscapes for data analysis. The results of this analysis act as a roadmap for shaping skill development priorities and directing job search strategies  By concentrating on skills that are both highly sought after and well compensated, aspiring data analysts can establish a stronger foothold in an increasingly competitive job market. Ultimately this exploration underscores how essential continous learning and staying attuned to eveolving trends are in the ever-chaning field of data analytics 