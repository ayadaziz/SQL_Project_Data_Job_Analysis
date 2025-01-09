# Introduction 
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/)
# Background

Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

Data Source [Data](https://www.lukebarousse.com/sql) . It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?

2. What skills are required for these top-paying jobs?

3. What skills are most in demand for data analysts?

4. Which skills are associated with higher salaries?

5. What are the most optimal skills to learn?

# Tools I Used

For my deep dive into the data analyst job market, I harnessed the power of several key tools:

1. **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.

2. **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.

3. **Visual Studio Code:** My go-to for database management and executing SQL queries.

4. **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis

Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

### 1. Top Paying Data Analyst Jobs

To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name as company_name
FROM
    job_postings_fact
LEFT JOIN
    company_dim on job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short ='Data Analyst' AND 
    job_location ='India' AND
    salary_year_avg is not NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10;
````
Here is the breakdown of the top data analyst jobs in 2023:

- **Wide Salary Range:** Top 10 paying data analyst roles span from $119,250 to $89,118, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like Deutche Bank, ACA Group & Clarivate are among those offering high salaries, showing a broad interest across different industries.

- **Job Title Variety:** There is a high diversity in job titles from Data Analyst to Financial Data Analyst, reflecting varied roles and specializations within data analytics.

![Top Paying Roles](Assets\Top5Roles_Salary.png)
*Bar graph visualizing the salary for the top 5 salaries for data analysts; ChatGPT generated this graph from my SQL query results*

### 2. Skills for Top Paying Jobs

To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
WITH top_paying_jobs AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_location = 'India' AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```

Here’s a table representation of the top 10 most frequently mentioned skills in data analyst job postings:

| **Skill**      | **Occurrences** |
|-----------------|-----------------|
| SQL            | 7               |
| Excel          | 6               |
| Python         | 5               |
| Word           | 3               |
| R              | 2               |
| Tableau        | 2               |
| Flow           | 2               |
| Oracle         | 1               |
| PyTorch        | 1               |
| TensorFlow     | 1               |


Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:

- SQL is leading with a bold count of 7.
- Excel follows closely with a bold count of 6.
- Python is also highly sought after, with a bold count of 5. - - Other skills like R, Tablaeu, Flow and Oracle show varying   degrees of demand.

### 3. In-Demand Skills for Data Analyst 

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_location = 'India'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5 
```

Here's the breakdown of the most demanded skills for data analysts in 2023

- SQL and Excel remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.

- Programming and Visualization Tools like Python, Tableau, and Power BI are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.



| **Skill**     | **Demand Count** |
|---------------|------------------|
| SQL           | 1016            |
| Excel         | 717             |
| Python        | 687             |
| Tableau       | 545             |
| Power BI      | 402             |
*Table of the demand for the top 5 skills in data analyst job postings.

### 4. Skills Based on Salary 
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```
Key Observations:

- **High Demand for Business Intelligence & Data Analytics:**
Power BI, Azure, and Tableau consistently rank high, indicating a strong market demand for professionals skilled in data visualization, analysis, and cloud-based solutions.
SQL, Excel, and Python are foundational skills with high demand across various industries, further emphasizing the importance of data analysis capabilities.

- **Project Management & Collaboration Tools Highly Valued:**
Visio, Jira, and Confluence are essential for project management, workflow visualization, and team collaboration. Their high average salaries suggest that organizations are willing to pay a premium for professionals proficient in these tools.

- **Cloud Computing & Microsoft Suite in Demand:**
Azure (Microsoft's cloud platform) is highly sought after, reflecting the growing reliance on cloud technologies.
Microsoft Office Suite (PowerPoint, Word, Excel, Outlook) remains crucial for business communication and productivity, with strong earning potential.

- **Specialized Technical Skills Command Premium:**
PyTorch, TensorFlow, and Unix/Linux are in high demand in the field of Artificial Intelligence and Machine Learning, commanding high salaries.
R is another popular language for statistical computing and data science, also reflecting well in the salary data.

Here’s the table with the top 20 skills based on average salary:

| **Skill**       | **Average Salary (USD)** |
|------------------|--------------------------|
| Visio           | 119,250                  |
| Jira            | 119,250                  |
| Confluence      | 119,250                  |
| Power BI        | 118,140                  |
| Azure           | 118,140                  |
| PowerPoint      | 104,550                  |
| Flow            | 96,604                   |
| Sheets          | 93,600                   |
| Word            | 89,579                   |
| SQL             | 85,397                   |
| Excel           | 84,366                   |
| PyTorch         | 79,200                   |
| Unix            | 79,200                   |
| TensorFlow      | 79,200                   |
| Windows         | 79,200                   |
| Python          | 77,186                   |
| R               | 76,667                   |
| Outlook         | 75,068                   |
| Oracle          | 75,068                   |
| Tableau         | 74,435                   |
*Table of the average salary for the top 20 paying skills for data analysts

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```


| Skill ID | Skill Name | Demand Count | Avg. Salary |
|---|---|---|---|
| 188 | Word | 3 | $89,579 |
| 0 | SQL | 9 | $85,397 |
| 181 | Excel | 8 | $84,366 |
| 1 | Python | 6 | $77,186 |
| 5 | R | 3 | $76,667 |
| 182 | Tableau | 3 | $74,435 | 
*Table of the most optimal skills for data analyst sorted by salary

**Key Insights:**

**High Demand for Data-Related Skills:**

SQL and Excel have the highest demand counts (9 and 8, respectively), indicating a strong market need for professionals with data manipulation and analysis skills.

Python also has significant demand (6), reflecting its growing importance in data science and machine learning.

**Competitive Salaries for In-Demand Skills:**

Word, despite having lower demand than SQL or Excel, commands the highest average salary ($89,579), suggesting a premium for professionals with advanced word processing and document management skills.

SQL and Excel, with high demand and relatively high average salaries, are valuable skills for career advancement.

**Data Visualization Skills are Valued:**

Tableau, a popular data visualization tool, has a moderate demand count (3) but a respectable average salary ($74,435), indicating a growing need for professionals who can effectively communicate data insights visually.

**R for Statistical Computing:**

R, a language specifically designed for statistical computing and data science, has a moderate demand and average salary, reflecting its niche but valuable role in certain data-driven fields.

# What I Learned

This project significantly enhanced my SQL proficiency. Key accomplishments include:

- 🧩**Mastering Complex Queries:** Developed expertise in crafting intricate SQL queries, including proficient use of JOIN clauses and subqueries (WITH clauses) for efficient data manipulation.

- 📊 **Data Aggregation Proficiency:** Gained a strong understanding of aggregation functions (COUNT(), AVG(), etc.) and their effective application within the GROUP BY clause for data summarization and analysis.

- 💡**Developing Analytical Skills:** Refined my ability to translate business questions into actionable SQL queries, demonstrating a strong foundation in data analysis and problem-solving within the SQL environment.


# Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market.

 The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. 
 
 Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. 
 
 This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.