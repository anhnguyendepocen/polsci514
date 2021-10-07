##################################################
## POLSCI514 week6 problem set
## Name: 
##################################################



## Random number  ##################################################################
# 1. Compute the CDF of normal distribution with mean 0 and variance 1, evaluated at 1.
pnorm(1, 0, 1)

# 2. Compute the 0.025 quantile of the standard normal distribution (mean = 0, variance = 1). 
#    Compare it with the 0.975 quantile of the same distribution. What do you notice? 
qnorm(0.025)
qnorm(0.975)

################################################################################

# QQplot #######################################################################
# Draw a random sample of size 10000 from t distribution with degree of freedom 1, 10, 100 using rt().
# Compare them with a standard normal distribution using qqnorm() function. What do you notice? 
qqnorm(rt(10000, 1))
qqnorm(rt(10000, 10))
qqnorm(rt(10000, 100))

# Plot ########################################################################

# 1. Draw a random sample of size 100 from a standard normal distribution, and plot a histogram.
hist(rnorm(100))

# 2. Let's use the turnout data we used before
turnout <- read.csv('data/turnout.csv')
# Let's remove the 2008 data to make things simple
turnout <- turnout[-14,]

# Create a scatter plot of the overseas voters ('overseas' variable) across time. 
# Add a reasonable title and axis label. 
plot(turnout$year, turnout$overseas, 
     xlab='year', ylab='overseas voters',
     main='Number of overseas voters from 1980 to 2004')

# 3. Using the turnout data, create a scatter plot of the ANES estimated turnout rate ('ANES' variable) for presidential and midterm elections.  
# Use a different color and/or symbol to make sure that they are distinct.
# Add a reasonable title and axis labels as well as legends. 

# hint: x-axis should be the 'year' and the y-axis should be 'ANES'.
# hint: adjust ylim() if the estimated turnout rate for midterm elections do not show in the plot.

turnout_pres <- turnout[turnout$year %% 4 ==0, ]
turnout_mid <- turnout[turnout$year %% 4 !=0, ]

plot(turnout_pres$year, turnout_pres$ANES, pch=1, ylim=c(50, 80),
     main='ANES estimate of turnout rate',
     xaxt='n', xlab='year', ylab='turnout (%)')
axis(side=1, at=seq(1980, 2004, 2), las=2 )
points(turnout_mid$year, turnout_mid$ANES, pch=16)
legend("topleft", legend=c('Presidential', 'Midterm'), pch=c(1, 16))


