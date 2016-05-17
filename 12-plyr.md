---
layout: page
title: R for reproducible scientific analysis
subtitle: Split-apply-combine
minutes: 45
---



> ## Learning Objectives {.objectives}
>
> * To be able to use the split-apply-combine strategy for data analysis
>

Previously we looked at how you can use functions to simplify your code.
We defined the `calcBirthYearAverage` function, which takes the healthData dataset,
and calculates the average birth year in the data. We also defined an
additional argument so we could filter by HIGroup:


~~~{.r}
# Takes a dataset and calculates the average year of birth for a
# specified study group.
calcBirthYearAverage <- function(dat, group = 1) {
  birthYearAverage <- mean(dat[dat$HIGroup == group, ]$birthYear)
  return(birthYearAverage)
}
~~~

A common task you'll encounter when working with data is that you'll want to
run calculations on different groups within the data. In the above, we are
simply calculating the mean birth year in the data. But what if
we wanted to calculated the mean birth year per sex, or per year of school?

We could, for example, run `calcBirthYearAverage` and on each subsetted dataset:


~~~{.r}
calcBirthYearAverage(healthData[healthData$education == 1,],1)
~~~



~~~{.output}
[1] NA

~~~



~~~{.r}
calcBirthYearAverage(healthData[healthData$education == 2,],1)
~~~



~~~{.output}
[1] NA

~~~



~~~{.r}
calcBirthYearAverage(healthData[healthData$education == 3,],1)
~~~



~~~{.output}
[1] NA

~~~

But this isn't very *nice*. Yes, by using a function, you have reduced a
substantial amount of repetition. That **is** nice. But there is still
repetition. Repeating yourself will cost you time, both now and later, and
potentially introduce some nasty bugs.

We could write a new function that potentially more flexible than `calcBirthYearAverage`, but this
also takes a substantial amount of effort and testing to get right.

The abstract problem we're encountering here is known as "split-apply-combine":

![Split apply combine](fig/splitapply.png)

We want to *split* our data into groups, in this case education levels, *apply*
some calculations on that group, then optionally *combine* the results
together afterwards.

## The `plyr` package

For those of you who have used R before, you might be familiar with the
`apply` family of functions. While R's built in functions do work, we're
going to introduce you to another method for solving the "split-apply-combine"
problem. The [plyr](http://had.co.nz/plyr/) package provides a set of
functions that we find more user friendly for solving this problem.

Let's load plyr now:


~~~{.r}
library(plyr)
~~~

Plyr has functions for operating on `lists`, `data.frames` and `arrays`
(matrices, or n-dimensional vectors). Each function performs:

1. A **split**ting operation
2. **Apply** a function on each split in turn.
3. Re**combine** output data as a single data object.

The functions are named based on the data structure they expect as input,
and the data structure you want returned as output: [a]rray, [l]ist, or
[d]ata.frame. The first letter corresponds to the input data structure,
the second letter to the output data structure, and then the rest of the
function is named "ply".

This gives us 9 core functions **ply.  There are an additional three functions
which will only perform the split and apply steps, and not any combine step.
They're named by their input data type and represent null output by a `_` (see
table)

Note here that plyr's use of "array" is different to R's,
an array in ply can include a vector or matrix.

![Full apply suite](fig/full_apply_suite.png)


Each of the xxply functions (`daply`, `ddply`, `llply`, `laply`, ...) has the
same structure and has 4 key features and structure:


~~~{.r}
xxply(.data, .variables, .fun)
~~~

* The first letter of the function name gives the input type and the second gives the output type.
* .data - gives the data object to be processed
* .variables - identifies the splitting variables
* .fun - gives the function to be called on each piece

Now we can quickly calculate the mean birth year per education level:


~~~{.r}
ddply(
 .data = healthData,
 .variables = "education",
 .fun = function(x) mean(x$birthYear)
)
~~~



~~~{.output}
   education       V1
1          1 1955.200
2          2 1946.600
3          3 1948.510
4          4 1946.634
5          5 1936.333
6          6 1922.328
7          7 1944.333
8          8 1927.964
9          9 1923.568
10        NA 1955.647

~~~

Let's walk through what just happened:

- The `ddply` function feeds in a `data.frame` (function starts with **d**) and
returns another `data.frame` (2nd letter is a **d**) i
- the first argument we gave was the data.frame we wanted to operate on: in this
  case the healthData dataset.
- The second argument indicated our split criteria: in this case the "education"
  column. Note that we just gave the name of the column, not the actual column
  itself like we've done previously with subsetting. Plyr takes care of these
  implementation details for you.
- The third argument is the function we want to apply to each grouping of the
  data. We had to define our own short function here: each subset of the data
  gets stored in `x`, the first argument of our function. This is an anonymous
  function: we haven't defined it elsewhere, and it has no name. It only exists
  in the scope of our call to `ddply`.

What if we want a different type of output data structure?:


~~~{.r}
dlply(
 .data = healthData,
 .variables = "education",
 .fun = function(x) mean(x$birthYear)
)
~~~



~~~{.output}
$`1`
[1] 1955.2

$`2`
[1] 1946.6

$`3`
[1] 1948.51

$`4`
[1] 1946.634

$`5`
[1] 1936.333

$`6`
[1] 1922.328

$`7`
[1] 1944.333

$`8`
[1] 1927.964

$`9`
[1] 1923.568

$`NA`
[1] 1955.647

attr(,"split_type")
[1] "data.frame"
attr(,"split_labels")
   education
1          1
2          2
3          3
4          4
5          5
6          6
7          7
8          8
9          9
10        NA

~~~

We called the same function again, but changed the second letter to an `l`, so
the output was returned as a list.

We can specify multiple columns to group by:


~~~{.r}
ddply(
 .data = healthData,
 .variables = c("education","sex"),
 .fun = function(x) mean(x$birthYear)
)
~~~



~~~{.output}
   education    sex       V1
1          1 Female 1955.500
2          1   Male 1955.000
3          2 Female 1933.000
4          2   Male 1955.667
5          3 Female 1946.059
6          3   Male 1949.812
7          4 Female 1948.621
8          4   Male 1945.099
9          5 Female 1927.278
10         5   Male 1942.725
11         6 Female 1921.538
12         6   Male 1923.106
13         7 Female 1945.255
14         7   Male 1943.491
15         8 Female 1928.059
16         8   Male 1927.860
17         9 Female 1928.753
18         9   Male 1920.663
19        NA Female 1955.833
20        NA   Male 1955.438

~~~


~~~{.r}
daply(
 .data = healthData,
 .variables = c("education","sex"),
 .fun = function(x) mean(x$birthYear)
)
~~~



~~~{.output}
         sex
education   Female     Male
     1    1955.500 1955.000
     2    1933.000 1955.667
     3    1946.059 1949.812
     4    1948.621 1945.099
     5    1927.278 1942.725
     6    1921.538 1923.106
     7    1945.255 1943.491
     8    1928.059 1927.860
     9    1928.753 1920.663
     <NA> 1955.833 1955.438

~~~

You can use these functions in place of `for` loops (and its usually faster to
do so): just write the body of the for loop in the anonymous function:


~~~{.r}
d_ply(
  .data=healthData,
  .variables = "education",
  .fun = function(x) {
    meanBirthYear <- mean(x$birthYear)
    print(paste(
      "The mean year of birth for education level", unique(x$education),
      "is", format(meanBirthYear, big.mark=",")
   ))
  }
)
~~~



~~~{.output}
[1] "The mean year of birth for education level 1 is 1,955.2"
[1] "The mean year of birth for education level 2 is 1,946.6"
[1] "The mean year of birth for education level 3 is 1,948.51"
[1] "The mean year of birth for education level 4 is 1,946.634"
[1] "The mean year of birth for education level 5 is 1,936.333"
[1] "The mean year of birth for education level 6 is 1,922.328"
[1] "The mean year of birth for education level 7 is 1,944.333"
[1] "The mean year of birth for education level 8 is 1,927.964"
[1] "The mean year of birth for education level 9 is 1,923.568"
[1] "The mean year of birth for education level NA is 1,955.647"

~~~

> ## Tip: printing numbers {.callout}
>
> The `format` function can be used to make numeric
> values "pretty" for printing out in messages.
>


> ## Challenge 1 {.challenge}
>
> Calculate the average intellect per education level. Which has the highest?
> Which had the lowest?
>

> ## Challenge 2 {.challenge}
>
> Calculate the average intellect per mental adjustment value and sex. Which had the
> highest and lowest in HIGroup 2? Which had the greatest change across between groups?
>

> ## Advanced Challenge {.challenge}
>
> Calculate the difference in intellect between
> education level 5 and 9 from the output of challenge 2
> using one of the `plyr` functions.
>

> ## Alternate Challenge if class seems lost {.challenge}
>
> Without running them, which of the following will calculate the average conscientiousness > per education year:
>
> 1.
> 
> ~~~{.r}
> ddply(
>   .data = healthData,
>   .variables = healthData$education,
>   .fun = function(dataGroup) {
>      mean(dataGroup$conscientiousness)
>   }
> )
> ~~~
>
> 2.
> 
> ~~~{.r}
> ddply(
>   .data = healthData,
>   .variables = "education",
>   .fun = mean(dataGroup$conscientiousness)
> )
> ~~~
>
> 3.
> 
> ~~~{.r}
> ddply(
>   .data = healthData,
>   .variables = "education",
>   .fun = function(dataGroup) {
>      mean(dataGroup$concientiousness)
>   }
> )
> ~~~
>
> 4.
> 
> ~~~{.r}
> adply(
>   .data = healthData,
>   .variables = "education",
>   .fun = function(dataGroup) {
>      mean(dataGroup$conscientiousness)
>   }
> )
> ~~~
>
