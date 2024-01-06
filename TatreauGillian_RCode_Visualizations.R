# R Code

# install treemap
# install.packages("treemap")

# load packages
library(treemap)
library(dplyr)
library(ggplot2)

# load data
df <- read.delim("/Users/gillian/Documents/Bellevue Grad Program/Fall 2023/DSC640/Weeks5&6/expenditures.txt")

# treemap 
t <- treemap(df, index=c("year","category"), 
             vSize="expenditure", type="index", 
             fontsize.labels=c(15,12),
             fontface.labels=c(2,1),
             fontcolor.labels=c("black","white"), 
             bg.labels=c("transparent"),              # Background color of labels
             align.labels=list(
               c("center", "center"), 
               c("right", "bottom")),                    
             title = 'Expenditure by Year', fontsize.title=12
)
t

# area chart
# Group year by sum of values
agg_tbl <- df %>% group_by(year) %>% 
  summarise(spend_sum = sum(expenditure),
            .groups = 'drop')
# Convert tibble to df
df2 <- agg_tbl %>% as.data.frame()

a <- ggplot(df2, aes(x=year, y=spend_sum)) + 
  geom_area( fill="#69b3a2", alpha=0.4) +
  geom_line(color="#69b3a2") +
  geom_point(color="#69b3a2") +
  ggtitle("Total Expenditure by Year") + 
  xlab('Year') + ylab('Expenditure') + 
  theme_minimal()
a

# stacked area chart
s <- ggplot(df, aes(x=year, y=expenditure, fill=category)) + 
  geom_area(colour="black", size=.2, alpha=.8) +
  ggtitle("Expenditure by Category") + 
  xlab('Year') + ylab('Expenditure') + 
  theme_minimal()
s

