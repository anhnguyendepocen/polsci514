##################################################
## POLSCI514 week13
## Introduction to R 
## Date: 2019/11/22
## Author: Saki Kuzushima
##################################################

# Logistics: teaching evaluation! 

# Table of contents
# 1. 599 pset helper codes
# 2. ggplot practice
# 3. showcase


# 1. 599 pset helper code ---------------------------------------------------------

# 1. Simulate data (1(a) modification )

# Create 100 datasets.
# Each dataset consists of 1000 observation.
# Each data point in the j th dataset follows N(j, 1), and they are independent of each other.

# It's good to start with a simple case. Start with the case j = 1.
# The data in the 1st dataset follows N(1,1).

# Use rnorm() to generate random variables from normal distribution
set.seed(123)
data1 <- rnorm(n=1000, mean=1, sd = 1)

# Confirming that it is normally distributed with mean 1
hist(data1)
mean(data1)

# I want to repeat this process 100 times, with differnet j
# Use for loop. First, create a storage
data_mat <- matrix(0, ncol = 100, nrow = 1000)
# Then, for loop
for (j in seq(1, 100)){
  data_mat[,j] <- rnorm(n=1000, mean=j, sd=1)
}


# Confirming that it is normally distributed with mean j
# j = 2
hist(data_mat[,2])
mean(data_mat[,2])
# j = 3
hist(data_mat[,3])
mean(data_mat[,3])


# 2. t-test
# Test if the null hypothesis that the mean = 1 is rejected, using data1
# mu argument specifies the value of the null hypotheiss
t.test(x=data1, mu=1)
# or
t.test(x=data1-1)
# Both failed to reject the null (which makes sense because the data is generated from N(1,1))



# 3. Confidence interval (see 599 inference slide p.8)
alpha <- 0.05
n <- 100

# generate random sample 
data1 <- rnorm(n=n, mean=1, sd = 1)

mu <- mean(data1) # sample mean
se <- sqrt(var(data1)) / sqrt(n) # standard deviation of sample mean 

# Exact inference
CI_exact <- c(mu + se*qt(p=alpha/2, df=n-1), mu, mu + se*qt(p=1-alpha/2, df=n-1))
names(CI_exact) <- c("lower", "point", "upper")
CI_exact

# Asymptotic inference
CI_asy <- c(mu + se*qnorm(p=alpha/2), mu, mu + se*qnorm(p=1-alpha/2))
names(CI_asy) <- c("lower", "point", "upper")
CI_asy


# 4. Cauchy, normal, and t distribution
x <- seq(-5, 5, 0.01)
cauchy <- dcauchy(x)
normal <- dnorm(x)
t1 <- dt(x, df=1)
t3 <- dt(x, df=3)
t5 <- dt(x, df=5)
t10 <- dt(x, df=10)
t100 <- dt(x, df=100)

df <- data.frame(cauchy=cauchy,
                 normal=normal,
                 t1=t1, 
                 t3=t3,
                 t5=t5,
                 t10=t10,
                 t100=t100,
                 x=x)

library(tidyverse)

# I try to make it fancy....
library(RColorBrewer)
display.brewer.pal(n=6, name = "Blues")
cols <- brewer.pal(n=6, name="Blues")


ggplot(df) + 
  geom_line(aes(x=x, y=cauchy), color= cols[2]) +
  geom_line(aes(x=x, y=t3), color = cols[3]) + 
  geom_line(aes(x=x, y=t5), color = cols[4]) + 
  geom_line(aes(x=x, y=t10), color = cols[5]) + 
  geom_line(aes(x=x, y=normal), color = cols[6]) +
  theme_bw()
# At the point zero, From the top to bottom
# Normal > t10 > t5 > t3 > cauchy







# ggplot exercise: histogram ----------------------------------------------------------------


# We will use a dataset "diamonds" that come with ggplot
?diamonds
summary(diamonds)
head(diamonds)


# 0. Review
# Let's review some basic syntax of ggplot

# Q. Plot price against carat using diamonds data
# (It may take time for a plot to show up...)
ggplot(diamonds) +
  geom_point(aes(x=carat, y=price))


# Q. Using the plot created above, Change the color of points based on the cut
ggplot(diamonds) +
  geom_point(aes(x=carat, y=price, color=cut))

# Q. What kind of guess can you make about the factors affecting the price? 






# Histogram may be the kind of plot we use most often. 
# Let's practice some of the ways to create better histogram

# 1. Histogram based on categorical variables 
# Let's show the number of diagmonds grouped by "cut"


# geom_bar() can create a histogram based on grouping
ggplot(data = diamonds) + 
  geom_bar(aes(x=cut))
# What is interesting about this function is that, the y-axis - count, is not a variable
# in the diamonds dataset. geom_bar function internally create count variable, and then
# plot the histogram using the variable. 
# THis is because the defaule argument to "stat" in geom_bar is "count"
# which means that the geom_bar() internally create a variable of count, and then plot it. 

# or stat_count can do the same thing
ggplot(data=diamonds) + 
  stat_count(aes(x=cut))

# Or, you can first create a table of the number of observation for each cut
cut_n <- diamonds %>%
  group_by(cut) %>%
  summarise(n = mean(price))

# Then, you can use geom_bar with stat = "identity"
ggplot(cut_n) +
  geom_bar(aes(x=cut, y=n), stat="identity")


# We can color the histograms based on grouping variables
ggplot(data = diamonds) + 
  geom_bar(aes(x = cut, fill = clarity))
# position = "fill" will make each bar have the same height
ggplot(data = diamonds) + 
  geom_bar(aes(x = cut, fill = clarity), position = "fill")
# Or "dodge" can create mini-histograms 
ggplot(data = diamonds) + 
  geom_bar(aes(x = cut, fill = clarity), position = "dodge")



# 2. Histogram based on continuous variables
# Let's show the histogram based on the price
ggplot(data=diamonds) + 
  geom_histogram(aes(x=carat))


# Change the bin width
ggplot(data=diamonds) + 
  geom_histogram(aes(x=carat), binwidth = 0.01)

# Q. Why are there several peaks? Why are there more diamonds right of each peak than left? 


# You can also color the histogram based on grouping
ggplot(data=diamonds) + 
  geom_histogram(aes(x=carat, fill = cut))


# Exercise: 
# Q Create a histogram based on the color variable using geom_bar()
ggplot(data = diamonds) + 
  geom_bar(aes(x=color))


# Q Create plot the average price for each color using geom_bar()
# Hint. You first need to create a table of average price for each color

t1 <- diamonds %>%
  group_by(color) %>%
  summarise(avg_price = mean(price))

ggplot(t1) +
  geom_bar(aes(x=color, y=avg_price), stat="identity")


# reference: R for data science Chapter 3 and 7
# 3. Some showcase -------------------------------------------------------------------------------



# one step deeper in R....
library(lobstr)

# A dataframe is a list (!?)
d1 <- data.frame(x = c(1, 5, 6), y = c(2, 4, 3))
class(d1)
typeof(d1) 
attributes(d1)


# Which uses less memory? 
x <- 1:3
y <- 1:1e3
z <- 1:1e6

obj_size(x)
obj_size(y)
obj_size(z) # same!?


# Which is faster - base matrix and sparse matrix?
library(microbenchmark)
library(Matrix)

N <- 100

fill <- function(mat){
  mat[1,1] <- 1
  
  return(mat)
}

# Base matrix
X <- matrix(0, nrow=N, ncol=N)
base <- microbenchmark(fill(X), times = 10, unit = "ms")

# Sparse matrix
Y <- as(X, "dgCMatrix")
Y
sparse <- microbenchmark(fill(Y), times = 10, unit = "ms")

# compare time 
base
sparse # matrix is much faster! 

typeof(X)
attributes(X)

typeof(Y)
attributes(Y) # What is S4? 



# text analysis...

library(quanteda)

# word cloud is a way to plot the frequency of words.
# The words that are used often are plotted bigger

# I use US presidential inaugural address textx 

dfm_inaug <- corpus_subset(data_corpus_inaugural, President == "Trump") %>% 
  dfm(remove = stopwords('english'), remove_punct = TRUE) %>%
  dfm_trim(min_termfreq = 10, verbose = FALSE)

set.seed(100)
textplot_wordcloud(dfm_inaug)

# Compare by the person...

corpus_subset(data_corpus_inaugural, 
              President %in% c("Washington", "Jefferson", "Madison")) %>%
  dfm(groups = "President", remove = stopwords("english"), remove_punct = TRUE) %>%
  dfm_trim(min_termfreq = 5, verbose = FALSE) %>%
  textplot_wordcloud(comparison = TRUE)


# refernece
# https://quanteda.io/articles/pkgdown/examples/plotting.html



# Other possible topics...


# parallel computing 
# more on simulation
# more on tidyverse
# text 
# network
# creating R package

# python
# C++
# Linux 
# API (e.g. twitter)
# github
# (cluster computer?)
# web scraping



# Plot confidence interval  ---------------------------
# plot
df <- data.frame(x=0, 
                 point=0, 
                 lower = -0.5,
                 upper = 0.5)
ggplot(df) + 
  geom_point(aes(x=x, y=point)) + 
  geom_errorbar(aes(x=x,ymin=lower, ymax=0.5))


# regression
X1 <- rnorm(n = 100)
e <- rnorm(n=100)
y <- 2 * X1 + e

fit <- lm(y ~ X1)
temp <- coefplot::coefplot(fit)
temp$data









