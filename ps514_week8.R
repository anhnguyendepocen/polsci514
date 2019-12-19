##################################################
## POLSCI514 week8
## Introduction to R 
## Date: 2019/10/18
## Author: Saki Kuzushima
##################################################


# Table of contents

# (0) Logistics
# - pset 3: due today
# _ pset 4: due in two weeks
# - how to check if the code runs properly! 

# (1) List and Array
# (2) Custom functions


# (1) Array and List  --------------------------------------------------------------------------


# Let's learn two more useful classes in R: array and list. 

# Array is a generalization of matrix. While matrix must be 2 dimensional, 
# array can be 3, 4, .... dimensional. For instance, 

# This is equivalent to matrix(NA, nrow = 2, ncol = 2)
x <- array(NA, dim = c(2,2)) 

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
x[1,2,3] 
x[2,3,4]

# You can change the element 
x[1,3,2] <- NA
x


# you can also give names to the dimensions of an array.
# To do that , you give a vector of strings for each dimension
# of the array, inside a R list (which we will see later):

array_names <- list(c("one", "two", "three"), c("A", "B"), c("x", "y", "z"))
a <- array(seq(1, 18), dim=c(3,2,3), dimnames=array_names)
a

# Then, you can access each elemnet by the dimension name
a["one", "A", "x"]
a[1,"B", 3]


# Let me introduce another class -- list, which we just saw. 
# List is the most general container across many containers in R (dataframe, matrix, array). 
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


























