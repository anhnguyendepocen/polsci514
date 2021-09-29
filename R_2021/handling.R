##################################################
## POLSCI514 week4
## Introduction to R 
## Date: 2019/9/24
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
country_factor <- as.factor(country)
class(country_factor)
class(country)

# convert back to character
country_char <- as.character(country_factor)
country_char == country

# More explicitly 
sex_char <- c('m', 'f', 'm')
sex_factor <- factor(sex_char, levels=c('m', 'f')) 

# You can see that there is "levels", Canada, China, Japan and US. 
levels(country_factor)
levels(sex_factor)

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
# To read/write a file, you have to specify its path.

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

# use sessionInfo() to check the version of R
sessionInfo()

# Mini quiz
score_data <- data.frame(names=c('tom', 'james', 'mary', 'john', 'sarah', 'david',
                                 'lisa', 'chris', 'mitchell', 'eric'),
                         group=c(1,2,3,1,2,3,1,2,3,1),
                         hw1=c(90, 89, 83, 28, 82, 72, 63, 12, 5, 64),
                         hw2=c(82, 43, 98, 42, 57, 94, 11, 43, 42, 54))

# Write the dataframe 'score_data' as a csv file.
# Read the saved csv file and assign it to the object called 'new_score_data'

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

# Q3. Compute the difference between what you computed in Q2 vs ANES estiamte of turnout rate for each election year.  
# What is the average difference of the turnout rate based on the VEP, across the election years?
# In which year the difference is the biggest?


# Q4 create a vector with a factor class that indicate whether the election is presidential or mid-term. 
# Add the vector as a column of the turnout data. Hint: use 'rep' function.

# Q5. Subset the data into two groups: One for presidential elections and the other for mid-term elections. 
# Compute the average difference in the turnout rate based on the VEP, across the election years for both presidential and mid-term elections.  
# Which elections, presidential or mid-terms, have higher difference between ANES estimate and the turnout rate based on the VEP? 


# Matrix ----------------------------------------------------------------------
# We learn anothor object similar to dataframe: Matrix. 

# We learned that we can add names to a vector 
X <- c(1,2,3,4,5,6)
names(X) <- c('a', 'b', 'c', 'd', 'e', 'f')
# What we are doing here is that we are adding an attribute to a vector

# Likewise, we can add a different attribute, dimensions.
# This will effectively turns a vector into a matrix.
dim(X) <- c(2,3)
X

# Normally, we simply create a matrix using matrix() function. 
# First, the following code will create a 2 * 2 matrix with all elements being 1. 
X1 <- matrix(1, nrow = 2, ncol = 2)
# You can supply a vector
X2 <- matrix(c(1,2,3,4), nrow = 2, ncol = 2)
X3 <- matrix(c(1,2,3,4), nrow = 2, ncol = 2, byrow=T)
# Note that the vector is arranged by column (you can change this by 'byrow' argument
# in the matrix function)

# Add rownames and column names to a matrix
rownames(X1) <- c('a', 'b')
colnames(X1) <- c('A', 'B')

# Add a row to a matrix
newrow <- c(2,2)
X1_new <- rbind(X1, newrow)

# add a column to a matrix
newcol <- c(5,6)
X2_new <- cbind(X2, newcol)

# access elements of a matrix
X1[1,1] # 1st row, 1st col

# Matrix and scalar: element-wise operation
X1 + 1
X1 * 10
X1 - 1
X1 / 2

# Matrix and matrix: element-wise operation (if they have the same dimensions.) 
X1 + X2
X1 * X2
X1 - X2
X1 / X2

# Whenever we do matrix multiplication, we have to be careful about the dimensions. 
Y <- matrix(c(1,2,3,4,5,6), nrow = 2, ncol = 3)
Z <- matrix(c(10, 20, 30, 40, 50, 60), nrow = 3, ncol = 2)
W <- matrix(1:10, nrow = 2, ncol=5)

# You can check the dimension by dim()
dim(Y)
dim(Z)
dim(W)

# When you multiply matrices, use %*%, instead of *
# Remember that X %*% Y is possible only when the row length of X is the 
# same as the column length of Y

# This is possible :)
Y %*% Z

# This is impossible :( 
Y %*% W


# You can convert dataframe to matrix
df <- data.frame(x = c(1,2), y = c(3,4))
df_mat <- as.matrix(df)
class(df_mat)

# Or matrix to dataframe
X1_df <- as.data.frame(X1)
class(X1_df)


# You can do matrix multiplication with matrix but not with dataframe
# This returns error
df %*% X # error

# But this is possible 
df_mat %*% X


# Note that * does element-wise multiplication while %*% does matrix multiplication 
X2 * X2
X2 %*% X2


# You can transpose and invert matrices 
# This will transpose the matrix
t(Y)
# This will invert the matrix
solve(X2)
# This will return error because Y is not a square matrix 
solve(Y) # error

# Exercise --------------------------------------------------------------------

# Q1. Create a matrix object 'A' with 4 rows and 3 columns, filled with numbers 1...12 by rows.
# i.e. A[1,1] should be 1, A[1,2] should be 2, and A[1,3] should be 3.

# Q2. Create a matrix object 'B' with 3 rows and 4 columns, filled with numbers 1,3,5,7,9,...23 by columns.
# i.e. B[1,1] = 1, B[2,1] = 3, B[3,1] = 5, B[2,1] = 7 ...

# Q3. What is the 3rd row, 3rd column element of the matrix B?

# Q4. Compute a matrix multiplication of A times B and assign the result to a matrix object 'D'

# Q5. Compute a matrix multiplication of D and the transpose of D 


















