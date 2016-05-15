---
layout: page
title: R for reproducible scientific analysis
subtitle: Vectorisation
minutes: 30
---



> ## Learning Objectives {.objectives}
>
> * To understand vectorised operations in R.
>

Most of R's functions are vectorised, meaning that the function will
operate on all elements of a vector without needing to loop through
and act on each element one at a time. This makes writing code more
concise, easy to read, and less error prone.



~~~{.r}
x <- 1:4
x * 2
~~~



~~~{.output}
[1] 2 4 6 8

~~~

The multiplication happened to each element of the vector.

We can also add two vectors together:


~~~{.r}
y <- 6:9
x + y
~~~



~~~{.output}
[1]  7  9 11 13

~~~

Each element of `x` was added to its corresponding element of `y`:


~~~{.r}
x:  1  2  3  4
    +  +  +  +
y:  6  7  8  9
---------------
    7  9 11 13
~~~


> ## Challenge 1 {.challenge}
>
> Let's try this on the `health` column of the `healthData` dataset.
>
> Make a new column in the `healthData` data frame that
> contains health rounded to the nearest integer.
> Check the head or tail of the data frame to make sure
> it worked.
>
> Hint: R has a round() function
>

> ## Challenge 2 {.challenge}
>
> On a single graph, plot neuroticism against health rounded to the nearest integer, 
> for each of the study groups.
>
> Repeat the exercise, graphing only for people with: conscientiousnss greater than 5, 
> self-rated health below 7, and alcohol use in young adulthood of 2.
>

Comparison operators, logical operators, and many functions are also
vectorized:


**Comparison operators**


~~~{.r}
x > 2
~~~



~~~{.output}
[1] FALSE FALSE  TRUE  TRUE

~~~

**Logical operators** 

~~~{.r}
a <- x > 3  # or, for clarity, a <- (x > 3)
a
~~~



~~~{.output}
[1] FALSE FALSE FALSE  TRUE

~~~

> ## Tip: some useful functions for logical vectors {.callout}
>
> `any()` will return `TRUE` if *any* element of a vector is `TRUE`
> `all()` will return `TRUE` if *all* elements of a vector are `TRUE`
>

Most functions also operate element-wise on vectors:

**Functions**

~~~{.r}
x <- 1:4
log(x)
~~~



~~~{.output}
[1] 0.0000000 0.6931472 1.0986123 1.3862944

~~~

Vectorised operations work element-wise on matrices:


~~~{.r}
m <- matrix(1:12, nrow=3, ncol=4)
m * -1  
~~~



~~~{.output}
     [,1] [,2] [,3] [,4]
[1,]   -1   -4   -7  -10
[2,]   -2   -5   -8  -11
[3,]   -3   -6   -9  -12

~~~
 

> ## Tip: element-wise vs. matrix multiplication {.callout}
>
> Very important: the operator `*` gives you element-wise multiplication!
> To do matrix multiplication, we need to use the `%*%` operator:
> 
> 
> ~~~{.r}
> m %*% matrix(1, nrow=4, ncol=1)
> ~~~
> 
> 
> 
> ~~~{.output}
>      [,1]
> [1,]   22
> [2,]   26
> [3,]   30
> 
> ~~~
> 
> 
> 
> ~~~{.r}
> matrix(1:4, nrow=1) %*% matrix(1:4, ncol=1)
> ~~~
> 
> 
> 
> ~~~{.output}
>      [,1]
> [1,]   30
> 
> ~~~
>
> For more on matrix algebra, see the [Quick-R reference
> guide](http://www.statmethods.net/advstats/matrix.html)

> ## Challenge 3 {.challenge}
>
> Given the following matrix:
>
> 
> ~~~{.r}
> m <- matrix(1:12, nrow=3, ncol=4)
> m
> ~~~
> 
> 
> 
> ~~~{.output}
>      [,1] [,2] [,3] [,4]
> [1,]    1    4    7   10
> [2,]    2    5    8   11
> [3,]    3    6    9   12
> 
> ~~~
>
> Write down what you think will happen when you run:
>
> 1. `m ^ -1`
> 2. `m * c(1, 0, -1)`
> 3. `m > c(0, 20)`
> 4. `m * c(1, 0, -1, 2)`
>
> Did you get the output you expected? If not, ask a helper!
>

> ## Challenge 4 {.challenge}
>
> We're interested in looking at the sum of the
> following sequence of fractions:
>
> 
> ~~~{.r}
>  x = 1/(1^2) + 1/(2^2) + 1/(3^2) + ... + 1/(n^2)
> ~~~
>
> This would be tedious to type out, and impossible for high values of
> n.  Use vectorisation to compute x when n=100. What is the sum when
> n=10,000?


## Challenge solutions

> ## Solution to challenge 1 {.challenge}
>
> Let's try this on the `health` column of the `healthData` dataset.
>
> Make a new column in the `healthData` data frame that
> contains health rounded to the nearest integer.
> Check the head or tail of the data frame to make sure
> it worked.
>
> Hint: R has a round() function
>
> 
> ~~~{.r}
> healthData$healthInteger <- round(healthData$health)
> head(gapminder)
> ~~~
> 
> 
> 
> ~~~{.error}
> Error in head(gapminder): object 'gapminder' not found
> 
> ~~~
>

> ## Solution to challenge 2 {.challenge}
>
>
> On a single graph, plot neuroticism against health rounded to the nearest integer, 
> for each of the study groups.
>
> Repeat the exercise, graphing only for people with: conscientiousnss greater than 5, 
> self-rated health below 7, and alcohol use in young adulthood of 2.
>
>
> 
> ~~~{.r}
>  ggplot(healthData, aes(x = healthInteger, y = neuroticism)) + 
>   geom_point()
> ~~~
> 
> <img src="fig/09-vectorisation-ch2-sol-1.png" title="plot of chunk ch2-sol" alt="plot of chunk ch2-sol" style="display: block; margin: auto;" />
> 
> ~~~{.r}
>  ggplot(healthData[healthData$conscientiousness > 5 & healthData$selfRatedHealth < 7 & healthData$alcoholUseInYoungAdulthood == 2,],
>         aes(x = healthInteger, y = neuroticism)) + 
>    geom_point()
> ~~~
> 
> 
> 
> ~~~{.error}
> Warning: Removed 119 rows containing missing values (geom_point).
> 
> ~~~
> 
> <img src="fig/09-vectorisation-ch2-sol-2.png" title="plot of chunk ch2-sol" alt="plot of chunk ch2-sol" style="display: block; margin: auto;" />
>

> ## Solution to challenge 3 {.challenge}
>
> Given the following matrix:
>
> 
> ~~~{.r}
> m <- matrix(1:12, nrow=3, ncol=4)
> m
> ~~~
> 
> 
> 
> ~~~{.output}
>      [,1] [,2] [,3] [,4]
> [1,]    1    4    7   10
> [2,]    2    5    8   11
> [3,]    3    6    9   12
> 
> ~~~
>
>
> Write down what you think will happen when you run:
>
> 1. `m ^ -1`
>
> 
> ~~~{.output}
>           [,1]      [,2]      [,3]       [,4]
> [1,] 1.0000000 0.2500000 0.1428571 0.10000000
> [2,] 0.5000000 0.2000000 0.1250000 0.09090909
> [3,] 0.3333333 0.1666667 0.1111111 0.08333333
> 
> ~~~
>
> 2. `m * c(1, 0, -1)`
>
> 
> ~~~{.output}
>      [,1] [,2] [,3] [,4]
> [1,]    1    4    7   10
> [2,]    0    0    0    0
> [3,]   -3   -6   -9  -12
> 
> ~~~
>
> 3. `m > c(0, 20)`
>
> 
> ~~~{.output}
>       [,1]  [,2]  [,3]  [,4]
> [1,]  TRUE FALSE  TRUE FALSE
> [2,] FALSE  TRUE FALSE  TRUE
> [3,]  TRUE FALSE  TRUE FALSE
> 
> ~~~
>

> ##  Challenge 4 {.challenge}
>
> We're interested in looking at the sum of the
> following sequence of fractions:
>
> 
> ~~~{.r}
>  x = 1/(1^2) + 1/(2^2) + 1/(3^2) + ... + 1/(n^2)
> ~~~
>
> This would be tedious to type out, and impossible for
> high values of n.
> Can you use vectorisation to compute x, when n=100?
> How about when n=10,000?
>
> 
> ~~~{.r}
> sum(1/(1:100)^2)
> ~~~
> 
> 
> 
> ~~~{.output}
> [1] 1.634984
> 
> ~~~
> 
> 
> 
> ~~~{.r}
> sum(1/(1:1e04)^2)
> ~~~
> 
> 
> 
> ~~~{.output}
> [1] 1.644834
> 
> ~~~
> 
> 
> 
> ~~~{.r}
> n <- 10000
> sum(1/(1:n)^2)
> ~~~
> 
> 
> 
> ~~~{.output}
> [1] 1.644834
> 
> ~~~
> 
> We can also obtain the same results using a function:
> 
> ~~~{.r}
> inverse_sum_of_squares <- function(n) {
>   sum(1/(1:n)^2)
> }
> inverse_sum_of_squares(100)
> ~~~
> 
> 
> 
> ~~~{.output}
> [1] 1.634984
> 
> ~~~
> 
> 
> 
> ~~~{.r}
> inverse_sum_of_squares(10000)
> ~~~
> 
> 
> 
> ~~~{.output}
> [1] 1.644834
> 
> ~~~
> 
> 
> 
> ~~~{.r}
> n <- 10000
> inverse_sum_of_squares(n)
> ~~~
> 
> 
> 
> ~~~{.output}
> [1] 1.644834
> 
> ~~~
>

