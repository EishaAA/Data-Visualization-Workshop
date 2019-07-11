library("highcharter")
library(datasets)

rm(list=ls())

# Full demos and documentation: http://jkunst.com/highcharter/

# set working directory to current path of script
current_path <- getActiveDocumentContext()$path
setwd(dirname(current_path ))

# load some data
data(iris)
data(unemployment)

# scatter plot
hchart(iris, "scatter", hcaes(x = Sepal.Length, y = Petal.Length, group = Species))

# histogram
hchart(iris$Sepal.Length, color = "#B71C1C", name = "Sepal Length") %>% 
    hc_title(text = "You can zoom me")

# Bar chart
hchart(iris, type="bar", hcaes(x = Species, y = Sepal.Length))

# Whoops! That's a stacked bar chart. We can use summary data frame generated previously
# to build a normal bar chart

# Let's make a choropleth! =================================================
# Highcharts map collection: https://code.highcharts.com/mapdata/

hcmap("countries/us/us-all-all",
      data = unemployment,
      name = "Unemployment",
      value = "value",
      joinBy = c("hc-key", "code"),
      borderColor = "transparent") %>%
    hc_colorAxis(dataClasses = color_classes(c(seq(0, 10, by = 2), 50))) %>% 
    hc_legend(layout = "vertical", align = "right",
        floating = TRUE, valueDecimals = 0, valueSuffix = "%")


# Nice. Let's try plotting Canada. We'll make a fake dataset for now.
randValues <- c(1:14)
provinces <-c("ca-5682", "ca-bc", "ca-nu", "ca-nt", "ca-ab", "ca-nl", "ca-sk", "ca-mb", "ca-qc", "ca-on", "ca-nb", "ca-ns", "ca-pe", "ca-yt" )
df <- data.frame(code=provinces, value=randValues)

hcmap("countries/ca/ca-all",
      data=df,
      value="value",
      name="Province Metric",
      borderColor = "transparent") %>%
    hc_legend(layout = "horizontal", align = "right") %>%
    hc_exporting(enabled = TRUE, filename = "highcharter_canada")


