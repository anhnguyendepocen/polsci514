##################################################
## POLSCI514 week2
## Introduction to R 
## Date: 2019/9/13
## Author: Saki Kuzushima
##################################################

# Note that this code heavily relies on a text book, 
# Imai 2017 'Quantitative Social Science', Chap 1. 

# Table of contents

# (0) Logistics

# (1) Arithmetic operations
# (2) Objects
# (3) Vectors
# (4) Functions
# (5) Read and Write data
# (6) Packages

# (0) Logistics ------------------------------------------------------------------------------------

# - Office Hour: 3:00-5:00pm, Wed
# - Writing LaTeX locallly (not using Overleaf): TexStudio
# - R resources: Data camp (https://www.datacamp.com/home)


# (1) Arithmetic operations --------------------------------------------------------------------------

3 + 5

# space does not matter
3 - 5
3-5

3 * 5

3 / 5

# both ** and ^ mean the power
3**2
3^2

# square root
sqrt(9)
# note: something() is called a function (explained in later weeks)

# use () to change the order of computation as we do in hand writing 
1 + 2 / 3
(1 + 2) / 3



# (2) Objects ---------------------------------------------------------------------------------------

# You can store values in a storage called "objects"
# To assign a value to an object, use "<-" ("=" works but we usually use "<-")
# (If you are curious why we use <- instead of =, 
# this blog post is interesting: https://colinfay.me/r-assignment/)
result <- 3

# you can print out the value stored in the object
result

# explicitly print out the value stored in the object
print(result)

# you cannot print out an object that is not created
nothing

# There are some rules for naming the object. 
# An object name cannot start with numbers
0object <- 1

# An object name cannot have spaces 
obj ct <- 1

# If you want to make a longer name, a recommended way is to connect
# words with "_" (By the way, this way of connection is called "snake" style)
my_object <- 1


# Objects can have many types of values. For instance,
# You can store numbers such as 1, 2, 0.4, 10000, or characters such as 
# "apple" or "statistics" and more!

# I will introduce the three most common classes 

# (i) character
obj <- "book"
# class() to check the class of an object
class(obj)

# (ii) numeric
obj <- 5
class(obj)

# (iii) logical 
obj <- TRUE  # All capital
obj <- FALSE
class(obj)

# Or, You can simply write
obj <- T # TRUE
obj <- F # FALSE


# Now that we learned logical classes, 
# Let me introduce two additional types of operators.
# They both return TRUE or FALSE

# (a) logical operators
# THe first is logical operators: & and | 
# & means "and", | means "or"
first_obj <- T
second_obj <- F

first_obj & first_obj # (TRUE and TRUE) is TRUE
first_obj & second_obj # (TRUE and FALSE) is FALSE
second_obj & second_obj # (FALSE and FALSE) is FALSE


first_obj | first_obj # (TRUE or TRUE) is TRUE
first_obj | second_obj # (TRUE or FALSE) is TRUE
second_obj | second_obj # (FALSE or FALSE) is FALSE


# (b) relational operators
# Another kind of operators is relational operators.
# Inequality can be expressed by < and >. greater than is <, less than is >
# If you want to add equality, they become >= and <=
x <- 10
y <- 3
z <- 3

x > y
y >= z

x < y
y <= z


# Equality is "==" and Not-equal is "!="
x <- 3
x == 3
x != 3

# Question
# True or False? 

(first_obj & second_obj) == TRUE

(first_obj & second_obj) & (first_obj | second_obj) 


# (3) Vectors ------------------------------------------

# For a data to be a data, it has to have more than one observation. 
# How to store data? One simple way to do this is Vector

# c() creates a vector, and each element is split by ","
# (c stands for concatnate)
score <- c(90, 89, 87, 67, 75, 50, 88, 89)
score

# You can combine vector using c()
score_first <- c(90, 89)
score_second <- c(50, 82)
score_combined <- c(score_first, score_second)

# use [] (indexing) to access each element of the vector
score[1]

# same for the 2nd, 3rd...element
score[2]
score[3]

# You can also access multiple elements 
score[c(1,2)]

# Use "-" in the [] to exclude elements
score[-1]

# If you use arithmetic operators to vector, it will be applied to 
# all elements of the vector 
score / 10
score + 100


# You can assign name to each element of the vector
my_vector <- c(10, 20, 30)
names(my_vector) <- c("a", "b", "c")
my_vector

# You can make a vector of logical values too
z <- c(T, T, T, F, F)

# You can compute the proportion of TRUE in a logical vector
mean(z)

# and the count of TRUE
sum(z)

# You can use logical operators to vectors 
# How about this? 
TF1 <- c(T, F)
TF2 <- c(T, T)
TF1 & TF2

# How about this...? 
TF1 && TF2

# When applied to a vector, "&" does an element-wise comparison, 
# such that the result is also an vector
# In contrast, "&&" compares only the first elements
# (We do not usually use &&, but it is good to know)
TF3 <- c(F, F)
TF3 & TF1
TF3 && TF3

# You can use relational operators (>, <, <=, >=, ==, !=) to vectors, too
z <- c(1, 2, 3, 4, 5)
z > 2
z == 1
z != 3

# Question
(z > 2) + (z <= 2)


# (4) Functions -------------------------------------------------------------------------------

# Functions take some input and resutn some output. Inputs are often called arguments. 
# We have seen some functions, such as class() and sqrt()
# (In fact, + - / * can also be seen as functions!)
# Functions have a form foo(), and you can provide the arguments inside ()
# There are several useful functions

# length of the vector
length(score)

# minimum and maximum
min(score)
max(score)
range(score)

# mean (average)
mean(score)

# summation (total)
sum(score)

# sequence of values
seq(from = 0, to = 100, by = 10)
1:10 # when by = 1

# Use ?some_function for help
?seq

# Question
# Compute the mean without using mean() functions? 



# Tips: Sepcify argument name ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# When you are new to some functions, it is better to specify the name of the argumnet
# although it is not neccesary for the code to work properly, but this prevents mistakes

seq(0, 100, 10) # this works, but
seq(from = 0, to = 100, by = 10) # is clearer and easy to understand
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# You can define your own functions, but I will cover it later.


# (5) Read and Write data -------------------------------------------------------------------

# So far, we manually input data. However, we usually want to work with some datasets we have. 
# There are many format of datasets, such as .xlsx, .csv, .dta, .txt
# Today, I introduce how to read and write .csv file, which is the most common format among R users
# (.csv stands for comma spread values)

# read.csv() to read files
world <- read.csv("World.csv")

# Does not work? Do you see the following error? 

# 
#Error in file(file, "rt") : cannot open the connection
#In addition: Warning message:
#  In file(file, "rt") :
#  cannot open file 'World.csv': No such file or directory
# 

# If so, it is very likely that you misspecified "Path".
# Path is an address of each file and directory. It specifies the unique location of all files in the computer. 
# Because a computer stores files in a tree structure, it has a form like "parent/child/your_file.csv"
# For instance, (Mac) "/Users/sakikuzushima/academic/POLSCI514/Letter.txt" or
# (Windows) "C:\user\docs\Letter.txt"


# The easiest way to avoid the problem about path is to place 
# the data files you use in the same place as your "working directory".
# You can check your current working direcotry by getwd()
getwd()
# If the working directory is not in the place you want, you change by  
# "Session > Set Working Directory > To Source File Location" 
# (or, you can do setwd() with the path to the directory you want to use)

# Alternatively, you can specify the absolute or relative path of the file 
# Absolute path specifies the full path startring from the "root" of the file structure
# e.g. /Users/sakikuzushima/academic/POLSCI514/Letter.txt
# Relative path specifies the path relative to your working directory.
# If you have a directory called "data" inside your working directory, 
# you can read the file in directory "data", by
world <- read.csv("data/World.csv")


# Tips: No more error in read.csv()! +++++++++++++++++++++++++++++++++++

# Misspecified path is one of the most common erorr in programming. 
# To avoid this, there are a couple of tips

# - Use the location of the .R file (e.g. ps514_week2.R) as the working directory.
#   You can do this by "Session > Set Working Directory > To Source File Location" 
# - Place the data file in the same place as the working directory.
#   (This is the easiest option, but your working directory can get messy.)
# - Create a directory (folder) called something like "data" in the same place
#   as the location of your .R file. Then read.csv("data/some_data.csv")

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# When you read data using "read.csv()" it has a class "data.frame"
class(world)

# Class "Data.frame" is the most common class to deal with table-style data. 
# It is actually a collection of vectors, but you can consider it as a spreadsheet.
# You can view the data by "Environment > click the object"
# Alternatively, 
View(world)
# (Make sure to capitalize "V")
# if you have a gigantic data, this can take time. 

# There are several functions to inspect a data.frame object
names(world) 
colnames(world) # same as names()

# number of rows and columns
nrow(world)
ncol(world)

# dimension (both rows and columns)
dim(world)

# summarise
summary(world)

# head() to print out the first 5 rows, tail() the last 5 rows
head(world)
tail(world)

# To access each column of the data.frame, use $ operator.
world$births

# Alternatively, you can use indexing ([]). 
# some_data_frame[row, column] allows you to call specific rows and columns of the data
# You can either provide the number of row/columns or the names of them. 
world[1,1]

world[,"births"] # same as world$births
# leave it blank when you do not want to specify rows or columns

world[c(1,2,3), c(1,2,3)]
world[c(1,2,3), c("country", "period", "age")]


# Q. print out the 1st to the 10th row of the "deaths" column.
# If you can, try it in many ways.

# Tips: quickly inspect data +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# There are a couple of steps I usually follow when I read data 
# This enables you to inspect the data quickly before moving on to the actual analysis

world <- read.csv("World.csv") # read data
colnames(world) # check what variables are in the data
head(world) # inspect the first 5 rows of the data
summary(world) # get a brief summary of the data
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Subsetting dataframe is one of the most common code we write in the research. 
# However, indexing is sometimes not very useful. For instance, 
# in world data, how to get data where age is 0-4? You can specify the corresponding row numbers 
# (1 and 16), but what if the data has too long rows? Or, what if the data is not ordered by age? 

# Using logical vector is a good solution.
age04 <- world$age == "0-4"
world[age04,]

# Or equivalently,
world[world$age == "0-4",]



















# Sometimes, data contains missing data. In R, missing value is represented by "NA".
new_vector <- c(1, 2, 3, 4, 5, NA)

# Missing value creates many problems
mean(new_vector) # NA
# some functions can take an argument to exclude NA
?mean
mean(new_vector, na.rm = T)


# To save data in csv files, write()
write.csv(x=world, file="new_world.csv")

# (6) Packages -------------------------------------------------------------------------------------

# Like other open source programming languages, R has many packages. 
# Packages are sets of pre-defined functions created by other users. 
# For instance, suppose you want to use data created by STATA. The data file 
# has format .dta, and you cannot use read.csv() for .dta

# You have to install the package if you haven't done before 
install.packages("foregin")
# Attach the package to use 
library(foreign)

# Now you can read .dta using read.dta() function
world_new <- read.dta("World.dta")

# You can save as .dta using write.dta()
write.dta(world_new, 'my_world.dta')











