# Practical 6

# Name: LM NKADIMENG

# Student Number: u19182504

#Packages:

library(readr)
library(readxl)
library(ggplot2)

# Data:

# The first dataset of interest is:

bank <- read_csv("bank_data.csv")

# The second dataset of interest is:

spirals <- read_excel("spiral.xlsx")

# The third dataset of interest is:

cluster <- read.csv("cluster.csv")

### QUESTION 1 ###

# Question 1a: 
bank$y <- ifelse(bank$y == "yes", 1,0)
bank$y <- factor(bank$y, levels = c(1,0))


# Question 1b:
set.seed(15)
ds <- sample(1:nrow(bank), round(0.7*nrow(bank)), replace = FALSE)
Q1b_train <- bank[ds,]
Q1b_test <- bank[-ds,]

# Question 1c:
(table(Q1b_train$y)/nrow(Q1b_train)) * 100
Q1c <- glm(y ~., data=Q1b_train, family="binomial")

# Question 1d:
Q1d <- predict(Q1c, Q1b_test, type="response")


# Question 1.e:
condition <- ifelse(Q1d>0.5, 1, 0)
Q1e <- factor(condition, levels = c(0, 1))

### QUESTION 2 ### 

# Question 2.a:
set.seed(18)
Q2a<- kmeans(spirals, centers = 3, nstart = 20)


# Question 2.b:
Q2b <- sapply(1:15,function(k){kmeans(spirals,k,nstart = 20,iter.max = 20)$tot.withinss})


### QUESTION 3 ###



# Question 3:
set.seed(72)
Q3a <- kmeans(cluster, centers = 2, nstart = 20)
Q3b <- kmeans(cluster, centers = 3, nstart = 20)
Q3c <- kmeans(cluster, centers = 4, nstart = 20)
Q3d <- kmeans(cluster, centers = 5, nstart = 20) 
Q3e <- Q3c


