##################################################
## POLSCI514 week12
## Introduction to R 
## Date: 2019/11/22
## Author: Saki Kuzushima
##################################################

# (0) Logistics
#- no hw this week, but do review tidyverse (resources in the bottom of this code)

# Table of contents
# 1. 599 helper
# 2. ggplot



# 1. 599 pset 10 helper (Q5) - Obtaining difference in means
dat <- read.csv('data/leaders.csv')


unique(dat$result)


# create a binary variable that indicate "big success" of assassination
# I define "big success" as the case where leaders dies  within a day after the attack.
dat$big_success <- ifelse(dat$result == "dies within a day after the attack", 1, 0)

bigs <- subset(dat, dat$big_success == 1)  # treatment group
no_bigs <- subset(dat, dat$big_success == 0) # control group


# Differnece in means (estimator of the causal effect of assassination on civil war)
mean(bigs$civilwarafter) - mean(no_bigs$civilwarafter)
# The average treatment effect of "big success" in assassination on the occurence of civil war is -0.03
# i.e. (the conflict is less likely to occur when the assassination is "big success")

# sample variance of each term
var(bigs$civilwarafter) # treatment 
var(no_bigs$civilwarafter) # control
# note that var() function compute sample variane - it is an unbiased estimator.
# From documnatation
# "The denominator n - 1 is used which gives an unbiased estimator of the
# (co)variance for i.i.d. observation" 



# Simulate the occurence of civil war. 

# Suppose the X | Z ~ Bernoulli(p) where p can be estimated by the two means we use in the
# difference in means. 
pt <- mean(bigs$civilwarafter) # treatment
pc <- mean(no_bigs$civilwarafter) # control

# simulate the occurence of civil war 
rbinom(n = 100, size = 1, prob = pt)
rbinom(n = 100, size = 1, prob = pc)

#(note that this is not the exact answers but those codes are helpful...)


# 2. dplyr (cont.) ---------------------------------------------------------------------

library(nycflights13)

# So far we have learned several useful functions in dplyr

# Let's review some functions in dplyr. We have learned

filter() # pick observations by values
arrange() # reorder the rows by some variables
select() # pick variables by their names
mutate() # create a new variable with existing variables
summarise() # collapses many values into a single summary


# Let's quickly go through the last exercise. 

# Exercise (mutate)
# Currently dep_time and sched_dep_time are convenient to look at, but hard to compute with
# because they’re not really continuous numbers. 
# Convert them to a more convenient representation of number of minutes since midnight.
# e.g. 515 in sched_dep_time means 5:15am. We want to convert this into 5*60 + 15 = 315 (min from 0:00am).

# hint
1234 %/% 100 # integer part of division
1234 %% 100 # remainder part of division


# We can convert 12:34pm into minites this way 
(1234 %/% 100) * 60 + (1234 %% 100)
# (1234 %/% 100) return 12 as the integer part of the division (the first two digits) 
# (1234 %% 10) returns 34 as the remainder part of the division (last two digits)

# add the minutes variables using mutate
new_flights <- mutate(flights, 
                      dep_time_min=(dep_time %/% 100) * 60 + (dep_time %% 100),
                      sched_dep_time_min=(sched_dep_time %/% 100) * 60 + (sched_dep_time %% 100)) %>%
  select(dep_time_min, sched_dep_time_min)



# One thing I want to highlight is to assign the result of dplyr computation with an object.

# For instance, this codedoes not modify the object, flights, itself
flights %>% arrange(arr_delay)
flights
# If you want to save the modification you made, 
flights_ordered <- flights %>% # assign to new object
  arrange(arr_delay)
flights_ordered

# no pipe
flights_ordered <- arrange(flights, arr_delay)

# If you want to make a modiifcation to the original dataset itself 
flights_ordered <- flights_ordered %>% # assign to same object
  arrange(dep_delay)
flights_ordered




# (cont. from last week) summarise


# Summarise() create a summary statistics of some columns 
# for instance, mean departure delay time
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))
# na.rm = T removes NA values when computing the mean

# summarise is useful particularly when it is with group_by() function. 
# It changes the scope of the data on which mean is computed. 
# When you provide a variable name to group_by function, 
# group_by() will internally split the data, and summarise() will
# compute the mean within each group. 
# Like arrange(), group_by() will use the second and later variables to break ties. 


# You can connect the line by pipe
group_by(flights, year, month, day) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE))
# or
flights %>%
  group_by(year, month, day) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE)) 



# and you can save the result in some object
delays <- flights %>%
  group_by(year, month, day) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE)) 

delays
# comment: I found this template find it the most useful in general :) 



# Of course, you can use other functions than mean
# A useful function that is specific to dplyr is n() - the number of rows of each group
delays <- flights %>%
  group_by(year, month, day) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE),
            count = n(),
            var_delay = var(dep_delay, na.rm = TRUE))

delays

# base equivalent ~~~~~~~~~~~~~~~~~~~~~~~~~`
delay_base <- tapply(flights$dep_delay, list(flights$year, flights$month, flights$day), mean, na.rm = T)
class(delay_base) # array - first dim: year, second dim: month, third dim: day
delay_base[1,,] # first year (2013) (row = months, column = day)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`

# Exercsie: Compute the average arrival delay time for each carrier, 
# and sort by the carrir with the largest arrival delay. Which carrier has the largest arrival delay on average? 
# (Use 'airlines' to see the full names of carriers)
airlines





# 2. ggplot ----------------------------------------------------------------------


# (This section relies on chapter 3 of R for data science. https://r4ds.had.co.nz/data-visualisation.html)

# ggplot2 is another code member of tidyverse, as well as dplyr. 
# ggplor2 allows you to create beautiful figures and graphs easily. 
#(I personally prefer ggplot when I make complicated graphs with many layers 
# and colors but I prefer base R when I create simple graphs and "quick and dirty" figures. )



#In today's lecture, I will introduce some basic usage of ggplot2.
# Because there are numerous features in ggplot, I cannot cover everything. 
# Once you familiarize yourself with the basic, please refer to the book or other online resources for specific features.
# A cheat sheet for ggplot (provided by R studio) may be helpful:
# https://rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf

# We will use mpg data 
mpg
?mpg # for description of data 

# example ggplot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) 
# this shows a negative relationship bwtween engine size (displ) and fuel efficiency (hwy)

# In ggplot, you begin with "ggplot()" function. It creates a coordinate systmes on which 
# you can add layers of plots. (Note that ggplot() only creates a coordinates. It does not
# create any plots by itself!)

# After ggplot(), you use geom_XXXX functions. FOr instance, the above example uses geom_point()
# which craetes a layer of points on your plot - a scatterplot. ggplot2 has many geom_XXXX function, 
# and we will go through some of them later. 

# Each geom function takes a "mapping" argument, and it is always paird with "aes"
# x and y argument in "aes" specifies which variables to map to the x and y axis. 
# In ggplot2, like dplyr, you don't have to specify the data frame because it 'knows' that
# you are using a paritcular dataset already (specified in ggplot function).



# The template for ggplot
# NOT RUN
ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

# <DATA>: data frame or tibble like object
# <GEOM_FUNCTION>: ggplot2 has several functions that starts with "geom." 


# (1) Aesthetic mapping
# Let's go through some of the features in "aes". There are many methods
# to control and customize the color, size and other "aesthetic" aspect of the plots. 

# Changing the color of points
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
# This add color to points, and the color depends on the "class" varibale of mpg data.
# c.f. customize color: http://www.sthda.com/english/wiki/ggplot2-colors-how-to-change-colors-automatically-and-manually


# Or, you can change the color of the entire points
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color="blue")
# Note that the "color" argument is supplied to geom_point(), not aes().

# Changing the size of points 
ggplot(data=mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
# This...may not look great in this case. 

# Change the transparency of the points
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# Change the shpae of the points
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
# Or, you can change the shape of points for all points
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), shape=4)

# ggplot only use 6 shapes, so the last group (SUV) is omitted. 
# For the list of shapes we can use : https://r4ds.had.co.nz/data-visualisation.html#fig:shapes
# c.f. This page summarise differenct specification of aes mapping https://ggplot2.tidyverse.org/articles/ggplot2-specs.html


# Warnings! :  location of + 
# It has to come at the end of the line, not the start. 
# For instance, this does not work
ggplot(data = mpg) +
 geom_point(mapping = aes(x = displ, y = hwy))

# Also, ggplot has a numerous features and I cannot cover all of them. Please refer to the book, R for data science,
# or use Google because someone else must have encountered the same problem before! There are tons of good online resources about gglpot. 




# (2) geom function

# I will illustrate the usage of dplyr + ggplot using the problem set 5 data (polls in 2016)
polls <- read.csv('data/polls2016.csv')


# create a data frame that contain all the relevant information
# this data frame has one row for each state, and columns are
# the average support rates (%) of Clinton and Trump in each state
# and the number of electoral votes for each state
# and state name # (The question asks you to use 3 most recent data only. To do this
# you can use top_n() function. )

t1 <- polls %>%
  group_by(state) %>%
  summarise(mean_cl = mean(Clinton),
            mean_tr = mean(Trump),
            ev = mean(electoral_votes))


# scatter plot
ggplot(t1) + 
  geom_point(aes(x = mean_cl, y = mean_tr))

# connect by  line (not helpful in this case)
ggplot(t1) + 
  geom_line(aes(x = mean_cl, y = mean_tr))

# But if we plot the time trend, connecting dots may make sense

# We can plot the time trend of the support for Trump and Clinton
ggplot(polls) + 
  geom_line(aes(x=days_to_election, y=Trump), color = 'red') +  # I use "minus" to switch the direction of x axis
  geom_line(aes(x=days_to_election, y=Clinton), color = 'blue') + 
  ylab("support") + xlab('days to election') +
  scale_x_reverse()


scale_x_maunal()
scale_x_discrete()
scale_x_continuous()

# I do not assign any hw this week, because I didn't find any problem sets in QSS book 
# that talks about the content I covered today. (dplyr and ggplot).
# However, I strongly encourage you to review the materials
# for dplyr and ggplot, particularly in r4ds book. 

# The most relevant chapters in the r4ds book are:
# Chapter 5: data transformation
# Chapter 3: data visualization

# Also I listed up several resources below. They will be helpful to learn tidyverse. 

# Resources: 

# Data camp has several courses in ggplot and dplyr
# For instane https://www.datacamp.com/courses/introduction-to-data-visualization-with-ggplot2
# and https://www.datacamp.com/courses/data-manipulation-with-dplyr-in-r
# r4ds: https://r4ds.had.co.nz/
# For specific usage of ggplot, I find the official website the most helpful
# https://ggplot2.tidyverse.org/index.html


