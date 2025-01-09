/*
Answer: What are the most optimal skills to learn(aka its in high demand and a high-paying skill)? 
-Identify skills in high demand & associated with high average salaries for data analyst roles
-Concentrates on remote positions with specified salaries 
-Why? Targets skills that offer job security (high demand) & financial benefits (high salaries), 
    offering stategic insights for career development in data analytics 
*/ 

WITH skills_demand AS (
    SELECT
        skills_dim.skill_id, 
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL 
        AND job_location = 'India'
    GROUP BY
        skills_dim.skill_id
), average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg),0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_location = 'India'
    GROUP BY
        skills_job_dim.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count>2
ORDER BY
    demand_count DESC,
    avg_salary DESC    
LIMIT 25;




SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim) as demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'India'
    GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id)>2
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

