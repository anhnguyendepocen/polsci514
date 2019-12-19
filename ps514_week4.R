##################################################
## POLSCI514 week4
## Introduction to R 
## Date: 2019/9/20
## Author: Saki Kuzushima
##################################################

# Note that this code heavily relies on a text book, 
# Imai 2017 'Quantitative Social Science', Chap 2. 

# Table of contents

# (0) Logistics
# - Did you get the pset 1 graded?
# - Office hour: 3 - 5pm Wed 
# - feedback google form
# - info: CSCAR seminar: https://cscar.research.umich.edu/events/

# (1) Review: subsetting data using Pset 2
# (2) Plot - histogram
# (3) Random number - sample
# (4) Q and A / exercise time? 


# (1) Review: Subsetting data -------------------------------------------------------------

# Let's analyze the real data using problem set 2
# Note that this quesiton is taken from Imai (2017).

# First, read the question and understand the variables...

# Let's load the data again to make sure that the dataset is laoded
world <- read.csv("World.csv")

# Check what kind of variables are in the dataset
colnames(world)

# Check first 6 observations
head(world)

# Get the summary statistics of the data
summary(world)


# Q1. Crude Birth Rate


# step1: create a variable "py.total" for the total person year, by summing "py.men" and "py.women"
world$py.total <- world$py.men + world$py.women

## step 2: calculate the CBR
sum(world$births) / sum(world$py.total)

world$births[1:15]


world.CBR.period1 <- sum(world$births[1:15]) / sum(world$py.total[1:15])
world.CBR.period2 <-  sum(world$births[16:30]) / sum(world$py.total[16:30])

# step3: display answer

# CBR of the world, 1950-55
world.CBR.period1
# CBR of the world, 2005-2010
world.CBR.period2




# Q2. ASFR

## step1. calculate ASFR for the entire data 
world.ASFR <- world$births / world$py.women

# step2: It's nice to add names to each element of the vector
names(world.ASFR) <- world$age

## step3. show the results for women in reproductive age range [15, 50) for each period
world.ASFR.period1 <- world.ASFR[4:10] 
world.ASFR.period2 <- world.ASFR[19:25]

# step4: display the result
# 1950-55
world.ASFR.period1
# 2005-2010
world.ASFR.period2


x <- c(1,2,3)
names(x) <- c('a','b', 'c')




# Q3. TFR
world.TFR.period1 <- sum(world.ASFR[4:10] * 5)
world.TFR.period2 <- sum(world.ASFR[19:25] * 5)

# 1950-55
world.TFR.period1
# 2005-2010
world.TFR.period2

# Make sure to interpret the result after you compute the same thing for Kenya and Sweden.



# There is a function solely for the subsetting task - subset(). 
# subset function takes mainly two arguments. 
# first argument (x): data to be subsetted
# second argument (subset): logical vector indicating rows to be kept 
# What does it mean...Let me show some example!


# Let's say we want to obtain the subset of data such that the period is "1950-1955"
# First, we create a logical vector, indicating which element has period "1950-1955"
select <- world$period == "1950-1955" 
# On the right side of "<-", world$period is the "period" column of the "world" data, 
# and I checked if each element of the period column is "1950-1955" or not. 
# Then, I assigned the resutling logical vector to an object "select"

# The following code produces the desired subset of the data
subset(world, select)
# Or, equivalently
subset(world, world$period == "1950-1955")


# Question: Obtain the subset of data such that births is 0
subset(world, world$births == 0)

# Question: Obtain the subset of data such that births is NOT 0. Does the result make sense? 
subset(world, world$births != 0)
# !=: not equal, ==: equal 

# Question: Obtain the subset of data such that births is less than 10000 
subset(world, world$births < 10000)

# Question: Obtain the subset of data such that (i) the period is "1950-1955" and 
# (ii) the births is 0
# hint: use "&" (and) operator
subset(world, (world$period == "1950-1955") & (world$births == 0))





# (2) Plot - histogram and plot ---------------------------------------------------------------------------------------

# After we analyze the data, we usually want to create cool plots 
# to communicate with others. One of the most common plots we use in statistics
# is histogram. Hitogram is a collection of bins, or buckets, in which
# data with certain range of values are put. Let me show an example.


vec <- c(0, 1, 4, 6, 9, 2, 3, 5, 2, 10)
hist(vec)
# For instance, the bin 0-2 contains 4 values (0,1,2,2), so the "frequency"
# is 4. 

# if you want to specify the number of bins:
hist(vec, breaks=10)
hist(vec, breaks=2)

# You can customize the breaks, by passing a vector containing the exact breaks you want.
hist(vec, breaks = c(0, 1, 10))
hist(vec, breaks = c(4, 10)) # gives error because some values not included

# to have bar of same width, a convenient way is to use seq():
hist(vec, breaks = seq(from=0, to=100, by=5)) 
hist(vec, breaks = seq(0, 100, 5))  # same

# Let's use the real data to create histogram. We will use turnout.csv data
# First, read the description of the data, turnout.txt and understand what 
# kind of variables are contained. 

# First, load the data and follow the usual steps
turnout <- read.csv('turnout.csv') # load data
colnames(turnout) # variable names
head(turnout) # peak at the first 6 rows of the data
summary(turnout) # brief summary of the data

# Create the histogram of the ANES estimated voting rate
hist(turnout$ANES)

# Let's review how to handle dataframe. Create a variable for the actual voting rate
# by dividing the total number of vote ("total") by the voting eligible population ("VEP")
actual <- turnout$total / turnout$VEP * 100
# Create the histogram of the actual voting rate
hist(actual)

# It looks like ANES estimate has higher values than the actual voting rate.
# Let's make a fair comparison. Adjust the breaks such that both histogram shares the same bins.
hist(turnout$ANES, breaks=seq(0, 100, 10))
hist(actual, breaks=seq(0, 100, 10))
# It is clear that ANES estimates are concentrated on the higher end than actual voting rate. Why??? 

# You can change the labels of the title, x axis and y axis 
hist(actual, breaks=seq(0, 100, 10), main = "Histogram of the actual voting rate", 
     xlab = "Actual voting rate", ylab = "Count")
# main: title
# xlab: label of x axis
# ylab: label of y axis

# Question: plot the histogram of the voting eligible population
hist(turnout$VEP)

# Question: plot the histogram of the overseas voting (overseas voters)
hist(turnout$overseas, main="Title")




# R has a gereneral function for plotting: plot(), literally!
# plot() takes two argument: x and y. X corresponds to the x axis and y corrsponds to the y axis. 
# For instance, 
vec1 <- c(1,2,3)
vec2<- c(10, 20, 30)
plot(x=vec1, y=vec2)
# It plots three dots, at (1, 10), (2, 20), and (3, 30)
  
# We can use plot() to get more information about the turnout data. 
# Let's plot the time trend of the overseas voting
plot(x=turnout$year, y=turnout$overseas)
# Overseas voting has been incraesing since around 1995. 

# Let's plot the time trend of the ANES estimate of the voting rate. 
plot(x=turnout$year, y=turnout$ANES)
# What does this imply? Why the turnout rate goes up and down alternatively? 
# (Note that we do not have data for 2006).

# Question: plot the time trend of the actual voting. 
plot(x=turnout$year, y=actual, xlab='year', ylab="actual vote")



# So far we have seen only simple plots, but R can do much better!
# There is a package to create very cool plots, ggplot2
# Using this package, you can even create animation, gif, interactive plots, and more.
# You can see some of the cool plots here: https://www.r-graph-gallery.com/index.html





# (3) Random number - sample ------------------------------------------------------------------------------

# In statistics, we often (too often) encounter an example of rolling a die (c.f. Nigeria example?)
# and tossing coins. Although we could simulate this process physically by actually throwing coins, and die, 
# We do not always have coins, let alone dice. 
# How should we do this in R? There is a handy function to do this: sample()

# sample(), as its name suggests, draws a sample of size (1) from c('H', 'T'). 
sample(c('H', 'T'), size = 1)

# try running the above code many times (just hit Ctrl/Cmd + Enter), or press "Run"), and see what happens. 
# Or, the following code will save your energy of hitting "Run" many times.

for (i in 1:10){  # this is called for loop. We will learn this later. 
  print(sample(c('H', 'T'), size = 1))
}

# As you see, sometimes it returns "T" and other times "H". This is how R is simulating a coin toss!


# You can simulate rolling a die 
sample(seq(1,6), size = 1)

# run the above code many times
for (i in 1:10){
  print(sample(seq(1,6), size = 1))
}

# This time, sample() function draws a sample of size (1) from c(1,2,3,4,5,6) (= seq(1,6)).

# You can draw multiple samples. If you want to throw a die twice, 
sample(seq(1,6), size = 2, replace = T)  #replace = T allows us to get the same face more than once. 

# 


