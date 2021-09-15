##################################################
## POLSCI514: Objects and Data structure  
##################################################

# Main topics: vector, dataframe 


# Arithmetic operations ----------------------------------------------------

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

# Objects ------------------------------------------------------------------

# You can store values in "objects"
# To assign a value to an object, use "<-" ("=" works but we usually use "<-")

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
# words with "_" or "."

my_object <- 1
my.object <- 1

# Objects can contain many types of values. For instance,
# You can store numbers such as 1, 2, 0.4, 10000, or characters such as 
# "apple" or "statistics" and more.

# I will introduce the three most common types 

#  character
obj <- "book"
typeof(obj)

#  double (numeric) 
obj <- 5
typeof(obj)

#  logical 
obj <- TRUE  # All capital
obj <- FALSE
typeof(obj)

# Or, You can simply write
obj <- T # TRUE
obj <- F # FALSE

# More operators -----------------------------------------------------------

# +, -, /, * are called operators
# Here we introduce more operators often used.

# (a) logical operators
obj_t <- T
obj_f <- F

# and
obj_t & obj_t # (TRUE and TRUE) is TRUE
obj_t & obj_f # (TRUE and FALSE) is FALSE
obj_f & obj_f # (FALSE and FALSE) is FALSE

# or
obj_t | obj_t # (TRUE or TRUE) is TRUE
obj_t | obj_f # (TRUE or FALSE) is TRUE
obj_f | obj_f # (FALSE or FALSE) is FALSE

# (b) relational operators
x <- 10
y <- 3
z <- 3

# larger than (or equal to)
x > y
y >= z

# smaller than (or equal to)
x < y
y <= z

# equality 
y == 3
y != 3

# This operators are important when you want to have complicated subset of data. 

# Mini quiz: More and and or  -----------------------------------------------------
# 1. True or False? (Why?)

a <- TRUE
b <- FALSE

a & b
(a & b) != TRUE
(a & b) & (a | b) 
(a & b) | (a | b) 



# Vectors ---------------------------------------------------------------------

# For a data to be a data, it has to have more than one observation. 
# How to store data? One simple way to do this is Vector

# c() creates a vector, and each element is split by ","
# ('c' stands for concatnate)

# The types of the elements of (atomic) vectors must be the same
# (c.f. Later we learn vectors with different types (This is called List)).

lgl_var <- c(TRUE, FALSE)
dbl_var <- c(1, 2.5, 4.5)
chr_var <- c("these is", "something")

score <- c(90, 89, 87, 67, 75, 50, 88, 89)
score

# You can combine vector using c()
score_first <- c(90, 89)
score_second <- c(50, 82)
score_combined <- c(score_first, score_second)

# Check the length of a vector by 'length()'
length(score_first)

# You can assign name to each element of the vector
my_vector <- c(10, 20, 30)
names(my_vector) <- c("a", "b", "c")
my_vector

# If you use arithmetic operators to vector,
# it will be applied to each element of the vector 
score / 10
score + 100

# use logical operators on vectors
my_vector == 15

# use relational operators on vectors
my_vector > 15

# Subsetting vectors ----------------------------------------------------------

# subset by index
score[1]
score[c(1,2)]
score[-1] # exclude

# subset by name
my_vector['a']
my_vector[c('a', 'b')]

# subset by the values
my_vector[my_vector > 15]

select <- my_vector > 15
my_vector[select]
subset(my_vector, subset=my_vector > 15)

# Functions --------------------------------------------------------------------

# Functions take some input and resutn some output. Inputs are often called arguments. 
# We have seen some functions, such as length() and sqrt()
# (In fact, + - / * can also be seen as functions!)

score <- c(90, 20, 83, 45, 28, 89)

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

# Tips: Sepcify argument name 
# When you are new to some functions, it is better to specify the name of the argumnet
# although it is not neccesary for the code to work properly, but this prevents mistakes

seq(0, 100, 10) # this works, but
seq(from = 0, to = 100, by = 10) # is clearer and easy to understand

# You can define your own functions, and I will cover it later.

#  Quiz: ----------------------------------------------------------------------

# Suppose you are a GSI and the following is the score of the students
score <- c(90, 89, 38, 28, 82, 72, 63, 12, 5, 64)
names(score) <- c('tom', 'james', 'mary', 'john', 'sarah', 'david', 'lisa', 'chris', 'mitchell', 'eric')

# How many students are in your class?

# What is the mean (average) score?

# What is the highest and the lowest score?

# What is the score of Sarah?

# Who received scores higher than 50? 

# How many students receive scores higher than the mean? 

# Who received the higest and the lowest score?

# Mary's score was recorded incorrectly and it was 83. 
# Create a new vector 'correct_score' with the correct values.


# Dataframe ------------------------------------------------------------------

# Vectors can be considered as one variable (e.g. age, gender, etc...)
# We usually want to use multiple variables. 
# An object with class "data.frame" can contain multiple vectors.

world <- data.frame(country=c('USA', 'CHN', 'IND', 'RUS'),
                    pop=c(382, 1398, 1366, 144),
                    area=c(3.797, 3.705, 1.269, 6.612))

class(world)

# Class "Data.frame" is the most common class to deal with table-style data. 
# It is a collection of vectors, but you can consider it as a spreadsheet.
# You can view the data by "Environment > click the object" on Rstudio
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

# head() to print out the first 6 rows, tail() the last 6 rows
head(world)
tail(world)

# adding a new column
world$gdp <- c(21.43, 14.34, 2.89, 1.7)

# Subsetting data frame---------------------------------------------------------

# 1. select columns

# by '$' 
world$country
world$pop
world$area

# by  column number
world[,1]
world[,c(1,2)]

# or use column name
world[, "country"] # make sure to put ,
world[,c("country", "pop")]


# 2. select rows

# by row number
world[1,] 

# by the values 
world[world$country == "USA",]
world[world$pop > 1000,]

# 3. select rows and columns

world[1,2]
world[1, world$country == "USA"]

#Alternatively, subset()
subset(world, world$country == "USA")
subset(world, world$country == "USA", select=pop)



# Quiz: More subset -----------------------------------------------------------

score_data <- data.frame(names=c('tom', 'james', 'mary', 'john', 'sarah', 'david', 'lisa', 'chris', 'mitchell', 'eric'),
                         group=c(1,2,3,1,2,3,1,2,3,1),
                         hw1=c(90, 89, 83, 28, 82, 72, 63, 12, 5, 64),
                         hw2=c(82, 43, 98, 42, 57, 94, 11, 43, 42, 54))

# extract the columns for hw1 and hw2

# extract the row for John's entry

# extract Sarah's score for the hw2

# add a new column for the average score of hw1 and hw2. 
# set the column name for this column to be 'hw_mean'

# who received the highest score in the hw1 and the hw2? 
# who received the higest score on average?

# extract the rows for group 1 

# compute the average score of hw2 for each group (1,2,3) 

# add a new column for the difference between hw1 and hw2.    
# Who received higher score in hw2 than hw1? 

# (*) there is an additional student 'paul' in the class. 
# He is in the group 2 and his score for hw1 was 80 and hw2 was 75. 
# Add a row for paul's entry. 

# (*) sort the rows so that the names are in alphabetical order
