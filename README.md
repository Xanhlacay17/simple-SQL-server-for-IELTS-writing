# simple-SQL-server-for-IELTS-writing
How to get a high score on the IELTS writing
 Link dataset on kaggle: [IELTS Writing Scored Essays Dataset](https://www.kaggle.com/datasets/mazlumi/ielts-writing-scored-essays-dataset)

 # IELTS Essay Data Analysis Project

## 1. Data Cleaning
- [x] **Check for duplication:** Identified and removed duplicate rows. Verified successful deletion.
- [x] **Data filtering:** Discovered an invalid value in the `question` column and removed it successfully. 😊

---

## 2. Data Analysis & Insights

### Q1: Overall Score Distribution
*What is the overall score distribution (count and percentage) of essays across the dataset?*

### Q2: Score Category Analysis
*How many essays received a high score (Overall >= 7.0) versus a low score (Overall <= 5.5)?*
- **Step 1:** Create a query to classify scores into categories.
- **Step 2:** Display the score distribution based on these categories.

### Q3: Task 1 vs. Task 2 Comparison
*Is there a significant difference in the average Overall score between Task 1 and Task 2 essays?*

### Q4: Essay Length vs. Score Correlation
*What is the correlation between the word count of the essay and the final Overall score?*
- **Step 1:** Count the word count of each essay.
- **Step 2:** Analyze the correlation between word count and the band score. *Does a longer essay necessarily receive a higher score?*

### Q5: High-Scoring Essays Word Count
*What is the average word count for Task 1 and Task 2 essays that achieve a Band 7.0 or higher?*

### Q6: Lowest-Performing Prompts (Task 1)
*Which specific writing question prompts have the lowest average scores for Task 1?*
- **Step 1:** Classify by question types.
- **Step 2:** Identify the specific writing questions (prompts) with the lowest average scores.

### Q7: Lowest-Performing Prompts (Task 2)
*Which specific writing question prompts have the lowest average scores for Task 2?*

### Q8: Examiner Comments & Criteria Analysis
*Categorize the examiner comments (`Examiner_Commen`) according to each specific criterion and calculate the average score for each criterion that contains feedback.*

 
