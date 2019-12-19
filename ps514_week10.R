##################################################
## POLSCI514 week10
## Introduction to R 
## Date: 2019/11/8
## Author: Saki Kuzushima
##################################################


# Table of contents

# (0) Logistics
# - tidyverse install

# (1) Review: custom functions
# (2) Review of for loop and tapply using election prediction data 
# (2) A quick look at Tidyverse - dplyr 

# (1) Review of custom functions ---------------------------------------------

# Last week we learned how to create custom functions. 
# (....Demonstration of generalization and translation on board ....)

# Remember that mean of a vector is a sum of vector divided by the length of a vect
test_vec <- sample(1:100, 10)
mean(test_vec)
sum(test_vec)/length(test_vec) # same


# This code create a function to compute mean in the second way. 
MyMean <- function(x){
  res <- sum(x)/length(x)
  return(res)
}

# A tip to create function is to start with an example. Here, I first wrote a code
# to compute mean dividing a sum by the length of a vector called "test_vec"
# Then, I wrapped the code sum(test_vec)/length(test_vec) with function(x){ ... }
# and replaced "test_vec" to "x". Here, "x" represents a generic vector. 

MyMean(test_vec)
mean(test_vec) # same

# Note: usage  of a function (not only about the custom functions)
# In R, all function has a form "name_of_the_function()" i.e. parenthesis will follow after the name of 
# a function. Also, all functions are objects. i.e. function is also stored in a box with a particular name. 
# e.g. MyMean is a storage for a function. 

# The things you supply to a function, is called an argument. 
# You can specify the arguments explicitly or implicitly. 
MyMean(x=test_vec)
MyMean(test_vec)
# are the same. Both supply test_vec to an argument x. (Analogy of a function in math, f(x))

# Some functions take more than one arguments. For instance, 
?plot
# says it can take two (and more ) arguments, x, y, and ... . (Let's ignore "..." for now)
# So you can supply two things. For instance, 
time <- 1990:2000
value <- rnorm(11)

plot(x=time, y=value) # explicit
plot(time, value) # implicit (the output is the same)


# You can also create a function that takes more than one arguments
# This function return nth element of a vector x
MyTwo <- function(x, n){
  res <- x[n]
  return(res)
}

my_vec <- sample(1:20, 10)
MyTwo(x=my_vec, n = 3)
my_vec[3]  # same 

# You can combine a function with if else too
MyTwo2 <- function(x, n){
  if (n <= length(x)){
    res <- x[n]
  }else{
    # If n is grater than the length of x, we cannnot get the n th element of x
    # So, we return error message.
    res <- 'Impossible!'
  }
  return(res)
}

MyTwo2(x=my_vec, n = 100)
length(my_vec)

# Exercise: Create a function to compute the 
# mean of a vector if the vector's length is even;
# sum of a vector if the vector's length is odd. 

# Check if something is even or odd -- %% (modulo)
10 %% 2 ## return 0 because the reminder is zero
11 %% 2 ## returns 1 because the reminder is 1 

x <- 10
x %% 2 == 0 # returns TRUE because x is even

test <- c(1,2,3,4)

# length 
length(test)

# sum 
sum(test)

# mean 
mean(test)
sum(test)/ lenght(test)

# check 
length(test) %% 2 == 0

My_func <- function(x){
  
  if (length(x) %% 2 == 0){
    # if length of x is even
    out <- mean(x)
  }else{
    # if length of x is odd
    out <- sum(x)
  }
  return(out)
}



# (2) Review of for loop and tapply using election prediction data  -----------------------------

# Let's do some practice of using for loop and tapply, using the real data
# we use the data for the 599 problem set: Midterm Election prediction in 2018. 

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
# 2.the number of districts in each state.
# and store them in a dataframe

# Note that you may have noticed that the number of rows does not match the number of seats. 
nrow(house)  # not 435
# We will talk about this problem later, but let's ignore about this for now. 

# The task is a bit involved. Whenever we have involved problems, 
# the best appraoch is to spli tthe task into pieces. 
# So, let's first focus on getting the 1. mean winning probability, and 2. number of district 
# of Michigan! 

# Michigan
# get a subset of data for Michigan
mi <- subset(house, house$state == "MI")

# mean winning probability
mean(mi$win_probability) 
# number of districts
max(mi$district)
length(mi$district)

# Ok, we did this for Michigan. So, we have to expand this procedure to all other states. 
# Which tools can we use to do the same computation for many data? - loop and apply family! 

# I wil lshow two ways - loop and apply. 
# If you are a beginner, first get used to the loop way. Then, if you are confortable, 
# try to use apply. 


# base way 1 (for loop)
state_ls <- split(house, house$state) # split the data by state variable
class(state_ls)

win <- n_dist <- c() # craete a storage
win <- c()
n_dist <- c()
for (i in 1:length(state_ls)){
  # get the i th element of the list, state_ls
  house_state <- state_ls[[i]]
  # compute the mean winning probability and store in the i the elemnet of the vector win
  win[i] <- mean(house_state$win_probability)
  # get the max ID of the district, and store in the i th elemnet of the vector n_dist
  n_dist[i] <- max(house_state$district)
}
win
n_dist


# State name 
unique(house$stat) ## unique element of a vector

# store in a data frame
base_way1 <- data.frame(state=unique(house$state), 
                        win=win, 
                        n_dist=n_dist)

# base way2(apply family)
# apply a function "mean" on a vector "house$win_probability$ for each state
win <- tapply(house$win_probability, house$state, mean)
n_dist <- tapply(house$district, house$state, max)

# store in a dataframe
base_way2 <- data.frame(state=unique(house$state), 
                        win=win, 
                        n_dist=n_dist)

# the result is the same. 
head(base_way1)
head(base_way2)


# These two computation - split -> for loop and tapply -- are very useful in data analysis
# because this "group wise" computation shows up many times. 
# Use the code above as a reference to do some data analysis of the data you are interested in. 


# (3) tidyverse -- dplyr

# So far, we have been mostly using "base" functions - the functions that come along 
# when you installed R. However, we have more useful packages! For instance, 
# I created a list of packages that (I think) are useful for political scientists
# (list_packages.pdf) This is far from an extensive list of the packages available. 

# One of the most useful package I and many people think is "tidyverse" 
# Tidyverse is a collection of packages that includes ggplots, dplyr and other useful packages. 
# This was mainly created by Hadley Wickham, and he wrote a book (online available here: https://r4ds.had.co.nz/)
# about how to use this package. So, this section will cover a small part of the book, 
# that I find is most useful for preprocessing and small descriptive statistics. 
# (The following content is based on the r4ds, Chapter 5 Data Transforamtion: https://r4ds.had.co.nz/transform.html, 
# and 18. Pipes https://r4ds.had.co.nz/pipes.html)


# Lets' first attach the tidyverse package
library(tidyverse)

# get the sample data 
data(mtcars)
head(mtcars)

# To effectively use dplyr and other tidyverse packages, I have to introduce "pipe"
# Pipes are a way to express a sequence of code better, and is provided by magrittr package in tidyverse. 
# Pipe is expressed as %>% (does it look like a pipe....? maybe)
# The basic syntax works like this

# takes the number of rows
rows <- mtcars %>% 
  nrow()
  
# This is the same as
rows <- nrow(mtcars)

# What %>% does is to plug something before the pipe, 
# to the frist argument of the function after the pipe. 
# You can supply other arguments too
test_mean <- mtcars$mpg %>% 
  mean(na.rm = T)
# na.rm=T is the second argument, and the first argumetn is mtcars$mpg (mpg column of the data called mrcars).
# (na.rm = T removes all the NAs to compute the mean)

# This is equivalent to 
test_mean <- mean(mtcars$mpg, na.rm = T)

test_vec <- c(1,2,3,NA)
mean(test_vec)
mean(test_vec, na.rm =T)

# Why do we want to write in this way? Because we can do something nicely and more intuitively.  
# For instance, we can rewrite the code to compute the mean winning probability and the numbe rof district
# more efficeintly. 
# (I will explain the syntax later)

# dplyr way (I will explain it in detail later)
dplyr_way <- house %>% 
      group_by(state) %>%
      summarise(win=mean(win_probability), 
                n_dist = max(district))

# all results are the same
head(base_way1)
head(base_way2)
head(dplyr_way)

# The dplyr allows you to write a clearner way than for loop or tapply. 
# (Also, the computational time is usually shorter with dplyr ,but it depends on the data size, 
# the actual computation you do etc. )

# I will use nycflight13 data as the book uses this. 
# THis data contains all flights that departed from NYC in 2013. 
# install.packages("nycflights13") -- if you haven't installed already
library(nycflights13)
data(flights)

# always inspect the data! 
head(flights)
summary(flights)

# it looks a bit different from data.frame. This is called tibble - a data frame equivalent
# in dplyr. 

# Let me introduce several key dplyr functions that allows you to do majority of the
# simple data manipulations. 

filter() # pick observations by values
arrange() # reorder the rows by some variables
select() # pick variables by their names
mutate() # create a new variable with existing variables
summarise() # collapses many values into a single summary

# Today; I will focus on summarise() because I think it is the most useufl! 
# and have a great connection with tapply we have learnd. 

# Summarise() collapses a data frame into a single row
# mean departure delay time
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))
# na.rm = T removes NA values when computing the mean

# summarise is useful only when it is with group_by() function. 
# It changes the scope of the data on which mean is computed. 
# When you provide a variable name to group_by function, 
# group_by() will internally split the data. 

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
# For instance, the example above use max() function to get the max value. 
# A useful function that is specific to dplyr is n() - the number of rows of each group
delays <- flights %>%
  group_by(year, month, day) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE),
            count = n()) 

delays



# (If time allows.... more examp,le )
# Note: how to check the districts with more than one candidate..


# 1. apply way

# the number of rows for each district
rows <- tapply(house$district, house$state, length)
# the max ID number of district 
maxs <- tapply(house$district, house$state, max)
# They should be the same because each district should have one ID, and ID are 1,2,3,....
# If they are difference, there is something wrong going on...

# store the result in a data frame
check <- data.frame(
  rows=rows, 
  maxs=maxs,
  same=(rows==maxs)
)
check
# Okay... theere are three states whose number of rows and the max ID of the district does not match. 
# For instante CA
# subset CA data
ca <- subset(house, house$state == "CA")
# added a logical vector that indicates the duplication of the same value 
ca$is_duplicate <- duplicated(ca$district)
ca
# 6, 27, 44 distrct has two rows! 



# 2. dplyr way 
dplyr_check <- house %>%
  group_by(state, district) %>%
  summarise(count = n()) %>%
  filter(count > 1)
# easy! yay!  



# Reference : R for Data Science: https://r4ds.had.co.nz/
