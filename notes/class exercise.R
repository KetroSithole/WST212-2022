library(sqldf)
library(readr)
library(RH2)

orion_sales <- read_csv("orion_sales.csv")
orion_order <- read_csv("orion_order_fact.csv")
super_flat_unit <- read_csv("super_flat_unit.csv")


Q1fg <- sqldf("SELECT Own_ID, SUM(Price)/COUNT(Own_ID) AS Owner_Average
            FROM super_flat_unit
            GROUP BY Own_ID")

Q1 <- sqldf("SELECT Own_ID, Owner_Average, AVG(Owner_Average) AS Ave_Flats
              FROM (SELECT Own_ID, SUM(Price)/COUNT(Own_ID) AS Owner_Average
                FROM super_flat_unit
                GROUP BY Own_ID)
            HAVING Owner_Average < Ave_Flats")


Q3a <- sqldf("SELECT s.Country, s.First_Name, s.Last_Name,
              SUM(o.Quantity_Ordered*o.Retail_Price) AS Value_Sold,
              COUNT(o.Order_ID) AS Orders,
              SUM(o.Retail_Price)/COUNT(o.Order_ID) AS Avg_Order
              FROM orion_order AS o
              INNER JOIN orion_sales as s
              ON o.Employee_ID = s.Employee_ID AND year(o.Order_Placed)='2011'
              GROUP by s.Country, s.First_Name, s.Last_Name
              HAVING Value_Sold >= 200")
             

Q3b <- sqldf("SELECT Country, Max(Value_Sold) AS Max_Sold,
             Max(Orders) AS Max_Orders,
             Max(Avg_Order) AS Max_Average,
             Min(Avg_Order) AS Min_Average
             FROM(SELECT s.Country, s.First_Name, s.Last_Name,
                SUM(o.Quantity_Ordered*o.Retail_Price) AS Value_Sold,
                COUNT(o.Order_ID) AS Orders,
                SUM(o.Retail_Price)/COUNT(o.Order_ID) AS Avg_Order
                FROM orion_order AS o
                INNER JOIN orion_sales as s
                ON o.Employee_ID = s.Employee_ID AND year(o.Order_Placed)='2011'
                GROUP by s.Country, s.First_Name, s.Last_Name
                HAVING Value_Sold >= 200)
             GROUP BY Country")