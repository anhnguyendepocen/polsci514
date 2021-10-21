##################################################
## POLSCI514 week8 problem set
## Name: 
##################################################


# Function  -------------------------------------------------------------------
# example dataframe
my_dataframe <- data.frame(x= rnorm(100),
                           y=runif(100),
                           z=rnorm(100))

# 1. Compute the variance of x, y, z respectively using your custom function.
# Compare the result with the pre-defined function, var()

# 2. Create a function to compute x^2 + y^2 + z^2, and apply the function
# for each row of the dataframe, my_dataframe.
# Save the result in a new column, 'result2'.
# Hint: 'for' loop

# 3. Create the following function.
# It takes three arguments, x, y, z. 
# if y is less than 0.5, it returns x + z 
# otherwise, it returns x - z 
# Apply this function on my_dataframe for each row.
# Save the result in a new column, 'result3'
# Hint: if-else

# Array --------------------------------------------------------------
# The following code generate a hypothetical data
survey_data <- data.frame(vote=sample(c(0,1), 1000, T),
                          gender=sample(c('male', 'not-male'), 1000, T),
                          race=sample(c('white', 'not-white'), 1000, T))
survey_data$educ <- sample(c('college', 'not-college'), 1000, T)


# 1. Going back to the original problem, can we express the summary of the survey data using a 3D array? 
# What is the dimension of this array? (i.e. what is "dim" argument?)

# 2. Using the array, obtain the number of white male without college eduation who voted. 

# 3. Using the array, obtain the number of male who voted (regardless of education level and race). 

# 4. Using the original data (survey_data), make sure that your answers to Q2 and Q3 are correct.

