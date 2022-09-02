 /*previewing all the data*/
SELECT * 
FROM diabetes; #768 records

/*No of women that are diabetic*/
SELECT
COUNT(*)
FROM diabetes
WHERE outcome = 'Diabetic'; -- 268 records

/*No. of women that are not diabetic*/
SELECT 
COUNT(*)
FROM diabetes
WHERE outcome = 'Non-Diabetic'; -- 500 records

/*creating a new table with categorized coulumn*/
CREATE TABLE diabetes_prediction_in_women AS (
SELECT pregnancies AS No_of_times_pregnant,
insulin, 
skin_thickness,
diabetes_pedigree_function AS family_history,
age,
glucose,
outcome,
     CASE WHEN blood_pressure < 80 THEN 'normal'
          WHEN blood_pressure BETWEEN 80 AND 89 THEN 'stage_1_hypertension'
		  WHEN blood_pressure BETWEEN 90 AND 120 THEN 'stage_2_hypertension'
		  WHEN blood_pressure >= 120 THEN 'hypertensive_crisis'
	END AS diastolic_blood_pressure,
    
	CASE WHEN age BETWEEN 21 AND 49 THEN 'reproductive_age'
         WHEN age BETWEEN 50 AND 70 THEN 'non_reproductive_age'
	END AS age_range,
    
    CASE WHEN bmi < 18.5 THEN 'underweight'
         WHEN bmi BETWEEN 18.5 AND 24.9 THEN 'normal'
         WHEN bmi BETWEEN 25.0 AND 29.9 THEN 'overweight'
         WHEN bmi >= 30 THEN 'obese' 
    END AS body_mass_index
         
          FROM diabetes);

--  Data Analysis

/*What is the highest number of times a woman got pregnant and the glucose level*/ 
  SELECT MAX(pregnancies) AS No_of_times_pregnant, 
  glucose AS glucose_level
  FROM diabetes;  #17 times with a glucose level of 148
  
/*to ascertain the relationship between age_range and diabetes*/
SELECT COUNT(outcome) AS Diabetes, age_range
FROM diabetes_prediction_in_women
WHERE outcome = 'diabetic'
GROUP BY age_range;  -- women of reproductive age are at risk of diabetes

/*to ascertain the relationship between blood pressure  and diabetes*/
SELECT COUNT(Outcome) AS diabetes, diastolic_blood_pressure
FROM diabetes_prediction_in_women
WHERE outcome = 'diabetic'
GROUP BY diastolic_blood_pressure; 
-- 178 out of 268 diabetic women have normal blood pressure hence no association

/*to ascertain the relationship between the body mass index and diabetes*/
SELECT COUNT(outcome) AS Diabetes, body_mass_index
FROM diabetes_prediction_in_women
WHERE outcome = 'diabetic'
GROUP BY body_mass_index
ORDER BY Diabetes; -- obese women are susceptible to diabetes according to the data

/*Does a number of times a woman gets pregnant affect her glucose level 
and make her prone to being diabetic?*/
SELECT 
     CASE WHEN pregnancies BETWEEN 0 AND 5 THEN '0-5'
		  WHEN pregnancies BETWEEN 6 AND 10 THEN '6-10'
          WHEN pregnancies BETWEEN 11 AND 15 THEN '11-15'
          ELSE '16 and above'
	END AS No_of_times_pregnant,
	(outcome) AS diabetes,
    ROUND(AVG(glucose),2) AS glucose_level
    FROM diabetes
    GROUP BY No_of_times_pregnant;  
    #Women that have been pregnant 0-5 times have normal glucose-level and less prone to diabetes than others#
    
   
  
  
  
  
    
    
          
        























