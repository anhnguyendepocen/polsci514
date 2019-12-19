##################################################
## POLSCI514 week7
## Introduction to R 
## Date: 2019/10/18
## Author: Saki Kuzushima
##################################################



# Table of contents

# (0) Logistics
# - pset 3: due today

# (1) Review of the for loop
# (2) While loop
# (3) Conditionals (if else)
# (4) Nested Loop

# (1) Review of the for loop -------------------------------------

# For loop repeatedly condusts a task inside {} for each i 
# in a specified sequence in () 

# For loop has three key elements:
# (1) "for" 
# (2) iteration "(i in 1:10)"
# (3) task "{ some code here }"

# For instance, the following code print out sqrt(i) for each i
# in 1, 2, ... 10. 

for (i in 1:10){
  print(sqrt(i))
}

# This code flip a coin 10 times 
for (i in 1:10){
  print(sample(c('T', 'F'), 1))
}

# You can store the result in a vector

# storage
out <- c()
out <- rep(0, 10)

# for loop
for (i in 1:10){
  out[i] <- sqrt(i)
}

# result
out

out[5]

# Or, you can store the result in a matrix
# This code filp a coin 10 times, and record the number of head and tail.
# Repeat this process 100 times. 

# storage
out_mat <- matrix(0, nrow = 100, ncol = 2)

# for loop
for (i in 1:100){
  
  coin <- sample(c(1, 0), 10, replace = T)
  # sampling with replacement (because 10 > 2)
  # 1 is head; 0 is tail
  
  # the number of heads
  coin_head <- sum(coin)
  # the number of tails
  coin_tail <- 10 - coin_head
  
  out_mat[i, 1] <- coin_head
  out_mat[i, 2] <- coin_tail
  
}

# result
out_mat

hist(out_mat[,2])


# This structure -- storage + loop + output -- is a canonical way of using 
# loop in areal data analysis!

# Exercise: Using the code above, replace the coin flip with die rolling. 
# i.e. roll a die 10 times, and record the number of times each face shows up. 

# Hint: use the following codes
# This roll a die 3 times
die <- sample(1:6, 3, replace = T)

# This count the number of times 5 shows up. 
face5 <- sum(die == 5)

# storage
out_mat <- matrix(0, nrow=100, ncol=6)

# loop 
for (i in 1:100){
  
  # die rolling 
  die <- sample(1:6, 10, replace = T)
  
  
  for (j in 1:6){
    face <- sum(die == j)
    out_mat[i, j] <- face
  }
  
  # count
  face1 <- sum(die == 1)
  face2 <- sum(die == 2)
  face3 <- sum(die == 3)
  face4 <- sum(die == 4)
  face5 <- sum(die == 5)
  face6 <- sum(die == 6)
  
  # store the reuslt
  out_mat[i, 1] <- face1
  out_mat[i, 2] <- face2
  out_mat[i, 3] <- face3
  out_mat[i, 4] <- face4
  out_mat[i, 5] <- face5
  out_mat[i, 6] <- face6

}

# result
out_mat





# (2) While loop -------------------------------------------------

# For loop is great, but sometimes for loop cannot achieve the task we want. 
# Suppose you want to roll a die many times, until 6 appears. How to write such code? 

# You can write for loop and roll a die 100 times, but is it always guaranteed to 
# get 6 at least once? (what is the probability that no 6 shows up? -- at least not zero)
# Also, if 6 appears in the first throw, the rest of 99 trials
# are useless and waste of time. What should we do? 

# We can use while loop to write such code. 
# For loop loops over each i in a sequence of numbers (e.g. 1, 2, ..10).
# In contrast, while loop repeat the process until some specified condition
# is satisfied. i.e. the code in {} is executed only when the logical statement in ()
# is true. 

# See the example. 
x <- 2
while (x < 100){
  x <- x^2
  print(x)
}

# There are three iterations, so let's see what is going on one by one. 
# Before the loop, x = 2. 

# While loop can be 'read' as "While (some condition is TRUE) do (some task)"

# ~~~~~~~~~~~~~~~~~~~~~~ walk through ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# At the beginning, x is 2
# First, check if x < 100. This is TRUE because x = 2 < 100. The loop starts. 

# In the first iteration, x was squread, and it has become x = 4
# print out 4

# Check if x < 100. This is TRUE because x = 4 < 100. Loop continues. 
# In the second iteration, x was squared again, and x = 16.
# print out 16

# Check if x < 100. This is TRUE because x = 16 < 100. Loop continues. 
# In the third iteration, x was squared again, and x = 256. 
# print out 256

# Check if x < 100. THis is FALSE because x = 256 > 100.  Loop stops! 

# (Note that this kind of one-by-one examination (walk through) 
# is important when you  write and read codes with loops!)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# The rolling of a die until 6 shows up can be written like this.

# initialize an object to store the result 
# Wihout this (out != 6) returns error! 
out <- 0
# while loop
while (out != 6){
  # roll a die
  out <- sample(1:6, 1)
  # print the result
  print(out)
}


# While loop can be used to achieve the same tasks as for loop. 
# Counter is a helpful trick when we use while loop


# for loop to compute the square root from 1 to 10.
for (i in 1:10){
  print(sqrt(i))
}

# while loop 
i <- 1 # counter
while (i <= 10){  # be careful about the stopping condition! 
  print(sqrt(i))
  i <- i + 1 # increment the counter
}


# Exercise: -------------------------------------------------------
# The following two codes returns almost the same result, but
# something is wrong! What is wrong, and how to fix it? 

# Compute the log from 1 to 20
# for loop way
for (j in 1:20){
  print(log(j))
}

# while way
j <- 1
while(j < 20){
  print(log(j))
  j <- j + 1
}

# ---------------------------------------------------------------

# Be aware that while loop can easily cause infinite loop! 


# If you happen to cause infinite loop, don't panic.
# Just Press Esc in console, or press the red circle on the right top corner
# of the console 

# Infinite Loop
x <- 1
while(x < 10){
  print(x)
}


# Inifinite loop happned because the while condition is never satisfied because x is always 1. 
# When you write while loop, always check the loop stops at some point! 


# In short, in many cases, both for loop and while loop can do the exactly same task. 
# The choice depends on how easily you can write (and read) the code. 


# (3) Conditionals ----------------------------------------------

# We learned how to repeat code lines using for and while loops. 
# What if we want to have code lines that are or that
# are not executed depending on some condition? 
# If-Else conditionals can do this task. 

# the code between {} is executed only when the logical statement in
# parenthesis () (after if) is true 

# what happens if we change x to 9? 
x <- 9
y <- 1
if (x > 10){
  y <- x*2
}
y


# code in the {} after "else" is executed when the logical statement in 
# () is false. 
x <- 20
y <- 2
if (x > 10){
  y <- y*3
}else{
  y <- y*10
}
y

# Exercise: Guess the result without running the code
x <- 10
y <- 2
if (x < 5){
  y <- y + 2
}else{
  y <- 10
}
y




# conditionals are the most effective in loops

# This code shouts out "Hachi!" (8 is read "Hachi" in Japanese)
# if i is 8. 
for (i in 1:10){
  if (i == 8){
    print("Hachi!")
  }else{
    print(i)
  }
}

# (This code is inspired by the story of a Japanese dog, Hachi, 
# who paitiently waited for his ownder who never returned.)

# A more serious example
for (x in 1:100){
  # check if x is divisible by 9
  # %% is modulo
  if (x %% 9 == 0){
    cat(x, " is divisible by 9 \n")
  }
}

# You can use if-else condition to write the stopping condition of the loop
# To do that, use "break". Once the loop hits "break", the loop will terminate. 

for (j in 1:50){
  h <- j * 3
  print(h)
  if (h > 90){ # if h is greater than 90, break the loop
    break
  }
}


# The combination of for loop and if-break can often achieve the
# similar tasks to while loop
for (i in 1:100){
  die <- sample(1:6, 1)
  print(die)
  
  if (die == 6){ # if die is 6, print the statement and break the loop. 
    print('6 shows up!')
    break
  }
}

# You can add another stopping condition to while loop, using if-break
while (TRUE){
  print(x)
  if (x == 6){
    print("stop!")
    break
  }
  x <- x + 1
}

# Exercise: Guess the result without running the code
x <- 1
z <- 0
while (x < 5){
  if (x %% 2 == 0){
    z <- z + 2
  }
  x <- x + 1
  z <- z + 1
}
# hint: insert print(z) to check what is going on 





# (4) Nested Loop  --------------------------------------------------


# Soemtimes one loop is not enough. You can loop over the loop! 

# See this code and compare with the following code
for (i in 1:5){
  cat("i =", i, '\n')
}

# see the example of the "nested loop" 
for (i in 1:5){
  for (j in 1:3){
    cat("i =", i, ' j =', j, '\n')
  }
}


# We have the outer loop over i and the inner loop over j. 
# For each i in 1, 2, ... 5, the inner loop is executed. 
# So, when i = 1, j goes from 1 to 3, when i = 2, j goes from 1 to 3 again, 
# upto when i = 5, j goes from 1 to 3. 

# When do we want to use this? For instance, this is helpful when you want to fill
# a matrix with differnet numbers. This code fills a 5 by 10 matrix
# with any number in [1, 10]

mat <- matrix(NA, nrow = 10, ncol = 10)

for (j in 1:5){
  for (i in 1:10){
    for (h in 6:10){
      mat[i,j,h] <- sample(1:10, 1)
      print(h)
    }
  }
}
mat

# storage 
mat <- matrix(0, nrow = 10, ncol=10)

for (i in 1:10){
  for (j in 1:5){
    mat[i, j] <- sample(seq(0, 10, 2), 1)
  }
}

for (i in 1:10){
  for (j in 6:10){
    mat[i, j] <- sample(seq(1, 9, 2), 1)
  }
}

# combine 

for (i in 1:10){
  for (j in 1:5){
    mat[i, j] <- sample(seq(0, 10, 2), 1)
  }
  for (j in 6:10){
    mat[i, j] <- sample(seq(1, 9, 2), 1)
  }
}





# You can shoten the code for the first exerise too! 
# Exercise: 


# Nested loop is useful in simulation too
# What is the number of times you have to roll a die until 6 shows up first time? 
# You can solve this by simulation 

# storage 
out <- c()

# simulate 100 times 
for (i in 1:1000){
  
  # set the variables to zero
  die <- 0
  count <- 0
  
  # keep rolling a die until 6 shows up
  while(die != 6){
    die <- sample(1:6, 1)
    # count the number of times we rolled the die
    count <- count + 1
  }
  out[i] <- count

}
# histogram of the number of times you have to roll a die until 6 shows up 
hist(out, breaks=seq(1, 50, 1))












