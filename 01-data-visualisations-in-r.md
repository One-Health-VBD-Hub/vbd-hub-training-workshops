# (PART) Workshop 1: Data Visualisations in R {-}

# Introduction


## Learning objectives

**By the end of this workshop, you should be able to:**

1. Generate accessible visualisations to communicate complex data to different audiences and stakeholders.
2. Formulate data-driven hypotheses from effective data visualisations.
3. Build collaborative, professional connections within the VBD community.


## Prerequisites

**Before participating in this workshop, you should have:**

- Foundational knowledge of programming in R.
- Experience of formatting data and statistics in R.
- Basic understanding of VBDs.


## Training Plan

### Pre- live session content
This is to be completed ahead of the Live Session.
Content will be available on the Hub under Learning Resources.
The VBD Hub Forum is available for support and networking.


### Live session
10:00 - 13:00 on Thursday 19th March, via Teams.
Content will be made available on the Hub under Learning Resources on the day of the Live Session.


### Post- Live Session Challenge Task
Multi-stage task to be completed independently after the Live Session. The stages will increase in difficulty and provide an opportunity to apply what you have learnt to real VBD datasets.
Content will be posted on the Hub under Learning Resources on the day of the Live Session.
The VBD Hub Forum will be available for support and networking).


## Navigating Course Content
Many of the tasks in this workshop will be in a workbook-style format and will walk you through how to code specific functions and models. We encourage you to type this code yourself to practice syntax and gain the most out of the content provided, rather than copying and pasting.


All the datasets in this workshop have been tidied and wrangled for you. This is so we can focus on the key themes within this session - effective visualisations and graphics. Raw data is also provided, and we recommend you take a look at the “before” and “after” to better understand the data we are working with. To recap data wrangling in R, see here.


All coding through this workshop will be done in Rstudio, a user friendly IDE (integrated development environment) for R language. Please ensure you have R and RStudio installed and updated ahead of the Live Session. If you do not already have R or RStudio installed, see here.


## Available Materials & Support
If you need a quick reminder of basic coding in R, additional materials and cheat sheets can be found here:

- Basic R syntax & functions
- Data wrangling (read up to Data visualization)
- Basic hypothesis testing
-	Basic R cheatsheet
-	Data wrangling with dplyr and tidyr cheatsheet


If you need additional support through this workshop:

- The [**Forum**](http://forum.vbdhub.org) is a good place to discuss queries with fellow participants.
- Demonstrators will be available to help during the **Live Session**.
- During the **Challenge Task**, a specific discussion on the Forum will be open to ask demonstrators questions. One-to-one video support will also be available if required.
- For technical support (e.g. trouble accessing content or joining the Teams link), please contact (email). This is **not** for coding or statistical support.


## Installing Packages
This workshop will use several R packages throughout, please install these ahead of the **Live Session**.


**Packages for this workshop:**
(to be added when coding tasks)


::: {.rmdtip}
**Reminder:** To install packages in R, use the `install.packages()` command.
:::

To install one package:
``` r
install.packages("ggplot2")
```

To install multiple packages:
``` r
install.packages(c("ggplot2", "dplyr", "tidyr"))
```

# Pre- Live Session Content


[link to optional recap of linear models and basic plots](#recap)


## What can Visualisations Tell Us About Data?
We can draw several pieces of information from plots…


Example plots with prompts on data patterns (VBD specific).


Provide datasets, select appropriate plot, note patterns from data.


## Formulating Hypotheses From Visualisations
Given the information plots can tell us, we can draw hypotheses…


Example tasks - provide plots and have participants formulate hypotheses.


## Commonly Used Visualisations for VBD Data
Present a range of options (good and bad) of plots typically used for VBD data.


In this training, we will focus on abundance plots.


## Form (ahead of Live Session)
Used to gain an idea of what level the participants are at to cater the Live Session (last minute). Were they able to complete the tasks from the pre-content?


For the specified datasets, what data types did you identify?


What plot would you use for the specified datasets?


What hypotheses can you draw from the specified plots?


Use some strong (anonymised) examples in the recap part of the Live Session.


(optional) Reflection - Question along the lines of “What is one visualisation mistake you have made in the past?”


# Live Session


## Live Session Schedule 
10:00 - Introduction
10:10 - Recap pre- Live Session
10:20 - Build on Abundance Plots
10:40 - Drawing Hypotheses from Complex Plots
10:50 - BREAK
11:00 - What Makes a Good Visualisation?
11:15 - Collaborative task
12:00 - BREAK
12:10 - Share Collaborative Task Results
12:25 - Communicating to Different Audiences
12:40 - Visualisation Themes & Accessible Graphics
12:50 - Prepare for Challenge Task & Conclusion


## Introduction (10 mins)
Introduce myself


Introduce demonstrators


Recap Learning Objectives


Reiterate where to find support:
Forum
Demonstrators
Technical difficulties - (email)


## Recap Pre- Live Session Content (10 mins)
What went well?


Common mistakes?


Strong anonymous examples


## Building on Abundance Plots (30 mins)
Abundance over time


Abundance with multiple species


Abundance with multiple species over time


(maybe) mention temperature


## Drawing Hypotheses from Complex Visualisations (10 minutes)
Time-specific example


Species-specific example


## What Makes a Good Visualisation? (15 mins) 
Whiteboard discussion


Pros


Cons


## Collaborative Task (45 mins)
Breakout rooms - participants are given a messy or incorrect graph and need to work together to fix it.


Ideally I would like each breakout room to have a different “problem” graph to fix, but this will depend on timings when developing content.


## Share Collaborative Graphics (15 mins)
4 graphs to go through


I think it would be cool to share the graphs from each group to show what was wrong and what was done to fix it (demonstrators send graphs to me in a short 5 min break, I would share on my screen to avoid delays with swapping screens), but it could be the same graph across all groups if limited by time.


What went wrong?


What did you do to fix it?


Why?


## Communicating to Different Audiences (15 mins)
Academics, policy makers, public engagement


What the audience needs and what to emphasise.


## Visualisation Themes & Accessible Graphics (15 mins)
ggplot themes


Colour blind friendly, alt-text, font size, contrast, shapes as well as colour, clear legends


## Prepare for Challenge Task & Conclusion
Outline task


Where to find support


Conclusion


# Challenge Task 

(TBC)

## Level 1
Identify data types from the provided dataset.


Plot an abundance plot for two species.


## Level 2
Plot a trait over time (for a second but related dataset)


## Level 3
Draw some hypotheses from your visualisations.


## Level 4
Identify visual or accessibility limitations across your plots.


Make the themes consistent across all your plots.


Apply accessible elements.


## Level 5
Present your graphs as if you were presenting to:
i) Academics
ii) Policy makers
iii) Public engagement















































