# Loading libraries
library(ggplot2)
install.packages("magrittr") # package installations are only needed the first time you use it
install.packages("dplyr")    # alternative installation of the %>%
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr)    # alternatively, this also loads %>%

# reading files
candyRankings <- read.csv(file.choose())
candyProduction <- read.csv(file.choose())
View(candyProduction)
View(candyRankings)

# Scatter Plots 
# aes means which axes will have what data & geom_point represents the dots
# geom_smooth is the fitted line in blue
ggplot(data=candyRankings, aes(x=sugarpercent,y=pricepercent, label= competitorname)) + 
  geom_point() + geom_smooth(method = "lm") + 
  # check_overlap will remove all the overall text, vjust adjusts the text in vertical manner, nudge moves the text up , angle tilts to 30 and text size to 2
  geom_text(check_overlap = TRUE, vjust="bottom", nudge_y = 0.01, angle =30, size=2) +
  # adding labels in chart
  labs(title="Candies which contains more sugar are expensive", x='Sugar Content(Percentile)',y="Price(Percentile)")

# Bar Charts 
# selecting cols 2 to 10 which contains the flavors 
candyFeatures <- candyRankings %>% select(2:10)
# Boolean logic
candyFeatures[] <- lapply(candyFeatures, as.logical)
# Bar plot
ggplot(candyFeatures, aes(x=chocolate)) + geom_bar()

# fill - caramel will color code caramel with color & dodge will create seperate bar chart for explanation
ggplot(candyFeatures, aes(x=chocolate, fill=caramel)) +geom_bar(position = "dodge")

# Breaking the chart in two with facet_wrap()
candyFeatures <- candyRankings %>% select(2:10)
candyFeatures[] <- lapply(candyFeatures, as.logical)
ggplot(candyFeatures, aes(x=chocolate, fill=caramel)) +
  geom_bar(position = "dodge") +
  facet_wrap(c("caramel")) # put each level of "caramel" in a different facet

# Changing the color of the Bar plot with scale_fill_manual
candyFeatures <- candyRankings %>% select(2:10)
candyFeatures[] <- lapply(candyFeatures, as.logical)
ggplot(candyFeatures, aes(x=chocolate, fill=caramel)) +
  geom_bar(position = "dodge") +
  facet_wrap(c("caramel")) +
  scale_fill_manual(values = c("#BBBBBB", "#E69F00"))

# Adding title, moving legend & removing strips
# legend.position will move legends inside the plot
# strip.background will remove the strip from top facets
# strip.text will remove text from top facets
candyFeatures <- candyRankings %>% select(2:10)
candyFeatures[] <- lapply(candyFeatures, as.logical)
ggplot(candyFeatures, aes(x=chocolate, fill=caramel)) +
  geom_bar(position = "dodge") +
  facet_wrap(c("caramel")) +
  scale_fill_manual(values = c("#BBBBBB", "#E69F00")) +
  labs(title = "Chocolate candies have more caramel",x = "Is the candy chocolate?",y = "Count of candies") +
  theme(legend.position = c(0.9,0.9),strip.background = element_blank(),strip.text.x = element_blank()) 

# Line Charts  
linePlot <- ggplot(data = candyProduction, aes(x = observation_date, y = IPG3113N)) +
  geom_line() + # add a line chart
  geom_smooth() +
  labs(title = "Monthly candy production (US)",
       x = "", # making the axis label blank will remove it
       y = "As percent of 2012 production")

# Adding Theme
linePlot + theme_classic()