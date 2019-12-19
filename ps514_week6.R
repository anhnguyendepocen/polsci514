##################################################
## POLSCI514 week5
## Introduction to R 
## Date: 2019/10/4
## Author: Saki Kuzushima
##################################################


# Table of contents

# (0) Logistics
# - review pset2: modulo
# - header of R script


# (1) Factor class
# (2) Matrix operations
# (4) For loop*
# (5) Simulation*

# (0)  Modulo -------------------------------------

# When we want to know if a value is even or odd, 
# we can use modulo. It finds the remainder after division of one number by another
48 %% 5 
# 48 / 5 = 9 and remainder 3
10 %% 3
# 10 / 3 = 3 and remainder 1

#If (X mod 2) is 0, X is even. If (X mod 2) is 1, X is odd. 
100 %% 2 # even
15 %% 2 # odds

# (1) Factor class --------------------------------
# Let's learn another class: factor. It is used for categorical variable. 
# See the following code. 
country <- c("US", "Japan", "China", "Canada")
class(country)
country <- as.factor(country)
class(country)

# You can see that there is "levels", Canada, China, Japan and US. 
levels(country)

# You can change any classes to factor classes using as.factor() function 
x <- c(1,2,3)
class(x)
x <- as.factor(x)
class(x)
levels(x)

y <- c(1,2,3,2, 1, 3)
class(y)
y <- as.factor(y)


# Likewise, you can use as.integer(), as.character(), as.numeric()
x <- as.numeric(x)
class(x)

# We have actually seen factor class in the dataset in problem set 2. 
world <- read.csv("World.csv")
class(world$age)
class(world$period)

# THis is because of the setting in read.csv() function
# The default is set to stringAsFactors = T. This means that
# when some columns has string values, read.csv() will 
# convert it to factor class. This may cause problems sometimes,
world <- read.csv("World.csv", stringsAsFactors = F)
class(world$age) # character

world <- read.csv("World.csv", stringsAsFactors = T)
class(world$age) # factor





# (2) Matrix operations -------------------------------------------

# We learn anthher class: matrix. Matrix is similar to data.frame
# but slightly different. The big difference is in the matrix multiplication. 
# While you cannot do the matrix multiplication using data frame, you can do it 
# in matrices. and Matrix multiplication is a fundamental operations in linear regression! 

# First, the following code will create a 2 * 2 matrix with all elemenets being 1. 
X <- matrix(1, nrow = 2, ncol = 2)
# You can supply a vector
X <- matrix(c(1,2,3,4), nrow = 2, ncol = 2, byrow = F)
# Note that the vector is arranged by column (you can change this by byrow argument
# in the matrix function)


# Whenever we multiply matrices, we have to be careful about the dimensions. 
Y <- matrix(c(1,2,3,4,5,6), nrow = 2, ncol = 3)
Z <- matrix(c(10, 20, 30, 40, 50, 60), nrow = 3, ncol = 2)
W <- matrix(1:10, nrow = 2, 5)

# You can check the dimension by dim()
dim(Y)
dim(Z)
dim(W)

# When you multply matrices, use %*%, instead of *
# Remember that X %*% Y is possible only when the row length of X is the 
# same as the column length of Y

# This is possible :)
Y %*% Z

# This is impossible :( 
Y %*% W


# You can convert dataframe to matrix
df <- data.frame(x = c(1,2), y = c(3,4))
df_mat <- as.matrix(df)

# THis returns error
df %*% X # error

# But this is possible 
df_mat %*% X


# If you use *, it will comute the element-wise multiplication

# This is possible
X * X
# But the result is different from this!!
X %*% X


# You can transpose and invert matrices 
# This will transpose the matrix
t(Y)
# This will invert the matrix
solve(X)
# THis will return error because only square matrices can be invertible. 
solve(Y) # error

# Question: is the following multiplication possible? Why? 
# (Y and X are defined above.)
Y %*% X





# (4) For loop ------------------------------------------
# Finally we can learn loops and this will save you a lot of time!
# So, what is loops? Loop is a way to repeat (almost) the same computation
# without writing many lines. 

# For instance, run the code below
for (i in 1:10){
  print(sqrt(i))
}

log()
exp()




# This is called "for loop". This for loop computes the code inside
# the curly brackets {}, for each i in 1:10. Because i takes values
# from 1 up to 10, it prints out the square root of 1, 2, 3... 10. 

# Note that, inside the for loop, you have to use print() function
# to print out the result. 

# Remember that we saw the following code in the coin flip example
for (i in 1:10){
  print(sample(c('T', 'F'), 1))
}
# This for loop computes the code inside the {}, 10 times. 

# You can use vector to store the sequence of the outputs. 
out <- rep(1, 10)
# out <- c()  without speciying the length
for (i in 1:10){
  out[i] <- sqrt(i)
}


# First, I create a vector of length 10 whose elemnets are all zero. 
# (It does not have to be zero because we will replace the value anyway.)
# You can create a vector without specitying the length, 
# but it is recommended that you specify the length if you know it. 
# (In some other languages, like C++, you might need to speciy the length 
# depending on the data structure.)

# You can loop over not just integers, but other classes
country_vec <- c("US", "UK", "China", "Japan")
for (country in country_vec){
  cat('I am from ', country, '\n')
}

# cat() concatinate the objects and print it out. '\n'
# changes the line. 

# Q1. Compute the squre of X where X= 1, 2, .... 10.
for (i in 1:10){
  print(i^2)
}

x <- 1:10
x^2




# (5) Simulation -------------------------------------------------
# Statistics is all about learning population using sample, because
# population is unknown. However, we can hypothetically assume that 
# we know the population, and compare the properties of the sample 
# and the population. Simulation is helpful to do this type of analysis. 

# Suppose there are 100 blue and red balls in a bag, but we don't know 
# how many of balls in the bag are blue and red. Also, suppose that we draw 10 balls out 
# of the bag, and we can observe how many balls are blue and red among the 10 balls.
# What can we say about the number of blue and red balls in the bag? 

# Suppose the bag consists of 50 red and 50 blue balls. 
# THis is the population. In practice, we don't observe this, 
# but we hypothetically assume that we know the population. 
bag <- c(rep("B", 50), rep("R", 50))

# we draw a sample of size 10
temp <- sample(bag, 10)

# count how many are blue and red
red <- sum(temp == 'R')
blue <- sum(temp== 'B')
red
blue

# What is the best guess of the number of blue and red balls, 
# if you can only observe this table (i.e. you don't know the
# fact that the bag has 50 blue and 50 red balls.)

# What happens if we draw many samples? 
# (Be aware of the difference of "sample size" and "the number of sample")
# The following code will draw many samples, and store the count
# of the red and blue balls in the data frame

# The number of sample 
K <- 100 

# storage
result <- data.frame(R = rep(0, K),
                     B = rep(0, K),
                     iteration = 1:K)

# for loop for simulation
for (k in 1:K){
  # draw 10 balls from the bag
  res <- sample(bag, 10)
  
  # count the number of red/blue balls
  red <- sum(res == 'R')
  blue <- sum(res == 'B')
  
  result[k,'R'] <- red
  result[k, 'B'] <- blue
  
}
result

# Plot the histogram of the number of red balls
hist(result$R, breaks=0:10)

# What does it tell? The histogram shows that we draw 5 balls
# most often. We can intuitively guess that the half of the 
# balls in the bag are red. And, we know that this guess is good!
# because we know the true answer. 










