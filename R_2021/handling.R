##################################################
## POLSCI514 week3
## Introduction to R 
## Date: 2019/9/20
## Author: Saki Kuzushima
##################################################

# Read and Write data -------------------------------------------------------------------

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




# Tips: quickly inspect data +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# There are a couple of steps I usually follow when I read data 
# This enables you to inspect the data quickly before moving on to the actual analysis

world <- read.csv("data/World.csv") # read data
colnames(world) # check what variables are in the data
head(world) # inspect the first 5 rows of the data
summary(world) # get a brief summary of the data
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




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


