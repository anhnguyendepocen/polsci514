
# Application of loops and conditionals: Simulation 

# Suppose that you took a survey on 100 people in a town and asked whether they are a Democrat or a Republican. 
# (Let's assume that they always answer truthfully....)
# How would you infer the proportion of people who support Republican in this town?

# We can use the proportion of Republican supporters in the sample,
# as an estimate of the proportion of Republican supporters in the population.
# but how to assess the quality of the estimate?
# Simulation provides one solution - We define a hypothetical population in R, and 
# then draw samples from the population. Finally, we compare the sample estimate vs
# what we wanted to estimate (estimand).

# Example: 
# Suppose there are 1000 voters in a town, some are republican and others are democrats. 
# The following code defines the 1000 voters. 
# The true proportion of people who support Republican in this town is 0.5.
pop <- c(rep('R', 500), rep('D', 500))

# we draw a sample of size 10
s1 <- sample(pop, 10)

# Mini quiz: Compute the proportion of Democrats and Republican in your sample 
s1_dem <- mean(s1 == "D")
s1_rep <- mean(s1 == "R")

# Is this a good estimate? 
# Are we just lucky and get a good estimate, or is our estimator always good?

# We can use simulation to draw sample repeatedly many times.
# Because we can have many samples, we can observe the distribution of the sample statistic.
# By comparing the distribution of the sample statistic with the population, 
# we can evaluate if the estimator is a good one or not. 

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
  # sample 10 people 
  s <- sample(pop, 10)
  
  result[k,'R'] <- mean(s == 'R') 
  result[k,'D'] <- mean(s == 'D') 
}
result

# Plot the histogram of the distribution of the proportion of Republicans in your samples 
hist(result$R, breaks=seq(0, 1, 0.1))
abline(v=0.5, col='red')

# You can tell that, on average, your estimator works well to estimate the proportion of Republican in the town.

# Mini quiz: Do the same simulation as above, but change the sample size from 10 to 100. What do you notice? 
K <- 1000 

# storage
result <- data.frame(R = rep(0, K),
                     D = rep(0, K))

# "for" loop for simulation
for (k in 1:K){
  # sample 10 people 
  s <- sample(pop, 100)
  
  result[k,'R'] <- mean(s == 'R') 
  result[k,'D'] <- mean(s == 'D') 
}
result

# Plot the histogram of the distribution of the proportion of Republicans in your samples 
hist(result$R, breaks=seq(0, 1, 0.1))
abline(v=0.5, col='red')


# Finite population vs super population----------------------------------------

# sample size 
n <- 100

# 1. Sampling from finite population
N <- 1000 # Total number of people in the population
m <- 800  # number of democrats in the population

pop <- c(rep(1, m), rep(2, N-m)) # 1=Democrats; 0=Republican
s_finite <- sample(pop, n) # sampling without replacement from pop

# 2. Sampling from super population
p <- 0.8 # proportion of democrats in the population

f_super <- rbinom(n, 1, prob=p) # Bernoulli with prob = p







