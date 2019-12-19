##################################################
## POLSCI514 week10
## Introduction to R 
## Date: 2019/11/8
## Author: Saki Kuzushima
##################################################


# Table of contents

# (0) Logistics
# - comment on pset 4: Interpret the result! 
# - plan from now: tidyvrese + 599 ps helper + (more 'real' data analysis if time allows)

# 1. 599 pset 8 helper (posson binom)
# 2. dplyr basic

# 1. 599 pset 8 helper (posson binom) -------------------------------------------

# Brief intro of Poisson binomial distribution

# btw wikipedia is a great source of check the properties of probability distributions quickly.
# binomial: https://en.wikipedia.org/wiki/Binomial_distribution
# poisson binomial: https://en.wikipedia.org/wiki/Poisson_binomial_distribution

# Poisson binomial distribution is like a collection of "different" coin tosses. 
# Let's start with binomial - a collection of "same" coin tosses  

# How many times do we get the head of coin when the coin is "fair" (the probability of getting head = 1/2)
# when we throw the coin 10 times? 

# Let's simulate this process. Using rbinom() function, draw one sample from Binom(n=10, p=1/2). 
x <- rbinom(n = 1,  size = 10, prob = 1/2)
x

# If you get larger sample, you can get the histogram 
y <- rbinom(n=100, size=10, prob=1/2)
hist(y)

# While binomial distribution assumes that the probability of getting head is same across the tosses
# Poisson binomial relaxes this assumtion, and assume that the probability of getting head is different across each tosses.
# Suppsoe the probability of getting head is (1, 1/2, 1/3, ...1/10)
library(poisbinom)
# First let's check the usage of rpoisbinom
?rpoisbinom

# Example section is helpful. The following is the code in the example section. 
## Binomial probabilities -----------------------
pp <- runif(500)

## PMF
dpoisbinom(230, pp)  
# (the probability that 36 of 500 coins are head)

## CDF
ppoisbinom(36, pp)

## Quantile function
qpoisbinom(0.3, pp)

## Random deviates
rpoisbinom(5, pp)
# ----------------------------------------------

# Now we can use rbinom to simulate the coin toss with different coins. 
# create c(1, 1/2, 1/3, ...1/10)
prob_pb <- rep(0, 10)
for (i in 1:10){
  prob_pb[i] <- 1/i
}

z <- rpoisbinom(n=1, pp=prob_pb)
z

# In the pset 8, we have different winning probability for each candidate. Use it as the probability (pp), 
# and use dpoisbinom function to create PMF of 
# The following code computes the PMF of poissbinomial distributinon
pp <- runif(n=100, min=0, max=1)
a <- seq(0,1, 0.01) # because this random variable can take values from 0 to 100. 
pmf <- ppoisbinom(q=a, pp) 
plot(a, pmf)




# (2) dplyr way of group summary statistics   -----------------------------


# load data
house <- read.csv('data/house_pred_18.csv')
# show first 6 rows of the data
head(house)
# show summary of the data
summary(house)
# Whenever you have a new data, do check head() and summary()! 
# It's important to quickly inspect the data before doing any analysis. 


# Suppose we want two summary statistics:
# 1. the mean winning probability across the candidate of each state, 
# and store them in a dataframe

# Exercise: Solve this task this using for loop or tapply
# If you can solve this by for loop or tapply, try the other way. Or Find a new way to compute this. 
# hint is in the code last week


# base way 1 (for loop)
mean_win <- state_name <- c()
house_state <- split(house, house$state)
for (i in 1:length(house_state)){
  temp <- house_state[[i]]
  state_name[i] <- as.character(temp$state)[1]
  mean_win[i] <- mean(temp$win_probability)
}

mean_win
base1 <- data.frame(state_name=state_name, 
                    mean_win=mean_win)
base1

# base way2(apply family)

tapply(house$win_probability, house$state, mean)









# (3) tidyverse -- dplyr

# This section introduces the most useful functions of dplyr. 
# (The following content is based on the r4ds, Chapter 5 Data Transforamtion: https://r4ds.had.co.nz/transform.html, 


# Lets' first attach the tidyverse package
library(tidyverse)

# get the sample data 
data(mtcars)
head(mtcars)

# Quick review of pipe! 
# Essentially, what %>% does is to plug something before the pipe, 
# to the frist argument of the function after the pipe. 

# takes the number of rows
rows <- mtcars %>% 
  nrow()

# This is the same as
rows <- nrow(mtcars)


# I will use nycflight13 data (as the book uses this). 
# THis data contains all flights that departed from NYC in 2013. 
# install.packages("nycflights13") -- if you haven't installed already

#install.packages('nycflights13') 
library(nycflights13)
data(flights)
?flights # for data description

# always inspect the data! 
head(flights)
summary(flights)

# it looks a bit different from data.frame. This is called tibble 
#- a data frame equivalent in dplyr. 
# One difference arises when you showed the object in console.
# If you use dataframe, all elements show up; tibble shows only a first few rows
# so that your console is occupied by a gigantic dataframe
flights
flights_df <- as.data.frame(flights)
flights_df ## this will take time and exhausts your console. Don't recommend. 
head(flights_df) # this looks better

# Another difference is that some meta information will show up as well as the actual table
flights
# You can see the dimensions, class of each variable (int, chr etc...)



# Let me introduce several key dplyr functions that allows you to do majority of the
# simple data manipulations. 

filter() # pick observations by values
arrange() # reorder the rows by some variables
select() # pick variables by their names
mutate() # create a new variable with existing variables
summarise() # collapses many values into a single summary

# I will do some demonstration as well as equivalent code using base. (inside ~~~~~~ area)

# 1. filter 
# THis allows you to subset data based on the values
# The first argument is the name of the data frame (or tibble), 
# the second and the rest of the arguments are the expressions taht filter the data
filter(flights, month == 1, day == 1)

# Or, using pipe
flights %>%
  filter(month == 1, day == 1)

# You can assign the subset to some object
jan1 <- filter(flights, month == 1, day == 1)

# base equivalent ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
subset(flights, flights$month ==1 & flights$day == 1)
# or
flights[flights$month == 1 & flights$day == 1,]
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 2. arrange
# This function will change the order of observation based on some variables
# If you provide more than one column name, each additional column will be used to 
# break ties 
arrange(flights, year, month, day)
# This will arrange by year, month and day. 

# for decreasing order, use desc()
arrange(flights, desc(dep_delay))
# compare with
arrange(flights, dep_delay)



# base equivalent ~~~~~~~~~~~~~~~~~~~~~~~~~~~`

# order will return a "ranking" of a variable
x <- sample(1:10, 3)
x
order(x) # the smallest gets 1, the middle gets 2, the largest gets 3 

# We can use this with indexing to arrange
flights[order(flights$dep_delay),]
flights[order(flights$dep_delay, decreasing = T),] # decreasing
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`



# 3. select

# select will literally select some of the columns you are interested in. 
select(flights, year, month, day)
# You can exclude some columns using negative sign
select(flights, year, month, day)

# base equivalent ~~~~~~~~~~~~~~~~~~~~~~~~~~~`
flights[,c("year", "month", "day")]
flights[,!(colnames(flights) %in% c("year", "month", "day"))] # exclude

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`

# 4. mutate
# add a column that are functions of existing columns

# First create a small subset of data for display
flights_sml <- select(flights, 
                      year:day, # all columns from year to day
                      ends_with("delay"),  # the columns that ends with "delay"
                      distance, 
                      air_time)


mutate(flights_sml,
       gain = dep_delay - arr_delay
)

# You can refer to the column you just created 
mutate(flights_sml,
       gain = dep_delay - arr_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours # refer to gain and hours yo ujust created
)

# base equivalent ~~~~~~~~~~~~~~~~~~~~~~~~~~~`
flights_sml$gain <- flights_sml$dep_delay - flights_sml$arr_delay
flights_sml
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`




# Exercise (filter)
# Find all flights that had an arrival delay of two or more hours
filter(flights, arr_delay >= 120)

# Exercise (arrange)
# Sort flights to find the most delayed flights, and the flights that left earliest
# (departure delay!)
arrange(flights, desc(dep_delay))

arrange(flights, dep_delay)

# start here next week (and talk about ggplot 2) ---------------------------------

# Exercise (mutate)
# Currently dep_time and sched_dep_time are convenient to look at, but hard to compute with
# because they’re not really continuous numbers. 
# Convert them to a more convenient representation of number of minutes since midnight.

mutate(flights, 
       dep_time_min=(dep_time %/% 100) * 60 + (dep_time %% 100),
       sched_dep_time_min=(sched_dep_time %/% 100) * 60 + (sched_dep_time %% 100)) %>%
  select(dep_time_min, sched_dep_time_min)

new_flights <- mutate(flights, 
                      dep_time_min=(dep_time %/% 100) * 60 + (dep_time %% 100),
                      sched_dep_time_min=(sched_dep_time %/% 100) * 60 + (sched_dep_time %% 100))
select(new_flights, dep_time_min, sched_dep_time_min)


# hint
1234 %/% 100 # integer part of division
1234 %% 100 # remainder part of division


(1234 %/% 100) * 60 + (1234 %% 100)





# 5. Summarise

# Summarise() create a summary statistics of some columns 
# for instance, mean departure delay time
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))
# na.rm = T removes NA values when computing the mean

# summarise is useful particularly when it is with group_by() function. 
# It changes the scope of the data on which mean is computed. 
# When you provide a variable name to group_by function, 
# group_by() will internally split the data, and summarise() will
# compute the mean within each group. 
# Like arrange(), group_by() will use the second and later variables to break ties. 

# split the data by year, month and day
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

# You can connect the line by pipe
group_by(flights, year, month, day) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE))
# or
flights %>%
  group_by(year, month, day) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE)) 

# and you can save the result in some object
delays <- flights %>%
  group_by(year, month, day) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE)) 

delays

# Of course, you can use other functions than mean
# A useful function that is specific to dplyr is n() - the number of rows of each group
delays <- flights %>%
  group_by(year, month, day) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE),
            count = n()) 

delays

# base equivalent ~~~~~~~~~~~~~~~~~~~~~~~~~`
delay_base <- tapply(flights$dep_delay, list(flights$year, flights$month, flights$day), mean, na.rm = T)
class(delay_base) # array! 
delay_base[1,,] # first year (2013) (row = months, column = day)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`

# Exercsie: Compute the average arrival delay time for each carrier, 
# and sort by the carrir with the largest delay. Which carrier has the largest arrival delay on average? 
# (Use 'airlines' to see the full names of carriers)
airlines

# Exercise: use dplyr to compute the group mean of winning probability within each state
# (the solution is actually in the lecture code for the last week...)


# Reference : R for Data Science, Chapter 5: https://r4ds.had.co.nz/







