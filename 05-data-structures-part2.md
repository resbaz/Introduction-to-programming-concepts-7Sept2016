---
layout: page
title: R for reproducible scientific analysis
subtitle: Exploring Data Frames
minutes: 45
---



> ## Learning Objectives {.objectives}
>
> - To learn how to manipulate a data.frame in memory
> - To tour some best practices of exploring and understanding a data.frame when it is first loaded.
>

At this point, you've see it all - in the last lesson, we toured all the basic data types and data structures in R. Everything you do will be a manipulation of those tools. But a whole lot of the time, the star of the show is going to be the data.frame - that table that we started with that information from a CSV gets dumped into when we load it. In this lesson, we'll learn a few more things about working with data.frame.

We learned last time that the columns in a data.frame were vectors, so that our data are consistent in type throughout the column. As such, if we want to add a new column, we need to start by making a new vector:




~~~{.r}
newCol <- c(2,3,5,12)
cats
~~~



~~~{.output}
    coat weight likes_string
1 calico    2.1         TRUE
2  black    5.0        FALSE
3  tabby    3.2         TRUE

~~~

We can then add this as a column via:


~~~{.r}
cats <- cbind(cats,  newCol)
~~~



~~~{.error}
Error in data.frame(..., check.names = FALSE): arguments imply differing number of rows: 3, 4

~~~

Why didn't this work? Of course, R wants to see one element in our new column for every row in the table:


~~~{.r}
cats
~~~



~~~{.output}
    coat weight likes_string
1 calico    2.1         TRUE
2  black    5.0        FALSE
3  tabby    3.2         TRUE

~~~



~~~{.r}
newCol <- c(4,5,8)
cats <- cbind(cats, newCol)
cats
~~~



~~~{.output}
    coat weight likes_string newCol
1 calico    2.1         TRUE      4
2  black    5.0        FALSE      5
3  tabby    3.2         TRUE      8

~~~

Our new column has appeared, but it's got that ugly name at the top; let's give it something a little easier to understand:


~~~{.r}
names(cats)[4] <- 'age'
~~~

Now how about adding rows - in this case, we saw last time that the rows of a data.frame are made of lists:


~~~{.r}
newRow <- list("tortoiseshell", 3.3, TRUE, 9)
cats <- rbind(cats, newRow)
~~~



~~~{.error}
Warning in `[<-.factor`(`*tmp*`, ri, value = "tortoiseshell"): invalid
factor level, NA generated

~~~

Another thing to look out for has emerged - when R creates a factor, it only allows whatever is originally there when our data was first loaded, which was 'black', 'calico' and 'tabby' in our case. Anything new that doesn't fit into one of its categories is rejected as nonsense, until we explicitly add that as a *level* in the factor:


~~~{.r}
levels(cats$coat)
~~~



~~~{.output}
[1] "black"  "calico" "tabby" 

~~~



~~~{.r}
levels(cats$coat) <- c(levels(cats$coat), 'tortoiseshell')
cats <- rbind(cats, list("tortoiseshell", 3.3, TRUE, 9))
~~~

Alternatively, we can change a factor column to a character vector; we lose the handy categories of the factor, but can subsequently add any word we want to the column without babysitting the factor levels:


~~~{.r}
str(cats)
~~~



~~~{.output}
'data.frame':	5 obs. of  4 variables:
 $ coat        : Factor w/ 4 levels "black","calico",..: 2 1 3 NA 4
 $ weight      : num  2.1 5 3.2 3.3 3.3
 $ likes_string: logi  TRUE FALSE TRUE TRUE TRUE
 $ age         : num  4 5 8 9 9

~~~



~~~{.r}
cats$coat <- as.character(cats$coat)
str(cats)
~~~



~~~{.output}
'data.frame':	5 obs. of  4 variables:
 $ coat        : chr  "calico" "black" "tabby" NA ...
 $ weight      : num  2.1 5 3.2 3.3 3.3
 $ likes_string: logi  TRUE FALSE TRUE TRUE TRUE
 $ age         : num  4 5 8 9 9

~~~

We now know how to add rows and columns to our data.frame in R - but in our work we've accidentally added a garbage row. We can ask for a data.frame minus this offender:


~~~{.r}
cats[-4,]
~~~



~~~{.output}
           coat weight likes_string age
1        calico    2.1         TRUE   4
2         black    5.0        FALSE   5
3         tabby    3.2         TRUE   8
5 tortoiseshell    3.3         TRUE   9

~~~

Notice the comma with nothing after it to indicate we want to drop the entire fourth row. 
Alternatively, we can drop all rows with `NA` values:


~~~{.r}
na.omit(cats)
~~~



~~~{.output}
           coat weight likes_string age
1        calico    2.1         TRUE   4
2         black    5.0        FALSE   5
3         tabby    3.2         TRUE   8
5 tortoiseshell    3.3         TRUE   9

~~~

In either case, we need to reassign our variable to persist the changes:


~~~{.r}
cats <- na.omit(cats)
~~~

> ## Discussion 1 {.challenge} 
> What do you think
> ```
> cats$weight[4]
> ```
> will print at this point?
>

The key to remember when adding data to a data.frame is that *columns are vectors or factors, and rows are lists.*
We can also glue two dataframes together with `rbind`:


~~~{.r}
cats <- rbind(cats, cats)
cats
~~~



~~~{.output}
            coat weight likes_string age
1         calico    2.1         TRUE   4
2          black    5.0        FALSE   5
3          tabby    3.2         TRUE   8
5  tortoiseshell    3.3         TRUE   9
11        calico    2.1         TRUE   4
21         black    5.0        FALSE   5
31         tabby    3.2         TRUE   8
51 tortoiseshell    3.3         TRUE   9

~~~
But now the row names are unnecessarily complicated. We can ask R to re-name everything sequentially:


~~~{.r}
rownames(cats) <- NULL
cats
~~~



~~~{.output}
           coat weight likes_string age
1        calico    2.1         TRUE   4
2         black    5.0        FALSE   5
3         tabby    3.2         TRUE   8
4 tortoiseshell    3.3         TRUE   9
5        calico    2.1         TRUE   4
6         black    5.0        FALSE   5
7         tabby    3.2         TRUE   8
8 tortoiseshell    3.3         TRUE   9

~~~

> ## Challenge 1 {.challenge}
>
> You can create a new data.frame right from within R with the following syntax:
> 
> ~~~{.r}
> df <- data.frame(id = c('a', 'b', 'c'), x = 1:3, y = c(TRUE, TRUE, FALSE), stringsAsFactors = FALSE)
> ~~~
> Make a data.frame that holds the following information for yourself:
>
> - first name
> - last name
> - lucky number
>
> Then use `rbind` to add an entry for the people sitting beside you. 
> Finally, use `cbind` to add a column with each person's answer to the question, "Is it time for coffee break?"
>

So far, you've seen the basics of manipulating data.frames with our cat data; now, let's use those skills to digest a more realistic dataset. Lets read in some real data now. For the remainder of the workshop we will play with some child health data from positive psychology. The data is stored on the GitHub repository used for these training materials, and R can read the file directly from there:


~~~{.r}
healthData <- read.csv("https://goo.gl/oqQGKF")
~~~

> ## Miscellaneous Tips {.callout}
>
> 1. Another type of file you might encounter are tab-separated
> format. To specify a tab as a separator, use `sep="\t"`.
>
> 2. You can also read in files from a local file location by replacing
> the URL with a file location, as we saw earlier with the cat data.
>
> 3. You can read directly from excel spreadsheets without
> converting them to plain text first by using the `xlsx` package.
>

Let's investigate the health data a bit; the first thing we should always do is check out the structure of the data with `str`:


~~~{.r}
str(healthData)
~~~



~~~{.output}
'data.frame':	2255 obs. of  15 variables:
 $ id                        : int  3 4 7 8 10 12 15 17 18 20 ...
 $ conscientiousness         : num  5.83 7.73 6.5 5.88 4.25 ...
 $ extraversion              : Factor w/ 95 levels ".","1.000","1.408",..: 45 93 20 16 67 36 71 49 65 65 ...
 $ intellect                 : num  6.04 6.82 5.53 4.23 4.75 ...
 $ agreeableness             : Factor w/ 56 levels ".","1.000","1.051",..: 34 56 17 34 26 34 42 23 39 23 ...
 $ neuroticism               : Factor w/ 43 levels ".","1.000","1.442",..: 18 41 22 18 15 32 37 32 30 30 ...
 $ sex                       : Factor w/ 2 levels "Female","Male": 2 2 2 2 2 2 2 2 2 2 ...
 $ selfRatedHealth           : int  4 5 3 3 4 4 4 4 5 4 ...
 $ mentalAdjustment          : int  2 3 3 2 2 2 3 1 3 3 ...
 $ illnessReversed           : int  3 5 4 4 3 5 2 4 5 4 ...
 $ health                    : num  6.74 11.96 8.05 6.48 6.74 ...
 $ alcoholUseInYoungAdulthood: int  2 3 2 1 2 2 1 1 1 2 ...
 $ education                 : int  9 8 6 8 9 4 6 7 9 9 ...
 $ birthYear                 : int  1909 1905 1910 1905 1910 1911 1903 1908 1909 1911 ...
 $ HIGroup                   : Factor w/ 2 levels "Group 1","Group 2": 1 1 1 1 1 1 1 1 1 1 ...

~~~

We can also examine individual columns of the data.frame with our `typeof` function:


~~~{.r}
typeof(healthData$id)
~~~



~~~{.output}
[1] "integer"

~~~



~~~{.r}
typeof(healthData$conscientiousness)
~~~



~~~{.output}
[1] "double"

~~~



~~~{.r}
typeof(healthData$sex)
~~~



~~~{.output}
[1] "integer"

~~~



~~~{.r}
str(healthData$health)
~~~



~~~{.output}
 num [1:2255] 6.74 11.96 8.05 6.48 6.74 ...

~~~

We can also interrogate the data.frame for information about its dimensions; remembering that `str(healthData)` said there were 2255 observations of 15 variables in healthData, what do you think the following will produce, and why?


~~~{.r}
length(healthData)
~~~



~~~{.output}
[1] 15

~~~

A fair guess would have been to say that the length of a data.frame would be the number of rows it has (2255), but this is not the case; remember, a data.frame is a *list of vectors and factors*:


~~~{.r}
typeof(healthData)
~~~



~~~{.output}
[1] "list"

~~~

When `length` gave us 15, it's because gapminder is built out of a list of 6 columns. To get the number of rows and columns in our dataset, try:


~~~{.r}
nrow(healthData)
~~~



~~~{.output}
[1] 2255

~~~



~~~{.r}
ncol(healthData)
~~~



~~~{.output}
[1] 15

~~~

Or, both at once:


~~~{.r}
dim(healthData)
~~~



~~~{.output}
[1] 2255   15

~~~

We'll also likely want to know what the titles of all the columns are, so we can ask for them later:

~~~{.r}
colnames(healthData)
~~~



~~~{.output}
 [1] "id"                         "conscientiousness"         
 [3] "extraversion"               "intellect"                 
 [5] "agreeableness"              "neuroticism"               
 [7] "sex"                        "selfRatedHealth"           
 [9] "mentalAdjustment"           "illnessReversed"           
[11] "health"                     "alcoholUseInYoungAdulthood"
[13] "education"                  "birthYear"                 
[15] "HIGroup"                   

~~~

At this stage, it's important to ask ourselves if the structure R is reporting matches our intuition or expectations; do the basic data types reported for each column make sense? If not, we need to sort any problems out now before they turn into bad surprises down the road, using what we've learned about how R interprets data, and the importance of *strict consistency* in how we record our data.

Once we're happy that the data types and structures seem reasonable, it's time to start digging into our data proper. Check out the first few lines:


~~~{.r}
head(healthData)
~~~



~~~{.output}
  id conscientiousness extraversion intellect agreeableness neuroticism
1  3             5.825        3.986     6.044         4.613       3.649
2  4             7.732        7.016     6.821         6.649       6.299
3  7             6.498        2.697     5.527         3.087       4.091
4  8             5.881        2.504     4.234         4.613       3.649
5 10             4.254        5.147     4.751         3.850       3.208
6 12             7.508        3.535     6.821         4.613       5.415
   sex selfRatedHealth mentalAdjustment illnessReversed health
1 Male               4                2               3   6.74
2 Male               5                3               5  11.96
3 Male               3                3               4   8.05
4 Male               3                2               4   6.48
5 Male               4                2               3   6.74
6 Male               4                2               5   9.01
  alcoholUseInYoungAdulthood education birthYear HIGroup
1                          2         9      1909 Group 1
2                          3         8      1905 Group 1
3                          2         6      1910 Group 1
4                          1         8      1905 Group 1
5                          2         9      1910 Group 1
6                          2         4      1911 Group 1

~~~

To make sure our analysis is reproducible, we should put the code
into a script file so we can come back to it later.

> ## Challenge 2 {.challenge}
>
> Go to file -> new file -> R script, and write an R script
> to load in the healthData dataset. Put it in the `scripts/`
> directory and add it to version control.
>
> Run the script using the `source` function, using the file path
> as its argument (or by pressing the "source" button in RStudio).
>

> ## Challenge 3 {.challenge}
>
> Read the output of `str(healthData)` again; 
> this time, use what you've learned about factors, lists and vectors,
> as well as the output of functions like `colnames` and `dim`
> to explain what everything that `str` prints out for gapminder means.
> If there are any parts you can't interpret, discuss with your neighbors!
>

## Challenge solutions

> ## Discussion 1 {.challenge}
> Note the difference between row indices, and default row names;
> even though there's no more row named '4',
> cats[4,] is still well-defined (and pointing at the row named '5').
>

> ## Solution to Challenge 1 {.challenge}
> 
> ~~~{.r}
> df <- data.frame(first = c('Grace'), last = c('Hopper'), lucky_number = c(0), stringsAsFactors = FALSE)
> df <- rbind(df, list('Marie', 'Curie', 238) )
> df <- cbind(df, c(TRUE,TRUE))
> names(df)[4] <- 'coffeetime'
> ~~~
>

> ## Solution to Challenge 2 {.challenge}
> The contents of `script/load-healthData.R`:
> 
> ~~~{.r}
> healthData <- read.csv("https://goo.gl/oqQGKF")
> ~~~
> To run the script and load the data into the `healthData` variable:
> 
> ~~~{.r}
> source(file = "scripts/load-healthData.R")
> ~~~
>
