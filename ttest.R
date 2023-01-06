# T- Test and interpreting P-Values

install.packages("patchwork")

library(tidyverse)
library(patchwork)
library(gapminder)

# Asking about the average, is that average different from some presumed average,
# or is it different amongst groups

# Hypothesis testing: HO: the mean life expectancy is 50 years
# H1: the mean life expectancy is not 50 years

# Assume null (H0) is true, ask if that's true what's the probability that we would
# get as different of a result of 5%

gapminder %>%
  filter(continent == "Africa") %>% # Remember filter == rows
  select(lifeExp) %>% # Remember select == columns variables
  t.test(mu = 50) # Assumed mean

# Reject null hypothesis since P-Value < 0.05

myttest <- gapminder %>%
  filter(continent == "Africa") %>% # Remember filter == rows
  select(lifeExp) %>% # Remember select == columns variables
  t.test(mu = 50) # Assumed mean

attributes(myttest)

myttest$p.value

# Two sided T-Test to test difference of means
# Two sided vs one: two sided is asking if there is a difference in ANY direction
# Is there a statistically significant difference between life_exp in EUR and AFR

options(scipen = 9999)

gapminder %>%
  filter(continent %in% c("Africa", "Europe")) %>%
  t.test(lifeExp ~ continent, data = ., alternative = "two.sided")

# P-Value very small, less than 0.05 so there is a stat sig difference

# One sided T-Test to test difference of means
# Ireland < Swift life_exp, is our obs true
# Null: life_exp is exactly the same
# Alternative is that Ireland is less than Switzerland

gapminder %>%
  filter(country %in% c("Ireland", "Switzerland")) %>%
  t.test(lifeExp ~ country, data = ., alternative = "less",
         conf.level = 0.95)

# Paired T-Test

gapminder %>%
  filter(year %in% c(1957, 2007) & continent == "Africa") %>%
  mutate(year = factor(year, levels = c(2007, 1957))) %>%
  t.test(lifeExp ~ year, data = ., paired = TRUE)
