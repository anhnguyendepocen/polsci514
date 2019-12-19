##################################################
## POLSCI514 week3
## Introduction to R 
## Date: 2019/9/20
## Author: Saki Kuzushima
##################################################

# Note that this code heavily relies on a text book, 
# Imai 2017 'Quantitative Social Science', Chap 2. 

# Table of contents

# (0) Logistics

# (1) Read and Write data
# (2) Get information of the data.frame
# (3) Access elements of the data.frame
# (4) Subset data.frames
# (5) Packages
# (6) Exercise: Analyze data


# (0) Logistics ------------------------------------------------------------------------------------

# - Office Hour: 3:00-5:00pm, Wed

# Resources
# - Writing LaTeX locallly (not using Overleaf): TexStudio
# - CAP LAB GSI: Fabricio and Thomas (see syllabus)
# - R resources: Data camp (https://www.datacamp.com/home)


# Review ----------------------------------------------------------------------------------

# (1) Assign the result of 10 divided by 2 to an object "x".
# e.g.
x <- 10 / 2

# (2) Check the class of the object "x".
class(x)

# (3) Create a logical vector of length 3, whose element is (TRUE, TRUE, FALSE), and assign it
# to an object "y".

y <- c(TRUE, TRUE, FALSE)

# (4) Print out the first element of "y".
y[1]

# (5) Create a numeric vector of length 5, whose element is (1, 2, 3, 4, 5), and assign it to 
# an object "z"
z <- c(1, 2, 3, 4, 5)

z <- seq(from=1, to=100, by=1)


# (6) What is the result of the following code? Explain what is going on. 
a <- c(120, 130, 150, 112)
a <= 125



# (7) What is the result of the following code? Explain what is going on. 
# ("y" is defined by question 3. )
mean(y)

# (8) What is the result of the follwoing code? Explain what is going on. 
# ("y" is defined by question 3. )
y2 <- c(FALSE, FALSE, TRUE)

y & y2
y | y2



# (1) Read and Write data -------------------------------------------------------------------

# So far, we manually input data. However, we usually want to work with some external datasets. 
# There are many formats in data files, such as .xlsx, .csv, .dta, .txt
# Today, I introduce how to read and write .csv file, which is the most common file format among R users.
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

# If so, it is very likely that you misspecified "path", the unique 
# address of the file in the computer. 
# Path specifies the unique location of all files in the computer. 
# it has a form like 
# (Mac) "/Users/Umich/class514/your_file" or
# (Windows) "C:Umich/class514/data/your_file.csv"
# For more information about the path, See "what_are_file_paths.txt" file.

# The easiest way to avoid the problem about path is to place 
# the data files in the same place as your "working directory".
# working directory is literally the place you are working at currently. 
# You can check your current working direcotry by getwd()
getwd()
# If the working directory is not in the place you want, you change by  
# "Session > Set Working Directory > To Source File Location" 
# (or, you can use setwd("path-to-the-directory-you-want-to-use"))
# Once your data is located in the same place as your working directly, 
# you can use the short name of the files (e.g. Wolrd.csv) for read.csv()

# check working directory
getwd()

# change working directory 
setwd("~/Google Drive/academic/GSI/POLSCI514/week3")

# After placing "World.csv" to the same place as the working directory, 
world <- read.csv("data/World.csv")


# If the data file is not placed in the same directory as your working directory,
# you have to specify the correct path of the file to use read.csv().
# There are two ways of specifying the correct path:
# absolute path and relative path. 

# Absolute path specifies the full path startring from the "root" of the file structure
absolute_path <- "/Users/sakikuzushima/Google Drive/academic/GSI/POLSCI514/week3/data//World.csv"
# Usuaully, this tends to be long. So it is often more convenient to use relative path.

# Relative path specifies the path, relative to your working directory.
# If you have a directory called "data" inside your working directory, 
# and a file "World.csv" is inside the "data" directory. 
# You can write the relative path to the "World.csv" as 

relative_path <- "./data/World.csv" # or, "data/World.csv"
world <- read.csv(relative_path)

# For more information about relative and absolute path, the following links are useful
# Mac: 
# https://www.geeksforgeeks.org/absolute-relative-pathnames-unix/
# https://www.youtube.com/watch?v=ephId3mYu9o

# Windows: 
# https://docs.microsoft.com/en-us/dotnet/standard/io/file-path-formats
# https://en.wikipedia.org/wiki/Path_(computing)#MS-DOS/Microsoft_Windows_style

# Note that 
read.csv("data/World.csv")
# only loads the data, but it only prints out the loaded data, and did not create any object. 
# You have to assign the data to an object in order to play with it.
# In the following line, we first load the data file, and then assigned them 
# to the object called "my_data"
my_data <- read.csv("data/World.csv")

# Finally, the following code converts the "my_data" object to a csv file. 
write.csv(my_data, "my_world.csv")


# Tips: No more error in read.csv()! +++++++++++++++++++++++++++++++++++

# Misspecified path is one of the most common erorr in programming. 
# To avoid this, there are a couple of tips

# - Use the location of the .R file (e.g. ps514_week2.R) as the working directory.
#   You can do this by "Session > Set Working Directory > To Source File Location" 
# - Place the data file in the same place as the working directory.
#   (This is the easiest option, but your working directory can get messy.)
# - Create a directory (folder) called something like "data" in the same place
#   as the location of your .R file. Then use read.csv("data/some_data.csv")
# - By the time you have more code adn data files, you might need to structure them
#   in a more organized way. 

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# (2) Get information of the data.frame ------------------------------------------------------- 

# After you create an object "world" by "read.csv()", 
# you can inspect the feature of the object. 

# The object create by "read.csv()" has class "data.frame"
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

# head() to print out the first 6 rows, tail() the last 6 rows
head(world)
tail(world)



# Tips: quickly inspect data +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# There are a couple of steps I usually follow when I read data 
# This enables you to inspect the data quickly before moving on to the actual analysis

world <- read.csv("data/World.csv") # read data
colnames(world) # check what variables are in the data
head(world) # inspect the first 5 rows of the data
summary(world) # get a brief summary of the data
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



# (3) Access elements of the data.frame --------------------------------------------------------

# Next, you want to access the elements of the data.frame. 
# you can use indexing "[]" to do this. 
# You can either provide the number of row/columns or the names of them. 

# For example, to get the 1st row of the 1st column 
world[1,5] # [row, column]. Order matters! 

world[1,"deaths"] # You can supply the name of the row/column instead of the numbers

# You can access multiple elements as well using vectors
world[c(1,2,3), c(1,2,3)]
world[c(1,2,3), c("country", "period", "age")]

# Instead of each element, You may want to access each row/column of the dataframe. 
# To access each column of the data.frame, use $ operator.
world$deaths

# You can use indexing, and you have to leave the row blank if you want columns. 
world[,"deaths"] #deaths column
world[1,] # 1st row 

# To access "deaths" column of the "world" data, all of them work in the same way
world$deaths
world[,"deaths"]
world[,5]


# (4) Subset dataframes ----------------------------------------------------------------------

# Subsetting dataframe is one of the most common code we write in the research because we
# usually use only a subset of the datasets. You can achieve this by indexing and "$" operator. 
# However, indexing is sometimes not very useful. For instance, 
# using world data, how to get data where age is 0-4? You can specify the corresponding row numbers 
# (1st and 16th row), but what if the data has too long rows? Or, what if the data is not ordered by age? 
world[c(1,16), "age"]
world[c(1,16),]

# Using logical vector is a good solution.
age04 <- world$age == "0-4" 


# age04 is a logical vector, and its element is T if "age" is "0-4", F otherwise.
# Then, you can use the logical vector age04 to subset the data. 
world[age04,]
# This returns rows whose value in "age" is "0-4".

# Or equivalently, you can write in this way
world[world$age == "0-4",]

# this is same as
age04 <- world$age == "0-4" 
world[age04,]

# Or, you can use subset() function
subset(world, world$age == "0-4")
subset(world, age04)
# The first argument is the dataframe, and the second argument is the logical vector, 
# indicating which rows to keep. 


# Q. Get the subset of the data where "age" is 70-79.
age7079 <- world$age == "70-79"
world[age7079,]

# Q. Get the subset of the data where "period" is 1950-1955


# Q. Get the subset of the data where "period" is 2005-2010 and "age" is 70-79.




# (5) Packages -------------------------------------------------------------------------------------

# Like other open source programming languages, R has many packages. 
# Packages are sets of pre-defined functions created by other users. 
# For instance, suppose you want to use data created by STATA. The data file 
# has format .dta, and you cannot use read.csv() for .dta

# You have to install the package if you haven't done before 
install.packages("foreign")
# Attach the package to use 
library(foreign)

# Now you can read .dta using read.dta() function
world_new <- read.dta("World.dta")

# You can save as .dta using write.dta()
write.dta(world_new, 'my_world.dta')



# (6) Exercise: Analyze data ---------------------------------------------------------------------------------

# Let's analyze the rael data using problem set 2
# Note that this quesiton is taken from Imai (2017).

# First, read the question and understand the variables...

# Let's load the data again to make sure that the dataset is laoded
world <- read.csv("data/World.csv")

# Check what kind of variables are in the dataset
colnames(world)

# Check first 6 observations
head(world)

# Get the summary statistics of the data
summary(world)


