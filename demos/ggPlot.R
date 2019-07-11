library(rstudioapi)
library(ggplot2)
library(datasets)

rm(list=ls())

# set working directory to current path of script
current_path <- getActiveDocumentContext()$path
setwd(dirname(current_path ))

# setwd("/Users/eisha/Desktop/Data_Viz/tutorial") # or specify it directly

# import R dataset
data(iris) # multivariate data
data(Indometh) # time series
data(nottem) # monthly time series
data(mtcars)

# convert nottem time series object into data frame
nottemDates <- seq(as.Date("1920-01-01"), as.Date("1939-12-01"), by = "1 month")
nottemDf <- data.frame(date=nottemDates, temp=as.vector(nottem))

# Documentation for ggPlot: https://ggplot2.tidyverse.org/index.html

# example of custom ggPlot theme ============================================
customtheme <- theme_minimal() + theme(
    plot.background = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    axis.line = element_line(colour = "black"),
    axis.ticks = element_line(colour = "black"),
    axis.text = element_text(face="plain", color="#000000", size=14, angle=0),
    axis.title = element_text(face="plain", color="#000000", size=16),
    axis.title.y = element_text(margin = margin(t=0, r=6, b=0, l=0)),
    axis.title.x = element_text(margin = margin(t=10, r=0, b=0, l=0))
    #legend.title=element_blank()
)

# 2D Scatter Plots ===========================================================
# an example where each species has a different colour and shape
myScatterplot1 <- ggplot(iris, aes(x=Sepal.Length, y=Petal.Length)) +
    geom_point(aes(color=Species, shape=Species), size=4) +
    scale_shape_manual(values = c(5, 16, 17)) +
    scale_color_manual(values = c("#00AFBB", "#E7B800", "#FC4E07")) +
    customtheme +
    xlab("Sepal Length") +
    ylab("Petal Length")
myScatterplot1

# a nice and easy bubble chart in ggPlot; automatically generates a legend too!
myScatterplot2 <- ggplot(iris, aes(x=Sepal.Length, y=Petal.Length)) +
    geom_point(aes(size=Petal.Width)) +
    scale_size("Petal Width") +
    customtheme +
    xlab("Sepal Length") +
    ylab("Petal Length")
myScatterplot2

# what if I wanted to have the color correspond to a third variable?
mid<-mean(iris$Petal.Width)
myScatterplot3 <- ggplot(iris, aes(x=Sepal.Length, y=Petal.Length)) +
    geom_point(aes(color=Petal.Width), size=4) +
    scale_color_gradient2(midpoint=mid, low="blue", mid="white", high="red", space ="Lab") +
    customtheme +
    xlab("Sepal Length") +
    ylab("Petal Length")
myScatterplot3

# works, but a diverging colour scheme makes no sense here. Let's change it:
myScatterplot4 <- ggplot(iris, aes(x=Sepal.Length, y=Petal.Length)) +
    geom_point(aes(color=Petal.Width), size=4) +
    scale_color_gradient(low="blue", high="yellow") +
    customtheme +
    xlab("Sepal Length") +
    ylab("Petal Length")
myScatterplot4

# Much better!

# Line Charts ==============================================================
# let's summarize the data to get the mean and standard deviation concentration of drug at each time point
IndomethSummary <-  do.call(data.frame, aggregate(conc ~ time, Indometh, function(x) c(mn=mean(x), std=sd(x))))

# example line plot with multiple lines (one line per subject)
myLineplot1 <- ggplot(Indometh[Indometh$Subject==1|Indometh$Subject==2|Indometh$Subject==3,], aes(x=time, y=conc)) +
    geom_line(aes(color=Subject), size=1) +
    geom_point(aes(color=Subject, shape=Subject), size=4) +
    scale_color_manual(values = c("#00AFBB", "#E7B800", "#FC4E07")) +
    customtheme +
    xlab("Time") +
    ylab("Concentration") +
    theme(legend.position = c(0.9, 0.7), legend.title = element_text(size=16), legend.text = element_text(size=14))
myLineplot1

# let's plot the mean value for all the subjects, and add some error bars
# Error Bar Documentation: https://ggplot2.tidyverse.org/reference/geom_linerange.html
myLineplot2 <- ggplot(IndomethSummary, aes(x=time, y=conc.mn)) +
    geom_line() +
    geom_point() +
    #geom_errorbar(aes(ymin = conc.mn-conc.std, ymax = conc.mn+conc.std ), width=0.2) +
    #geom_pointrange(aes(ymin = conc.mn-conc.std, ymax = conc.mn+conc.std )) +
    customtheme +
    xlab("Time") +
    ylab("Concentration")
myLineplot2

# a fancier method of plotting a time series, using smoothed conditional means
# Documenation: https://ggplot2.tidyverse.org/reference/geom_smooth.html
mySmoothplot <- ggplot(Indometh, aes(x=time, y=conc)) +
    geom_point(color="#444444") +
    geom_smooth(level=0.95, color="#000000", fill="#0000FF") +
    customtheme +
    xlab("Time") +
    ylab("Concentration")
mySmoothplot


# Column Chart =======================================================================================
# this time, let's try using some dummy data from a local file

# First, to import and do a bit of preprocessing
df <- read.csv("./data/dummy_single_variate_groups.tsv", sep="\t", header=TRUE)
dfSum <- do.call(data.frame, aggregate(readout ~ treatment, df, function(x) c(mn=mean(x), std=sd(x))))
dfSumGroup <- do.call(data.frame, aggregate(readout ~ treatment+sex, df, function(x) c(mn=mean(x), std=sd(x))))

# we can make a column chart with error bars
myBarchart <- ggplot(dfSum, aes(x=treatment, y=readout.mn)) + 
    geom_col(fill="#FF6666") +
    geom_errorbar(aes(ymin = readout.mn-readout.std, ymax = readout.mn+readout.std), width=0.2) +
    customtheme +
    xlab("Group") +
    ylab("Readout")
myBarchart


# Grouped Column Chart ===============================================================================
# let's split our data by sex and generate a clustered bar graph
groupWidth <- 0.7
seriesColours <- c("#444444", "#AAAAAA")

myGroupedBarchart <- ggplot(dfSumGroup, aes(x=treatment, y=readout.mn, fill=sex, width=groupWidth)) + 
    geom_col(position="dodge") +
    geom_errorbar(aes(ymin = readout.mn-readout.std, ymax = readout.mn+readout.std ), position=position_dodge(width=groupWidth), width=0.2, size=1) +
    customtheme +
    xlab("Group") +
    ylab("Readout") +
    scale_fill_manual(values=seriesColours) +
    theme( legend.title = element_text(size=16), legend.text = element_text(size=14),  )
myGroupedBarchart


# Violin Plot ======================================================================================
# let's try a violin plot with the same data
myViolinplot <- ggplot(data=df, aes(x=treatment, y=readout)) +
    geom_violin(fill="#33AAFF", color=FALSE) +
    geom_boxplot(width = 0.2) +
    customtheme +
    xlab("Group") +
    ylab("Readout")
myViolinplot

# 1D Density Plots =================================================================
fillColourSeries <- scale_fill_manual(values=c("#FF0000", "#00FF00", "#0000FF"))
#fillColourSeries <- scale_fill_grey()

lineColourSeries <- scale_color_manual(values = c("#FF0000", "#00FF00", "#0000FF"))
#lineColourSeries <- scale_color_grey()

densityLineWeight <- 0.2

myDensityplot <- ggplot(data=df, aes(x=readout, group=treatment, fill=treatment, color=treatment)) +
    geom_density(alpha=0.6, size=densityLineWeight, color=NA) +
    customtheme +
    xlab("Group") +
    ylab("Readout") +
    geom_vline(data = dfSum, aes(xintercept = readout.mn, color = treatment), linetype = "solid") +
    fillColourSeries +
    lineColourSeries
myDensityplot

# 2D Density Plots ======================================================================================
# first, let's generate some artificial data

a <- data.frame( x=rnorm(20000, 10, 1.9), y=rnorm(20000, 10, 1.2) )
b <- data.frame( x=rnorm(20000, 14.5, 1.9), y=rnorm(20000, 14.5, 1.9) )
c <- data.frame( x=rnorm(20000, 9.5, 1.9), y=rnorm(20000, 15.5, 1.9) )
data <- rbind(a,b,c)

ggplot(data, aes(x=x, y=y) ) + geom_point() # Check it out by scatter plot

# we can generate a 2D histogram - here is with automatic bin sizes
ggplot(data, aes(x=x, y=y) ) +
    geom_bin2d() +
    theme_bw()

# and with custom bin sizes
ggplot(data, aes(x=x, y=y) ) +
    geom_bin2d(bins = 70) +
    theme_bw()

# how about a contour plot? Lines only:
ggplot(data, aes(x=x, y=y) ) +
    geom_density_2d() +
    theme_bw()

# Show area as well? (set color="white" to view contour lines)
ggplot(data, aes(x=x, y=y) ) +
    stat_density_2d(aes(fill = ..level..), geom = "polygon") +
    theme_bw()

# finally, using raster
# Using raster
ggplot(data, aes(x=x, y=y) ) +
    stat_density_2d(aes(fill = ..density..), geom = "raster", contour = FALSE) +
    scale_x_continuous(expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0)) +
    scale_fill_distiller(palette=4, direction=-1) + #  grab R color Brewer palette using the geom_distiller function
    theme(legend.position='none') # no need for the legend here

# Faceting ==================================================================================
# Documentation: https://ggplot2.tidyverse.org/reference/facet_grid.html

# this forms a matrix of panels defined by row and col faceting variables (great with two discrete vars)
# faceting in 1 direction
myFacetedPlot1 <- ggplot(mtcars, aes(disp, mpg)) +
    geom_point() +
    facet_grid(cols=vars(cyl))
myFacetedPlot1

# faceting in 2 directions
myFacetedPlot2 <- ggplot(mtcars, aes(disp, mpg)) +
    geom_point() +
    facet_grid(vars(gear), vars(cyl))
myFacetedPlot2

# Saving figures ==================================================================================
ggsave("demo_violinplot.pdf", myViolinplot, width=5, height=3, units="in")



