rm(list=ls(all=T))
setwd("C:/Users/subha/Desktop/Data Science/Projects/Statistical Analysis")

#Load Libraries
x = c("ggplot2", "corrgram", "DMwR", "caret", "randomForest", "unbalanced", "C50", "dummies", "e1071", "Information",
      "MASS", "rpart", "gbm", "ROSE", 'sampling', 'DataCombine', 'inTrees')
install.packages(x)
lapply(x, require, character.only = TRUE)
rm(x)

#Read the data
cab= read.csv("Data.csv", header = T, na.strings = c(" ", "", "NA"))
str(cab)
-----------------------------------------------------------------------------------------
install.packages("lubridate")
library(lubridate)
#Feature Extraction

for (i in 1:nrow(cab)){
  gsub("UTC","",cab$pickup_datetime[i])
}


for (i in 1:nrow(cab)){
  x <- ymd_hms(cab$pickup_datetime[i], tz = "UTC")
  cab$month[i]=month(x)
  cab$year[i]=year(x)
}

for (i in 1:nrow(cab)){
  x <- ymd_hms(cab$pickup_datetime[i], tz = "UTC")
  cab$hour[i]=hour(x)
  cab$weekday[i]=wday(x)
}

cab$hour=as.numeric(cab$hour)
for (i in 1:nrow(cab)){
  cab$daytime[i]=ifelse(cab$hour[i] <= 18 & cab$hour[i] >= 5,1,0)
  cab$daytime[i]=ifelse(cab$hour[i] > 18 | cab$hour[i] < 5,0,1)
}

lat1 = cab$pickup_latitude
lat2 = cab$dropoff_latitude
lon1 = cab$pickup_longitude
lon2 = cab$dropoff_longitude
latdiff= (lat1 - lat2)
londiff = (lon1 - lon2)
cab$euclidean = ((latdiff ** 2) + (londiff ** 2)) ** 0.5

str(cab)

cab$hour=NULL
cab$pickup_datetime =NULL

cab$passenger_count= as.factor(cab$passenger_count)
cab$weekday= as.factor(cab$weekday)
cab$daytime= as.factor(cab$daytime)
cab$month= as.factor(cab$month)
cab$year= as.factor(cab$year)
-------------------------------------------------------------------------------------------
#Correlation analysis
install.packages("corrgram")
library(corrgram)
numeric_index = sapply(cab,is.numeric) #selecting only numeric
numeric_data = cab[,numeric_index]

corrgram(cab[,numeric_index], order = F,
         upper.panel=panel.pie, text.panel=panel.txt, main = "Correlation Plot")


#other than euclidean, all other are not that correlated with fare amount, they are dropped.
--------------------------------------------------------------------------------------------
#Chi Square analysis
## Chi-squared Test of Independence
factor_index = sapply(cab,is.factor)
factor_data = cab[,factor_index]

unique(cab$daytime)
unique(cab$year)
unique(cab$month)
unique(cab$weekday)
unique(cab$passenger_count)

for (i in 1:4)
{
  print(names(factor_data)[i])
  print(names(factor_data)[i+1])
  print(chisq.test(table(factor_data[,i],factor_data[,i+1])))
}
#All the categorical variables are highly correlated with each other
# so one should be kept. But passenger count is kept along with one of the extracted variable "weekday"
# And others are dropped
# We will see later if they add upto the multicollinearity.

cab$month=NULL
cab$year =NULL
cab$daytime=NULL
cab$pickup_latitude =NULL
cab$dropoff_latitude=NULL
cab$pickup_longitude =NULL
cab$dropoff_longitude =NULL

head(cab)
------------------------------------------------------------------------------
#ANOVA test

twoway = aov(fare_amount ~ passenger_count + weekday, data = cab)

summary(twoway)

#The p-value of the passenger count variable is low (p < 0.05)
#so it appears that it has a real impact on the fare amount
#weekday is still kept for VIF test
-------------------------------------------------------------------------------
install.packages("usdm")
library(usdm)

cab$passenger_count= as.numeric(cab$passenger_count)
cab$weekday= as.numeric(cab$weekday)

vif(cab[,-2])

#Not much multicollinearity in the data.
--------------------------------------------------------------------------------
#Create dummy variables
install.packages('fastDummies')
library('fastDummies')

cab <- dummy_cols(cab, select_columns = c('passenger_count', 'weekday'))
str(cab)

cab$passenger_count=NULL
cab$weekday =NULL
cab$weekday_1=NULL
cab$passenger_count_1 =NULL
----------------------------------------------------------------------------------
#run regression model
lm_model = lm(fare_amount ~., data = cab)

#Summary of the model
summary(lm_model)

# F statistics value is very high and p value is very low that means the variables are significant.
# From all passenger count classes, 4 classes out of 6 are not significant.