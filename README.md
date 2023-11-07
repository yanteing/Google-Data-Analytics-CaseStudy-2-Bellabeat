# Google-Data-Analytics-CaseStudy-Bellabeat
Course: https://www.coursera.org/learn/google-data-analytics-capstone

## Introduction
In this second case study, I will be performing several real-world tasks of a junior data analyst at a fictional company called Bellabeat. I will be implementing steps of the data analysis processs: **[Ask,Prepare,Process,Analyze,Share,Act]** which I have learned throughout the course and applying it into this project

## Scenario
Bellabeat is a successful small company and a high-tech manufacturer of health-focused products for women founded by Urška Sršen and Sando Mur in 2013. Bellabeat has since grown rapidly and quickly positioned itself as a tech-driven wellness company for women. The company offers smart devices such as: **Leaf, Ivy, and Time**. These items can track health data such as activity, sleep, menstrual cycles, heart rate, and hydration.

Bellabeat has the potential to grow to become a major player in the global market for smart devices. Bellabeat's cofounder and chief creative officer, Urška Sršen , thinks that studying fitness data from smart devices could help the business find new development prospects. The Bellabeat marketing analytics team has been asked to analyze smart device data to understand how users are interacting with their smart devices. The insights discovered will then help guide marketing strategy for the company.

## Task
I have been tasked by  Urška Sršen to address the first question:
1) Conduct data analysis on Fitbit smart device usage to identify patterns and insights regarding user behavior
2) If any significant trends are detected, explore how these trends can be leveraged to enhance Bellabeat products and provide value to Bellabeat customers.



## Data Analysis Process

## 1. Ask
### Analysis Questions
Three questions will guide the future marketing program:
1) What are the prevalent usage patterns and behaviors of Fitbit smart device users, and can we discern any meaningful insights or correlations within this data?
2) If we identify substantial trends in Fitbit smart device usage data, how can these trends be integrated into the design and development of Bellabeat products, with a focus on improving user experience and meeting customer needs more effectively?
3) How can the insights derived from the analysis of Fitbit smart device usage data be employed to create more value for Bellabeat customers, potentially through tailored features, personalized recommendations, or enhancements to existing products?

## 2. Prepare
The dataset used is a [Fitbit Fitness Tracker Data](https://www.kaggle.com/datasets/arashnic/fitbit) stored in Kaggle and was uploaded by Mobius. 

This dataset is generated by respondents in a distributed survey via Amazon Mechanical Turk between 3rd – 5th December 2016. Thirty eligible Fitbit users agreed to submit their personal tracker data, which included minute-level output for heart rate, sleep, and physical activity monitoring. The variation in output reflects the use of different Fitbit tracker models and personal monitoring habits and preferences.

The dataset provided consist of 18 .csv files in both long and wide data format. Upon inspection, they includes users count of 33 users over the period of 31 days (12th April – 12th May 2016). These are the dataset structure:


|Dataset|Daily|Hourly|Minute|Second
|------|------|------|------|------|
Activity |X|			
Calories	|X	|	X|X
Intensities	|X	|X	|X
Steps	|X	|X	|X
Heartrate	|		| |	|X| |
MET			|	| |X |
Sleep	|		| |X ||	
Weight	|X|

## 3. Process
I am using BigQuery to perform my data cleaning & data analysis. The main reason is because the total number of rows inside the combined dataset is too large, and BigQuery has the capability & capacity to support this huge volume of data, wherelse Microsoft Excel only has a limit of around 1 million rows.

I decided to dive deeper into datasets containing activity, steps, sleep, intensities and weight because these are commonly tracked parameters in smart devices:
* dailyActivity_merged – contains daily calories, intensities, and steps.
* hourlyIntensities_merged
* hourlySteps_merged
* heartrate_seconds_merged
* sleepDay_merged

The next step was to use Google BigQuery to find out how many unique users are there for each of the respective datasets 

| Dataset | Number of users | 
|---------|-----------------|
| dailyActivity_merged | 33 |
| hourlyIntensities_merged | 33 |
| hourlySteps_merged | 33 |
| heartrate_seconds_merged | 14 |
| sleepDay_merged | 24 |

### Data_Cleaning
For this project I used Microsoft Excel and SQL for data cleaning. I started the cleaning process by checking all of my datasets for the same issues: blank spaces, duplicates, and inconsistencies. The following  is my changelog for the cleaning process in Excel:

1. General (Applied to all the datasets)
   * Removed blank spaces using conditional formatting  
   * Verified User Id column entries were uniform (10 characters) in length using LEN function (i.e. =LEN(A2))
   * Added underscores between words in column names
   * Added column “Day” using date function ( i.e. =TEXT(B2, "dddd"))
   * Changed “DateTime” columns into two separate columns, “Date” and “Time” using INT function (i.e. =INT(A2),  =A2 - INT(A2))

2. Activity
   * Changed column name “activitydate” to “Date”
   * Changed column name “totalsteps” to “steps”
   * Removed "Tracker Distance", "Logged_Activities_Distance", "Very_Active_Distance", "Moderately_Active_Distance", "Light_Active_Distance", and "Sedentary_Active_Distance" columns. 

3. Sleep
   * Changed column name “sleepday” to “Date”
   * Subtracted "Time Asleep" from column "Total Time In Bed" and created new column "Time Awake" from results.
   * Removed column "Total Sleep Records"

4. Weight
   * Changed column name “Is Manual Report” to “Report_Type”
   * Changed column “Report_Type” Responses from True/False to Manual/Automatic respectively
   * Removed column “Fat”
   * Removed column “LogId”
   
## 4. Analyze & Share
(SQL Query Link)
(Tableau Link)

### Device Usage
I have prepared my analysis and now I would like to visualize this in Tableau.
To better understand the market strategy, we categorize users by how often they use their wearable smart devices to track their health activities, based on the number of days they log data.

![image](https://github.com/yanteing/Google-Data-Analytics-CaseStudy-2-Bellabeat/blob/main/Images/User%20Category.png)
From the pie chart above, 87.9% of users (29 out of 33) are active users and only 1 person is a light user, the remaining 3 users are moderate users. Next, to see if the users wear their devices for the whole day or not, Daily_Activity and Daily_Sleep datasets are combined then the total usage time is calculated using this query

 

![image](https://github.com/yanteing/Google-Data-Analytics-CaseStudy-2-Bellabeat/blob/main/Images/Device%20Usage%20Period.png)
Looking at the bar chart for the number of log-ins, the daily usage period for active users is similar to that of all users, which makes sense since they make up the largest group. Additionally, it can be observed from the daily log counts for both moderate and light users that they record their activity for the entire day rather than just for more than half of the day and less than half of the day.

 
### Intensity
Next analysis is of the user’s activity level starting with intensities/activity minutes

![image](https://github.com/yanteing/Google-Data-Analytics-CaseStudy-2-Bellabeat/blob/main/Images/Avg%20Calories%20Burned%20based%20on%20Intensity%20Levels.png) ![image](https://github.com/yanteing/Google-Data-Analytics-CaseStudy-2-Bellabeat/blob/main/Images/Number%20of%20Users%20Log%20Over%20Time.png)
On average, users are meeting the recommended 150 minutes of vigorous and moderate exercise per week. Interestingly, more of their time is spent engaging in light-level activity compared to moderate or very active levels. It's worth noting that all 33 users in the dataset tracked their activity, with 21 of them consistently logging their daily activities throughout the month. This suggests a generally active user base that's achieving recommended exercise levels while favoring lighter activities

### Steps
Next analysis is of the user’s steps finding

![image](https://github.com/yanteing/Google-Data-Analytics-CaseStudy-2-Bellabeat/blob/main/Images/Steps%20Finding.png)
On average, users are taking around 7,000 steps per day, a level associated with reduced mortality risk according to a study. Their step count gradually increases throughout the day, with a notable peak around 6pm. However, there's a rapid rise and fall between 10am and 4pm. Interestingly, step counts tend to decrease from Wednesday to Friday, indicating a potential mid-week dip in activity. There is also a positive correlation between taking more steps and burning more calories

### Sleep
Next analysis is of the user’s sleep behaviour

![image](https://github.com/yanteing/Google-Data-Analytics-CaseStudy-2-Bellabeat/blob/main/Images/Average%20Hours%20of%20Sleep%20per%20Day.png)

Out of the total 33 users, 24 of them tracked their sleep, although with less consistency compared to activity tracking. Only 15 of these 24 users completed at least half of the month in terms of sleep tracking, indicating sporadic logging rather than daily commitment. Half of the users meet the recommended 7 hours of sleep per CDC guidelines, but the other half fall short, with an average sleep duration of 6.9 hours for all users. On a weekly basis, users experience fluctuations in sleep duration, alternating between getting around 7 hours and just under 6.8 hours of sleep. Notably, the majority of users face disrupted sleep patterns, with at least 15 minutes of wakefulness during their sleep cycles.

### Weight
Next analysis is of the user’s weight findings

![image](https://github.com/yanteing/Google-Data-Analytics-CaseStudy-2-Bellabeat/blob/main/Images/Weight%20Change%20%26%20Weight%20Logs.png)
![image](https://github.com/yanteing/Google-Data-Analytics-CaseStudy-2-Bellabeat/blob/main/Images/Number%20of%20Weight%20Logs%20for%20Users.png)

Out of the 33 users, only 8 tracked their weight data, and of those, just 2 users did so more than 5 times, indicating limited engagement with weight tracking. Users with more weight logs had a greater percent change in body weight than those who only logged a few times. This could indicate users who track weight are more motivated to lose weight and as such lose more.

### Analysis Conclusion:
The key strategies for Bellabeat are to market the features that align with what Fitbit users are already utilizing, emphasizing improved wellness in areas where Fitbit data suggests users may need improvement, and avoiding weight loss-centric marketing. Instead, they should promote their new comprehensive health feature, the Wellness Score, which distinguishes Bellabeat from its competitors. This approach aims to target the existing user base effectively and differentiate Bellabeat in the health and wellness tracking market

## Act & Recommendations

### 1. Market the features that Bellabeat offers which Fitbit users are already using
* Most users spend the majority of their active minutes performing light level exercise which users could better expand on with the ability to assign specific exercises such as yoga or walking to their daily activity
* Users are meeting the recommended time of moderate-vigorous active minutes so they are likely interested to see how they are performing day to day and can set new goals with the Bellabeat App
* Expand on the options to track physical activity with specific exercises tracking and coaching memberships for new workout plans

### 2. Market improved wellness by targeting areas of health tracking that the Fitbit data suggests users could further improve on
 * Meet the recommended 7 hours of sleep with the sleep tracker and monitor their sleep cycles for better sleep health
 * Get more than 7,000 steps (to decrease mortality rates) with the option to set step count goals
 * Use the stress meter as a metric to evaluate how their sleep and activity are possibly impacting their mental health

### 3. Avoid marketing that focuses on weight loss, instead promote the positive and well rounded health feature: the Wellness Score. This sets Bellabeat apart from its competitors
* The data suggests users do not have an interest in weight tracking as it was the least used feature
* The wellness score calculates overall health of the body and mind, not just a number on the scale which users may find refreshing and uplifting. It can also help them to stay motivated to track consistently by seeing a snapshot of their performance day to day
* A focus on meditation, hydration, and other aspects that make up a healthy life imprints the brand’s positive values on consumers
* Marketing this feature will expand the ways current fitness tracking consumers can monitor their health but also widen the demographic to less fit consumers as a way to enter the health world in a non-intimidating way

# In summary
Bellabeat should persist in promoting its comprehensive health monitoring services. Highlight the capabilities of their Ivy and Leaf products, which offer all the physical fitness tracking features users appreciate in Fitbit devices. Additionally, emphasize the unique Wellness Score tool, which enables users to monitor essential aspects of a healthy life, such as hydration, stress, and menstrual cycle, in a stylish and positive manner.
