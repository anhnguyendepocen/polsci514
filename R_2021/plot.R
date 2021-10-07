##################################################
## POLSCI514: Plot
##################################################

# hist()
# plot()
# axis 
# layering plots 
# save plots


# hist() ######################################################################
a <- rnorm(1000)

hist(a,                                      # data
     breaks=seq(-4, 4, 0.5),                 # bin breaks
     main='Standard Normal Distribution',    # fig title
     xlab='x', ylab='Frequency'              # axis label
     )

# alternative: barplot() when you already have a summary table 
a_df <- data.frame(group=letters[1:5],
                   n=c(10, 21, 6, 11, 13))
barplot(height=a_df$n, names.arg=a_df$group)


# mini quiz
# 1. Draw a random sample of size 100 from a uniform distribution between 0 and 1.
# Then, plot three histograms with the bin width being 0.01, 0.05, 0.1, respectively.

# plot() #####################################################################
x <- seq(-5, 5, length.out=100)
y <- 0.5 * x + rnorm(100)

# scatter plot of x and y
plot(x, y)

# adding some basic information
plot(x=x, y=y,
     main='Scatter Plot of x and y',
     xlab='x', ylab='y',
     xlim=c(-5, 5), ylim=c(-5, 5))

# manually set axis
plot(x=x, y=y,
     main='Scatter Plot of x and y',
     xlab='x', ylab='y',
     xlim=c(-5, 5), ylim=c(-5, 5),
     xaxt='n', yaxt='n')             # remove axis  
axis(side=1,                         # which side of axis? see (?axis())
     at=seq(-5, 5, 1))               # where to put tick-marks
axis(side=2,                         # which side of axis? see (?axis())
     at=seq(-5, 5, 2.5))               # where to put tick-marks

# line plot
plot(x=x, y=y, type='l')


# layering plots #############################################################
z <- 0.5 * x

# plot() will create a basis for a plot, and lines(), points() and other functions
# can add layers to the plot

w <- x * (-0.5) + rnorm(100)

plot(x=x, y=y,
     main='Scatter Plot of x and y',
     xlab='x', ylab='y',
     xlim=c(-5, 5), ylim=c(-5, 5),
     xaxt='n', yaxt='n')             
axis(side=1,                        
     at=seq(-5, 5, 1))              
axis(side=2,                        
     at=seq(-5, 5, 2.5))             
points(x=x, y=w, pch=16)   # pch controls the symbol
legend("topleft", legend=c('Data 1', 'Data 2'), pch=c(1,16)) # add legends

# scatter plot with a line
plot(x=x, y=y,
     main='Scatter Plot of x and y',
     xlab='x', ylab='y',
     xlim=c(-5, 5), ylim=c(-5, 5),
     xaxt='n', yaxt='n')             
axis(side=1,                        
     at=seq(-5, 5, 1))              
axis(side=2,                        
     at=seq(-5, 5, 2.5))             
lines(x=x, y=z, col='red')      # change color

# different line types
plot(x=x, y=y,
     main='Scatter Plot of x and y',
     xlab='x', ylab='y',
     xlim=c(-5, 5), ylim=c(-5, 5),
     xaxt='n', yaxt='n')             
axis(side=1,                        
     at=seq(-5, 5, 1))              
axis(side=2,                        
     at=seq(-5, 5, 2.5))             
lines(x=x, y=z, col='red')                     # solid line 
lines(x=x, y=z+0.5, col='red', lty='dotted')   # dotted line 
lines(x=x, y=z-0.5, col='red', lty='dashed')   # dotted line 

# mini quiz
# Reproduce the first scatter plot in this section, using different pch values and color.
# i.e. you can reuse the code below but play with different pch values. 
# You can check the list of pch values online, for example: http://www.sthda.com/english/wiki/r-plot-pch-symbols-the-different-point-shapes-available-in-r.
# You can also check the list of colors, for example: https://www.r-graph-gallery.com/colors.html

plot(x=x, y=y,
     pch=1, col='black'
     main='Scatter Plot of x and y',
     xlab='x', ylab='y',
     xlim=c(-5, 5), ylim=c(-5, 5),
     xaxt='n', yaxt='n')             
axis(side=1,                        
     at=seq(-5, 5, 1))              
axis(side=2,                        
     at=seq(-5, 5, 2.5))             
points(x=x, y=w, pch=16, col='black')   

# save plots ##################################################################
pdf('some_plots.pdf')           # path to the plot
plot(x=x, y=y,
     main='Scatter Plot of x and y',
     xlab='x', ylab='y',
     xlim=c(-5, 5), ylim=c(-5, 5),
     xaxt='n', yaxt='n')             
axis(side=1,                        
     at=seq(-5, 5, 1))              
axis(side=2,                        
     at=seq(-5, 5, 2.5))             
lines(x=x, y=z, col='red')      
dev.off()

# You can use png(), or jpeg() to save as .png or .jpeg

# multiple plots ##############################################################

par(mfrow=c(1,2))    # horizontal
plot(x, y, col='red')
plot(x, y, col='blue')

par(mfrow=c(3,1))    # vertical 
plot(x, y, col='red')
plot(x, y, col='blue')
plot(x, y, col='orange')

par(mfrow=c(2,2))    # mfrow is row-wise; nfcol is column-wise ordering 
plot(x, y, col='red', main='1')
plot(x, y, col='blue', main='2')
plot(x, y, col='orange', main='3')
plot(x, y, col='cyan', main='4')

par(mfcol=c(2,2))    # mfrow is row-wise; nfcol is column-wise ordering 
plot(x, y, col='red', main='1')
plot(x, y, col='blue', main='2')
plot(x, y, col='orange', main='3')
plot(x, y, col='cyan', main='4')

# To set par() to the default back
dev.off()
# Quiz ########################################################################

# 1. Draw a random sample of size 100 from a standard normal distribution, and plot a histogram.

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










