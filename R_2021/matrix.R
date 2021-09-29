##################################################
## POLSCI514 week5
## Introduction to R 
## Author: Saki Kuzushima
##################################################

# Matrix ----------------------------------------------------------------------
# We learn anothor object similar to dataframe: Matrix. 

# We learned that we can add names to a vector 
X <- c(1,2,3,4,5,6)
names(X) <- c('a', 'b', 'c', 'd', 'e', 'f')
# What we are doing here is that we are adding an attribute to a vector

# Likewise, we can add a different attribute, dimensions.
# This will effectively turns a vector into a matrix.
dim(X) <- c(2,3)
X

# Normally, we simply create a matrix using matrix() function. 
# First, the following code will create a 2 * 2 matrix with all elements being 1. 
X1 <- matrix(1, nrow = 2, ncol = 2)
# You can supply a vector
X2 <- matrix(c(1,2,3,4), nrow = 2, ncol = 2)
X3 <- matrix(c(1,2,3,4), nrow = 2, ncol = 2, byrow=T)
# Note that the vector is arranged by column (you can change this by 'byrow' argument
# in the matrix function)

# Add rownames and column names to a matrix
rownames(X1) <- c('a', 'b')
colnames(X1) <- c('A', 'B')

# Add a row to a matrix
newrow <- c(2,2)
X1_new <- rbind(X1, newrow)

# add a column to a matrix
newcol <- c(5,6)
X2_new <- cbind(X2, newcol)

# access elements of a matrix
X1[1,1] # 1st row, 1st col

# Matrix and scalar: element-wise operation
X1 + 1
X1 * 10
X1 - 1
X1 / 2

# Matrix and matrix: element-wise operation (if they have the same dimensions.) 
X1 + X2
X1 * X2
X1 - X2
X1 / X2

# Whenever we do matrix multiplication, we have to be careful about the dimensions. 
Y <- matrix(c(1,2,3,4,5,6), nrow = 2, ncol = 3)
Z <- matrix(c(10, 20, 30, 40, 50, 60), nrow = 3, ncol = 2)
W <- matrix(1:10, nrow = 2, ncol=5)

# You can check the dimension by dim()
dim(Y)
dim(Z)
dim(W)

# When you multiply matrices, use %*%, instead of *
# Remember that X %*% Y is possible only when the row length of X is the 
# same as the column length of Y

# This is possible :)
Y %*% Z

# This is impossible :( 
Y %*% W


# You can convert dataframe to matrix
df <- data.frame(x = c(1,2), y = c(3,4))
df_mat <- as.matrix(df)
class(df_mat)

# Or matrix to dataframe
X1_df <- as.data.frame(X1)
class(X1_df)


# You can do matrix multiplication with matrix but not with dataframe
# This returns error
df %*% X # error

# But this is possible 
df_mat %*% X


# Note that * does element-wise multiplication while %*% does matrix multiplication 
X2 * X2
X2 %*% X2


# You can transpose and invert matrices 
# This will transpose the matrix
t(Y)
# This will invert the matrix
solve(X2)
# This will return error because Y is not a square matrix 
solve(Y) # error

# Exercise --------------------------------------------------------------------

# Q1. Create a matrix object 'A' with 4 rows and 3 columns, filled with numbers 1...12 by rows.
# i.e. A[1,1] should be 1, A[1,2] should be 2, and A[1,3] should be 3.

# Q2. Create a matrix object 'B' with 3 rows and 4 columns, filled with numbers 1,3,5,7,9,...23 by columns.
# i.e. B[1,1] = 1, B[2,1] = 3, B[3,1] = 5, B[2,1] = 7 ...

# Q3. What is the 3rd row, 3rd column element of the matrix B?

# Q4. Compute a matrix multiplication of A times B and assign the result to a matrix object 'D'

# Q5. Compute a matrix multiplication of D and the transpose of D 


















