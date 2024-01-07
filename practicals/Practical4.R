# PRACTICAL 4

# Name: Snqobile Ntshagase

# Student Number: 19108002

library(sqldf)
library(stringr)
library(readr)
library(RH2)
library(lubridate)
library(rJava)
library(RJDBC)

orion_customer <- read_csv("orion_customer.csv") 
orion_product_dim <- read_csv("orion_product_dim.csv") 
orion_order_fact <- read_csv("orion_order_fact.csv") 
orion_sales <- read_csv("orion_sales.csv") 
orion_employee_addresses <- read_csv("orion_employee_addresses.csv") 


ultimate_employee <- read_csv("ultimate_employee.csv")
ultimate_flat_unit <- read_csv("ultimate_flat_unit.csv")
ultimate_building <- read_csv("ultimate_building.csv")
ultimate_suburb <- read_csv("ultimate_suburb.csv")
ultimate_city <- read_csv("ultimate_city.csv")


#Question 1
  
  q1 <- sqldf("SELECT a.Product_ID, a.Product_Name, b.Quantity_Ordered
               FROM orion_product_dim AS a
               INNER JOIN orion_order_fact AS b
               ON a.Product_ID = b.Product_ID
               WHERE b.Order_Delivered >= '2011-01-01' AND b.Order_Delivered <= '2011-12-31'
               GROUP BY a.Product_Name, b.Quantity_Ordered
               ORDER BY b.Quantity_Ordered")
  
#Question 2
  
  q2 <- sqldf("SELECT b.Employee_Name, b.City, a.Job_Title
               FROM orion_sales AS a
               LEFT JOIN orion_employee_addresses AS b
               ON a.Employee_ID = b.Employee_ID
               WHERE a.Gender = 'F' AND a.Job_Title LIKE '%Sales%'
               ORDER BY b.City, a.Job_Title, b.Employee_Name")

#Question 3
  
  q3 <- sqldf("SELECT a.Product_ID, a.Product_Name, b.Order_Placed
               FROM orion_product_dim AS a
               LEFT JOIN orion_order_fact AS b
               ON a.Product_ID = b.Product_ID
               WHERE b.Order_Placed = NULL")
  
#Question 4
  
  q4 <- sqldf("SELECT a.Customer_Name, SUM(c.Quantity_Ordered) AS Foreign_Purchases
               FROM orion_customer AS a
               INNER JOIN orion_product_dim as b
               ON a.Customer_Country != b.Supplier_Country
               LEFT JOIN orion_order_fact as c
               ON a.Customer_ID = c.Customer_ID
               WHERE a.Customer_Country = 'US' OR a.Customer_Country = 'AU'
               GROUP BY a.Customer_Name
               ORDER BY Foreign_Purchases DESC, a.Customer_Name")
  
#Question 5
  
  q5 <- sqldf("SELECT a.Emp_Name, a.Emp_Email, b.Sub_Name, c.City_Name
               FROM ultimate_employee AS a
               LEFT JOIN ultimate_suburb AS b
               ON a.Sub_ID = b.Sub_ID
               LEFT JOIN ultimate_city AS c
               ON a.City_ID = c.City_ID
               WHERE a.Emp_Email LIKE '%ymail%' OR a.Emp_Email LIKE '%shaimail%'")
  
#Question 6
  
  q6 <- sqldf("SELECT Flat_Unit_Number, Bld_Name, Sub_Name, City_Name
               FROM ultimate_flat_unit AS a
               INNER JOIN ultimate_building AS b
               ON a.Bld_ID = b.Bld_ID
               INNER JOIN ultimate_suburb AS c
               ON a.Sub_ID = c.Sub_ID
               INNER JOIN ultimate_city AS d
               ON a.City_ID = d.City_ID")