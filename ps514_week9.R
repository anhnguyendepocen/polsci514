##################################################
## POLSCI514 week8
## Introduction to R 
## Date: 2019/10/18
## Author: Saki Kuzushima
##################################################


# Table of contents

# (0) Logistics
# - pset3 comments- commenting, header, review of plot function 

# (1) List and Array
# (2) Custom functions
# (3) Exercise

x <- seq(1, 10)
y <- rnorm(10)
plot(x, y)
plot(y)

x <- seq(0, 100, 10)
length(x)
y <- rnorm(11)
plot(x, y)


# (1) Array and List  --------------------------------------------------------------------------

# (1.1) Array 

# Quick review of matrix...
x <- matrix(c(1,2,3,4), nrow = 2)
y <- matrix(seq(1:6), nrow = 2, ncol = 3)
dim(x)
dim(y)

# (Quick) Exercise: How to multiply x and y? Can you invert x? How about y? 
x %*% y # multiplication
t(y) %*% x # t() transpose

solve(x) # solve()
solve(y)


# Example: 
# Imagine you run an experiment where the observations vary in many categories
# For instance, you have outcome variable (for instance, voted or not)
# treatment variable 0, 1 (for instance, canvasser's visit), and many categorical variables. 
# If you only have one covariate, let's say sex, we can express the summary as a matrix

matrix(c(100, 20, 90, 30), nrow = 2, ncol = 2, 
       dimnames = list(c("treatment", "control"), c("male", "female")))


# But what if we have another variable, lets' say age? Suppose we make a categorical variable 
# for age - say below 40 and above 40. Can we express the same summary in a matrix? No! because we have 3 dimensions. 
# Instead of matrix, we can use array. 

result <- array(c(100, 20, 90, 30, 110, 25, 100, 40), dim = c(2,2,2), 
                dimnames = list(c("treatment", "control"),
                                c("male", "female"), 
                                c("below40", "above40")))
result


# Array is a generalization of matrix. While matrix must be 2 dimensional, 
# array can be 3, 4, .... dimensional. For instance, 

# This is equivalent to matrix(NA, nrow = 2, ncol = 2)
x <- array(NA, dim = c(2,3)) 

# It can be 3 dimensional
x <- array(NA, dim = c(2,2,2))

# or 10 dimensional! 
x <- array(NA, dim = rep(2, 10))

# now, because it's easier to visualize, let's stick with 3D arrays 
# Let's see how to create an array filled with some values:
x <- array(seq(1,24,1), dim=c(2,3,4))
# Like we saw when we fillex matrices, the list is filled column wise. 
# We want to fill an 2*3*4 array by a sequence of numbers from 1 to 24. 
# Then, the first 2*3 matrix is filled by using 1 to 6, the second matrix by 7 to 12, 


# You can access each element of array in the same way as in matrix
x[1,1,1]
x[1,1,2]
x[1,2,3] 
x[2,3,4]

# You can change the element 
x[1,3,2] <- "c"
x



# You can also give names to the dimensions of an array.
# To do that , you give a vector of strings for each dimension
# of the array, inside a R list (which we will see later):

array_names <- list(c("one", "two", "three"), c("A", "B"), c("x", "y", "z"))
a <- array(seq(1, 18), dim=c(3,2,3), dimnames=array_names)
a

# Then, you can access each elemnet by the dimension name
a["one", "A", "x"]
a[1,"B", 3]


x <- list(c(1,2,3), c(1,2,3))
x_a <- array(x, dim=2)


# Exercise: 
# Using the first array we see - "result", show the outcome of the 
# male above 40 years old in the treatment group, 
# and male above 40 years old in the control group


# (1.2) List 

# Let me introduce another class -- list, which we just saw. 
# List is (in my opinion) the most general container across many containers in R (dataframe, matrix, array). 
# The most distinct part of list is that it can contain the object with different classes, 
# including vector, array, matrix, dataframe, and list itself

my_list <- list(c(1,2,3), "Hello", matrix(NA, nrow = 2, ncol = 3))
my_list

# because lists can contain anything, it's very useful to give 
# some meaningful names from the beginning:
my_list2 <- list(vec = c(1,2,3),
               string = "hellohello",
               mat = matrix(NA, nrow = 2, ncol = 2),
               arr = array(NA, dim = c(2,3)))
my_list2

# we can access each element of list in the same way as we did in dataframe
my_list2$vec
my_list2[["vec"]] 

# But you have to use [[]] instead of [] to access an element to a list
# If you use [] it keeps the list structure
class(my_list2[["vec"]])
class(my_list2["vec"])

# if you want to add new elements to a list, you could simply do like
# when adding a column to a data.frame:
my_list2$logical <- TRUE
my_list2[["nothing"]] <- NaN
my_list2


# apply function on list
my_list3 <- list(x= rnorm(100),
                 y=runif(1000),
                 z=rnorm(100))

lapply(my_list3, mean)

# dataframe / matrix
my_dataframe <- data.frame(x= rnorm(100),
                          y=runif(100),
                          z=rnorm(100))

apply(my_dataframe, 2, mean)


# (2) Custom functions -----------------------------------------------------

# The most powerful and fun aspect of programming involves creating custom functions. 
# So far, we have been using a lot of pre-made functions like summary(), mean(), c(), etc.
# They are basically born because many people wanted to repeat the same procedure many times
# so they wanted to save time. For instance, you can compute the mean by summing over a vecotr
# and dividing by the length of a vector. so 


vec <- runif(100)
sum(vec)/length(vec)
# will compute the mean without problem. But
mean(vec)
# is faster and simpler right? That's why some people created these useful functions in the past. 

# However, the problem is that the pre-made function is (1) too general and (2) not flexible. 
# They are too general because the target users are everyone, and not flexible because it is pre-made. 
# So, why not we make our own functions??? (And publish it to the general audience in the future? 
# R is a open source language, so you can create a collection of functions, and bundle them to make a package

# c.f. See who created "poisbinom" package...
# https://cran.r-project.org/web/packages/poisbinom/poisbinom.pdf


# You can make your own functions like this
SakiMean <- function(x){
  res <- sum(x)/length(x)
  return(res)
}
 
# You can store the functions in a list!
NathanMean <- function(x){
  res <- sum(x)/length(x)
  return(res)
}

OurMean <- list(s=SakiMean, n=NathanMean)

# THis does not work because OurMean is not a function, it is a list.
OurMean(vec)
# But this works
OurMean$s(vec)




# Nice! So what is going on? 
# All functions must have three elements (1) Input (2) Some procedure (3) Output
# (I like the analogy of cooking - you have (1) ingredient (2) cooking recipe (3) dish)
# So, R functions also have to have three key elements. 
# (1) Input: It comes inside the parenthesis (). In the function above, I have x as an input.
# (2) Some procedure: It comes inside the {}. I compute the sum of x and divided by the length of x, 
#     and then, assigned it in an object, res. 
# (3) Output: return() will generate the output. Here, we get the object 'res' as an output. 

# Syntax wise, this is what is going on. 
# First, I am assigning (<-) something that starts with function() to some storage (= object). 
# Then, you have three key elements of the function, input inside (), procedures inside {}, output as return(). 

# Exercise: 
# Create your own function to compute the sample variance of a vector. 
# Check the result, by comparing it with var() function. 


MyVar <- function(x){
  # compute the mean because we use in the computation of the variance
  x_bar <- mean(x)
  # and create n - the length of the vector
  n <- length(x)
  
  # variance
  out <-  1/(n-1) * sum((x-x_bar)^2)
  
  return(out)
}

# Now you can use the function 
vec <- c(1,2,3,4,5,6)
MyVar(vec)
# The result is the same as this 
var(vec)

# example dataframe
my_dataframe <- data.frame(x= rnorm(100),
                           y=runif(100),
                           z=rnorm(100))

# You can apply the function to each row of the dataframe, my_dataframe
apply(my_dataframe, 1, var)

# This is same as
for (i in 1:nrow(my_dataframe)){
  print(var(my_dataframe[i,]))
}

# You can apply custom functions to each row of the dataframe
# This is some custom function
ZoeFunction <- function(x, y, z){
  out <- x^2 + 2*y + 3*z
  return(out)
}

# apply this functio to each row
for (i in 1:nrow(my_dataframe)){
  out <- ZoeFunction(x=my_dataframe[i,"x"],
                     y=my_dataframe[i,"y"],
                     z=my_dataframe[i,"z"])
  print(out)
}

# You can store the result in a vector
storage <- c()
for (i in 1:nrow(my_dataframe)){
  storage[i] <- ZoeFunction(x=my_dataframe[i,"x"],
                            y=my_dataframe[i,"y"],
                            z=my_dataframe[i,"z"])
}


# Exercise: (advanced)
# Create the following function. This function takes a vector (X) and a natural number (N) as an input. 
# Then, it computes the mean and variance of the vector.  
# As an output, it returns a sample of specified size (N) from a normal distribution, 
# whose parameters are the mean and the variance of (X). 
# hint: Use rnorm(). Read the documantation of rnorm().



# Let's revisit World population dataset to see how useful functions are. 

# load data
world <- read.csv("World.csv")

# Q1 - CBR
# We want to compute the crude birth rate (CBR), so we can create a function for it!
cbr <- function(data){
  return(sum(data$births) / sum(data$py.men + data$py.women))
}

# split a dataset into the first and the second half
world_1 <- subset(world, world$period == '1950-1955')
world_2 <- subset(world, world$period == '2005-2010')

# apply the function
cbr(world_1)
cbr(world_2)



# Q2 - ASFR

asfr <- function(data) {
  # Compute ASCF for each age range
  out <- data$births / data$py.women
  # add the name of the vector, using age variable
  names(out) <- data$age 
  # only returns the range between from 15 to 50
  return(out[4:10])
}

# apply the function
asfr(world_1)
asfr(world_2)


# The codes become much shorter by using functions! 
 
# Let's combine the technique we have learned so far. 
# To demonstrate, let's create your own cusom function to get some summary statistics from the data. 

# Exercise: 
# Create a function that takes a vector as in input
# and return the following statistics as a list.
# - mean
# - median
# - variance
# - standard deviation
# - minimum
# - maximam
# Then, apply the function on births, and deaths variable in world data

# Exercise:
# Change the output from list to vector. Using apply() function, 
# return the summary statistics of the two variables as a matrix

# You can combine with if else too

SakiSwitch <- function(x){
  
  # if the length of x is even
  if (length(x) %% 2 == 0){
    out <- sum(x)
  }else{
    out <- mean(x)
  }
  return(out)
}
SakiSwitch(x)





# (3) Exercise Time!







