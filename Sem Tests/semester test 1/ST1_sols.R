################################################################################
# WST 212                                                                      #
# Semester Test 1                                                              #
# 2 April 2022                                                                 #
# 08:30 - 12:30                                                                #
# No late submissions will be accepted.                                        #
# Remember to save your script regularly.                                      #
# Check for possible syntax errors: Clear your environment and re-run your code#                                                                         #
################################################################################

# Name: 

# Student Number: 

# Data and Packages

library(readr)
library(sqldf)
library(lubridate)
library(RH2)
library(RJDBC)
library(rJava)

customer_info <- read_csv("customer_info.csv", show_col_types = FALSE)
customer_purchase_ctc <- read_csv("customer_purchase_ctc.csv", show_col_types = FALSE)
customer_purchase_info <- read_csv("customer_purchase_info.csv", show_col_types = FALSE)
employee_purchase_info <- read_csv("employee_purchase_info.csv", show_col_types = FALSE)
product_description <- read_csv("product_description.csv", show_col_types = FALSE)
product_sales <- read_csv("product_sales.csv", show_col_types = FALSE)

################################################################################

# Question 1 (3 marks)

customer_purchase_info$Purchase_Date <- as_date(customer_purchase_info$Purchase_Date, format = '%d-%b-%Y')

Q1 <- sqldf("SELECT *
              FROM customer_purchase_info
              WHERE (Purchase_Date BETWEEN '2022-01-05' AND '2022-02-26') 
                AND (Customer_type = 'Member')
              ORDER BY Customer_Id")


# Question 2 (3 marks)

customer_info$Today <- date("2022-04-02")

customer_info$Customer_birth <- as_date(customer_info$Customer_birth, format = '%d-%b-%Y')

Q2 <- sqldf("SELECT Customer_name, Customer_contact, Customer_birth,
              floor((Today - Customer_birth)/365.25) AS Age
              FROM customer_info
              WHERE floor((today - Customer_birth)/365.25) >= 60
              ORDER BY Customer_name") 



# Question 3 (3 marks)

Q3 <- sqldf("SELECT Product_ID, Rating,
              CASE
                WHEN Rating >= 9 AND Rating <= 10  THEN 'Excellent'
                WHEN Rating >= 6.5 AND Rating  < 9 THEN 'Good'
                WHEN Rating >= 4.5 AND Rating < 6.5 THEN 'Average'
                WHEN Rating >= 3 AND Rating < 4.5 THEN 'Poor'
                ELSE 'Terrible'
              END AS Feedback
            FROM customer_purchase_info
            ORDER BY Rating DESC")


# Question 4 (3 marks)

Q4 <- sqldf("SELECT Payment,COUNT(Payment) AS Payment_Count
            FROM customer_purchase_info
            GROUP BY Payment
            HAVING Payment_Count > 320
            ORDER BY Payment_Count DESC")



# Question 5 (3 marks)

Q5 <- sqldf("SELECT employee_id, Customer_name, Customer_contact, address, 
                Gender, Customer_birth
              FROM employee_purchase_info AS pi
              LEFT JOIN customer_info AS ci
              ON pi.Customer_ID=ci.Customer_ID")


# Question 6 (8 marks)

# Question 6a (4 marks)
Q6a <- sqldf("SELECT i.Customer_Id, i.Invoice_ID, 
                  SUM((c.Unit_Price*c.Quantity)+c.Tax) AS Customer_Total
                FROM customer_purchase_info AS i
                INNER JOIN customer_purchase_ctc AS c
                ON i.Invoice_ID = c.Invoice_ID
                GROUP BY i.Customer_Id
                ORDER BY Customer_Total DESC")

# Question 6b (4 marks)
Q6b <- sqldf("SELECT i.Branch, c.Product_ID, d.Product_line,
                SUM((c.Unit_price*c.Quantity)+c.Tax) AS Total_sales
              FROM customer_purchase_info AS i
              INNER JOIN customer_purchase_ctc AS c
              ON i.Invoice_ID = c.Invoice_ID
              INNER JOIN product_description AS d
              ON c.Product_ID = d.Product_ID
              GROUP BY i.Branch, c.Product_ID
              ORDER BY i.Branch, c.Product_ID")


# Question 7 (4)

Q7 <- sqldf("SELECT i.Customer_Id, i.Invoice_ID, s.Total, s.cogs,
                (s.Total-s.cogs) AS Profit
              FROM customer_purchase_info AS i
              INNER JOIN product_sales AS s
              ON i.Invoice_ID = s.Invoice_ID
              WHERE (s.Total-s.cogs) >= 20
              ORDER BY Profit")

