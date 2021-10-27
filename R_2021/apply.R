# Apply family

# Apply function basics
# Apply with custom functions
# More than one arguments
# sweep
# tapply
# Speed comparison

# apply() basics ##############################################################

# apply() function enables quick operations with matrix, array and list.
# It can do the same operation as "for" or "while" loop but with a shorter line and faster.
# It can be difficult at first but it becomes a must when you deal with larger data.

# The basic components are:
# apply(X, MARIN, FUN,..)
# X: a matrix, array or a list that a function is applied to
# MARGIN: a vector that species the dimension of X that a function is applied to
#         1 = row, 2 = col, c(1,2) for both, can be higher for array 
# FUN: the function to be applied.

# Example
mat <- matrix(seq(1, 6), nrow=3, ncol=2)
mat
# Compute mean for each row
apply(mat, 1, mean)

# Same as
for (i in seq(1, nrow(mat))){
  print(mean(mat[i,]))
}

# Compute mean for each column
apply(mat, 2, mean)

# Mini quiz: write a code that does the same computation as above code

# Other functions
apply(mat, 1, sum)
apply(mat, 2, sum)

apply(mat, 1, max)
apply(mat, 1, min)

# Simple alternative
colSums(mat)
rowSums(mat)
colMeans(mat)
rowMeans(mat)

# Array example
arr <- array(seq(1, 24), dim=c(3,4,2))
apply(arr, 1, sum)

# Sanity check
sum(arr[1,,])
sum(arr[2,,])
sum(arr[3,,])

# apply on two dimension
apply(arr, c(1,2), sum)

# A good way to remember how to specify the MARGIN is 
# that the output will keep the dimension that you specified

# List example
# Use lapply() instead of apply() for list
# lapply() does not take MARGIN argument 
lis <- list(a=c(1,2,3), b=c(4,5,6)) 
lis

lapply(lis, mean)
lapply(lis, sum)




# Using custom function ------------------------------------------------------

# You can provide a custom function for FUN argument
f1 <- function(x){
  return(sum(x))
}

mat <- matrix(seq(1, 6), nrow=3, ncol=2)
apply(mat, 1, f1)
apply(mat, 1, sum)

# Using functions that take more than one argument

# You can provide the additional argument after FUN
f2 <- function(x, y){
  return(sum(x) - y)
}

# For each row, take a sum and then subtract y
apply(mat, 1, f2, y=1)
apply(mat, 1, sum) - 1 # same


# sweep ---------------------------------------------------------------------
# Similar to apply but "sweep" out 
# sweep(x, MARGIN, STATS, FUN)
# STATS: the summary stats to be swept out
# FUN: default is "-"

mat <- matrix(seq(1, 6), nrow=3, ncol=2)
mat

# for each row, subtract the minimum value
mat_min <- apply(mat, 1, min)
sweep(mat, 1, mat_min, "-")

# for each row, divide by the row sum
sweep(mat, 1, rowSums(mat), "/")
# This is useful to normalize (i.e. to make it sum to 1)



# tapply --------------------------------------------------------------------
# compute group-level summary stats
# tapply(X, INDEX, FUN, ..)
# X: typically a vector
# INDEX: a factor vector to specify the grouping

turnout <- read.csv('data/turnout.csv') 
turnout$type <- ifelse(turnout$year %% 4 == 0, "pres", "mid")

# compute the average ANES estimate of turnout for presidential and midterm 
tapply(turnout$ANES, turnout$type, mean)


# Quiz (HW) ------------------------------------------------------------------

set.seed(123) 

# Use the matrix A to answer Q1-3
A <- matrix(sample(seq(1, 24), 24), nrow=4, ncol=6)

# 1. Compute the column-wise sum of this matrix 

# 2. Find the maximum value of each row 

# 3. Normalize each column
# i.e. for each column, divide each element by the sum of the column

# Use the list B to answer Q4
B <- list(a=rnorm(10), b=rnorm(10), c=runif(10))

# 4. copmute the sum of each element of the list - a, b, and c 


# Speed comparison---------------------------------------------------------

bigmat <- matrix(rnorm(10000), nrow=100, ncol=100)

# row means
out <- rep(0, 100) 
# apply
start_time <- Sys.time()
out <- apply(bigmat, 1, mean)
end_time <- Sys.time()
apply_time <- end_time - start_time 

# rowmeans 
start_time <- Sys.time()
out <- rowMeans(bigmat) 
end_time <- Sys.time()
rowmean_time <- end_time - start_time 

# for loop 
start_time <- Sys.time()
for (i in seq(1, nrow(bigmat))){
  out[i] <- mean(bigmat[i,])
}
end_time <- Sys.time()
for_time <- end_time - start_time

cat('apply: ', apply_time*1000, 'ms\n')  # millisecond
cat('rowMeans: ', rowmean_time*1000, 'ms\n')
cat('for loop: ', for_time*1000, 'ms\n')















