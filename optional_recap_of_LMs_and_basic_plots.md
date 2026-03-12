# (APPENDIX) Optional Recap of LMs and Basic Plots {-}

# Recap of Linear Models & Basic Plots (optional) {#recap}


Before we dive into the wonderful world of plots and visualisations, let's turn our attention to the models we will be using to plot outputs. Here, we will recap simple linear models - linear regression models and ANOVAs. There are several ways to approach these, but using a consistent approach throughout this workshop will contribute to shared understanding to make the most of the tasks and collaborative opportunities to follow.


Following this, we will cover some basic plots that are commonly used during exploratory data analysis. These can help us make decisions about which statistical models and visualisations are appropriate for our data.


## Linear Models

### Linear Regression Models
Linear regression models are a commonly used type of linear model, which are particularly useful when both the response and predictor variables are continuous. We use linear regression models to quantify the relationship between these two variables so that we can identify trends and make predictions from the data.


Linear regression models fit a straight line relationship between the response variable and continuous explanatory variable, which can be shown as the equation:
(insert equation for linear regression model)

$$
y = mx + c
$$


To code a linear regression model, we can use the following syntax:

``` r
specificModelName <- lm(responseVariable ~ explanatoryVariable, data = yourDataset)
```

::: {.rmdtip}
**Tip:** When naming models or other objects in R, try to use specific names so you know what your object is explicitly. Using short names like model1, model2, etc. can get confusing.
:::

::: {.rmdcaution} 
**Frequent Mistake:**

- R cannot handle spaces in object names. There are a few options for alternative syntax, we would recommend using camelCase where letters are capitalised to indicate new words (e.g. `specificModelName`), or using an underscore to connect words (e.g. `specific_model_name`).
- If using camelCase, remember that R is case sensitive - if your object is named `specificModelName`, but you call `specificmodelname`, R will show an error:
```
#> Error: object ‘specificmodelname’ not found.
```

:::


To view the output of a linear regression model, we can use the summary() function:
``` r
summary(specificModelName)
```
This will show a lot of information (which is useful to familiarise yourself with), but for this workshop, we are primarily interested in the Coefficients table.


This table will have one row for each coefficient in the model - two rows for a simple linear regression model: the Intercept and the Slope.

- The Intercept estimate represents the predicted value of the response variable when the explanatory variable is zero.
- The Slope estimate is proportional to the correlation coefficient between the response variable and explanatory variable, scaled by the ratio of standard deviations. Put simply, this estimate represents the strength (value) and direction (positive or negative) of the relationship between the response and explanatory variables.



The Coefficient table also shows the details for a t-test, which tells us whether or not the slope and intercept are significantly different from zero.

- `Std. Error` - how far observations sit from the regression line.
- `t value` - the estimate divided by the standard error.
- `Pr(>|t|)` - the p-value, used to inform the probability of observing this result if the true coefficient was zero.


::: {.rmdtip}
**Tip:**
When we plot a line of best fit, this reflects the mean, variance, and correlations in your dataset. Knowledge on these model coefficients will help you better understand the plots and visualisations we do later in this workshop.
:::


### ANOVA Models
What happens if your explanatory variable is categorical, rather than continuous? This is where ANOVA models come in, or the **AN**alysis **O**f **VA**riance across the means of different groups or categories. An ANOVA is a useful type of linear model, particularly when the response variable is continuous, and the explanatory variable is categorical.


Coding an ANOVA is essentially the same as a linear regression model - we still use the lm() function to fit the relationship between a response and explanatory variable. However, now that the explanatory variable is categorical, the slope represents the difference between group (category) means.


``` r
specificModelName <- lm(continuousResponse ~ categoricalExplanatory, data = yourDataset)
```

As before, we can use the `summary()` function to check the model output and view the Coefficients table (which will be laid out in the same way as a linear regression model output).


``` r
summary(specificModelName)
```


Despite looking the same, there are some differences for an ANOVA output:

- The Intercept is the mean of the first category.
- The Slope is the difference between the mean of the first category and this (named) category.


While the `summary()` function can be used to assess the differences between specific categories, the `anova()` function can tell us whether or not the categorical explanatory variable as a whole has a significant effect on the response variable.


``` r
anova(specificModelName)
```


The output of the `anova()` function also provides a table, which lists the following statistics:

- `Df` - refers to the number of categories and observations.
- `Sum Sq` & `Mean Sq` - measures of variance between or within categories. 
- `F-value` - the ratio of explained variance to unexplained variance (a higher F-value indicates the categorical variable has a significant effect). 
- `Pr(>F)` - the p-value, used to inform the probability of observing this F-value if there was no true difference between the categories.


::: {.rmdtip}
**Tip:**

- Use `summary()` if you are interested in the category means and differences of the explanatory variable.
- Use `anova()` if you are interested in the overall significance of the explanatory variable on the response variable.

:::


If you are interested in further linear models, you can find resources here:

- Linear Models: Multiple explanatory variables
- Linear Models: Multiple variables with interactions

**This additional content is optional, and is not necessary to complete this workshop.**


## Basic Plots


### Scatter Plots
A scatter plot can be used when you want to visualise the relationship between two continuous variables.


Plotting raw data with a scatter plot allows you to identify trends in the data, including direction and strength of the relationship between the variables. You can also spot outlier observations that deviate from the general pattern, and the shape of the data can help decide whether a linear or non-linear model is appropriate for your dataset.


To plot a simple scatter plot, we can use the `plot()` function:


`plot(myDataframe$variable1, myDataframe$variable2)`


::: {.rmdcaution}
**Frequent Mistake:** If you just press `plot()` without describing specific variables in your dataset, you will end up with a messy and overwhelming visualisation. Use `$` and specify the specific variables you want to compare.
:::


### Histograms
Histograms are used to visualise the distribution on a single continuous variable. This is done by splitting the range of values into intervals, called bins, and calculating the frequency of data points that sit in each interval.


Histograms can be particularly useful to check whether your data is normally distributed or skewed, to view the variance (or spread) of your data, and to identify gaps in the data which may suggest issues with data collection.


Histograms do not show us the relationship between variables. However, we can plot two histograms for two variables we want to compare so that we can assess the distributions of the two variables.


To plot a simple histogram, we can use the `hist()` function:


`hist(myDateframe$variable1)`


### Boxplots
Boxplots are used to compare the distribution of a continuous variable across different groups or categories. They are particularly useful when your response variable is continuous, and your explanatory variable is categorical. 


A boxplot summarises the distribution of data using five key statistics:

- The minimum value
- The lower quartile (Q1)
- The median
- The upper quartile (Q3)
- The maximum value


The box represents the interquartile range (IQR), which contains the middle 50% of the data. Values that fall outside this range may appear as outliers. 


Boxplots summarise the distribution and variation of the data, but do not show individual observations. Therefore, some detailed variation within the dataset may not be visible. 


To plot a simple boxplot, we can use the `boxplot()` function:


`boxplot(myDataframe$continuousVariable ~ myDataframe$categoricalVariable)`


## Reading & Resources
Coming soon



::: {.rmdtip}
**Tip:** This is a tip.
:::

::: {.rmdnote}
**Note:** This is a note.
:::

::: {.rmdimportant}
**Important:** This is important.
:::

::: {.rmdcaution}
**Caution:** This is a caution.
:::

::: {.rmdwarning}
**Warning:** This is a warning.
:::
















