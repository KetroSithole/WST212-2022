# Practical 2

# Name: Lehlogonolo Marcus Nkadimeng

# Student Number: u19182504

# Data and Packages

library(readr)
library(sqldf)
library(RJDBC)
library(RH2)
library(lubridate)
library(rJava)

music_customer <- read_csv("music_customer.csv", show_col_types = FALSE)
orion_customer <- read_csv("orion_customer.csv", show_col_types = FALSE)
orion_employee_addresses <- read_csv("orion_employee_addresses.csv", show_col_types = FALSE)
orion_order_fact <- read_csv("orion_order_fact.csv", show_col_types = FALSE)
orion_sales <- read_csv("orion_sales.csv", show_col_types = FALSE)

# Question 1: 

Q1 <- sqldf("SELECT UPPER(State), COUNT(State) AS NumEmp
            FROM orion_employee_addresses
            WHERE UPPER(Country) = 'US'
            GROUP BY UPPER(State)")

# Question 2:

# The line of code below provides you a variable 'today' 
# in the Orion_customer table to assist getting the customer's ages.

orion_customer$today <- date("2022-03-15")
Q2 <- sqldf("SELECT Customer_ID, Customer_Birth_Date,
            ((today - Customer_Birth_Date)/365) AS Age
            FROM orion_customer")

# Question 3:

Q3 <- sqldf("SELECT Country, COUNT(*) AS Employees,
            SUM(Gender = 'M') AS Men, SUM(Gender = 'F') AS Women
            FROM orion_sales
            GROUP BY Country
            HAVING Women > 40")

# Question 4:
Q4 <- sqldf("SELECT CONCAT(Customer_Name, ' ', Customer_Surname) AS Customer_Full_name,
            Customer_Phone, Customer_Email
            FROM music_customer
            WHERE (Customer_City = 'Pretoria' OR Customer_City  = 'Johannesburg') AND Customer_Phone LIKE '%011%'
            ORDER BY Customer_Full_Name")


# Question 5:
Q5 <- sqldf("SELECT s.Employee_ID, s.First_Name, s.Last_Name, ea.Postal_Code
            FROM orion_sales AS s
            INNER JOIN orion_employee_addresses AS ea
            ON s.Employee_ID = ea.Employee_ID
            ORDER BY Employee_ID")


# Question 6:
Q6 <- sqldf("SELECT ea.Employee_ID, ea.Employee_Name, os.Job_Title, ea.City
            FROM orion_employee_addresses AS ea
            LEFT JOIN orion_sales AS os
            ON ea.Employee_ID = os.Employee_ID")


# Question 7:
orion_customer$Personal_ID = NULL
Q7 <- sqldf("SELECT cus.Customer_ID, cus.Customer_First_Name, cus.Customer_Last_Name, SUM(oo.Quantity_Ordered) AS items, oo.Order_ID
            FROM orion_order_fact AS oo
            LEFT JOIN orion_customer AS cus
            ON cus.Customer_ID = oo.Customer_ID
            GROUP BY oo.Order_ID")
