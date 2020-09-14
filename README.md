# ABSTRACT
In this report, fare prediction of a cab service is done through journey details. Generally, details like pickup and drop off locations, journey date and time and passenger details are provided. But certain other factors like if the journey was done during a weekday or a weekend or if the journey was done during daytime or nighttime etc. can also be responsible for the task. These factors are extracted from the given details and the prediction is done through a linear regression model. It is also seen how the fare prices vary with respect to the factors that are present and what are all the important factors contributing to the prediction through various hypothesis tests.
# INTRODUCTION
A cab rental start-up company has successfully run the pilot project and now wants to launch their cab service across the country. After collecting the historical data from the pilot project, the certain variables are obtained which leads to the fare amount. The project is based on the Forecasting/Prediction type of data science problem statement.
# DATA DESCRIPTION
The variables that are obtained after the pilot project are as follows:
•	Pickup date and time indicating when the cab rides started.
•	Pickup longitude indicating the longitude coordinates of where the cab rides started.
•	Pickup latitude indicating the latitude coordinates of where the cab rides started.
•	Drop-off longitude indicating the longitude coordinates of where the cab rides ended.
•	Drop-off latitude indicating the latitude coordinates of where the cab rides ended.
•	Passenger count indicating the number of passengers in the car rides.
# FEATURE EXTRACTION
The major features extracted from the data obtained are as follows:
•	From the date and time of the journey details, the information regarding whether the journey was done during morning, afternoon, evening, or night was extracted.
•	From the same details as above, features like the year, month, weekday, and the day in a month when the journey happened are also extracted.
•	From the pickup and drop off latitude and longitude, the distance between the pickup and drop off points are extracted using a Python library called Geopy. Geopy makes it easy for Python developers to locate the coordinates of addresses, cities, countries, and landmarks across the globe using third-party geocoders and other data sources.
# EXPLORATORY DATA ANALYSIS
# CAB FARE OVER THE YEARS
  
The average cab fare is more or less the same over the years, but the total number of cab rides vary throughout. Thus, the corresponding revenue generated also varies accordingly and it increased initially and then decreased and another fluctuation happened later. There is no such pattern derived from the yearly analysis.

# CAB FARE SEASONAL ANALYSIS
  
The average fare for all the months over the year has been more or less constant. However, it is seen that the count of rides and correspondingly the revenue generated over the years is maximum for the month of June. One reason can be educational institutes mostly start their academic sessions at that time. Plus, due to the extreme hot climate in the month of June, people usually prefer a cab ride. We can also see that during the end months the rides and total revenue generated is higher than the starting months because those are the months of festivals.

# CAB FARE WEEKLY ANALYSIS
  
Again, the average fare over the week is more or less the same. But it has been seen that the number of rides and correspondingly the revenue generated is slightly more during weekdays than during weekends mostly because of offices and educational institutes.

# CAB FARE WEEKLY ANALYSIS
  
Cab rides are much more during the morning time because people are generally going to workplaces and also during the evening time as people generally travelling back from offices, going out for dinner, movies, hanging out after college/office. Also, the average cab fare is more doing night due to night fare supplement charges.

# CAB FARE RELATIONSHIP WITH OTHER FACTORS
 
As it is seen that the fare amount is directly proportional to the distance but for other variables further analysis must be done.

# HYPOTHESIS TESTS
# CORRELATION ANALYSIS
Two independent continuous variables are checked at a time if they move together directionally. If yes, one should be removed. Because that could lead to biasness in the model. (Also, one continuous independent variable is taken, checked if it is highly correlated with the target variable if it is continuous too. They should move together directionality).
H0: Two variables are independent
H1: Two variables are not independent
• If p-value is less than 0.05 then the null hypothesis is rejected saying that 2 variables are dependent.
• And if p-value is greater than 0.05 then the null hypothesis is accepted saying that 2 variables are independent.
 
"pickup_longitude","pickup_latitude","dropoff_longitude","dropoff_latitude" are not that correlated with fare amount. Hence, they are dropped.
Great circle and geodesic are highly correlated with each other, hence dropping great circle is dropped.
geodesic and fare amount are highly correlated with each other. Its p value is calculated. The p value for the above relations can also be calculated in the same way.
 
Fare amount and geodesic are highly correlated with each other and p=0, hence H0 is rejected stating that they are dependent which is a must need condition for linear regression.

# CHI SQUARE ANALYSIS (TEST OF INDEPENDENCE)
Similar analysis is done here as it was in correlation test but with the categorical variables.
Hypothesis testing:
Null Hypothesis: 2 variables are independent.
Alternate Hypothesis: 2 variables are not independent.
If p-value is less than 0.01 then the null hypothesis is rejected saying that 2 variables are dependent.
And if p-value is greater than 0.01 then the null hypothesis is accepted saying that 2 variables are independent.
Alpha here is taken as 0.01 as majority of the variables in the data are categorical variables and it is unfair to remove them based on small amount of dependencies with others.
After the analysis it is seen that year, month and weekday are dependent on others, p value is less than 0.01, hence rejecting H0 for their relations and dropping them is done.

# ANOVA TEST
It is carried out to compare between each group in a categorical variable. ANOVA is done to check if the means for different groups are same or not. It does not help us to identify which mean is different.
Hypothesis testing:
Null Hypothesis: mean of all categories in a variable are same.
Alternate Hypothesis: mean of at least one category in a variable is different.
If p-value is less than 0.05 then we reject the null hypothesis.
And if p-value is greater than 0.05 then we accept the null hypothesis.
No variable has same mean for all the categories. P value is less than 0.05, thus H0 is rejected.

# VIF TEST
This test is to check if there is any multicollinearity left in the data after all the above statistical tests. VIF is always greater or equal to 1.
if VIF is 1 --- Not correlated to any of the variables.
if VIF is between 1-5 --- Moderately correlated.
if VIF is above 5 --- Highly correlated.
•	VIF determines the strength of the correlation between the independent variables. It is predicted by taking a variable and regressing it against every other variable.
•	VIF score of an independent variable represents how well the variable is explained by other independent variables.
 
So, the closer the R^2 value to 1, the higher the value of VIF and the higher the multicollinearity with the independent variable.
After the test it is seen that none of the remaining variables have high multicollinearity.

# MODEL BUILDING
Firstly, the two remaining categorical variables are converted to dummy variables keeping one of classes as base. Then a multiple linear regression model is built on top of it. The summary table of the analysis is given below:

 

# Interpretation
1) Here the R squared statistic value indicates that 97.3 percentage of the variance in the dependent variable is explained by independent variables collectively. So, the model does a good job explaining the changes in the dependent variable. Adjusted R square is the same as R squared stating all variables are significant.
2) H0: Variables are not carrying any information towards the target variable. (b=0)
H1: Variables are carrying info towards target variable. (b != 0)
Here it can be seen that F-statistic value is exceptionally large and p value is less than 0.05, thus H0 is rejected stating that the variables have a linear relationship and are carrying info towards target variable. (b != 0).
3) The maximum value for the log of the likelihood function is -22083, the likelihood that the process described by the model produced the data that were observed (maximise the probability of observing the data).
4) Omnibus is a test of the skewness and kurtosis of the residual. The value is relatively high, and the probability of omnibus is relatively low indicating that the residual is not normally distributed.
5) Even the skew value is not close to 0 confirming the above result.
6) DW value suggests that there is positive autocorrelation. That is, error of a given sign tends to be followed by an error of the same sign. For example, positive errors are usually followed by positive errors, and negative errors are usually followed by negative errors.
7) Kurtosis of the normal distribution is 3.0. In this case it is close to 5, validates the other results.
8) A large JB value is seen and the probability of JB is 0 indicating that the errors are not normally distributed.
9) In linear regression the condition number of the moment matrix can be used as a diagnostic for multicollinearity. A relatively small number (<30) is required, in this case it is.

# Recommendations
# (Ways to deal with Non-Normal Residual Distribution and positive autocorrelation.)
1.	One should not remove outliers just because they make the distribution of the residuals non-normal. We may examine the case that has that high residual and see if there are problems with it (the easiest would be if it is a data entry error).
2.	Assuming there is no good reason to remove that observation, one can run the regression with and without it and see if there are any large differences in the parameter estimates; if not, you can leave it and note that removing it made little difference.
3.	If it makes a big difference, the choice of the OLS model itself may be entirely wrong for this data set. It may be needed to look at alternate models. One could try robust regression, which deals with outliers or quantile regression or any other regression model that make no assumptions about the distribution of the residuals.
4.	Some key explanatory variables might have been left out which is causing some signal to leak into the residuals in the form of autocorrelations. If one can use one residual to predict the next residual, there is some predictive information present that is not captured by the predictors. Typically, this situation involves time-ordered observations. For example, if a residual is more likely to be followed by another residual that has the same sign, adjacent residuals are positively correlated. One can include a variable that captures the relevant time-related information or use a time series analysis.
5.	Maybe one can transform the response variable to make the distribution of the random errors approximately normal, fit the model, transform the predicted values back into the original units using the inverse of the transformation applied to the response variable.

# CONCLUSION
The fare amount prediction model is built using linear regression on the dataset. The data is studied properly, and the necessary information is extracted, and a model is built upon it. It is recommended to deploy the model after the necessary checks as mentioned in the recommendation part. In future whenever a test case comes, it can be fed to the model and its fare amount can be predicted.
