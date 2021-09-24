##################################################
## POLSCI514 week4
## NAME
##################################################

# Exercise: More on data subsets and summary  -------------------------------

# The following is the description of data
# Source: Imai (2018) Introduction to Quantitative Social Science

# Surveys are frequently used to measure political behavior such as
# voter turnout, but some researchers are concerned about the accuracy
# of self-reports.  In particular, they worry about possible *social
# desirability bias* where in post-election surveys, respondents who did
# not vote in an election lie about not having voted because they may
# feel that they should have voted.  Is such a bias present in the
# American National Election Studies (ANES)?  The ANES is a nation-wide
# survey that has been conducted for every election since 1948.  The
# ANES conducts face-to-face interviews with a nationally representative
# sample of adults.  The table below displays the names and descriptions
# of variables in the `turnout.csv` data file.
# 

#--------------------------------------------------------------------------------
# Name                 Description
# -------------------- ----------------------------------------------------------
# `year`               Election year
# 
# `VEP`                Voting Eligible Population (in thousands) 
# 
# `VAP`                Voting Age Population (in thousands) 
# 
# `total`              Total ballots cast for highest office (in thousands) 
# 
# `ANES`               ANES estimate of turnout rate
# 
# `felons`             Total ineligible felons (in thousands) 
# 
# `noncitizens`        Total non-citizens (in thousands) 
# 
# `overseas`           Total eligible overseas voters (in thousands)
# 
# `osvoters`           Total ballots counted by overseas voters (in thousands)
#--------------------------------------------------------------------------------

# Q1. Read the data and print out the summary of the data

# Q2. Compute the turnout rate based on the voting eligible population (VEP) for each election year. 

# Q3. Compute the difference between what you computed in Q2 vs ANES estiamte of turnout rate for each election year.  
# What is the average difference of the turnout rate based on the VEP, across the election years?
# In which year the difference is the biggest?


# Q4 create a vector with a factor class that indicate whether the election is presidential or mid-term. 
# Add the vector as a column of the turnout data. 

# Q5. Subset the data into two groups: One for presidential elections and the other for mid-term elections. 
# Compute the average difference in the turnout rate based on the VEP, across the election years for both presidential and mid-term elections.  
# Which elections, presidential or mid-terms, have higher difference between ANES estimate and the turnout rate based on the VEP? 


# Exercise --------------------------------------------------------------------

# Q1. Create a matrix object 'A' with 4 rows and 3 columns, filled with numbers 1...12 by rows.
# i.e. A[1,1] should be 1, A[1,2] should be 2, and A[1,3] should be 3.

# Q2. Create a matrix object 'B' with 3 rows and 4 columns, filled with numbers 1,3,5,7,9,...23 by columns.
# i.e. B[1,1] = 1, B[2,1] = 3, B[3,1] = 5, B[2,1] = 7 ...

# Q3. Compute a matrix multiplication of A times B and assign the result to a matrix object 'D'

# Q4. Compute a matrix multipliaction of D and the transpose of D 

