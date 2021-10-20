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


# (1) Array and List  ---------------------------------------------------------

# (1.1) Array 

# Quick review of matrix...
x <- matrix(c(1,2,3,4), nrow = 2)
y <- matrix(seq(1:6), nrow = 2, ncol = 3)
dim(x)
dim(y)

# Mini quiz (not hw) How to multiply x and y? Can you invert x? How about y? 


# Example: 
# Imagine you have a survey about election turnout. 
# You have an outcome variable (voted or not) -- any problem about this survey question??
# You also have demographic information about the respondents: gender and race.
# For simplicity, let's use binary indicator: 
# For gender, whether "male" or not.
# For race, whether "while" or not. 

# The following code generate a hypothetical data
survey_data <- data.frame(vote=sample(c(0,1), 1000, T),
                          gender=sample(c('male', 'not-male'), 1000, T),
                          race=sample(c('white', 'not-white'), 1000, T))

# We can have two-by-two table to summarize the data
survey_mat <- matrix(0, nrow=2, ncol=2)
rownames(survey_mat) <- c('male', 'not-male')
colnames(survey_mat) <- c('white', 'not-white')

# Mini quiz: Fill the above matrix so that each cell contains the number of people
# who voted in the category.
# e.g. survey_mat[1,1] will have the number of white male who voted. 

# But what if we have another variable, lets' say age? Suppose we make a categorical variable 
# for education -- whether the respondents is a college graduate (or higher education) or not. 
survey_data$educ <- sample(c('college', 'not-college'), 1000, T)


# Can we express the same summary in a matrix?  -- No because we have three categories.
# Instead of matrix, we can use array. 

# Array is a generalization of matrix. While matrix must be 2 dimensional, 
# array can be 3, 4, .... dimensional. For instance, 

# This is equivalent to matrix(NA, nrow = 2, ncol = 2)
x <- array(NA, dim = c(2,3)) 

# It can be 3 dimensional
x <- array(NA, dim = c(2,2,2))

# or 10 dimensional!  -- it is hard to handle an array with this high dimensions though.
x <- array(NA, dim = rep(2, 10))

# now, because it's easier to visualize, let's stick with 3D arrays 
# Let's see how to create an array filled with some values:
x <- array(seq(1,24), dim=c(2,3,4))
# Like we saw when we fill matrices, the list is filled by column-wise order. 
# We want to fill an 2*3*4 array by a sequence of numbers from 1 to 24. 
# Then, the first 2*3 matrix is filled by using 1 to 6, the second matrix by 7 to 12, 


# You can access each element of array in the same way as in matrix
x[1,1,1]
x[1,1,2]
x[1,2,3] 
x[2,3,4]

# You can change the element 
x[1,3,2] <- 100 
x



# You can also give names to the dimensions of an array.
# To do that , you give a vector of strings for each dimension
# of the array, inside a R list (which we will see later):

array_names <- list(c("one", "two", "three"), c("A", "B"), c("x", "y", "z"))
a <- array(seq(1, 18), dim=c(3,2,3), dimnames=array_names)
a

# Then, you can access each elemnet by the dimension name
a["one", "A", "x"]

# Mini quiz (Not homework)
# Going back to the original problem, can we express the summary of the survey data using a 3D array? 
# What is the dimension of this array? (i.e. what is "dim" argument?)



# (1.2) List  -----------------------------------------------------------------

# Let me introduce another class -- list, which we just saw. 
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
# If you use [] it also returns a list 
class(my_list2[["vec"]])
class(my_list2["vec"])

# if you want to add new elements to a list, you could simply do like
# when adding a column to a data.frame:
my_list2$logical <- TRUE
my_list2[["nothing"]] <- NaN
my_list2

 
# You can use c() to combine two lists
my_list3 <- list(seq(1,5))
my_list4 <- list(seq(6, 10))
my_list5 <- c(my_list3, my_list4)

# Use unlist to convert a list to a vector
unlist(my_list5)

# To foreshadow what we do next week...
# lapply() will apply a function on each element of a list

# Example list
my_list5
lapply(my_list5, mean) 
lapply(my_list5, sum)

# You can provide a custom function too
MyVar <- function(x){
  x_bar <- mean(x) 
  n <- length(x)
  return(1/(n-1)*sum((x-x_bar)^2) )
}
lapply(my_list5, MyVar)
lapply(my_list5, var)
















