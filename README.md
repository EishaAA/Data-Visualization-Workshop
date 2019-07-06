# MiCM Data Visualization Workshop

Last Modified: Eisha Ahmed - July 5, 2019

##### Table of Contents  
[Course Outline](#course-outline)  
[Setting up your R and R Studio environment](#setup) 


---
<a name="course-outline"/>

## Course Outline

### Overview
Data visualization (DV) is a form of visual communication used to present data, and is important across many disciplines. This course will cover the core principles of good graphics and best practices, how to choose a visualization approach depending on the type of data and the desired message, and demonstrations of how DV can yield insights into data otherwise lost or buried by statistics alone. Participants will also learn how to visualize data and implement basic graphics in R, and generate their own graphics to visualize data. Source code for demonstrated charts will be made available to workshop participants.

The focus of this course is on DV principles that translate to any tool or programming language. Although this workshop will discuss the implementation of common graphics in R as a demonstration, it not an R programming course and will not delve into the details of data manipulation techniques.

### Course Contents
* **Principles of good graphics:** Core principles of good DV, including the selection of the appropriate visualization strategy for the data and message, what makes an effective graphic, and what to avoid.
* **Types of visualization graphics:** Survey various DV approaches for different types of data, from the basics to more specialized presentations (such as bar graphs and variants, scatter plots, line charts, box plots, heatmaps, colourmaps, dendograms, and networks).
* **Visualizing data in R:** How to visualize data and generate various graphic types in R. We will explore both methods that use build-in R functions and external libraries for visualization (such as ggplot2, Leaflet, RGL, Lattice, highcharter).

---
<a name="setup"/>

## Setting up your R and R Studio environment

It is highly recommended that you install R and R studio on your computer *before* hand, as we will not be discussing installation or setup during the workshop. Multiple tutorials are available online that can guide you through the installation processes for your computer and operating system.

**If you have never installed R and/or R Studio**, you can access the download links to the latest releases from the following URLs (install R first):

* R for MacOS: https://cran.r-project.org/bin/macosx/
* R for Windows: https://cran.r-project.org/bin/windows/base/
* R Studio: https://www.rstudio.com/products/rstudio/download/#download

Examples of one such helpful tutorial (skip the SDSFoundations installation instructions):
https://courses.edx.org/courses/UTAustinX/UT.7.01x/3T2014/56c5437b88fa43cf828bff5371c6a924/

**If you already have R and R Studio**, please confirm that you have R version ≥3.2.0 installed. You can do so by running the following line of code in the R console to check the version number:

```R
R.Version()$version.string
```

### Updating R and R Studio

If needed, there are a few different ways of updating your version of R and R Studio depending on your operating system. The easist method is to simply manually download and re-install the latest version, then restart R Studio. The new version of R will be loaded automatically. Note that this method will not automatically carry over installed R packages, thus they will have to be re-installed.

If you are working on a Mac, I highly reccomend you go this route and spare yourself the headache (I have had troubles recently with the updateR method described in multiple tutorials).

If you are working a Windows machine, you can also update R using the installr package to update the software. A full tutorial on how to do this can be found here: https://www.r-statistics.com/2013/03/updating-r-from-r-on-windows-using-the-installr-package/

### Installing R packages

Finally to prepare your R environment, you can install the R packages that will be used during this workshop in advance. In R Studio, you can install the packages line-by-line by running the following lines of code:

```R
install.packages("ggplot2")
install.packages("lattice")
install.packages("leaflet")
install.packages("rgl")
install.packages("highcharter")
```

Finally, we will load these libraries into our workspace and check the version numbers to ensure there are no errors:

```R
# load packages into workspace
allPackages <- c("ggplot2", "lattice", "leaflet", "rgl", "highcharter")
lapply(allPackages, library, character.only = TRUE)
```

No error messages should be returned after loading the libraries.

*Note for macOS users:* When initially attempting to install RGL on macOS, you may get the following error:

```
'Error in dyn.load(file, DLLpath = DLLpath, ...)... On MacOS, rgl depends on XQuartz, which you can download from xquartz.org'.
```

First download XQuatrz from xquartz.org, then restart your computer. You should now be able to load the RGL library without any error messages.

Now you can check the version numbers of each package:

```R
lapply(allPackages, function(x) sprintf("%s version %s", x, packageVersion(x)))
```

That's it, your environment setup is complete. Now you're ready to jump into data visualization in R!
