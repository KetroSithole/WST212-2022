# Practical 1

# Name: u19182504

# Student Number: LM NKADIMENG

# Data and Packages

library(sqldf)
library(readr)

col1 <- c(5, 1, 6)
col2 <- c(2, 9, 4)
col3 <- c(0, 3, 7)

X_matrix <- matrix(cbind(col1, col2,col3), ncol = 3)

X_data <- as.data.frame(X_matrix)

employee_payroll <- read_csv("payroll.csv")
employees <- read_csv("employees.csv")
staff <- read_csv("staff.csv")

# Question 1.1:
Y_matrix <- matrix(data = seq(15,1), nrow = 3, ncol = 5)

# Question 1.2:
X_transpose <- t(X_matrix)



# Question 1.3:
X_inverse <- solve(X_matrix)


# Question 1.4:
X_det <- det(X_matrix)


# Question 1.5:
X_extract <- X_matrix[1,2]


# Question 2.1:
Y_data <- data.frame(matrix(c(seq(10,21)), nrow = 4, ncol = 3, byrow=T))


# Question 2.2:
X_modified <- X_data[-3, -2]

# Question 2.3:
rowMean <- function(X_data, FUN = mean){
  return(apply(X_data, 2, FUN))
}
X_means <- rowMean(X_data)


# Question 3:
a <- integer()
b <- integer()
c <- integer()

Calculator <- function(a,b,c){
  result <- (1 + (a/c))^b
  return(result)
}


# Question 4.1:
Q4_1 <- sqldf("SELECT Employee_ID, Employee_Gender, Marital_Status, Dependents
              FROM employee_payroll")

# Question 4.2:
Q4_2 <- sqldf("SELECT Employee_ID, Employee_Gender, Salary
              FROM employee_payroll
              ORDER BY Salary")

# Question 4.3:
Q4_3 <- sqldf("SELECT Employee_ID, City
              FROM employees
              WHERE Country = 'AU' 
              ORDER BY Employee_ID")

# Question 4.4:
#use the AS new_column_name

Q4_4 <- sqldf("Select Employee_ID, Salary, Salary*0.1 AS Bonus 
              from employee_payroll")
# Question 4.5:

## use CASE statement
Q4_5 <- sqldf("SELECT Employee_ID, Dependents,
              case
              WHEN Dependents = 0 then 'No children' 
              WHEN (Dependents = 1 OR Dependents = 2) then 'Small Family'
              WHEN Dependents > 2 then 'Large Family'
              end as Family_Size
              FROM employee_payroll")
              
       

