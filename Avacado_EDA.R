# Exploratory Data Analysis
# (And some R studio IDE tips and tricks)


# Load libraries that we will use
library(tidyverse)
library(ggbeeswarm)
library(lubridate)


# Getting Started:

# Load data set
df <- read_csv("https://raw.githubusercontent.com/aaronquinton/Rstudygroup_EDA/master/Data/avocado.csv")


# Let's look at our data:

df
str(df)

#Go back and change to read_csv

glimpse(df)

View(df)

summary(df)


#equivalent to unique.data.frame, but much faster
distinct(df)

unique(df$type)
unique(df$region)


# Let's make the columns names more machine readable and select only the variables we want to look at.

df_test <- df

colnames(df_test) <- c("sort_id", "Avg_Price", "Tot_Vol")

df <- rename(df, sort_id = X1)

df <- select(df, date = Date, avg_price_usd = AveragePrice, 
             tot_vol = `Total Volume`, tot_bags = `Total Bags`, region, type)


# Lets look at the avg Price

avg_price_plot <- df %>% 
  ggplot(aes(x = avg_price_usd))
    
avg_price_plot +
  geom_histogram()

avg_price_plot +
    geom_freqpoly()

avg_price_plot  +
    geom_density()

avg_price_plot +
    geom_boxplot() +
    coord_flip()

avg_price_plot +
    stat_ecdf()


# Lets add multiple variables
# If its another categorical example

avg_price_plot2 <- df %>% ggplot(aes(x = avg_price_usd, fill = type))
 
avg_price_plot2 + geom_histogram()
 
avg_price_plot2 + geom_histogram(position = "identity", alpha = 0.5)

avg_price_plot2 + geom_freqpoly(aes(col = type))

avg_price_plot2 + geom_density(alpha = 0.5)

avg_price_plot + geom_boxplot(aes(x = type, y = avg_price_usd)) + coord_flip()

avg_price_plot2 + stat_ecdf(aes(col = type)) 

df %>% 
  ggplot(aes(x = region, y = avg_price_usd)) +
  geom_boxplot()  + coord_flip()

df %>% 
  ggplot(aes(y = avg_price_usd, x = region)) +
    geom_quasirandom(aes(col = type), alpha = 0.5) +
    coord_flip() +
    guides(col = FALSE)

df %>% 
  ggplot(aes(y = avg_price_usd, x = region)) +
  geom_quasirandom(aes(col = type), alpha = 0.5) +
  coord_flip() +
  guides(col = FALSE)



# cool functions/geoms for later
ggplot2::ggplot(ggplot2::mpg,aes(class, hwy)) + geom_violin() + geom_jitter()
# Generate fake data
distro <- data.frame(
  'variable'=rep(c('runif','rnorm'),each=100),
  'value'=c(runif(100, min=-3, max=3), rnorm(100))
)
ggplot2::ggplot(distro,aes(variable, value)) + geom_quasirandom()
ggplot2::ggplot(distro,aes(variable, value)) + geom_quasirandom(width=.1)
