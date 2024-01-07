# Practical 5

# Name: LM NKADIMENG

# Student Number: u19182504

#Packages:

library(dplyr)
library(tidyr)
library(gapminder)
library(stringr)

# Data:

# The first dataset of interest is:

summary(gapminder)
?gapminder

# The second dataset of interest is:

sample_text <- 'I am a student from the University of Pretoria. I
                was born in Durban, South Africa and I have been a huge soccer
                fan for 9 years. I also have a passion for Philosophy 
                and love talking about it and discovering more things about the field. 
                Therefore, I am going to get a degree in Philosophy toimprove my chances 
                of becoming a Philosophy professor. I have been working towards this goal
                for 4 years. I am currently enrolled in a PhD program. It is very difficult, 
                but I am confident that it will be a good decision.'

# The third dataset of interest is:

string <- 'Hi my name are John and my email address are john.doe@somecompany.co.uk and my friend\'s 
email are jane_doe124@gmail.com, but the following are invalid emails: j@p, jj@p, j@pp and jp.com.'

# Question 1a: 
Q1a <- gapminder %>% filter(continent=="Africa" & year=="2002") %>% select(-c(lifeExp, continent, year, gdpPercap))


# Question 1b:
Q1b <- gapminder %>%  filter(pop==max(pop)) %>% select(country)


# Question 1c:
Q1c <- gapminder %>% mutate(GDP = pop*gdpPercap) %>% select(GDP)


# Question 1d:
Q1d <- gapminder %>% mutate(GDP = pop*gdpPercap) %>% filter(GDP==max(GDP)) %>% select(country)


# Question 1e:
gapminder <- gapminder %>% mutate(mean_life_exp = mean(lifeExp))


# Question 1f:
Q1f <- gapminder %>% filter(lifeExp>mean(lifeExp)) %>% group_by(continent) %>% summarize(n=n())


# Question 1.g:
gapminder <- gapminder %>% mutate(high_level_exp = case_when
                                  (lifeExp>mean_life_exp ~ 1,
                                    lifeExp<mean_life_exp ~ 0))

# Question 2.a) & Question 2.b)
Q2a <- str_detect(sample_text, "Durban")
Q2b <- "Durban"


# Question 2.c) & Question 2.d)
Q2c <- str_extract_all(sample_text, "[0-9]{1,}+")
Q2d <- "[0-9]{1}+"

# Question 2.e) & Question 2.f)
Q2e <- str_locate(sample_text, "Philosophy")
Q2f <- "Philosophy"

# Question 2.g) & Question 2.h)
Q2g <- str_detect(sample_text, "PhD")
Q2h <- "PhD"

# Question 3.a)
str_extract_all(string, "[//w.]{1,}+[@][\\.\\w]{1,}+")
Q3a <- "[\\w.]{1,}+[@][\\.\\w.]{1,}+"

# Question 3.b)
#valid <- "[\\w.]+[@][\\w]+[.][\\w.]"
str_extract_all(string, "[\\w.]{2,}+[@][\\w]+[.][\\w.]+")
Q3b <- "[\\w.]{2,}+[@][\\w]+[.][\\w.]+"

# Question 3.c)
Q3c <- str_replace_all(string, "are", "is")

