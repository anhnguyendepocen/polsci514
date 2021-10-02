##################################################
## POLSCI514 week5 problem set
## Name: 
##################################################


# Matrix 

# 1. Create a matrix object 'A' with 4 rows and 3 columns, filled with numbers 1...12 by rows.
# i.e. A[1,1] should be 1, A[1,2] should be 2, and A[1,3] should be 3.

A <- matrix(seq(1,12), nrow=4, ncol=3, byrow=T)
# 2. Create a matrix object 'B' with 3 rows and 4 columns, filled with numbers 1,3,5,7,9,...23 by columns.
# i.e. B[1,1] = 1, B[2,1] = 3, B[3,1] = 5, B[1,2] = 7 ...
B <- matrix(seq(1, 23, 2), nrow=3, ncol=4)

# 3. What is the 3rd row, 3rd column element of the matrix B?
B[3,3]

# 4. Compute a matrix multiplication of A times B and assign the result to a matrix object 'D'
D <- A %*% B

# 5. Compute a matrix multiplication of D and the transpose of D 
D %*% t(D)



## Random variable   

# 1. Draw a sample of size 10 from a normal distribution with mean 1 and variance 4. 
x <- rnorm(n=10, mean=1, sd=sqrt(4))

# 2. Plot a histogram using the sample you draw in Q2. 
hist(x)

# 3 Repeat Q1 and Q2 for different sample sizes: 100, 1000, and 10000. What do you notice? 
hist(rnorm(n=100, mean=1, sd=sqrt(4)))
hist(rnorm(n=1000, mean=1, sd=sqrt(4)))
hist(rnorm(n=10000, mean=1, sd=sqrt(4)))
# Comment:  The histgram becomes like a PDF of normal distribution as the sample size increases.

# 4. Compute the CDF of normal distribution with mean 0 and variance 1, evaluated at 1.
dnorm(1, 0, 1)

# 5. Draw a sample of size 10000 from a uniform distribution with the minimum value being 5 and the maximum value being 10. 
#    Plot a histogram using the sample. 
hist(runif(10000, 5, 10))

# 6. Compute the 0.025 quantile of the standard normal distribution (mean = 0, variance = 1). 
#    Compare it with the 0.975 quantile of the same distribution. What do you notice? 
qnorm(0.025, 0, 1)
qnorm(0.975, 0, 1)
# comment: the absolute values of the two quantiles are the same but opposite sign. 
# This is becasue the PDF of normal distribution is symmetric at 0.

## QQ plot 
# 1. Draw a random sample of size 10000 from t distribution with degree of freedom 1, 10, 100 using rt().
# Compare them with a standard normal distribution using qqnorm() function. What do you notice? 
qqnorm(rt(10000, df=1))
qqnorm(rt(10000, df=10))
qqnorm(rt(10000, df=100))
# comment: The t distribution becomes closer to normal distribution as the degree of freedom increases.
