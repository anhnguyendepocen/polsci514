##################################################
## POLSCI514: Loop 
##################################################


#  Simulation -------------------------------------------------
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
  print(sqrt(i))
}

# This is called "for loop". This for loop computes the code inside the curly brackets {}, for each i in 1:10. 
# Because i takes values from 1 up to 10, it prints out the square root of 1, 2, 3... 10. 

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

# Quiz  ---------------------------------------------------------------
# 1. Compute sum of x^2 for x = 1,2,...10. using "for" loop. 
#    Hint: First, create a vector of storage. Then, use "for" loop to compute x^2 for x = 1,2,...10.
#    Then, compute the sum of the vector.

# 2. Draw a sample of size 100 from a standard normal distribution 1000 times.  
#    Compute the sample mean for each sample, and plot the histogram of the sample means.

# 3*. Fibonacci sequence is defined as 0, 1, 1, 2, 5, 8... 
#    i.e. x(t) = x(t-1) + x(t-2), with x(1) = 0, x(2) = 1. 
#    Compute the 30th number in the Fibonacci sequence.

################################################################################
# (while loop)


# if else















