# (PART) Workshop 2:  Data Wrangling with Hub Search & ohvbd {-}

# Introduction


## Learning objectives

**By the end of this workshop, you should be able to:**

1. Use VBD Hub resources to access shared VBD datasets.
2. Effectively wrangle real-world VDB datasets ready for further analysis.
3. Build collaborative, professional connections within the VBD community.


## Prerequisites

**Before participating in this workshop, you should have:**

- Foundational knowledge of programming in R.
- Experience of formatting data and statistics in R.
- A basic understanding of VBDs.


## Training Plan
### Pre- live session content
This is to be completed ahead of the Live Session.
Content will be available on the Hub under Learning Resources.
The VBD Hub Forum is available for support and networking.


### Live session
10:00 - 13:00 on Thursday 26th March, via Teams.
Content will be made available on the Hub under Learning Resources on the day of the Live Session.


### Post- Live Session Challenge Task
Multi-stage task to be completed independently after the Live Session. The stages will increase in difficulty and provide an opportunity to apply what you have learnt to real VBD datasets.
Content will be posted on the Hub under Learning Resources on the day of the Live Session.
The VBD Hub Forum will be available for support and networking).


## Navigating Course Content
Many of the tasks in this workshop will be in a workbook-style format and will walk you through how to code specific functions and models. We encourage you to type this code yourself to practice syntax and gain the most out of the content provided, rather than copying and pasting.


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


## VBD Hub Overview
What is VBD Hub?


Goals


Impact


## Navigating VBD Hub
Home - what’s there?


Find data - what’s there?


About - what’s there?


Resources - what’s there?


Community - what’s there?


## Resources Available Through VBD Hub & How to Use Them to Access Data


### Hub Search
Hub Search - what is this and how to use it


Task - access a specific dataset with Hub search


### ohvbd package
ohvbd package - what is this and how to use it


ohvbd - install and functions

To install the `ohvbd` package, run the following command:

``` r
install.packages("ohvbd")
```

An example of loading data: 

<!--@chloe You can incorporate code to be run at render time here.
Note: it's best to have as little work as possible for the server to do, so we'll mostly be getting people to use local data.-->


``` r
library(ohvbd)
find_vd_ids()
#> <ohvbd.ids>
#> Database: vd
#>   [1]   216   217   218   219   220   221   222   223   349
#>  [10]   350   351   352   353   354   355   356   361   362
#>  [19]   363   364   365   366   367   368   369   370   371
#>  [28]   372   373   374   390   391   393   394   395   396
#>  [37]   397   398   399   400   401   402   403   404   405
#>  [46]   406   407   408   409   410   411   412   413   414
#>  [55]   415   416   417   418   419   420   421   422   423
#>  [64]   424   425   426   427   428   429   430   431   432
#>  [73]   433   434   435   436   437   438   439   440   441
#>  [82]   442   443   444   445   446   447   449   450   451
#>  [91]   452   453   454   471   472   473   474   475   499
#> [100]   500   504   520   521   522   523   524   525   526
#> [109]   527   528   529   530   531   532   533   534   535
#> [118]   536   537   538   539   540   541   542   543   544
#> [127]   545   546   547   552   556   557   559   560   585
#> [136]   586   589   590   591   595   596   600   601   602
#> [145]   604   605   606   607   608   609   610   611   612
#> [154]   613   614   615   616   617   619   620   621   622
#> [163]   623   624   625   626   627   628   629   630   631
#> [172]   632   633   634   635   636   637   638   639   640
#> [181]   641   642   643   644   645   646   647   648   649
#> [190]   650   651   652   653   654   655   656   657   658
#> [199]   659   660   661   662   663   664   665   666   667
#> [208]   668   669   670   671   672   673   674   675   676
#> [217]   677   678   679   680   681   682   686   687   689
#> [226]   690   691   692   693   694   695   696   697   698
#> [235]   699   700   701   702   703   704   705   706   707
#> [244]   708   709   710   711   712   713   714   715   717
#> [253]   718   719   720   721   722   723   724   725   726
#> [262]   727   728   729   731   732   733   734   735   736
#> [271]   737   738   739   740   741   742   743   744   745
#> [280]   746   747   748   749   750   751   752   753   754
#> [289]   755   756   757   758   759   760   761   762   763
#> [298]   764   765   766   767   768   769   770   771   772
#> [307]   773   774   775   776   777   778   779   780   781
#> [316]   782   783   784   785   786   787   788   789   790
#> [325]   791   792   793   794   795   796   797   798   799
#> [334]   800   801   802   803   804   805   806   807   808
#> [343]   809   810   811   812   813   814   815   816   817
#> [352]   818   819   820   821   822   823   824   825   826
#> [361]   827   828   829   830   831   832   833   834   835
#> [370]   836   837   838   839   840   841   842   843   844
#> [379]   845   846   847   848   850   851   852   853   854
#> [388]   855   856   857   858   859   860   861   862   864
#> [397]   866   867   868   869   870   871   872   873   874
#> [406]   875   876   877   878   880   881   882   883   884
#> [415]   885   886   887   888   889   890   891   892   893
#> [424]   894   895   896   898   900   901   902   903   904
#> [433]   905   906   907   908   909   943   944   945   946
#> [442]   947   948   949   950   952   955   961 27003 27006
#> [451] 27009 27010 27011 27012 27014 27015 27016 27017 27020
#> [460] 27021 27022 27023 27024 27025 27032 27033 27035 27037
#> [469] 27038 27039 27040 27041 27042 27043
```


Task - access a specific dataset with ohvbd (Francis’ vignettes)


### Forum
Forum - what is this and how to use it


Task - introduce yourself on the Forum


## Data Wrangling Principles
Wide to long, check data type


Example task


## Form (ahead of the live session)
Did you access the datasets?


What types of data?


Data wrangling Q


# Live Session


## Schedule
10:00 - Introduction
10:10 - Recap Pre- Live Session Content
10:20 - Data Wrangling (Broad)
10:25 - Replicate/Merging
10:40 - Fix Species Name
11:00 - BREAK
11:10 - Real-World Data is Messy
11:25 - Collaborative Task
12:10 - BREAK
12:20 - Share Results from Collaborative Task
12:35 - Collaboration (Forum)
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


Common mistakes


Strong anonymous examples?


## Data Wrangling (Broad) (5 mins)
Lots of ways to wrangle data, depends on field, data collected, etc.


We will focus on two methods key to VBD data.


## Replicate/Merging (15 mins)
Similar columns across two datasets


Merge by common column


Useful functions


Common mistakes


## Fix Species Name (20 mins)
Find and remove a misnamed species


Remove underscore or spp. Etc. at the end of the species name


Make a column all lowercase


Useful functions


Common mistakes


Combine merging - merge by species


RGBIF for those wanting extra


## Real World Data is Messy (15 mins)
Common trip-ups in “messy” data sets


What to look out for


## Collaborative Task (45 mins)
Find a specified dataset through ohvbd


Identify what makes it messy


Wrangle data


Try to use datasets with multiple messy elements:
Mixed data types
Messy columns (merge)
Messy species names
Wide to long


## Share Results from Collaborative Task (15 mins)
4 groups


What went wrong?


How did you fix it?


Why?


## What Does Collaboration Mean to You? (15 minutes)
Why do you want to collaborate?


What makes a good collaboration?


What makes a bad collaboration?


How could you use the Forum in your own research context for collaboration?


Whiteboard


## Prepare for Challenge Task & Conclusion (10 mins)
Outline Challenge Task


Where to find support


Conclusion


# Challenge Task


## Level 1
Find a dataset using Hub Search or VBD Hub (participant choice)


## Level 2
What data types?


Does it need converting from wide to long?


## Level 3
Do any columns need merging? (second dataset? TBC?)


## Level 4
Check species names


Variable/trait names?


## Level 5
Share your wrangling process in the Forum, feedback to each other


You might choose to pair up with someone using similar data and give peer feedback





