##################################################
## POLSCI514: Loop 
##################################################
# "for" "while" loop
# "if-else" conditionals
# application: simulation 


# About "For" loop ------------------------------------------

# Loops are helpful to do the same computation many times.

# Example:
for (i in 1:10){
  print(i)
}

# This is called "for loop". This "for" loop computes the code inside the curly brackets {}, for each i in 1 to 10. 
# Because i takes values from 1 up to 10, it prints out the current i (1, 2, 3... 10). 

# Another example: 
# This "for" loop prints out the result of sampling one of "T" or "F" for 10 times. 
# Note that the computation inside {} does not have to have "i" 
for (i in 1:10){
  print(sample(c('T', 'F'), 1))
}

# You can use vector to store the outputs. 
# First, create a storage. This creates a vector of length 10 with all elements being 0.
out <- rep(0, 10)
#out <- c()  # alternative: You can create an empty vector without specifying the length
for (i in 1:10){
  out[i] <- sqrt(i)
  cat('i = ', i, ' out[',i,'] =', out[i], '\n')
}

# Example question: 
# Suppose we roll a die once, and record which face shows up.
# Repeat the process 100 times, and find the distribution of the times each face showed up. 

# First, create a vector to record which face shows up at i th roll of a die. 
# i ranges from 1 to 100. 
out <- rep(0, 100) 

# loop 
for (i in 1:100){
  
  # simulate a die rolling 
  die <- sample(1:6, 1)
  out[i] <- die
}

# result
out
out_tbl <- table(out)
barplot(out_tbl)


# Sometimes one loop is not enough. You can loop over the loop! 
# Compare the following two loops  
for (i in 1:5){
  cat("i =", i, '\n')
}

for (i in 1:5){
  for (j in 1:3){
    cat("i =", i, ' j =', j, '\n')
  }
}


# We have the outer loop over i and the inner loop over j. 
# For each i in 1, 2, ... 5, the inner loop is executed. 
# So, when i = 1, j goes from 1 to 3, when i = 2, j goes from 1 to 3 again, 
# upto when i = 5, j goes from 1 to 3. 

# Example: suppose you have the following panel data 
# Panel data is often used in IR and comparative.
panel <- expand.grid(c('US', 'Canada', 'Mexico'), seq(2000, 2020))
colnames(panel) <- c('country', 'year')
panel <- panel[order(panel$country, panel$year),]
rownames(panel) <- seq(1, nrow(panel))


# You may want to loop over each country and year
for (country in c('US', 'Canada', 'Mexico')){
  for (year in seq(2000, 2020)){
    cat('country: ', country, ' year: ', year, '\n')
    # do some computation here
  }
}

# Quiz  ---------------------------------------------------------------
# 1. Compute sum of x^2 for x = 1,2,...10. using "for" loop. 
#    Hint: First, create a vector of storage. Then, use "for" loop to compute x^2 for x = 1,2,...10.
#    Then, compute the sum of the vector.
out <- rep(0, 10)
for (x in 1:10){
  out[x] <- x^2
}
sum(out)


# 2. Draw a sample of size 100 from a standard normal distribution 1000 times.  
#    Compute the sample mean for each sample, and plot the histogram of the sample means.
out <- rep(0, 1000)
for (i in 1:1000){
  sample_norm <- rnorm(100, 0, 1)
  out[i] <- mean(sample_norm)
}
hist(out)



# 3*. Fibonacci sequence is defined as 0, 1, 1, 2, 3, 5, 8... 
#    i.e. x(t) = x(t-1) + x(t-2), with x(1) = 0, x(2) = 1. 
#    Compute the 30th number in the Fibonacci sequence.
x <- rep(0, 30)
x[1] <- 0
x[2] <- 1
for (i in 3:30){
  x[i] <- x[i-1] + x[i-2]
}


# -----------------------------------------------------------------

# There is another type of loop, "while" loop. 
# This is not used very often, but it is good to know that it exists.
# This is particularly helpful when you want to continue looping until
# certain condition is met.

# For example, 
x <- 2
while (x < 100){
  x <- x^2
  print(x)
}

# There are three iterations, so let's see what is going on one by one. 
# Before the loop, x = 2. 

# "While" loop can be read as "While (some condition is TRUE) do (some task)"
# At the beginning, x is 2
# First, check if x < 100. This is TRUE because x = 2 < 100. The loop starts. 

# In the first iteration, x was squread, and it has become x = 4
# print out 4

# Check if x < 100. This is TRUE because x = 4 < 100. Loop continues. 
# In the second iteration, x was squared again, and x = 16.
# print out 16

# Check if x < 100. This is TRUE because x = 16 < 100. Loop continues. 
# In the third iteration, x was squared again, and x = 256. 
# print out 256

# Check if x < 100. THis is FALSE because x = 256 > 100.  Loop stops! 


# Be careful with the infinite loop when you use "while" loop
# DO NOT RUN
x <- 1
while(x > 0){
  x <- x + 1
  print(x)
}
# If you accidentally enter an infinite loop, typing Ctrl + C on the console will kill the  process.  

# conditionals ----------------------------------------------------------------

# You can combine conditionals - "if-else" - with loops to do more things

# The following code checks if i is even or odd.
# Note that i %% 2 == 0 returns TRUE if i is divisible by 2. (This is called modulo.)

for (i in seq(1, 10)){
  print(i)
  if (i %% 2 == 0){ # condition (logical statement)
    print('even')   # execute this part if the condition is TRUE
  }else{
    print('odd') # execute this part if the condition is FALSE 
  }
}

for (i in seq(1, 10)){
  print(i)
  if (i %% 2 == 0){ # condition (logical statement)
    print('even')   # execute this part if the condition is TRUE
  }
}

# One way of using "if-else" is to count the number of current iteration 
# This is particularly helpful if your loop takes long time. 
for (i in seq(1, 10000)){
  # do some computation here

  if (i %% 1000 == 0){
    cat('i= ', i, '\n')
  }
}

# You can use if-else condition to write the stopping condition of the loop
# To do that, use "break". Once the loop hits "break", the loop will terminate. 
for (i in 1:50){
  h <- i * 3
  print(h)
  if (h > 90){ # if h is greater than 90, break the loop
    break
  }
}

# You can add another stopping condition to while loop, using if-break
# Note that it is risky to put "TRUE" in the conditional statement.
# If "if-break" condition is not met, this type of loop can run forever...
x <- 1 
while (TRUE){
  print(x)
  if (x == 6){
    print("stop!")
    break
  }
  x <- x + 1
}

# Another version of "if-else" is an ifelse() function.
# ifelse() takes three arguments:
# (1) test: conditional (logical vector)
# (2) yes: value if TRUE
# (3) no: value if FALSE
x <- c(-10, -5, 1, 3) 
y <- ifelse(x > 0, T, F)

x <- seq(1, 10)
y <- ifelse(x %% 2 == 0, "even", "odd")
 


# Quiz -------------------------------------------------------------------------

# 1. You can simulate a pair of die rolls using sample() function. i.e. 
die_pair <- sample(seq(1, 6), 2, replace=T)
# will simulate a pair of die roll.
# Using loops, simulate this process 1000 times. 

for (i in 1:1000){
  die_pair <- sample(seq(1, 6), 2, replace=T)
  print(die_pair)
}

# 2. Perform the same process as Q1, but stop the iteration if the faces of the pair of dies are the same. 
for (i in 1:1000){
  die_pair <- sample(seq(1, 6), 2, replace=T)
  print(die_pair)
  if (die_pair[1] == die_pair[2]){
    break
  }
}
# 3. Perform the same process as Q1, and compute the number of times the sum of the two faces is larger than 7. 
out <- rep(0, 1000)
for (i in 1:1000){
  die_pair <- sample(seq(1, 6), 2, replace=T)
  print(die_pair)
  out[i] <- sum(die_pair)
}
sum(out > 7)


# 4. Perform the same process as Q1, and plot the histogram of the sum of two faces.
hist(out)


