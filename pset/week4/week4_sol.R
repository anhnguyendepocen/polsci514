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
turnout <- read.csv('data/turnout.csv')

# Q2. Compute the turnout rate based on the voting eligible population (VEP) for each election year. 
turnout$veptr <- turnout$total / (turnout$VEP) * 100

# Q3. Compute the difference between what you computed in Q2 vs ANES estiamte of turnout rate for each election year.  
# What is the average difference of the turnout rate based on the VEP, across the election years?
# In which year the difference is the biggest?
turnout$diff <- turnout$ANES - veptr
turnout$year[turnout$diff == max(turnout$diff)]


# Q4 create a vector with a factor class that indicate whether the election is presidential or mid-term. 
# Add the vector as a column of the turnout data. 
election <- rep(c('presidential', 'midterm'), times=nrow(turnout)/2) 
election <- as.factor(election)
turnout$election <- election

# Q5. Subset the data into two groups: One for presidential elections and the other for mid-term elections. 
# Compute the average difference in the turnout rate based on the VEP, across the election years for both presidential and mid-term elections.  
# Which elections, presidential or mid-terms, have higher difference between ANES estimate and the turnout rate based on the VEP? 
turnout_pre <- turnout[turnout$election == 'presidential',]
turnout_mid <- turnout[turnout$election == 'midterm',]
mean(turnout_pre$diff)
mean(turnout_mid$diff)




















