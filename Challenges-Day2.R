############################################################################
# Challenges for Day 2
# These should be copied into the etherpad at appropriate times for attendees
# to copy into their own R scripts, in order to save time on typing out the 
# challenges
# Navigate by section headings.
#
# Created by Nikki Rubinstein
# 22 May, 2016
############################################################################

# Vectorisation (9) ########################################################

## Challenge 1 
# Let's try this on the health column of the healthData dataset.
# Make a new column in the healthData data frame that
# contains health rounded to the nearest integer.
# Check the head or tail of the data frame to make sure
# it worked.
# Hint: R has a round() function

## Challenge 2 
# Given the following matrix:
# m <- matrix(1:12, nrow=3, ncol=4)
# m
# Write down what you think will happen when you run:
#   1. m ^ -1
#   2. m * c(1, 0, -1)
#   3. m c(0, 20)
#   4. m * c(1, 0, -1, 2)
# Did you get the output you expected? If not, ask a helper!

## Challenge 3 
# We're interested in looking at the sum of the
# following sequence of fractions:
# x = 1/(1^2) + 1/(2^2) + 1/(3^2) + ... + 1/(n^2)
# This would be tedious to type out, and impossible for high values of
# n.  Use vectorisation to compute x when n=100. What is the sum when
# n=10,000?

# Control flow (10) ########################################################

## Challenge 1 
# Use an if statement to print a suitable message
# reporting whether there are any years of birth from 1812 in
# the healthData dataset.
# Now do the same for 1910.
  
## Challenge 2 
# Compare the objects output_vector and
# output_vector2. Are they the same? If not, why not?
# How would you change the last block of code to make output_vector2
# the same as output_vector?

## Challenge 3 
# Write a script that loops through the healthData data by illness level and prints 
# out whether the mean health measure is smaller or larger than 8 units.
# Hint: you may want to check out the functions na.rm(), is.na() and unique()

## Challenge 4 
# Modify the script from Challenge 4 to also loop over each
# study. This time print out whether the health measure is
# smaller than 5, between 5 and 8, or greater than 8.
  
# Writing data (11) ########################################################

## Challenge 1 
# Rewrite your 'pdf' command to print a second
# page in the pdf, showing a facet plot (hint: use facet_grid)
# of the same data with one panel per education year.
  
## Challenge 2 
# Write a data-cleaning script file that subsets the health
# data to include only data points collected collected for students in year
# 8.
# Use this script to write out the new subset to a file
# in the cleaned-data/ directory.

# Split-apply-combine (12) #################################################

## Challenge 1 
# Calculate the average intellect per education level. Which has the highest?
# Which had the lowest?

## Challenge 2 
# Calculate the average intellect per mental adjustment value and sex. Which had the
# highest and lowest in HIGroup 2? Which had the greatest change across between groups?

## Advanced Challenge 
# Calculate the difference in intellect between
# education level 5 and 9 from the output of challenge 2
# using one of the plyr functions.

## Alternate Challenge if class seems lost 
# Without running them, which of the following will calculate the average 
# conscientiousness per education year:
#   1. ddply(
#       .data = healthData,
#       .variables = healthData$education,
#       .fun = function(dataGroup) {
#            mean(dataGroup$conscientiousness)
#       }
#      )
#  2. ddply(
#       .data = healthData,
#       .variables = "education",
#       .fun = mean(dataGroup$conscientiousness)
#     )
#  3. ddply(
#       .data = healthData,
#       .variables = "education",
#       .fun = function(dataGroup) {
#           mean(dataGroup$concientiousness)
#       }
#     )
#  4. adply(
#       .data = healthData,
#       .variables = "education",
#       .fun = function(dataGroup) {
#         mean(dataGroup$conscientiousness)
#       }
#     )
  
# Dataframe manipulation with dplyr (13) ####################################

## Challenge 1 
# Write a single command (which can span multiple lines and includes pipes) that 
# will produce a dataframe that has the values for conscientiousness, extraversion 
# and intellect for males. 
# How many rows does your dataframe have and why?

## Challenge 2 
# Calculate the average mentalAdjustment per education. Which had the highest 
# mentalAdjustment and which had the lowest?
  
## Advanced Challenge 
# Calculate the average intellect for 5 randomly selected females in each sample 
# group. Then arrange the groups in reverse alphabetical order.
# Hint: Use the dplyr functions arrange() and sample_n(), they have similar syntax 
# to other dplyr functions.
