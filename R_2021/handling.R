##################################################
## POLSCI514 week3
## Introduction to R 
## Date: 2019/9/20
## Author: Saki Kuzushima
##################################################

# Main topic: Data I/O (Read and Write Data), Matrix 


# Vector + vector operation -------------------------------------------

x <- c(1,2,3)
y <- c(2,3,4)

# vector + scalar
x + 1

# vector + vector 
x + y
y - x
x * y
x / y


# Example with data frame
temp <- data.frame(x=c(1,2,3),
                   y=c(2,3,4))

temp$x + temp$y

# Another type of vector : Factor  --------------------------------
# Let's learn another type: factor. It is used for categorical variable. 
country <- c("US", "Japan", "China", "Canada")
country <- as.factor(country)
class(country)

# You can see that there is "levels", Canada, China, Japan and US. 
levels(country)

# Factors are useful when you know the set of possible values but 
# they’re not all present in a given dataset. 
# In contrast to a character vector, when you tabulate a factor 
# you’ll get counts of all categories, even unobserved ones: 
sex_char <- c("m", "m", "m")
sex_factor <- factor(sex_char, levels = c("m", "f"))

table(sex_char)
table(sex_factor)

# Path ------------------------------------------------------------------------

# A path is like an address of each file in a computer.
# To read/write a file, you have to specity its path.

# A computer has a hierarchical directory structure.
# A directory (or folder) contains sub-directories, and each sub-directories 
# contain sub-sub-directories ...
# Each directory can also contain files, such as "something.R", "another.tex", etc.

# Example file path
# (Mac) "/Users/Umich/class514/your_file.csv" or
# (Windows) "C:Umich/class514/data/your_file.csv"

# current directory
getwd()

# files in the current directory
list.files()

# change directory
# Use Rstudio 'Session > Set Working Directory' or 
# (The folowing path is in my case. Your path will be different.)
#setwd('~/Dropbox (University of Michigan)/teaching/polsci514/R_2021')

# It is a helpful practice to organize your files in a nice tree structure 
# so that it's easy to find the file path to the file
# For instance
#   |- POLSCI514 
#      |- R 
#         |- obj_data.R 
#         |- handling.R 
#         |- data
#            |- World.csv

# Some useful syntax
# two dots: parent directory
# one dot: current directory 
setwd('../') # set wd to the parent directory
setwd('./pset') # set wd to the child directory, called 'pset'


# Read and Write data ---------------------------------------------------------

# read.csv() function will read the csv file

world <- read.csv("data/World.csv")
# you have to specify the correct path of the file to use read.csv().

# Note that 
read.csv("data/World.csv")
# only loads the data, but it only prints out the loaded data, and did not create any object. 
# You have to assign the data to an object in order to play with it.
# In the following line, we first load the data file, and then assigned them 
# to the object called "my_data"
my_data <- read.csv("data/World.csv")

# By contrast, write.csv() will write the csv file 
write.csv(my_data, "my_world.csv")

# quickly inspect data 
colnames(world) # check what variables are in the data
head(world) # inspect the first 5 rows of the data
summary(world) # get a brief summary of the data

# Reading other file format
my_data2 <- read.table("data/World.txt", header=T, sep=",")
# How about .dta for STATA?


# A note on 'stringsAsFactors'

# If you are using R < 4.0.0, the default argument to 'stringsAsFactors' of 'read.csv' function
# should be set to TRUE while R >= 4.0.0 set it to FALSE
# see this post if you are interested: https://developer.r-project.org/Blog/public/2020/02/16/stringsasfactors/

# Thus, if you are using R < 4.0.0
class(world$age)
# should be a factor, but if you are using R >= 4.0.0, it should be a character
# To make the behavior consistent, R < 4.0.0 users should set 'stringsAsFactors' = FALSE in this exercise.



# Packages --------------------------------------------------------------------

# Like other open source programming languages, R has many packages. 
# Simply put, Packages are sets of pre-defined functions and created by other users. 
# For instance, suppose you want to use data created by STATA. The data file 
# has format .dta, and you cannot use read.csv() for .dta

# You have to install the package if you haven't done before 
# You have to do this only once
install.packages("foreign")
# Attach the package to use 
# This has to be done at every R session you want to use the package  
library(foreign)

# Now you can read .dta using read.dta() function
world_new <- read.dta("World.dta")

# You can save as .dta using write.dta()
write.dta(world_new, 'my_world.dta')



# It is a common practice NOT to keep 'install.package()' in your code
# but keep 'library()' only.
# It is also recommended to have 'library()' in the first couple of lines of code
# so other people can see which packages are required to execute your code.


# Exercise: More on data subsets and summary  -------------------------------

# The following is the description of data
# Source: Imai (2018) Introduction to Quantitative Social Science

# Surveys are frequently used to measure political behavior such as
# voter turnout, but some researchers are concerned about the accuracy
# of self-reports.  In particular, they worry about possible *social
# desirability bias* where in post-election surveys, respondents who did
# not vote in an election lie about not having voted because they may
# feel that they should have voted.  Is such a bias present in the
# American National Election Studies (ANES)?  The ANES is a nation-wide
# survey that has been conducted for every election since 1948.  The
# ANES conducts face-to-face interviews with a nationally representative
# sample of adults.  The table below displays the names and descriptions
# of variables in the `turnout.csv` data file.
# 

#--------------------------------------------------------------------------------
# Name                 Description
# -------------------- ----------------------------------------------------------
# `year`               Election year
# 
# `VEP`                Voting Eligible Population (in thousands) 
# 
# `VAP`                Voting Age Population (in thousands) 
# 
# `total`              Total ballots cast for highest office (in thousands) 
# 
# `ANES`               ANES estimate of turnout rate
# 
# `felons`             Total ineligible felons (in thousands) 
# 
# `noncitizens`        Total non-citizens (in thousands) 
# 
# `overseas`           Total eligible overseas voters (in thousands)
# 
# `osvoters`           Total ballots counted by overseas voters (in thousands)
#--------------------------------------------------------------------------------

# Q1. Read the data and print out the summary of the data


# Q2. Compute the turnout rate based on the voting eligible population (VEP) for each election year. 
veptr <- turnout$total / (turnout$VEP) * 100

# Q3. Compute the difference between what you computed in Q2 vs ANES estiamte of turnout rate for each election year.  
# What is the average difference across the election years?
diff_veptr <- turnout$ANES - veptr

# Q4. Subset the data into two groups: One for 1980-1992 and the other for 1994-2008. 
# Compute the average difference across the election years for both presidential and mid-term elections.  

# Q5. Subset the data into two groups: One for presidential elections and the other for mid-term elections. 
# Compute the average difference across the election years for both presidential and mid-term elections.  

# NOTE: add more?

# Matrix ----------------------------------------------------------------------
# We learn anthor object similar to dataframe: Matrix. 

# We learned that we can add names to a vector 
x <- c(1,2,3,4,5,6)
names(x) <- c('a', 'b', 'c', 'd', 'e', 'f')
# What we are doing here is that we are adding an attribute to a vector
str(attributes(x))

# Likewise, we can add a different attribute, dimensions.
# This will effectively turns a vector into a matrix.
dim(x) <- c(2,3)
x

# Normally, we simply create a matrix using matrix() function. 
# First, the following code will create a 2 * 2 matrix with all elemenets being 1. 
X1 <- matrix(1, nrow = 2, ncol = 2)
# You can supply a vector
X2 <- matrix(c(1,2,3,4), nrow = 2, ncol = 2)
X3 <- matrix(c(1,2,3,4), nrow = 2, ncol = 2, byrow=T)
# Note that the vector is arranged by column (you can change this by byrow argument
# in the matrix function)


# Whenever we multiply matrices, we have to be careful about the dimensions. 
Y <- matrix(c(1,2,3,4,5,6), nrow = 2, ncol = 3)
Z <- matrix(c(10, 20, 30, 40, 50, 60), nrow = 3, ncol = 2)
W <- matrix(1:10, nrow = 2, ncol=5)

# You can check the dimension by dim()
dim(Y)
dim(Z)
dim(W)

# When you multply matrices, use %*%, instead of *
# Remember that X %*% Y is possible only when the row length of X is the 
# same as the column length of Y

# This is possible :)
Y %*% Z

# This is impossible :( 
Y %*% W


# You can convert dataframe to matrix
df <- data.frame(x = c(1,2), y = c(3,4))
df_mat <- as.matrix(df)

# You can do matrix multiplication with matrix but not with dataframe
# THis returns error
df %*% X # error

# But this is possible 
df_mat %*% X


# If you use *, it will comute the element-wise multiplication

# This is possible
X * X
# But the result is different from this!!
X %*% X


# You can transpose and invert matrices 
# This will transpose the matrix
t(Y)
# This will invert the matrix
solve(X)
# THis will return error because only square matrices can be invertible. 
solve(Y) # error


# Exercise --------------------------------------------------------------------
# NOTE: 


















