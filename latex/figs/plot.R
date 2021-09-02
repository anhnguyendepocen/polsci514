# plot normal histogram
x <- rnorm(10000, 0, 1)
pdf('normal.pdf')
hist(x)
dev.off()

x <- runif(10000)
pdf('unif.pdf')
hist(x)
dev.off()

x <- rbeta(10000, shape1=3, shape2=3)
pdf('beta.pdf')
hist(x)
dev.off()
