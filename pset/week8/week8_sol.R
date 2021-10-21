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
myvar <- function(x){
  x_bar <- mean(x)
  n <- length(x)
  return(1/(n-1)*sum((x - x_bar)^2))
}

cat('my function: ', myvar(my_dataframe$x), ' ', myvar(my_dataframe$y), ' ', myvar(my_dataframe$z), '\n')
cat('var(): ', var(my_dataframe$x), ' ', var(my_dataframe$y), ' ', var(my_dataframe$z), '\n')

# 2. Create a function to compute x^2 + y^2 + z^2, and apply the function
# for each row of the dataframe, my_dataframe.
# Save the result in a new column, 'result2'.
# Hint: 'for' loop
my_func2 <- function(x, y, z){
  return(x^2 + y^2 + z^2)
}

my_dataframe$result2 <- rep(0, 100)
for (i in seq(1, nrow(my_dataframe))){
  my_dataframe$result2[i] <- my_func2(my_dataframe$x[i], my_dataframe$y[i], my_dataframe$z[i]) 
}


# 3. Create the following function.
# It takes three arguments, x, y, z. 
# if y is less than 0.5, it returns x + z 
# otherwise, it returns x - z 
# Apply this function on my_dataframe for each row.
# Save the result in a new column, 'result3'
# Hint: if-else
my_func3 <- function(x, y, z){
  if (y < 0.5){
    return(x + z)
  }else{
    return(x - z)
  }
}

my_dataframe$result3 <- rep(0, 100)
for (i in seq(1, nrow(my_dataframe))){
  my_dataframe$result3[i] <- my_func3(my_dataframe$x[i], my_dataframe$y[i], my_dataframe$z[i]) 
}



# Array --------------------------------------------------------------
# The following code generate a hypothetical data
survey_data <- data.frame(vote=sample(c(0,1), 1000, T),
                          gender=sample(c('male', 'not-male'), 1000, T),
                          race=sample(c('white', 'not-white'), 1000, T))
survey_data$educ <- sample(c('college', 'not-college'), 1000, T)


# 1. Going back to the original problem, can we express the summary of the survey data using a 3D array? 
# What is the dimension of this array? (i.e. what is "dim" argument?)

out <- array(0, dim=c(2,2,2), dimnames=list(c('white', 'not-white'), c('male', 'not-male'), c('college', 'not-college')))
for (race in c('white', 'not-white')){
  for (gender in c('male', 'not-male')){
    for (educ in c('college', 'not-college')){
      out[race, gender, educ] <- sum(survey_data$vote[survey_data$gender == gender & survey_data$race == race & survey_data$educ == educ])
    }
  }
}


# 2. Using the array, obtain the number of white male without college eduation who voted. 
out['white', 'male', 'not-college']

# 3. Using the array, obtain the number of male who voted (regardless of education level and race). 
sum(out[,'male',])

# 4. Using the original data (survey_data), make sure that your answers to Q2 and Q3 are correct.
sum(survey_data$vote[survey_data$gender == 'male' & survey_data$race == 'white' & survey_data$educ == 'not-college'])
sum(survey_data$vote[survey_data$gender == 'male'])

