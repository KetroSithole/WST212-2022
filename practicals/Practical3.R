# Practical 3

# Name: LM NKADIMENG

# Student Number: u19182504

# Data and Packages

library(readr)
library(sqldf)
library(lubridate)
library(RH2)

orion_customer <- read_csv("orion_customer.csv")
orion_employee_addresses <- read_csv("orion_employee_addresses.csv")
orion_employee_payroll <- read_csv("orion_employee_payroll.csv")
orion_order_fact <- read_csv("orion_order_fact.csv")
orion_organisation <- read_csv("orion_organisation.csv")
orion_product_dim <- read_csv("orion_product_dim.csv")

# SQL Joins

# Question 1: 
Q1 <- sqldf("SELECT oea.Employee_ID, oea.Employee_Name, oo.Job_Title, oo.Department
            FROM orion_employee_addresses AS oea
            INNER JOIN orion_organisation AS oo
            ON oea.Employee_ID = oo.Employee_ID
            ORDER BY Department")


# Question 2:
Q2 <- sqldf("SELECT oo.Manager_ID, COUNT(oo.Employee_ID) AS NumEmp
            FROM orion_organisation AS oo
            INNER JOIN orion_employee_addresses AS oea
            ON oo.Employee_ID = oea.Employee_ID
            GROUP BY Manager_ID
            ORDER BY NumEmp DESC")


# Question 3:

Q3 <- sqldf("SELECT op.Product_Name, op.Product_ID, oof.Order_Placed
            FROM orion_product_dim AS op
            INNER JOIN orion_order_fact AS oof
            ON op.Product_ID = oof.Product_ID
            WHERE oof.Order_Placed = NULL")

# Question 4:
Q4 <- sqldf("SELECT oc.Customer_ID, oc.Customer_Name, SUM(oof.Quantity_Ordered) AS Foreign_Purchases
            FROM orion_customer AS oc
            INNER JOIN orion_product_dim AS opd
            ON oc.Customer_Country != opd.Supplier_Country
            INNER JOIN orion_order_fact AS oof
            ON oc.Customer_ID = oof.Customer_ID
            WHERE oc.Customer_Country = 'US' OR oc.Customer_Country = 'AU'
            GROUP BY oc.Customer_ID
            ORDER BY Foreign_Purchases, oc.Customer_ID")


# SQL Subqueries

# Question 5:
Q5_a <- sqldf("SELECT Employee_ID
              FROM orion_employee_payroll
              WHERE month(Employee_Hire_Date) = 03
              ORDER BY Employee_ID")

Q5_b <- sqldf("SELECT oea.Employee_ID, oea.Employee_Name
              FROM orion_employee_addresses AS oea
              INNER JOIN (SELECT Employee_ID
              FROM orion_employee_payroll
              WHERE month(Employee_Hire_Date) = 03
              ORDER BY Employee_ID) AS t
              ON oea.Employee_ID=t.Employee_ID
              ORDER BY oea.Employee_ID ASC
              ")
# Question 6:

