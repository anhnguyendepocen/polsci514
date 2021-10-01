##################################################
## POLSCI514 week5 
## Random number 
##################################################

# Random number 

# In statistics, we often (too often) encounter an example of rolling a die (c.f. Nigeria example?)
# and tossing coins. Although we could simulate this process physically by actually throwing coins, and die, 
# We do not always have coins, let alone dice. 
# How should we do this in R? There is a handy function to do this: sample()

# sample(), as its name suggests, draws a sample of size (1) from c('H', 'T'). 
sample(c('H', 'T'), size = 1)

# try running the above code many times (just hit Ctrl/Cmd + Enter), or press "Run"), and see what happens. 
# Or, the following code will save your energy of hitting "Run" many times.

for (i in 1:10){  # this is called for loop. We will learn this later. 
  print(sample(c('H', 'T'), size = 1))
}

# As you see, sometimes it returns "T" and other times "H". This is how R is simulating a coin toss!


# You can simulate rolling a die 
sample(seq(1,6), size = 1)

# run the above code many times
for (i in 1:10){
  print(sample(seq(1,6), size = 1))
}

# This time, sample() function draws a sample of size (1) from c(1,2,3,4,5,6) (= seq(1,6)).

# You can draw multiple samples. If you want to throw a die twice, 
sample(seq(1,6), size = 2, replace = T)  #replace = T allows us to get the same face more than once. 

## Mini quiz ##################################################################
# 1. draw a sample of size 2 from a sequence of integer from 1 to 10 (i.e., 1, 2, ..., 10)
# using sampling without replacement

# 2. draw a sample of size 5 from a vector ('a', 'b', 'c') using sampling with replacement

################################################################################

# What if you want to generate more complicated random numbers? For instance, 
# how to generate random numbers that follows normal distribution? 
# You can use rnorm() function. 

# The following code will generate 10 random numbers 
# from the standard normal distribution (mean = 0, standard devidation = 1)
rnorm(n = 10, mean = 0, sd = 1)

# Remember that we used hist() function to create a histogram
x <- rnorm(n = 100, mean = 0, sd = 1)
hist(x, 
     breaks=seq(-3, 3, 0.5), # set the size of bin to be 0.5
     main='Standard normal distribution') #set figure title

# If you increase the sample size, the histogram resembles the normal distribution more. 
x <- rnorm(n = 1000, mean = 0, sd = 1)
hist(x)

# This code will generate 10 random numbers 
# from the uniform distribution between 0 and 1. 
# You can increase the sample size to make the histogram close to the uniform distribution.
y <- runif(n = 1000000, min = 0, max = 1)
hist(y)




# These family of functions have very similar names. Adding the folloiwng alphabet 
# to the abbrebiation of distribution (e.g. norm, unif) will craete a name of a function. 

# r: random number generation
# p: cumulative distribution function (CDF)
# d: probability density function (PDF) or probability mass function (PMF)
# q: quantile funciton
# To see what arguments we need to supply, use help (? + function name)

# We worked with two "r" function (rnorm and runif), so let's move on to p, d, and q function.

# "p" function generates CDF. Remember that CDF is the probability of X being equal to or less than some value. i.e. P(X <= t)
# This will generate the probability of X being less than or equal to 0.5 when X follows uniform distribution between 0 and 1. 
# i.e. P(X <= 0.5), X ~ Unif(0, 1). 
punif(q = 0.5, min = 0, max = 1)

# This will generate P(X <= 0), X ~ N(0, 1)
pnorm(q = 0, mean = 0, sd = 1)


# "d" function generates PDF (if continuous) or PMF (if descrete).
# This generates a PDF of X ~ N(0,1) evaluated at x = 1.
dnorm(x = 1, mean = 0, sd = 1)
# Note that this is NOT the probability that X = 1, X ~ N(0, 1). Such probbaility is zero because X is continuous. 

# You can plot a nice PDF of normal distribution using dnorm function.
x <- seq(-3, 3, 0.01)
y <- dnorm(x = x, mean = 0, sd = 1)
plot(x,y)

# PDF of X ~ Unif(2, 10) evaluated at x = 5
dunif(x = 5, min = 2, max = 10)
# Mini quiz: what is dunif(x=2, min=2, max=10)? Can you get the answer without running this code?

# The last one is the "q" function, for quantile function. 
# Remember that quantile function is the inverse of CDF. 
# if you want to obtain a quantile function of the standard normal distribution
x <- qnorm(p = 0.975, mean = 0, sd = 1)
x
# Because quantile function is the invrese of CDF, 
# This resturns 0.975, which we used for qnorm function. 
pnorm(q = x, mean = 0, sd = 1)

# We learned "inverse CDF method" to generate random numbers from any probability distribution. 
# There are two steps in this method. 

# (1) Generate rnadom numbers, U, from Unif(0,1)
# (2) Provide (1) in the inverse of the desired CDF, (i.e. quantile function).
# The output from (2) is the random numbers from the desired distribution. 

# Let's use Beta(2,2) distribution.
# For reference, this is what true beta(2,2) PDF looks like
a <- seq(0, 1, 0.001)
b <- dbeta(a, shape1 = 2, shape2 = 2)
plot(a,b)

# First, we generate random numbers
U <- runif(n = 10000, min = 0, max = 1)
# Then, provide the generated random numbers to quantile function of beta(2,2)
X <- qbeta(p = U, shape1 = 2, shape2 = 2)
hist(X)

## Quiz  ##################################################################

# 1. Draw a sample of size 10 from a normal distribution with mean 1 and variance 4. 

# 2. Plot a histogram using the sample you draw in Q2. 

# 3 Repeat Q1 and Q2 for different sample sizes: 100, 1000, and 10000. What do you notice? 

# 4. Compute the CDF of normal distribution with mean 0 and variance 1, evaluated at 1.

# 5. Draw a sample of size 10000 from a uniform distribution with the minimum value being 5 and the maximum value being 10. 
#    Plot a histogram using the sample. 

# 6. Compute the 0.025 quantile of the standard normal distribution (mean = 0, variance = 1). 
#    Compare it with the 0.975 quantile of the same distribution. What do you notice? 

################################################################################


# QQ plot ######################################################################
# QQ plot is a plot of two quantile funcitons, and is used to check if the data is generated from some known distribution. 
# 
# Let's start with the simple case. 
# Suppose we have two datasets, generated by two unknown distributions. 
# The idea behind QQ plot is that if all the quantiles of the two datasets are the same, 
# we can guess that the two distribution are very similar.


# Suppose data are generated from N(0, 1), T(df = 2) and Unif(-1,1) 
# For refernece, the actual CDF of these distributions look like the following.
temp <- seq(-3, 3, 0.001)

# N(0,1)
plot(temp, pnorm(temp, mean = 0, sd = 1),
     xlim = c(-3, 3), ylim = c(0, 1), main = "N(0,1)")

# T(df = 2)
plot(temp, pt(temp, df = 2),
     xlim = c(-3, 3), ylim = c(0, 1), main = "T(df = 2)")

# Unif(0,1)
plot(temp, punif(temp, min = -1, max = 1),
     xlim = c(-3, 3), ylim = c(0, 1), main = "Unif(-1,1)")


# Get the 1/4, 1/2, 3/4 quantiles of N(0, 1), T(df = 2) and Unif(0,1) 
X <- qnorm(p = c(0.25, 0.5, 0.75), mean = 0, sd = 1)
Y <- qt(p = c(0.25, 0.5, 0.75), df = 2)
Z <- qunif(p = c(0.25, 0.5, 0.75), min = -0.5, max = 0.5)

# The 1/4, 2/4, 3/4 quantile values for normal and t distribution with dof 2 are close to each other
X
Y
Z

# You can plot them to inspect visually
# If the two distributions are exactly the same, all points should line up on the 45 degree line

# X and X
plot(X, X, xlim = c(-1, 1), ylim=c(-1, 1), main = "X and X") # xlim and ylim set the range of x and y axis
abline(a=0,b=1) # This create a 45 degree line (y = x)

# X and Y
plot(X, Y, xlim = c(-1, 1), ylim=c(-1, 1), main = "X and Y")
abline(a=0,b=1) 

# X and Z
plot(X, Z, xlim = c(-1, 1), ylim=c(-1, 1), main="X and Z") # changed the range of the y axis
abline(a=0,b=1) 

# What if we increase the number of points we evaluate the quantile function
temp <- seq(0.01, 0.99, length.out=100)
X <- qnorm(p = temp, mean = 0, sd = 1)
Y <- qt(p = temp, df = 2)
Z <- qunif(p = temp, min = -0.5, max = 0.5)

# The 1/4, 2/4, 3/4 quantile values for normal and t distribution with dof 2 are close to each other
X
Y
Z

# You can plot them to inspect visually
# If the two distributions are exactly the same, all points should line up on the 45 degree line

# X and X
plot(X, X, xlim = c(-1, 1), ylim=c(-1, 1), main = "X and X") # xlim and ylim set the range of x and y axis
abline(a=0,b=1) # This create a 45 degree line (y = x)

# X and Y
plot(X, Y, xlim = c(-1, 1), ylim=c(-1, 1), main = "X and Y")
abline(a=0,b=1) 

# X and Z
plot(X, Z, xlim = c(-1, 1), ylim=c(-1, 1), main="X and Z") # changed the range of the y axis
abline(a=0,b=1) 


# In the above demonstration, we know the true distributions. 
# However, in reality, we do not know this (that is why we want to use QQ plot to check if the distributions are the same).
# What if you just have two datasets, and you want to check whether the datasetsare a sample from the same distribution? 

# Suppose this is an observed data and you don't know the distributio of it. 
data <- rt(1000, df = 3) # In fact, this is a random sample from t-distribution with defree of freedom 3. 

# And you guessed if this is from N(0, 1). 
x <- rnorm(n = 1000, mean=0, sd=1)

# Theoretically, we first order the observed data from the smallest to the largest, 
# and plot the point based on the sorted values. 
# However, qqplot() function does this job for you. 
# (If you inspect the definition of qqplot()  
# you can see what the function is doing behind the scene.)

# You can use qqplot() function to check if they have the same distribution
qqplot(data, x, xlim = c(-10, 10), ylim = c(-10, 10))
abline(a=0, b=1)
# It does not look like data follows N(0,1)! 

# Alternatively, you can use qqnorm() to compare with normal distribution in general 
qqnorm(data, xlim = c(-10, 10), ylim = c(-10, 10))
qqline(data)


## Quiz ########################################################################
# 1. Draw a random sample of size 10000 from t distribution with degree of freedom 1, 10, 100 using rt().
# Compare them with a standard normal distribution using qqnorm() function. What do you notice? 

################################################################################


# Setting 'seed' for random number generations #################################

# It is recommended to set the seed of random numebr generators for reproduciability. 
# It is a common practice to put it at the top of the code (below library() calls)

## Seed the current RNG, i.e., set the RNG status
set.seed(42)
u1 <- runif(30)
seed1 <- .Random.seed
set.seed(42)
u2 <- runif(30) # the same because of identical RNG status:
seed2 <- .Random.seed

identical(u1, u2)
identical(seed1, seed2)

# Unset (remove) current seed
rm(.Random.seed)

## This is helpful to reproduce the sample results when you use random number generation

set.seed(13)
x <- rnorm(10)
mean(x) # The value should be 0.6000538 for everyone. 

rm(.Random.seed)
x <- rnorm(10)
mean(x) # the values should be different from people to people





