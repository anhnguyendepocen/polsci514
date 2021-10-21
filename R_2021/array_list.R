# Array and List 

# Array  ---------------------------------------------------------------

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

# Quiz (homework) --------------------------------------------------------------
# 1. Going back to the original problem, can we express the summary of the survey data using a 3D array? 
# What is the dimension of this array? (i.e. what is "dim" argument?)

# 2. Using the array, obtain the number of white male without college eduation who voted. 

# 3. Using the array, obtain the number of male who voted (regardless of education level and race). 

# 4. Using the original data (survey_data), make sure that your answers to Q2 and Q3 are correct.


# List  -----------------------------------------------------------------

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

