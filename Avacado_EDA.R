# Exploratory Data Analysis
# (And some R studio IDE tips and tricks)


# Load libraries that we will use
library(tidyverse)
library(ggbeeswarm)
library(lubridate)


# Getting Started:

# Load data set
Avacado_Data <- read_csv("./Data/avocado.csv")


# Let's look at our data:

Avacado_Data
View(Avacado_Data)

head(Avacado_Data)
tail(Avacado_Data)

str(Avacado_Data)

summary(Avacado_Data)

#equivalent to unique.data.frame, but much faster
distinct(Avacado_Data)

unique(Avacado_Data$type)
unique(Avacado_Data$region)


# Lets import our data again as df2 but using read.csv to compare

df2 <- read.csv("./Data/avocado.csv")

df2
View(df2)

str(df2)


# Let's make the columns names more machine readable and select only the variables we want to look at.

df_test <- Avacado_Data

colnames(df_test) <- c("sort_id", "Avg_Price", "Tot_Vol")

Avacado_Data <- rename(Avacado_Data, sort_id = X1)

Avacado_Data <- select(Avacado_Data, date = Date, avg_price_usd = AveragePrice, 
             tot_vol = `Total Volume`, tot_bags = `Total Bags`, region, type)

Avacado_Data <- Avacado_Data %>% 
  mutate(type = factor(type), region = factor(region), date = ymd(date))

str(Avacado_Data)





# cool functions/geoms for later
ggplot2::ggplot(ggplot2::mpg,aes(class, hwy)) + geom_violin() + geom_quasirandom()
# Generate fake data
distro <- data.frame(
  'variable'=rep(c('runif','rnorm'),each=100),
  'value'=c(runif(100, min=-3, max=3), rnorm(100))
)
ggplot2::ggplot(distro,aes(variable, value)) + geom_quasirandom()
ggplot2::ggplot(distro,aes(variable, value)) + geom_quasirandom(width=.1)
