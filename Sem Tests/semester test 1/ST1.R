################################################################################
# WST 212                                                                      #
# Semester Test 1                                                              #
# 2 April 2022                                                                 #
# 08:30 - 12:30                                                                #
# No late submissions will be accepted.                                        #
# Remember to save your script regularly.                                      #
# Check for possible syntax errors: Clear your environment and re-run your code#                                                                         #
################################################################################

# Name: LM NKADIMENG

# Student Number: u19182504

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

# Question 1 (3 marks):

customer_purchase_info$Purchase_Date = as.Date(customer_purchase_info$Purchase_Date, format="%d-%B-%Y")
Q1 <- sqldf("SELECT *
            FROM customer_purchase_info
            WHERE Purchase_Date >= '2022-01-09' AND Purchase_Date <= '2022-02-28'
            ORDER BY Customer_Id")


# Question 2 (3 marks):
customer_info$Today <- date("2022-04-02")
customer_info$Customer_birth <- as_date(customer_info$Customer_birth, format = '%d-%b-%Y')
Q2 <- sqldf("SELECT Customer_name, Customer_contact, Customer_birth,
              floor((Today - Customer_birth)/365.25) AS Age
              FROM customer_info
              WHERE floor((today - Customer_birth)/365.25) >= 60
              ORDER BY Customer_name")


# Question 3 (3 marks):
Q3 <- sqldf("SELECT Product_ID, Rating,
            case
            WHEN Rating >= 9 THEN 'Excellent'
            WHEN Rating >= 6.5 AND Rating < 9 then 'Good'
            WHEN Rating >= 4.5 AND Rating < 6.5 then 'Average'
            WHEN Rating >= 3 AND Rating < 4.5 then 'Poor'
            WHEN Rating >= 0 AND Rating < 3 then 'Terrible'
            end as Feedback
            FROM customer_purchase_info
            ORDER BY Rating DESC")

fakeQ <- sqldf("SELECT Payment, COUNT(*) AS payment_stats
               FROM customer_purchase_info
               GROUP BY Payment
               HAVING payment_stats > 320")

# Question 4 (3 marks):
Q4 <- sqldf("SELECT Payment, COUNT(*) AS No_Customers
            FROM customer_purchase_info
            GROUP BY Payment
            HAVING No_Customers > 320
            ORDER BY No_Customers DESC")


# Question 5 (3 marks):
Q5 <- sqldf("SELECT e.employee_id, c.Customer_name, c.Customer_contact, e.address, c.Gender, c.Customer_birth
            FROM employee_purchase_info AS e
            LEFT JOIN customer_info AS c
            ON e.Customer_id = c.Customer_Id")


# Question 6 (8 marks):
Q6a <- sqldf("SELECT cpi.Customer_Id, cpi.Invoice_ID, SUM((ctc.Quantity*ctc.Unit_Price) + ctc.Tax) AS Customer_Total
            FROM customer_purchase_info AS cpi
            INNER JOIN customer_purchase_ctc AS ctc
            ON cpi.Invoice_ID = ctc.Invoice_ID
            GROUP BY Customer_Id
            ORDER BY Customer_Total DESC")

##Q6b <- sqldf("SELECT cpi.Branch, cpi.Product_ID, pd.Product_line,
#             SUM((ctc.Quantity*ctc.Unit_Price) + ctc.Tax) AS Customer_Total
         #    FROM customer_purchase_info AS cpi
           #  INNER JOIN product_description AS pd
            # ON cpi.Product_ID = pd.Product_ID
            # INNER JOIN customer_purchase_ctc AS ctc
             #ON cpi.Invoice_ID = ctc.Invoice_ID
             #GROUP BY Branch, Product_ID
            # ORDER BY Branch, Product_ID")


# Question 7 (4 marks):



