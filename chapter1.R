###################################
## Chapter 1: Data Visualization ##
###################################
#https://r4ds.hadley.nz/data-visualize
#####
# 1.1 Introduction

# This chapter focuses on the ggplot2 package
# which is part of the tidyverse
# gg = grammar of graphics

library(tidyverse)

# Example 1
# scatter plot which will be used to introduce:
# aesthetic mappings
# and geometric objects ... main building blocks of ggplot2

library(palmerpenguins) #body measurements of 3 pengiun species
library(ggthemes) #colorblind safe colour palette AWESOME!

#####
# 1.2 First Steps

# variable = quantity, quality, or property that you can measure
# value = state of a variable when you measure it
# observation = set of measurements made under similar conditions
# tabular data = set of values, each associated with a variable and an observation;
# tabular data is considered 'tidy' when each value is in its own cell,
# each variable is in its own column, and each observation in its own row.

# For example, with this data set a variable refers to an attribute of all penguins,
# and an observation refers to all attributes for a single penguin.

# data in tibble
penguins
# data showing all variables and first row
glimpse(penguins)
# in RStudio, view the tibble in the data viewer GUI
View(penguins)

# My notes
#
# when a categorical variable is mapped to an aesthetic, in this case species to color,
# ggplot 2 automatically assigns a unique value to the aesthetic (color) 
# and unique levels to the variable (in this case species) THIS IS CALLED SCALING

# example of aesthetics assigned at the global level, meaning they are scaled for each layer
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point() +
  geom_smooth(method = "lm")


# example of aesthetics at the local level
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species)) + #by using mapping, these aesthetics are applied at a local level
  geom_smooth(method = "lm")

# generally not a good idea to only use color for mapping in a plot because does not consider colour blindness
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method = "lm")

# can also change colors so they are color blind friendly
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind()

# Exercises
# 1.How many rows are in penguins? How many columns?
nrow(penguins) #344
ncol(penguins) #8

# 2.What does the bill_depth_mm variable in the penguins data frame describe? Read the help for ?penguins to find out.
# a number denoting bill length (millimeters)

# 3. Make a scatterplot of bill_depth_mm vs. bill_length_mm. That is, make a scatterplot with bill_depth_mm on the y-axis and bill_length_mm on the x-axis. Describe the relationship between these two variables.

ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm)
) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Penguins from Palmer Archipelago",
    x = "Bill length (mm)", y = "Bill depth (mm)",
  ) +
  scale_color_colorblind()
# Bill depth decreases as bill length increases

# 4. What happens if you make a scatterplot of species vs. bill_depth_mm? What might be a better choice of geom?

ggplot(
  data = penguins,
  mapping = aes(x = species, y = bill_depth_mm)
) +
  #geom_point() # ugly
  geom_boxplot()

# 5. Why does the following give an error and how would you fix it?

ggplot(data = penguins) + 
  geom_point() # error because geom_point does not have any aesthetics

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = bill_depth_mm)
) + 
  geom_point()

# 6. What does the na.rm argument do in geom_point()? What is the default value of the argument? Create a scatterplot where you successfully use this argument set to TRUE.

# na.rm removes/does not plot missing values (NA)
# it's default is set to FALSE, such that missing values are removed with a warning 
# if set to TRUE the missing values are removed silently

# 7. Add the following caption to the plot you made in the previous exercise: “Data come from the palmerpenguins package.” Hint: Take a look at the documentation for labs().

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = body_mass_g)
) +
  geom_point(aes(color = sex, shape = sex), na.rm = TRUE) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and bill length",
    subtitle = "Dimensions for Penguin sex",
    x = "Bill length (mm)", y = "Body mass (g)",
    color = "Sex", shape = "Sex",
    caption = "Data come from the palmerpenguins package."
  ) +
  scale_color_colorblind()

# 8. Recreate the following visualization. What aesthetic should bill_depth_mm be mapped to? And should it be mapped at the global level or at the geom level?

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(aes(color = bill_depth_mm)) + #bill depth mapped at local level
  geom_smooth(method = "gam") 

# 9. Run this code in your head and predict what the output will look like. Then, run the code in R and check your predictions.

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = FALSE) #used method loess

# 10. Will these two graphs look different? Why/why not?
# No, they won't look different because the top plot has the aes() mapped globally, applying to both geoms;
# but the bottom plot has the same aes typed into each geom.

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point() +
  geom_smooth()

ggplot() +
  geom_point(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  ) +
  geom_smooth(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  )

#####
# 1.3 ggplot2 calls

# Section 1.2 used a concise expression of ggplot2 which was super explicit
# This helps to learn, but less text makes it easier to see differences between plots

# e.g. compare these two versions of the same plot

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point()


ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()

# this also becomes a concern when programming (chapter 25)

# also will learn how to use pipes e.g.

penguins |> 
  ggplot(aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()

#####
# 1.4 Visualizing distributions

# categorical variable = a variable which can only take one of a small set of values

ggplot(penguins, aes(x = species)) +
  geom_bar()

# when categorical variables have non-ordered levels it's often preferable to 
# reorder the bars based on their frequencies
# to do so, you need to transform the variable to a factor
# then reorder the levels of that factor

ggplot(penguins, aes(x = fct_infreq(species))) +
  geom_bar()

# more on this in chapter 16

# numerical variable = quantitative and can be continuous or discrete

# histogram is a common visualization for numerical variables
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 200) # binwidth changes the thickness of the bars

# density plots are also used for visualizations of numerical variables
ggplot(penguins, aes(x = body_mass_g)) +
  geom_density()

# Exercises

# 1. Make a bar plot of species of penguins, where you assign species to the y aesthetic. How is this plot different?
ggplot(penguins, aes(y = species)) +
  geom_bar()
# bars are horizontal

# 2. How are the following two plots different? Which aesthetic, color or fill, is more useful for changing the color of bars?
ggplot(penguins, aes(x = species)) +
  geom_bar(color = "red")

ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "red")
# fill is more useful

# 3. What does the bins argument in geom_histogram() do?
# It changes the widths of the bars.

# 4. Make a histogram of the carat variable in the diamonds dataset that is available when you load the tidyverse package. Experiment with different binwidths. What binwidth reveals the most interesting patterns?
ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 0.1)

#####
# 1.5 Visualizing relationships

# visualizing relationships requires two variables mapped to aesthetics of a plot
# e.g. for a numerical variable and categorical variable,
# side-by-side boxplots can be good

ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot()

# another way to visualize this is with a density plot

ggplot(penguins, aes(x = body_mass_g, color = species)) +
  geom_density(linewidth = 0.75) # made lines thicker to stand out against the background

# can also map species to color and fill and use alpha to make transparent

ggplot(penguins, aes(x = body_mass_g, color = species, fill = species)) +
  geom_density(alpha = 0.5)

# stacked bar plots can be good to visualize two categorical variables
# e.g. number of pengiuns of each species on each island
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar()
# this plot shows that there are an equal number of Adelie penguins on each island
# but not the percentage of the penguins as a whole  on each island

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill") #can create a relative frequency plot by using position = "fill"

# for comparing two numerical variables,
# scatter plots are the most common form of data

# three or more variables can be incorporated into a plot
# by using additional aesthetics
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = island))

# But too many many aesthetic mappings on a plot can make it look
# cluttered and difficult to make sense of
# facet_wrap() can be used to facet a plot by a single variable

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  facet_wrap(~island)

# Exercises
# 1. The mpg data frame that is bundled with the ggplot2 package contains 234 observations collected by the US Environmental Protection Agency on 38 car models. Which variables in mpg are categorical? Which variables are numerical? 
glimpse(mpg)
#shows each variable and first column
?mpg

# 2. Make a scatterplot of hwy vs. displ using the mpg data frame. Next, map a third, numerical variable to color, then size, then both color and size, then shape. How do these aesthetics behave differently for categorical vs. numerical variables?
ggplot(mpg) +
  geom_point(aes(x = hwy, y = displ, color = class, size = class, shape = fl)) +
  scale_color_colorblind()

# 3. In the scatterplot of hwy vs. displ, what happens if you map a third variable to linewidth?
ggplot(mpg) +
  geom_point(aes(x = hwy, y = displ)) +
  geom_density(aes(linewidth = cyl)) +
  scale_color_colorblind()

# 4. What happens if you map the same variable to multiple aesthetics?
ggplot(mpg) +
  geom_point(aes(x = hwy, y = displ, color = fl, shape = fl), size = 6) +
  scale_color_colorblind()

# 5. Make a scatterplot of bill_depth_mm vs. bill_length_mm and color the points by species. What does adding coloring by species reveal about the relationship between these two variables? What about faceting by species?
ggplot(penguins) +
  geom_point(aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  scale_color_colorblind() +
  facet_wrap(~species)
#each species has a different average bill length to depth ratio

# 6. Why does the following yield two separate legends? How would you fix it to combine the two legends?
# the mapping is at the golabl level rather than at the local level
ggplot(data = penguins) +
  geom_point(aes(x = bill_length_mm, y = bill_depth_mm, color = species, shape = species)) +
  labs(color = "Species")
# faceting ?

# 7. Create the two following stacked bar plots. Which question can you answer with the first one? Which question can you answer with the second one?
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")
# what proportion of each penguin species make up the penguin communities of each island
ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "fill")
# Which islands are each penguin species distributed on?

#####
# 1.6 Saving your plots



