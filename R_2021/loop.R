##################################################
## POLSCI514: Loop 
##################################################
# Hypothetical question:
# Also suppose that you took a survey on 100 people in a town and asked whether they are a Democrat or a Republican. 
# (Let's assume that they always answer truthfully....)
# How would you infer the proportion of people who support Republican in this town?

# We can use a sample mean as an estimate of the population mean, but how to assess the quality of the estimate?
# Simulation provides one solution - it assumes that the population is known and we define it.
# Then, draw samples from the population, and compare the sample vs population statistics. 

# Example: 
# Suppose there are 1000 voters in a town, some are republican and others are democrats. 
# The following code defines the 1000 voters. 
pop <- c(rep('R', 500), rep('D', 500))
# So that the true proportion of people who support Republican in this town is 0.5.

# we draw a sample of size 100
s1 <- sample(pop, 100)

# Mini quiz: Compute the proportion of Democrats and Republican in your sample 


# Is this a good estimate? 
# Are we just lucky and get a good estimate, or is our estimator always good?

# We can use simulation to draw sample repeatedly many times, so that
# we can observe the distribution of the sample statistics.
# By comparing the distribution of the sample statistic with the population, 
# we can evaluate if the estimator is a good one or not. 

# What happens if we draw many samples? 
# Be aware of the difference of "sample size" and "the number of sample"
# In a survey context, "sample size" is the number of respondents, and 
# "the number of sample" is the number of times you conducted the survey.

# To draw samples repeatedly, we can use "for" loop.

# The number of sample 
K <- 1000 

# storage
result <- data.frame(R = rep(0, K),
                     D = rep(0, K))

# "for" loop for simulation
for (k in 1:K){
  # draw 10 balls from the bag
  s <- sample(pop, 10)
  
  result[k,'R'] <- mean(s == 'R') 
  result[k,'D'] <- mean(s == 'D') 
}
result

# Plot the histogram of the distribution of the proportion of Republicans in your samples 
hist(result$R, breaks=seq(0, 1, 0.1))
abline(v=0.5, col='red')

# You can tell that, on average, your estimator works well to estimate the proportion of Republican in the town.


# About "For" loop ------------------------------------------

for (i in 1:10){
  print(i)
}

# This is called "for loop". This for loop computes the code inside the curly brackets {}, for each i in 1:10. 
# Because i takes values from 1 up to 10, it prints out the current i (1, 2, 3... 10). 

# Remember that we saw the following code in the coin flip example
for (i in 1:10){
  print(sample(c('T', 'F'), 1))
}
# This for loop computes the code inside the {}, 10 times. 

# You can use vector to store the sequence of the outputs. 
out <- rep(1, 10)
# out <- c()  # alternative: without specifying the length
for (i in 1:10){
  out[i] <- sqrt(i)
}

# Example: 
# Suppose we roll a die once, and record the number of times each face shows up.
# Repeat the process 100 times, and find the distribution of the times each face showed up. 

# storage
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

# Soemtimes one loop is not enough. You can loop over the loop! 

# See this code and compare with the following code
for (i in 1:5){
  cat("i =", i, '\n')
}

# see the example of the "nested loop" 
for (i in 1:5){
  for (j in 1:3){
    cat("i =", i, ' j =', j, '\n')
  }
}


# We have the outer loop over i and the inner loop over j. 
# For each i in 1, 2, ... 5, the inner loop is executed. 
# So, when i = 1, j goes from 1 to 3, when i = 2, j goes from 1 to 3 again, 
# upto when i = 5, j goes from 1 to 3. 

# For example, suppose you have the following data :
panel <- expand.grid(c('US', 'Canada', 'Mexico'), seq(2000, 2020))
colnames(panel) <- c('country', 'year')
panel <- panel[order(panel$country, panel$year),]
rownames(panel) <- seq(1, nrow(panel))


# You may want to loop over each country and year
for (country in c('US', 'Canada', 'Mexico')){
  for (year in seq(2000, 2020)){
    cat('country: ', country, ' year: ', year, '\n')
  }
}

# Quiz  ---------------------------------------------------------------
# 1. Compute sum of x^2 for x = 1,2,...10. using "for" loop. 
#    Hint: First, create a vector of storage. Then, use "for" loop to compute x^2 for x = 1,2,...10.
#    Then, compute the sum of the vector.

# 2. Draw a sample of size 100 from a standard normal distribution 1000 times.  
#    Compute the sample mean for each sample, and plot the histogram of the sample means.

# 3*. Fibonacci sequence is defined as 0, 1, 1, 2, 5, 8... 
#    i.e. x(t) = x(t-1) + x(t-2), with x(1) = 0, x(2) = 1. 
#    Compute the 30th number in the Fibonacci sequence.

# -----------------------------------------------------------------

# There is another type of look, "while" loop. 
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

# conditionals ----------------------------------------------------------------

# You can combine conditionals - "if-else" - with loops to do more things

# The following code checks if i is even or odd.
# Note that i %%2 == 0 returns TRUE if i is divisible by 2.
for (i in seq(1, 10)){
  print(i)
  if (i %% 2 == 0){ # condition (logical statement)
    print('even')   # execute this part if the condition is TRUE
  }else{
    print('odd') # execute this part if the condition is FALSE 
  }
}

# One common way of using "if-else" is to count the number of current iteration 
# This is particularly helpful if your loop takes long time. 
for (i in seq(1, 10000)){
  # do some computation here

  if (i %% 1000 == 0){
    cat('i= ', i, '\n')
  }
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
# Note that it is risky to put "TRUE" in the conditional statemnet.
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


# Quiz -------------------------------------------------------------------------

# 1. You can simulate a pair of die rolls using sample() function. i.e. 
die_pair <- sample(seq(1, 6), 2, replace=T)
# will simulate a pair of die roll.
# Using loops, simulate this process 1000 times. 

# 2. Perform the same process as Q1, but stop the iteration if the faces of the pair of dies are the same. 

# 3. Perform the same process as Q1, and compute the number of times when the sum of the two faces are larger than 7. 


