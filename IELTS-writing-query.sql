
/*Q1: What is the overall score distribution (count and percentage) of essays across the dataset? */

SELECT Overall, COUNT(*) AS Total_Essays,
       ROUND(CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ielts_writing_dataset) AS DECIMAL(5,2)),2) AS Percentage
FROM ielts_writing_dataset
GROUP BY Overall
ORDER BY Overall DESC;

/* Q2: How many essays received a high score (Overall >= 7.0) versus a low score (Overall <= 5.5)? */
--Step 1: Create a query to classify scores
    SELECT
        Overall,
        CASE
            WHEN Overall >= 7.0 THEN 'High score'
            WHEN Overall <= 5.5 THEN 'Low score'
            ELSE 'Average score'
        END AS Academic_performance
    FROM ielts_writing_dataset

  -- Step 2: Display the score distribution based on score categories

SELECT
	Academic_performance,
	COUNT(*) AS Total_Essays,
	CONVERT(DECIMAL(5, 2), COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ielts_writing_dataset)) AS Academic_percentage 
 FROM categorized_data
 GROUP BY Academic_performance;

/*Q3: Is there a significant difference in the average Overall score between Task 1 and Task 2 essays? */

SELECT Task_Type, 
       ROUND(AVG(Overall),2) AS Average_Score,
       MAX(Overall) AS Highest_Score,
       MIN(Overall) AS Lowest_Score
FROM ielts_writing_dataset
GROUP BY Task_Type;

/* Q4: What is the correlation between the word count of the essay and the final Overall score? */
--Step 1:Count the word count of each essay

SELECT
    Overall,
    LEN(TRIM(Essay)) - LEN(REPLACE(TRIM(Essay), ' ', '')) + 1 AS Word_count
FROM ielts_writing_dataset

--Step 2: Does it show a correlation between word count and the brand score? Does a longer essay necessarily receive a higher score?

WITH word_categorized_data AS (
SELECT *,
        CASE 
            WHEN Word_count < 150 THEN '< 150 words'
            WHEN Word_count BETWEEN 150 AND 200 THEN '150 - 200 words'
            WHEN Word_count BETWEEN 201 AND 250 THEN '201 - 250 words'
            WHEN Word_count BETWEEN 251 AND 300 THEN '251 - 300 words'
            WHEN Word_count BETWEEN 301 AND 350 THEN '301 - 350 words'
            ELSE '> 350 words'
        END AS word_range
    FROM word_count_table)
SELECT 
    word_range,
    COUNT(*) AS Total_Essays,
    ROUND(AVG(Overall), 2) AS Average_Score,
    MIN(Overall) AS Min_Score,
    MAX(Overall) AS Max_Score
FROM word_categorized_data
GROUP BY word_range
ORDER BY MIN(Word_count);

/* Q5: What is the average word count for Task 1 and Task 2 essays that achieve a Band 7.0 or higher? */

SELECT
    Task_Type,
    AVG(LEN(TRIM(Essay)) - LEN(REPLACE(TRIM(Essay), ' ', '')) + 1) AS average_word_count
FROM ielts_writing_dataset
WHERE Overall >= 7.0
GROUP BY Task_Type

/* Q6: Which specific writing questions prompts have the lowest average scores for Task 1? */
--Step 1: Question type classification
SELECT
	Task_Type,
	Question,
	Essay,
	CASE
		WHEN Question + Essay LIKE '%bar%' OR Question + Essay LIKE '%column%' THEN 'Bar graph'
		WHEN Question + Essay LIKE '%line%' OR Question + Essay LIKE '%fluctuat%' THEN 'Line Graph'
		WHEN Question + Essay LIKE '%pie chart%' THEN 'Pie Chart'
		WHEN Question + Essay LIKE '%table%' THEN 'Table'
		WHEN Question + Essay LIKE '%map%' THEN 'Map'
		WHEN Question + Essay LIKE '%diagram' OR Question + Essay LIKE '%flowchart%' OR Question + Essay LIKE '%process%' THEN 'Diagram'
		ELSE 'Topic not found'
		END AS question_format
FROM ielts_writing_dataset
WHERE Task_Type = 1
--Step 2: Found specific writing questions (prompts) have the lowest average scores
SELECT
	COUNT(*) AS total_question_format,
	ROUND(CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ielts_writing_dataset) AS DECIMAL(5,2)),2) AS Percentage,
	ROUND(AVG(Overall), 2) AS average_score_by_question_prompt,
	question_format
FROM question_type_classification
GROUP BY question_format
ORDER BY average_score_by_question_prompt

/* Q7: Which specific writing questions prompts have the lowest average scores for Task 2?*/

WITH categorizing_task_2_questions AS (
SELECT
	DISTINCT Question,
	Task_Type
	CASE
		WHEN Question LIKE '%To what extent do you agree or disagree%' OR Question LIKE '%Do you agree or disagree%' OR Question LIKE '%What is your opinion%' THEN 'Agree/Disagree'
		WHEN Question LIKE '%Discuss both views and give your opinion%' OR Question LIKE '%Discuss both sides of this argument%' THEN 'Both Views'
		WHEN Question  LIKE '%Do the advantages outweigh the disadvantages%' OR Question LIKE '%Is this a positive or negative%' OR Question LIKE '%What are the advantages and disadvantages%' THEN 'Advantages & Disadvantages'
		WHEN Question  LIKE '%What are the causes%' OR Question LIKE '%what measures can be taken%' OR Question LIKE '%What problems does this cause%' OR Question LIKE '%What are the solutions%' THEN 'Causes & Solutions'
		WHEN Question  LIKE '%Why is this the case' THEN ' Two-Part Question'
		ELSE 'Topic not found'
		END AS question_format_task_2
FROM ielts_writing_dataset
WHERE Task_Type = 2)























