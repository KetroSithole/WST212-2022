library(readr)
library(sqldf)
library(lubridate)
library(RH2)

melody_album <- read_csv("melody_album.csv")
melody_album_price <- read_csv("melody_album_price.csv")
melody_customer <- read_csv("melody_customer.csv")
melody_invoice <- read_csv("melody_invoice.csv")
melody_invoice_line <- read_csv("melody_invoice_line.csv")


######################################################################################
q1 <- sqldf("SELECT ma.Album_Name, ma.Album_Artist, map.Price_Amount, map.Price_Desc
            FROM melody_album as ma
            INNER JOIN melody_album_price AS map
            ON ma.Price_ID = map.Price_ID
            ORDER BY Album_Name")
######################################################################################
q2 <- sqldf("SELECT mc.Customer_Acc_No, mc.Customer_Surname, mc.Customer_Name,
            SUM(mil.Purchase_Quantity* mil.Item_Unit_Price) AS Total
            FROM melody_customer AS mc
            INNER JOIN melody_invoice AS mi
            ON mc.Customer_Acc_No = mi.Customer_Acc_No
            INNER JOIN melody_invoice_line as mil
            ON mi.Invoice_Num = mil.Invoice_Num
            GROUP BY mc.Customer_Acc_No
            ORDER BY Total")
