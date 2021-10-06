##################################################
## POLSCI514 Plot
## Introduction to R 
##################################################

# hist()
# plot()
# axis 
# layering plots 
# save plots

# TODO: add exercise!

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
