# POLSCI514, Week 3, Problem set
# Name: 

#  Quiz: Subset vectors ----------------------------------------------------------------------

# Suppose you are a GSI and the following is the score of the students
score <- c(90, 89, 38, 28, 82, 72, 63, 12, 5, 64)
names(score) <- c('tom', 'james', 'mary', 'john', 'sarah', 'david', 'lisa', 'chris', 'mitchell', 'eric')

# How many students are in your class?

# What is the mean (average) score?

# What is the highest and the lowest score?

# What is the score of Sarah?

# Who received scores higher than 50? 

# How many students receive scores higher than the mean? 

# Who received the highest and the lowest score?

# Mary's score was recorded incorrectly and it was 83. 
# Create a new vector 'correct_score' with the correct values.


# Quiz: More subset -----------------------------------------------------------

score_data <- data.frame(names=c('tom', 'james', 'mary', 'john', 'sarah',
                                 'david', 'lisa', 'chris', 'mitchell', 'eric'),
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