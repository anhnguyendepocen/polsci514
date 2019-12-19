##################################################
## POLSCI514 week5
## Introduction to R 
## Date: 2019/10/4
## Author: Saki Kuzushima
##################################################


# Table of contents

# (0) Logistics

# (1) Review: more subsetting
# (2) Random number generation
# (3) QQ plot
# (4) Q and A / exercise time

# (1) Review: subset ---------------------------------------------------------------------------

# Generate some data frame
data <- data.frame(x=c(1,2,3,4,5),
                   y=seq(1, 10, 2),
                   z=sample(1:10, 5),
                   a=c("A","B", "C","D","B"))

# Q. How to obtain the subset of data whose column "a" has value B? 
# There are many ways to do this.

# (1) indexing with row numbers
# Because we know that the 2nd and the 5th rows have value "B" in the column "a", 
# we can slice these two rows, using indexing
data[c(2,5),]

# (2) indexing with logical vector
# Alternatively, we can create a logical vector indicating which row has value "B" in the column "a'
# and use it in the indexing
select <- data$a == "B"  # "$" gets a column from a data frame
data[select,] # Don't forget ","
# Or, directly,
data[data$a == "B",]


# (3) subset function
# You can supply the same lotical vector to subset function
subset(data, select)
# Or, 
subset(data, data$a == "B")

# Q. How to obtain the subset of data whose column "a" has value B, and column "y" has value 3?


# Because only the 2nd row satisfies both conditions
data[2,]

# We can create a logical vector by combining two lotical vectors by "&"
select1 <- data$a == "B"
select2 <- data$y == 3
select <- select1 & select2

data[select,]
subset(data, select) # same 

# Alternatively, you can directly do
data[(data$a == "B" & data$y == 3),]
subset(data, data$a == "B" & data$y == 3) # same


# Exercise: small class size data
# We a dataset about the effect of small class size on educational performance
# (The data and the description is from QSS, Chap 2)
# This data is actually an introduction to causal inference! 

# Load "STAR.csv" and small-class-size.html for the description of data 

star <- read.csv("data/STAR.csv")
summary(star)

# Q1. Obtain the subset of the data whose class size is small, regular, and regular with aid
# (hint. Use classtype variable. See the documantation for the description of the variable.)

small <- subset(star, star$classtype == 1)
regular <- subset(star, star$classtype == 2)
regular_aid <- subset(star, star$classtype == 3)

table(star$classtype)

# Q2. We want to know whether the small class size improved the academic achievement. 
# Compute the mean of the fourth grade reading score for those students assigned to a small class, 
# and those assigned to a regular-sized class without aid. Do students in the small class perform better? 
# How about the math score? 

# reading
mean(small$g4reading, na.rm = T) - mean(regular$g4reading, na.rm = T)

# math
mean(small$g4math, na.rm = T)  - mean(regular$g4math, na.rm = T)

# Note that when you have NA in the data you want to compute its mean, R will return NA. 
# To avoid this, we use "na.rm = T" to remove the NA value from the computatoin. 
# To see this, observe that they all return NA
NA + 1 
NA * 2
mean(c(NA, 1, 2), na.rm = T)
sum(c(NA, 1, 2))

# Q3. We examine whether the small class size reduced the achievement gaps across different racial groups.
# First, obtain the folloiwng subset of the data.
# (1) white students assigned to a small class 
# (2) white students assigned to a regular class without aid
# (3) minority students assigned to a small class 
# (4) minority students assigned to a regular class without aid
# Define "minority" as Blacks and hispanics for now.

white_small <- subset(small, small$race == 1)
white_regular <- subset(regular, regular$race == 1)
minority_small <- subset(small, small$race == 2 | small$race == 4)
minority_regular <- subset(regular, regular$race == 2 | regular$race == 4)

# Begin by comparing the average reading and math test scores between white and minority students.

# reading
mean(white_regular$g4reading, na.rm = T) - mean(minority_regular$g4reading, na.rm = T)

# math
mean(white_regular$g4math, na.rm = T) - mean(minority_regular$g4math, na.rm = T)


# Conduct the same comparison among those students who were assigned to small classes. 
# NOTE: You can replace some words by Cmd|Ctrl + F -> Find & Replace 

# reading
mean(white_small$g4reading, na.rm = T) - mean(minority_small$g4reading, na.rm = T)

# math
mean(white_small$g4math, na.rm = T)  - mean(minority_small$g4math, na.rm = T)

# Give a brief substantive interpretation of the results of your analysis.
# Hint: you can subtract the first mean from the second (i.e. white from the minority) to see the 
# differnece between the white students and the minority students in each case. 


# (2) Random number generation -----------------------------------------------------

# In statistics, we often (too often) encounter an example of rolling a die 
# and tossing coins. Although we could simulate this process physically by 
# actually throwing coins and die, we do not always have coins, let alone dice. 
# How should we do this in R? There is a handy function to do this: sample()

# sample(), as its name suggests, draws a sample of a given size from c('H', 'T'). 
sample(c('H', 'T'), size = 1)

# try running the above code many times (just hit Ctrl/Cmd + Enter), or press "Run"), and see what happens. 
# Or, the following code will save your energy of hitting "Run" many times.

for (i in 1:10){  # By the way, this is called "for loop". We will learn this later. 
  print(sample(c('H', 'T'), size = 1))
}

# As you see, sometimes it returns "T" and other times "H". 


# You can simulate rolling a die 
sample(seq(1,6), size = 1)

# run the above code many times
for (i in 1:10){
  print(sample(seq(1,6), size = 1))
}

# This time, sample() function draws a sample of size (1) from c(1,2,3,4,5,6) (= seq(1,6)).

# What if you want to generate more complicated random numbers? For instance, 
# how to generate random numbers that follows normal distribution? 
# You can use rnorm() function. 

# The following code will generate 10 random numbers 
# from the standard normal distribution (mean = 0, standard devidation = 1)
rnorm(n = 10, mean = 0, sd = 1)

# Remember that we used hist() function to create a histogram
x <- rnorm(n = 100, mean = 0, sd = 1)
hist(x)

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
dunif(x = 11, min = 2, max = 10)
# Q. Even if you change x to some value between 2 and 10, the output does not change. Why? 

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


# (3) QQ plot -------------------------------------------------------------------------------------------
# QQ plot is a plot of two quantile funcitons, and is used to check if the data is generated from some known distribution. 
# 
# Let's start with the simple case. 
# Suppose we have two datasets, generated by two unknown distributions. 
# Suppose we have 0.25, 0.5, 0.75 quantile of the datasets. If all the quantiles are the same, 
# we can guess that the two distribution are very similar.
# Let's see the demonstration

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


# Get the quantile functions of N(0, 1), T(df = 2) and Unif(0,1) 
X <- qnorm(p = c(0.25, 0.5, 0.75), mean = 0, sd = 1)
Y <- qt(p = c(0.25, 0.5, 0.75), df = 2)
Z <- qunif(p = c(0.25, 0.5, 0.75), min = -0.5, max = 0.5)

# X and Y are more similar than X and Z
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

# Suppose this is an observed data
data <- rt(1000, df = 3) # random sample from t-distribution with defree of freedom 3. 

# And you guessed if this is from N(0, 1). 
x <- rnorm(n = 1000, mean=0, sd=1)

# Theoretically, we first order the observed data from the smallest to the largest, 
# and record the value of some quantile, and plot the values. 
# However, qqplot() function does this job for you. 
# (If you inspect the definition of qqplot() by simply executing "qqplot", 
# you can see what the function is doing behind the scene.)

# You can use qqplot() function to check if they have the same distribution
qqplot(data, x, xlim = c(-10, 10), ylim = c(-10, 10))
abline(a=0, b=1)
# It does not look like data follows N(0,1)! 

# Alternatively, you can use qqnorm() to compare with normal distribution in general 
qqnorm(data, xlim = c(-10, 10), ylim = c(-10, 10))
qqline(data)






