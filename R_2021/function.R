##################################################
## POLSCI514 week8
## Introduction to R 
## Date: 2019/10/18
## Author: Saki Kuzushima
##################################################


# Topics
# (1) Custom functions
# (2) List and Array

# TODO: Add exercise using lapply? Create hw file

# Custom functions -------------------------------------------------------------

# The most powerful and fun aspect of programming involves creating custom functions. 
# So far, we have been using a lot of pre-made functions like summary(), mean(), c(), etc.
# They are basically born because many people wanted to repeat the same procedure many times
# so they wanted to save time. For instance, you can compute the mean by summing over a vector
# and dividing by the length of a vector.  

vec <- runif(100)
sum(vec)/length(vec)
# will compute the mean without problem. But
mean(vec)
# is simpler because it's one line. 

# However, the problem is that the pre-made function is (1) too general and (2) not flexible. 
# They are too general because the target users are everyone, and not flexible because it is pre-made. 
# So, why not we make our own functions? (And publish it to the general audience in the future? )
# R is a open source language, so you can create a collection of functions, and bundle them to make a package

# c.f. See who created "poisbinom" package...
# https://cran.r-project.org/web/packages/poisbinom/poisbinom.pdf


# You can make your own functions like this
SakiMean <- function(x){
  res <- sum(x)/length(x)
  return(res)
}
 

# First, I am assigning (<-) something that starts with function() to some storage (= 'SakiMean'). 

# All functions must have three elements (1) Input (2) Some computation (3) Output
# There is an analogy of cooking - you have (1) ingredient (2) cooking recipe (3) meal 

# R function is the same - you have three key elements of the function, input inside (), procedures inside {}, output as return(). 
# (1) Input: It comes inside the parenthesis (). In the function above, I have x as an input.
# (2) Some computation: It comes inside the {}. I compute the sum of x and divided by the length of x, 
#     and then, assigned it in an object, res. 
# (3) Output: return() will generate the output. Here, we get the object 'res' as an output. 


# Mini quiz (NOT homework)  ---------------------------------------------------
# 1. Create your own function to compute the sample variance of a vector. 
# Check the result, by comparing it with var() function. 

# 2. Create the following function. 
# This function takes a numeric vector (X) as an input. 
# Then, it computes the mean and variance of the vector X.  
# As an output, it returns a sample of the same size as the length of X from a normal distribution 
# whose parameters are the sample mean and the variance of (X). 
# (This process is called parametric bootstrap)
# -----------------------------------------------------------------------------

# Now you can use the function 
vec <- c(1,2,3,4,5,6)
MyVar(vec)
# The result is the same as this 
var(vec)

# example dataframe
my_dataframe <- data.frame(x= rnorm(100),
                           y=runif(100),
                           z=rnorm(100))

# Quiz (Homework): ------------------------------------------------------------
# 1. Compute the variance of x, y, z respectively using your custom function.
# Compare the result with the pre-defined function, var()

# 2. Create a function to compute x^2 + y^2 + z^2, and apply the function
# for each row of the dataframe, my_dataframe.
# Save the result in a new column, 'result2'.
# Hint: 'for' loop

# 3. Create the following function.
# It takes three arguments, x, y, z. 
# if y is less than 0.5, it returns x + z 
# otherwise, it returns x - z 
# Apply this function on my_dataframe for each row.
# Save the result in a new column, 'result3'
# Hint: if-else

#-----------------------------------------------------------------------------


