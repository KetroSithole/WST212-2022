# PRACTICAL 0

# Name: LM NKADIMENG

# Student Number: u19182504

# Data and Packages:

Heights <- seq(150,210)

# Question 1:
Y <- 5


# Question 2:
a <- 4
b <- 3
c = -8

X <- (-b - sqrt(b^2 - 4*a*c)) / (2*a)
# Question 3:
X_rounded <- round(X, 3)


# Question 4
Mean_Height <- mean(Heights)


# Question 5
Updated_Heights <- c(Heights, Mean_Height)


# Question 6
num <- length(Heights)

Temp_Heights <- rep(NA, 61)
for(i in 1:num){
  if((Heights[i] %% 2) == 0){
    Temp_Heights[i] <- Heights[i]  }  
}
Even_Heights <- Temp_Heights[!is.na(Temp_Heights)]

# Question 7
hist(Heights,
     main = "Histogram for the heights",
     col = 'purple2',
     border = 'pink2')

