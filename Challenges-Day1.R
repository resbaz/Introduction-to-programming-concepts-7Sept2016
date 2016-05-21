############################################################################
# Challenges for Day 1
# These should be copied into the etherpad at appropriate times for attendees
# to copy into their own R scripts, in order to save time on typing out the 
# challenges
# Navigate by section headings.
#
# Created by Nikki Rubinstein
# 22 May, 2016
############################################################################

# Introduction to R and RStudio (1) ########################################

## Challenge 1 
# Which of the following are valid R variable names?
#   min_height
#   max.height
#   _age
#   .mass
#   MaxLength
#   min-length
#   2widths
#   celsius2kelvin

## Challenge 2 
# What will be the value of each  variable  after each
# statement in the following program?
#   mass <- 47.5
#   age <- 122
#   mass <- mass * 2.3
#   age <- age - 20

## Challenge 3 
# Run the code from the previous challenge, and write a command to
# compare mass to age. Is mass larger than age?

## Challenge 4 
# Clean up your working environment by deleting the mass and age
# variables.

## Challenge 5 
# Install the following packages: dplyr, tidyr


# Seeking help (3) #########################################################

## Challenge 1 
# Look at the help for the c function. What kind of vector do you
# expect you will create if you evaluate the following: 
#   c(1, 2, 3)
#   c('d', 'e', 'f')
#   c(1, 2, 'f')

## Challenge 2 
# Look at the help for the paste function. You'll need to use this later. 
# What is the difference between the sep and collapse arguments?
 
## Challenge 3 
# Use help to find a function (and its associated parameters) that you could
# use to load data from a csv file in which columns are delimited with "\t"
# (tab) and the decimal point is a "." (period). This check for decimal
# separator is important, especially if you are working with international
# colleagues, because different countries have different conventions for the
# decimal point (i.e. comma vs period).
# hint: use ??csv to lookup csv related functions.

# Data structures (4) ######################################################

## Challenge 1 
# Start by making a vector with the numbers 11 to 20.
# Then use the functions we just learned to extract the 3rd through 5th element 
# in that vector into a new vector;
# name the elements in that new vector 'R', 'E', 'S'.

## Challenge 2 
# Is there a factor in our cats data.frame? what is its name?
# Try using ?read.csv to figure out how to keep text columns as character vectors 
# instead of factors; then write a command or two to show that the factor in cats 
# is actually is a character vector when loaded in this way.

## Challenge 3 
# What do you think will be the result of
# length(matrix_example)?
# Try it.
# Were you right? Why / why not?

## Challenge 4 
# Make another matrix, this time containing the numbers 1:50,
# with 5 columns and 10 rows.
# Did the matrix function fill your matrix by column, or by
# row, as its default behaviour?
# See if you can figure out how to change this.
# (hint: read the documentation for matrix!)

## Challenge 5 
# Create a list of length two containing a character vector for each of the 
# sections in this part of the workshop:
# - Data types
# - Data structures
# Populate each character vector with the names of the data types and data structures 
# we've seen so far.

## Challenge 6 
# Consider the R output of the matrix below:
# matrix(c(4, 1, 9, 5, 10, 7), ncol = 2, byrow = TRUE)
# What was the correct command used to write this matrix? Examine
# each command and try to figure out the correct one before typing them.
# Think about what matrices the other commands will produce.
#  1. matrix(c(4, 1, 9, 5, 10, 7), nrow = 3)
#  2. matrix(c(4, 9, 10, 1, 5, 7), ncol = 2, byrow = TRUE)
#  3. matrix(c(4, 9, 10, 1, 5, 7), nrow = 2)
#  4. matrix(c(4, 1, 9, 5, 10, 7), ncol = 2, byrow = TRUE)

# Exploring data.frames (5) ################################################

## Challenge 1 
# You can create a new data.frame right from within R with the following syntax:
# df <- data.frame(id = c('a', 'b', 'c'), x = 1:3, 
#      y = c(TRUE, TRUE, FALSE), stringsAsFactors = FALSE)
# Make a data.frame that holds the following information for yourself:
#   - first name
#   - last name
#   - lucky number
# Then use rbind to add an entry for the people sitting beside you. 
# Finally, use cbind to add a column with each person's answer to the question, 
# "Is it time for coffee break?"

## Challenge 2 
# Go to file - new file - R script, and write an R script
# to load in the healthData dataset. Put it in the scripts/
# directory and add it to version control.
# Run the script using the source() function, using the file path
# as its argument (or by pressing the "source" button in RStudio).

## Challenge 3 
# Read the output of str(healthData) again; 
# this time, use what you've learned about factors, lists and vectors,
# as well as the output of functions like colnames and dim
# to explain what everything that str prints out for gapminder means.
# If there are any parts you can't interpret, discuss with your neighbors!

# Subsetting data (6) ######################################################

## Challenge 1 
# Given the following code:
# x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
# names(x) <- c('a', 'b', 'c', 'd', 'e')
# print(x)
# 1. Come up with at least 3 different commands that will produce the following 
#    output:
#    x[2:4]
# 2. Compare notes with your neighbour. Did you have different strategies?

## Challenge 2 
# Run the following code to define vector x as above:
# x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
# names(x) <- c('a', 'b', 'c', 'd', 'e')
# print(x)
# Given this vector x, what would you expect the following to do?
# x[-which(names(x) == "g")]
# Try out this command and see what you get. Did this match your expectation?
# Why did we get this result? (Tip: test out each part of the command on it's 
# own like we just did above - this is a useful debugging strategy)
#
# Which of the following are true:
#   A) if there are no TRUE values passed to which, an empty vector is returned
#   B) if there are no TRUE values passed to which, an error message is shown
#   C) integer() is an empty vector
#   D) making an empty vector negative produces an "everything" vector
#   E) x[] gives the same result as x[integer()]

## Challenge 3 
# Given the following code:
# x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
# names(x) <- c('a', 'b', 'c', 'd', 'e')
# print(x)
# Write a subsetting command to return the values in x that are greater than 
# 4 and less than 7.

## Challenge 4 
# Given the following code:
# m <- matrix(1:18, nrow=3, ncol=6)
# print(m)
# Which of the following commands will extract the values 11 and 14?
#   A. m[2,4,2,5]
#   B. m[2:5]
#   C. m[4:5,2]
#   D. m[2,c(4,5)]

## Challenge 5 
# Given the following list:
# xlist <- list(a = "Research Bazaar", b = 1:10, data = head(iris))
# Using your knowledge of both list and vector subsetting, extract the number 2 from xlist. 
# Hint: the number 2 is contained within the "b" item in the list.

## Challenge 6 
# Given a linear model:
# mod <- aov(intellect ~ education, data=healthData)
# Extract the residual degrees of freedom (hint: attributes() will help you)
  
## Challenge 7 
# Fix each of the following common data frame subsetting errors:
#   1. Extract observations collected for birth year = 1909
#      healthData[healthData$birthYear = 1909,]
#   2. Extract all columns except 1 through to 4
#      healthData[,-1:4]
#   3. Extract the rows where the health metric is greater than 7
#      healthData[healthData$health  7]
#   4. Extract the first row, and the fourth and fifth columns
#      (intellect and agreeableness).
#      healthData[1, 4, 5]
#   5. Advanced: extract rows that contain information for those in education level 
#      7 and 9
#      healthData[healthData$education == 7 | 9,]

## Challenge 8 
# 1. Why does healthData[1:20] return an error? How does it differ from 
#    healthData[1:20, ]?
# 2. Create a new data.frame called healthData_small that only contains rows 
#    1 through 9 and 19 through 23. You can do this in one or two steps.
  
# Creating functions (7) ###################################################

## Challenge 1 
# Write a function called kelvin_to_celsius that takes a temperature in Kelvin
# and returns that temperature in Celsius
# Hint: To convert from Kelvin to Celsius you minus 273.15

## Challenge 2 
# Define the function to convert directly from Fahrenheit to Celsius,
# by reusing the two functions above (or using your own functions if you prefer).

## Challenge 3 
# Define the function to calculate the average year of birth for specific year 
# levels of a single study group.
# Hint: Look up the function %in%, which will allow you to subset by multiple 
# year levels

## Challenge 4 
# The paste function can be used to combine text together, e.g:
# best_practice <- c("Write", "programs", "for", "people", "not", "computers")
# paste(best_practice, collapse=" ")
# Write a function called fence that takes two vectors as arguments, called
# text and wrapper, and prints out the text wrapped with the wrapper:
# fence(text=best_practice, wrapper="***")
# Note: the paste function has an argument called sep, which specifies the
# separator between text. The default is a space: " ". The default for paste0
# is no space "".

# Creating publication quality graphics (8) ##################################

## Challenge 1 
# Modify the following example so that the figure visualises how illnessReversed 
# varies with health:
# ggplot(healthData,aes(x=selfRatedHealth,y=health)) +
# geom_point()

## Challenge 2 
# In the previous examples and challenge we've used the aes function to tell
# the scatterplot geom about the x and y locations of each point.
# Another aesthetic property we can modify is the point color. Modify the
# code from the previous challenge to color the points by the "education"
# column.
# HINT: transform the education column to a factor using the as.factor() function.

## Challenge 3 
# Switch the order of the point and line layers from the previous example. What
# happened?

## Challenge 4 
# Modify the color and size of the points on the point layer in the previous
# example.
# Hint: do not use the aes function.

## Challenge 5 
# What would you like to visualise from the dataset?
# Go ahead and try to do it using ggplot!

# ggsave("fig/Figure1.pdf")
