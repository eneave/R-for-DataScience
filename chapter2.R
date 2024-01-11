################################
## Chapter 2: Workflow basics ##
################################
#https://r4ds.hadley.nz/workflow-basics
#####
# 2.5 Exercises

# 1. Why does this code not work?
my_variable <- 10
#my_varıable there is a typo
my_variable

# 2. Tweak each of the following R commands so that they run correctly:
#libary(todyverse)

#ggplot(dTA = mpg) + 
#  geom_point(maping = aes(x = displ y = hwy)) +
#  geom_smooth(method = "lm)

library(tidyverse)

ggplot(data = mpg,
       mapping = aes(x = displ, y = hwy)) + 
  geom_point() +
  geom_smooth(method = "lm")

# 3. Press Option + Shift + K / Alt + Shift + K. What happens? How can you get to the same place using the menus?
# Tools, keyboard shortcuts help

# 4. Let’s revisit an exercise from the Section 1.6. Run the following lines of code. Which of the two plots is saved as mpg-plot.png? Why?
my_bar_plot <- ggplot(mpg, aes(x = class)) +
  geom_bar()
my_scatter_plot <- ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave(filename = "mpg-plot.png", plot = my_bar_plot)
# the bar plot because it's been made an object and called in ggsave

