
library(ISLR)
library(MASS)
attach(Boston)

# multiple linear reg
(lm.fit = lm(medv ~ lstat + age, data = Boston))
saveRDS(lm.fit, file = "./lm-boston.RDS")
