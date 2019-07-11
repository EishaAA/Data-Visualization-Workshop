library(rstudioapi)
library(lattice)
library(datasets)

rm(list=ls())

# set working directory to current path of script
current_path <- getActiveDocumentContext()$path
setwd(dirname(current_path ))

data(mtcars)
data(iris)

# Basic scatter plot: y ~ x =============================================
xyplot(Sepal.Length ~ Petal.Length, data = iris,
       group=Species, auto.key=TRUE,
       type = c("p", "g", "smooth")) # show points, grids, and smoothing lines


# Multiple panels by groups: y ~ x | group
xyplot(Sepal.Length ~ Petal.Length | Species, 
       group = Species, data = iris,
       type = c("p", "smooth"),
       scales = "free")

# Scatterplots for each combination of two factors (varient of above!)
xyplot(mpg ~ wt | cyl.f*gear.f,
       data = mtcars,
       main="Scatterplots by Cylinders and Gears", 
       ylab="Miles per Gallon", xlab="Car Weight")

# 3d scatterplot by factor level: z ~ x*y
# don't actually use this - no static 3D plots!
cloud(mpg ~ wt*mtcars$qsec | cyl.f,
      data = mtcars,
      main="3D Scatterplot by Cylinders") 


# Basic box plot =========================================================
bwplot(Sepal.Length ~ Species,
       data = iris,
       xlab = "Species", ylab = "Sepal Length")


# we can make a violin plot using panel = panel.violin
bwplot(Sepal.Length ~ Species,
       data = iris,
       panel = panel.violin,
       xlab = "Species", ylab = "Sepal Length")

# Basic dot plot
dotplot(len ~ dose,  data = ToothGrowth,
        xlab = "Dose", ylab = "Length")

# Basic stip plot
stripplot(len ~ dose,  data = ToothGrowth,
          jitter.data = TRUE, pch = 19,
          xlab = "Dose", ylab = "Length")


# kernel density plots ==============================================================
# create factors with value labels 
gear.f<-factor(mtcars$gear, levels=c(3,4,5), labels=c("3gears","4gears","5gears")) 
cyl.f <-factor(mtcars$cyl, levels=c(4,6,8), labels=c("4cyl","6cyl","8cyl")) 

densityplot( ~ mpg,
            data = mtcars,
            main="Density Plot", 
            xlab="Miles per Gallon")

# kernel density plots by factor level 
densityplot( ~ mpg | cyl.f,
    data = mtcars,
    main="Density Plot by Number of Cylinders",
    xlab="Miles per Gallon")

# kernel density plots by factor level (alternate layout) 
densityplot( ~ mpg | cyl.f,
    data = mtcars,
    main="Density Plot by Numer of Cylinders",
    xlab="Miles per Gallon", 
    layout=c(1,3),
    plot.points = FALSE)

       
# scatterplot matrix 
splom(mtcars[c(1,3,4,5,6)], main="MTCARS Data")

