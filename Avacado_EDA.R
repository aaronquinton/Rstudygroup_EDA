# Exploratory Data Analysis
# R study group live coding


# Load libraries that we will use
library(tidyverse)
library(ggbeeswarm)
library(magrittr)

# Getting Started:

# Load data set
df <- read_csv("https://raw.githubusercontent.com/aaronquinton/Rstudygroup_EDA/master/Data/avocado.csv")


# Let's look at our data with built in functions:

df
str(df)

glimpse(df)

View(df)

summary(df)


#equivalent to unique.data.frame, but much faster
distinct(df)

unique(df$type)
unique(df$region)


# Let's make the column names more machine readable and select only the variables we want to look at.

# Can rename this way, not great
df_test <- df
colnames(df_test) <- c("sort_id", "Avg_Price", "Tot_Vol")


# Better ways to rename using tidy verse functions.
df <- rename(df, sort_id = X1)

df <- select(df, date = Date, avg_price_usd = AveragePrice, 
             tot_vol = `Total Volume`, tot_bags = `Total Bags`, region, type)



# Lets look at the avg Price
## Note, I am saving the plot as a object and adding different geoms to it as we go along.
avg_price_plot <- df %>% 
  ggplot(aes(x = avg_price_usd))
    
avg_price_plot +
  geom_histogram()

avg_price_plot +
    geom_freqpoly()

avg_price_plot  +
    geom_density()

avg_price_plot +
    geom_boxplot(aes(x = 1 , y = avg_price_usd)) +
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


# Two numerical Variables
df %>% 
  ggplot(aes(x = avg_price_usd, y = tot_vol)) +
    geom_point(alpha = 0.1) +
    scale_y_log10()

df %>% 
  ggplot(aes(x = avg_price_usd, y = tot_vol)) +
    geom_bin2d() +
    scale_y_log10()


# How to plot EDA with 2+ Variables.
df %>% 
  ggplot(aes(y = avg_price_usd, x = region)) +
  geom_quasirandom(aes(col = type), alpha = 0.5) +
  coord_flip() +
  guides(col = FALSE)

## Lets order it by median life Exp.
library(forcats)

(quasirandom2plus <- df %>%
    mutate(region = factor(region)) %>%
    mutate(region = fct_reorder(region, avg_price_usd)) %>% 
    ggplot(aes(y = avg_price_usd, x = region, col = type)) + 
    geom_quasirandom(alpha = 0.3) +
    coord_flip() +
    labs(title = "2+ Variables: Swarm by Region and Type by Color", 
         y = "Avg Avacado Price (USD)", x = "region"))

