# Chi Squared Test

# Basically could the sample data be wrong, let's assume there's no difference
# If true, what're the chances that we'd get a sample of this magnitude or more

# Chi squared goodness of fit test

data()
head(iris)

?iris

flowers <- iris %>%
  mutate(Size = cut(Sepal.Length, breaks = 3, labels = c("Small",
                                                         "Medium",
                                                         "Large"))) %>%
  select(Species, Size)

table(flowers)

# Question: is there a stat sig difference in the proportion of flowers that are
#           small, medium, and large (alpha = 0.05)

# H0: The proportion of flowers that are small, medium, and large are equal
# H1: " " are not equal

flowers %>%
  select(Size) %>%
  table() %>%
  chisq.test()

# P-vale: 0.0000006673 very unlikely that if H0 were true that we'd see a sample that has as big
#         or greater of a difference...reject the H0