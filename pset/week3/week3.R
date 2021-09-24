# POLSCI514, Week 3, Problem set
# Name: 

#  Quiz: Subset vectors ----------------------------------------------------------------------

# Suppose you are a GSI and the following is the score of the students
score <- c(90, 89, 38, 28, 82, 72, 63, 12, 5, 64)
names(score) <- c('tom', 'james', 'mary', 'john', 'sarah', 'david', 'lisa', 'chris', 'mitchell', 'eric')

# How many students are in your class?
length(score)

# What is the mean (average) score?
mean(score)

# What is the highest and the lowest score?
max(score)
min(score)

# What is the score of Sarah?
score['sarah']

# Who received scores higher than 50? 
names(score)[score > 50]

# How many students receive scores higher than the mean? 
sum(score > mean(score))

# Who received the highest and the lowest score?
names(score)[score == max(score)]
names(score)[score == min(score)]

# Mary's score was recorded incorrectly and it was 83. 
# Create a new vector 'correct_score' with the correct values.
score['mary'] <- 83


# Quiz: More subset -----------------------------------------------------------

score_data <- data.frame(names=c('tom', 'james', 'mary', 'john', 'sarah',
                                 'david', 'lisa', 'chris', 'mitchell', 'eric'),
                         group=c(1,2,3,1,2,3,1,2,3,1),
                         hw1=c(90, 89, 83, 28, 82, 72, 63, 12, 5, 64),
                         hw2=c(82, 43, 98, 42, 57, 94, 11, 43, 42, 54))

# extract the columns for hw1 and hw2
score_data$hw1
score_data$hw2

# extract the row for John's entry
score_data[score_data$names == 'john',]

# extract Sarah's score for the hw2
score_data[score_data$names == 'sarah', 'hw2']

# add a new column for the average score of hw1 and hw2. 
# set the column name for this column to be 'hw_mean'
score_data$hw_mean <- (score_data$hw1 + score_data$hw2) / 2

# who received the highest score in the hw1 and the hw2? 
score_data$names[score_data$hw1 == max(score_data$hw1)]
score_data$names[score_data$hw2 == max(score_data$hw2)]

# who received the higest score on average?
score_data$names[score_data$hw_mean == max(score_data$hw_mean)]

# extract the rows for group 1 
score_data[score_data$group == 1,]

# compute the average score of hw2 for each group (1,2,3) 
mean(score_data$hw2[score_data$group == 1])
mean(score_data$hw2[score_data$group == 2])
mean(score_data$hw2[score_data$group == 3])

# alternatively...
tapply(score_data$hw2, score_data$group, mean)

# add a new column for the difference between hw1 and hw2.    
# Who received higher score in hw2 than hw1? 
score_data$score_diff <- score_data$hw2 - score_data$hw1
score_data$names[score_data$score_diff > 0]

# (*) there is an additional student 'paul' in the class. 
# He is in the group 2 and his score for hw1 was 80 and hw2 was 75. 
# Add a row for paul's entry. 
new_row <- c('paul', 2, 80, 75, mean(c(80, 75)), 75-80)
score_data <- rbind(score_data, new_row)

# (*) sort the rows so that the names are in alphabetical order
score_data[order(score_data$names),]
