Data Analysis

--Device Usage (User Categorization)
SELECT Id,
    COUNT(Id) AS Days_Logged,
CASE
    WHEN COUNT(Id) BETWEEN 21 AND 31 THEN 'Active User'
    WHEN COUNT(Id) BETWEEN 11 and 20 THEN 'Moderate User'
    WHEN COUNT(Id) BETWEEN 0 and 10 THEN 'Light User'
END AS Usage_Type
FROM `bellabeat-case-study-96.Activity.Daily_Activity`
GROUP BY Id


--Period of Use Per Day (Part One)
SELECT *,
SedentaryMinutes+LightlyActiveMinutes+FairlyActiveMinutes+VeryActiveMinutes+TimeAsleep AS TotalUsageTime
FROM
(
    SELECT 
      A.Id,
      A.ActivityDate,
      A.Day,
      A.SedentaryMinutes,
      A.LightlyActiveMinutes,
      A.FairlyActiveMinutes,
      A.VeryActiveMinutes,
      COALESCE(TotalMinutesAsleep,0) AS TimeAsleep
FROM `bellabeat-case-study-96.Activity.Daily_Activity` AS A
FULL JOIN `bellabeat-case-study-96.Sleep.Daily_Sleep` AS S
 ON A.Id = S.Id
 AND A.ActivityDate = S.SleepDay
)


--Period of Use Per Day (Part Two)
SELECT
  Id,
  PercentUse,
CASE
  WHEN PercentUse >= 100 THEN 'Whole Day'
  WHEN PercentUse BETWEEN 50 and 100 THEN 'More Than Half Day'
  WHEN PercentUse BETWEEN 0 and 50 THEN 'Less Than Half Day'
END AS PeriodUsePerDay
FROM 
(
  SELECT
    Id,
    (TotalUsageTime/1440)*100 AS PercentUse,
  FROM `bellabeat-case-study-96.Wearable_usage.Activity_Sleep_merged_with_Total_Usage`
)


-- Intensity: Average Activity data and grouping by User Id 
SELECT DISTINCT Id,
 COUNT(Id) AS logs,
 AVG(Steps) AS avg_steps,
 AVG(Total_Distance) AS avg_total_distance, 
 AVG(Very_Active_Minutes) AS avg_very_min,
 AVG(Fairly_Active_Minutes) AS avg_fair_min,
 AVG(Lightly_Active_Minutes) AS avg_light_min,
 AVG(Sedentary_Minutes) AS avg_sedentary_min,
 AVG(Calories) AS avg_calories_burned
FROM `bellabeat-case-study-96.activity_w_days`
GROUP BY Id
ORDER BY Id



--Sleep: How much sleep do users get on average
SELECT *,
(avg_min_asleep/60) AS avg_hour_asleep     
FROM (      
   SELECT DISTINCT Id,      
    COUNT(Id) AS total_logs,      
    SUM(Time_Not_Asleep) AS total_min_awake_in_bed,     
    AVG(Time_Not_Asleep) AS avg_min_awake_in_bed,     
    SUM(Total_Minutes_Asleep) AS total_min_asleep,      
    AVG(Total_Minutes_Asleep) AS avg_min_asleep     
 FROM `bellabeat-case-study-96.sleep_w_days`     
 GROUP BY Id      
 ORDER BY Id


--Weight
SELECT 
 DISTINCT Id,
 COUNT(Id) AS total_logs,
 AVG(Weight_Pounds) AS avg_weight_lbs,
 AVG(BMI) AS avg_BMI
FROM `bellabeat-case-study-96.weight_w_days`
GROUP BY Id
ORDER BY Id