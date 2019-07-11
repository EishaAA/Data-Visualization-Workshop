library("rgl")
library("datasets")
rm(list=ls())

# A more detailed tutorial can be found here: http://www.sthda.com/english/wiki/a-complete-guide-to-3d-visualization-device-system-in-r-r-software-and-data-visualization
data(iris)

x <- iris$Sepal.Length
y <- iris$Petal.Length
z <- iris$Sepal.Width

rgl.open()              # Open a new RGL device
rgl.bg(color = "white") # Setup the background color
#rgl.spheres(x, y, z, r=0.2)
rgl.points(iris$Sepal.Length, iris$Petal.Length, iris$Sepal.Width, color ="blue", size = 5) # Scatter plot


# helper function to compute axis limits: c(-max, +max)
lim <- function(x){c(-max(abs(x)), max(abs(x))) * 1.1}

rgl.clear(type = c("shapes", "bboxdeco")) # Clears plot scene of specified objects (“shapes”, “lights”, “bboxdeco”, “background”)

# Add x, y, and z Axes
rgl.lines(lim(x), c(0, 0), c(0, 0), color = "black")
rgl.lines(c(0, 0), lim(y), c(0, 0), color = "red")
rgl.lines(c(0, 0), c(0, 0), lim(z), color = "green")

