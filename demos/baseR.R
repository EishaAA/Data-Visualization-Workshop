library(rstudioapi)
library(datasets)
library(RColorBrewer)

rm(list=ls())

# set working directory to current path of script
current_path <- getActiveDocumentContext()$path
setwd(dirname(current_path ))

# setwd("/Users/eisha/Desktop/Data_Viz/tutorial") # or specify it directly

# import R dataset
data(iris)
data(nottem)
data(mtcars)

# convert nottem time series object into data frame
nottemDates <- seq(as.Date("1920-01-01"), as.Date("1939-12-01"), by = "1 month")
nottemDf <- data.frame(date=nottemDates, temp=as.vector(nottem))

# Histogram ===================================================================
hist(iris$Sepal.Length,
     main="Histogram of Sepal Length",
     xlab="Sepal Length",
     ylab="Count",
     border="#0011FF", # bar border colour
     col="#0022DD",    # bar fill colour
     xlim=c(4,8),      # set x axis limits
     ylim=c(0,40),     # set y axis limits
     las=1,            # rotate y-axis labels 90 degrees
     prob=FALSE,       # set to TRUE for probability density function
     cex.axis=1,       # axis number font size
     cex.lab=1.3,      # axis label font size
     cex.main=1.5,     # plot title font size
     breaks=6)         # number of breaks (approximate)

# Scatter/Bubble Plot =========================================================
plot(iris$Sepal.Length,
     iris$Petal.Length,
     main="Association between Sepal and Petal Length",
     xlab = "Sepal Length",
     ylab = "Petal Length",
     cex=1.2*sqrt(iris$Petal.Width), # point size
     col=iris$Species, # point colours
     pch=19,           # point shape
     frame=FALSE,
     xlim=c(4,8))
legend(x=7, y=2.3,
       levels(iris$Species),
       col=c("black","red","blue"),
       cex=1.3,
       pch=19,
       bty="n")   # remove box around legend
abline(a=-10.2, b=2.4, col="#FF0000") # a=yIntercept, b=slope
abline(h=2.5, col="#555555", lty="dashed")
text(x=7.5, y=2.7, labels="Dividing line", cex=1.3, col="#555555")
text(x=6.4, y=6.6, labels="y = 2.4x - 10.2", cex=1.3, col="#FF0000")

# Boxplot =====================================================================
boxplot(iris$Sepal.Length ~ iris$Species,
        las=1,
        main="Iris sepal length",
        xlab="Species",
        ylab="Sepal Length",
        cex.lab=1.2,
        frame=FALSE)

# Plot line ===================================================================
plot(nottemDf$date,
     nottemDf$temp,
     xlab="Date",
     ylab="Temperature",
     type="l",
     las=1,
     ylim=c(30,70),
     col="#FF0000",
     lwd = 3,
     frame=FALSE,
     cex.axis=1.4,
     cex.lab=1.6)

# Plot all pairs of variables =================================================
pairs(~Sepal.Length + Sepal.Width + Petal.Length + Petal.Width,
      iris,
      labels = c("Sepal Length", "Sepal Width", "Petal Length", "Petal Width"),
      col=iris$Species,
      upper.panel = NULL,
      pch=19,
      gap=0.5,
      cex.axis=1.2)


# Bar plot ====================================================================
irisSummary <- do.call(data.frame, aggregate(iris[,1:4], by=list(iris$Species), function(x) c(mn=mean(x), std=sd(x))))

barplot(irisSummary$Sepal.Length.mn,
        names = irisSummary$Group.1,
        xlab = "Species",
        ylab = "Sepal Length",
        ylim = c(0,8),
        col="#6699FF",
        border="#0000FF")

# hack: we draw arrows but with special "arrowheads"
arrows(c(1:3)*1.2-0.5,
       irisSummary$Sepal.Length.mn-irisSummary$Sepal.Length.std,
       c(1:3)*1.2-0.5,
       irisSummary$Sepal.Length.mn+irisSummary$Sepal.Length.std,
       length=0.3,
       angle=90,
       code=3,
       lwd=3)

# All that just for some error bars? Well that's no fun...

# Let's put multiple plots in the same figure ===============================
par(mfrow=c(1,3)) # number of rows, cols

plot(iris$Sepal.Length, iris$Petal.Length,        # x variable, y variable
     col = iris$Species,                          # colour by species
     main = "Sepal vs Petal Length in Iris")      # plot title

plot(iris$Sepal.Length, iris$Sepal.Width,         # x variable, y variable
     col = iris$Species,                          # colour by species
     main = "Sepal Length vs Width in Iris")      # plot title

plot(iris$Petal.Length, iris$Petal.Width,         # x variable, y variable
     col = iris$Species,                          # colour by species
     main = "Petal Length vs Width in Iris")      # plot title

# Heatmaps =============================================================
# you can even do heatmaps in base R! Clustering + dendograms are automatically done
# Great tutorial: https://www.r-graph-gallery.com/215-the-heatmap-function/
myCol <- colorRampPalette(brewer.pal(8, "Blues"))(25)

heatmap(as.matrix(mtcars), # requires a matrix as input
        scale="column",  # normalize data by column
        #Colv = NA,
        Rowv = NA,
        col=myCol)

# Saving plots =============================================================

pdf("testplot.pdf")
#png("test.png", width=4, height=4, unit="in", res=300)
plot(iris$Sepal.Length, iris$Petal.Length)
dev.off()




