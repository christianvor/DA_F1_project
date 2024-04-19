library(psych)

F1 <- read.csv("./data/F1_preprocessed")
F1$X <- NULL
table(is.na(F1))
F1 <- na.omit(F1) # removing NAs

# Checking correlation
corr <- cor(F1[,c(1, 2, 3, 9, 10, 11, 12, 13, 14)])
corPlot(corr)


# Linear Regression -------------------------------------------------------
F1_less <- F1
F1_less$officialName <- NULL
F1_less$driverId <- NULL
F1_less$country <- NULL
F1_less$constructorId <- NULL # taking out variables that
# would introduce too many dummy variables
mall <- lm(FinishingPosition ~ ., data = F1_less)

# Logistic Regression -----------------------------------------------------

# Creating binary variable to do logistic regression on
F1$podium <- ifelse(F1$FinishingPosition >= 1 & 
                      F1$FinishingPosition <= 3, 1, 0)

# Probability of ending up on podium based on PositionPractice1
logit_pp1 <- glm(podium ~ PositionPractice1, 
                 family = binomial, data = F1)
summary(logit_pp1)
plot(podium ~ PositionPractice1, data = F1)

# Based on PositionPractice2
logit_pp2 <- glm(podium ~ PositionPractice2, 
                 family = binomial, data = F1)
summary(logit_pp2)

# Based on StartingPosition
logit_sp <- glm(podium ~ StartingPosition, 
                family = binomial, data = F1)
summary(logit_sp)

# Based on all 3
logit_3 <- glm(podium ~ PositionPractice1 + 
                 PositionPractice2 + StartingPosition,
               family = binomial, data = F1)
summary(logit_3)

# As all 3 models have large AICs and generally low correlation,
# it doesn't make sense to use a logistic model.
# (Predicting based on FinishingPosition or Points would not make
# sense for obvious reasons.)