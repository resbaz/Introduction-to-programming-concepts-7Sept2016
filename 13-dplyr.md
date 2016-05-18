---
layout: page
title: R for reproducible scientific analysis
subtitle: Dataframe manipulation with dplyr
minutes: 90
---



> ## Learning Objectives {.objectives}
>
> * To be able to use the 6 main dataframe manipulation 'verbs' with pipes in `dplyr`
>

Manipulation of dataframes means many things to many researchers, we often select certain observations (rows) or variables (columns), we often group the data by a certain variable(s), or we even calculate summary statistics. We can do these operations using the normal base R operations:


~~~{.r}
mean(healthData[healthData$HIGroup == "Group 1", "health"])
~~~



~~~{.output}
[1] 9.199115

~~~



~~~{.r}
mean(healthData[healthData$HIGroup == "Group 2", "health"])
~~~



~~~{.output}
[1] 9.660906

~~~

But this isn't very *nice* because there is a fair bit of repetition. Repeating yourself will cost you time, both now and later, and potentially introduce some nasty bugs.

## The `dplyr` package

Luckily, the [`dplyr`](https://cran.r-project.org/web/packages/dplyr/dplyr.pdf) package provides a number of very useful functions for manipulating dataframes in a way that will reduce the above repetition, reduce the probability of making errors, and probably even save you some typing. As an added bonus, you might even find the `dplyr` grammar easier to read.

Here we're going to cover 6 of the most commonly used functions as well as using pipes (`%>%`) to combine them. 

1. `select()`
2. `filter()`
3. `group_by()`
4. `summarize()`
5. `mutate()`

If you have have not installed this package earlier, please do so:


~~~{.r}
install.packages('dplyr')
~~~

Now let's load the package:


~~~{.r}
library(dplyr)
~~~

## Using select()

If, for example, we wanted to move forward with only a few of the variables in our dataframe we could use the `select()` function. This will keep only the variables you select.


~~~{.r}
sex_health_neuroticism <- select(healthData,sex,health,neuroticism)
~~~

![](fig/13-dplyr-fig1.png)

If we open up `sex_health_neuroticism` we'll see that it only contains the sex, health and neuroticism columns. Above we used 'normal' grammar, but the strengths of `dplyr` lie in combining several functions using pipes. Since the pipes grammar is unlike anything we've seen in R before, let's repeat what we've done above using pipes.


~~~{.r}
sex_health_neuroticism <- healthData %>% select(sex,health,neuroticism)
~~~

To help you understand why we wrote that in that way, let's walk through it step by step. First we summon the healthData dataframe and pass it on, using the pipe symbol `%>%`, to the next step, which is the `select()` function. In this case we don't specify which data object we use in the `select()` function since in gets that from the previous pipe.

## Using filter()

If we now wanted to move forward with the above, but only with data for females, we can combine `select` and `filter`


~~~{.r}
sex_health_neuroticism_female <- health %>%
    filter(sex=="Female") %>%
    select(sex,health,neuroticism)
~~~



~~~{.error}
Error in eval(expr, envir, enclos): object 'health' not found

~~~

> ## Challenge 1 {.challenge}
>
> Write a single command (which can span multiple lines and includes pipes) that will produce a dataframe that has the values for `conscientiousness`, `extraversion` and `intellect` for males. 
>How many rows does your dataframe have and why?
>


As with last time, first we pass the healthData dataframe to the `filter()` function, then we pass the filtered version of the healthData dataframe to the `select()` function. **Note:** The order of operations is very important in this case. If we used 'select' first, filter would not be able to find the variable sex since we would have removed it in the previous step.

## Using group_by() and summarize()

Now, we were supposed to be reducing the error prone repetitiveness of what can be done with base R, but up to now we haven't done that since we would have to repeat the above for each sex. Instead of `filter()`, which will only pass observations that meet your criteria (in the above: `sex=="Female"`), we can use `group_by()`, which will essentially use every unique criteria that you could have used in filter.


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



~~~{.r}
str(healthData %>% group_by(sex))
~~~



~~~{.output}
Classes 'grouped_df', 'tbl_df', 'tbl' and 'data.frame':	2255 obs. of  15 variables:
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
 - attr(*, "vars")=List of 1
  ..$ : symbol sex
 - attr(*, "drop")= logi TRUE
 - attr(*, "indices")=List of 2
  ..$ : int  1231 1232 1233 1234 1235 1236 1237 1238 1239 1240 ...
  ..$ : int  0 1 2 3 4 5 6 7 8 9 ...
 - attr(*, "group_sizes")= int  1024 1231
 - attr(*, "biggest_group_size")= int 1231
 - attr(*, "labels")='data.frame':	2 obs. of  1 variable:
  ..$ sex: Factor w/ 2 levels "Female","Male": 1 2
  ..- attr(*, "vars")=List of 1
  .. ..$ : symbol sex
  ..- attr(*, "drop")= logi TRUE

~~~
You will notice that the structure of the dataframe where we used `group_by()` (`grouped_df`) is not the same as the original `healthData` (`data.frame`). A `grouped_df` can be thought of as a `list` where each item in the `list`is a `data.frame` which contains only the rows that correspond to the a particular value `sex` (at least in the example above).

![](fig/13-dplyr-fig2.png)

## Using summarize()

The above was a bit on the uneventful side because `group_by()` is much more exciting in conjunction with `summarize()`. This will allow you to create new variable(s) by using functions that repeat for each of the sex-specific data frames. That is to say, using the `group_by()` function, we split our original dataframe into multiple pieces, then we can run functions (e.g. `mean()` or `sd()`) within `summarize()`.


~~~{.r}
conscientiousness_by_sex <- healthData %>%
    group_by(sex) %>%
    summarize(mean_conscientiousness=mean(conscientiousness))
~~~

![](fig/13-dplyr-fig3.png)

That allowed us to calculate the mean conscientiousness for each sex, but it gets even better.

> ## Challenge 2 {.challenge}
>
> Calculate the average mentalAdjustment per education. Which had the highest mentalAdjustment and which had the lowest?
>

The function `group_by()` allows us to group by multiple variables. Let's group by `sex` and `education`.



~~~{.r}
intellect_bysex_byeducation <- healthData %>%
    group_by(sex,education) %>%
    summarize(max_intellect=max(intellect))
~~~

That is already quite powerful, but it gets even better! You're not limited to defining 1 new variable in `summarize()`.


~~~{.r}
intellect_health_bysex_byeducation <- healthData %>%
    group_by(sex,education) %>%
    summarize(mean_intellect=mean(intellect),
              sd_intellect=sd(intellect),
              mean_health=mean(health),
              sd_health=sd(health))
~~~

## Using mutate()

We can also create new variables prior to (or even after) summarizing information using `mutate()`.

~~~{.r}
intellect_health_bysex_byeducation <- healthData %>%
    mutate(serialKiller=intellect/mentalAdjustment) %>%
    group_by(sex,education) %>%
    summarize(mean_intellect=mean(intellect),
              sd_intellect=sd(intellect),
              mean_health=mean(health),
              sd_health=sd(health),
              mean_killer=mean(serialKiller),
              sd_killer=sd(serialKiller))
~~~



> ## Advanced Challenge {.challenge}
> Calculate the average intellect for 5 randomly selected females in each sample group. Then arrange the groups in reverse alphabetical order.
> **Hint:** Use the `dplyr` functions `arrange()` and `sample_n()`, they have similar syntax to other dplyr functions.
>

> ## Solution to Challenge 1 {.challenge}
>
>~~~{.r}
>conscientiousness_extraversion_intellect_males <- healthData %>%
>                            filter(sex=="Male") %>%
>                            select("conscientiousness","extraversion","intellect")
>~~~
>
>
>
>~~~{.error}
>Error: All select() inputs must resolve to integer column positions.
>The following do not:
>*  "conscientiousness"
>*  "extraversion"
>*  "intellect"
>
>~~~

> ## Solution to Challenge 2 {.challenge}
>
>~~~{.r}
>mentalAdjustment_byeducation <- healthData %>%
>    group_by(education) %>%
>    summarize(mean_mentalAdjustment=mean(mentalAdjustment))
>~~~

> ## Solution to Advanced Challenge {.challenge}
>
>~~~{.r}
>intellect_5ids_byHIGroup <- healthData %>% 
>    filter(sex=="Female") %>%
>    group_by(HIGroup) %>%
>    sample_n(5) %>%
>    summarize(mean_intellect=mean(intellect)) %>%
>    arrange(desc(HIGroup))
>~~~

## Other great resources
[Data Wrangling Cheat sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)
[Introduction to dplyr](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)
