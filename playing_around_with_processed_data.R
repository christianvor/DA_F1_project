#playing around with F1 processed

#Welcome to my (Wiktor's) beautiful mess of a file where I try to have some fun with this data and also wrap my head around it so it actually makes some sense to a human being
#Code here can be messy, uncommented and inefficient, please be patient

library(ggplot2)
library(tidyverse)

data <- read.csv('data/F1_preprocessed')

head(data)
str(data)
summary(data)

hist(data$points)
max(data$points)

#looking at which car constructors and engines tend to score the most points on average
mean.points.con <- aggregate(points ~ constructorId, data = data, mean)
mean.points.eng <- aggregate(points ~ engineManufacturerId, data = data, mean)

#this does not tell much, apparently starting position does not make a huge difference (just based on visual analyis)
plot(data$StartingPosition, data$points)

#same story
plot(data$PositionPractice1, data$points)
plot(data$PositionPractice2, data$points)

#the slightest resemblance of any linear correlation, but a huge stretch to call it anything obvious
plot(data$StartingPosition, data$FinishingPosition)

#this makes sense - lesser finishing position, more points
plot(data$FinishingPosition, data$points)

#looks bad as starting position (would imagine an importatnt thing) has NAs which breaks the whole thing
#since we cannot interpolate the NAs here, maybe we simply omit?
cor(data[, 10:14])

#this is a lot of NAs (about 8% of the data)
sum(is.na(data$StartingPosition))

#this was obvious from the start but a linear algebra approach may be quite terrible here

wins <- c()
for(i in 1:length(data$FinishingPosition)) {
  if(data$FinishingPosition[i]==1){
    wins[i] <- 1
  }
  else{
    wins[i] <- 0
  }
}

data$win <- wins

#plot(FinishingPosition~PositionPractice2, col=as.numeric(win), data = data)

#-------------------------------------------------------------------------------------------------------------------

#throwing out the NAs and all rides that have the finishing position 24
#the NAs break the code and the finishing position 24 mostly means that the driver did not finish the race at all
data_clean <- na.omit(data)
data_clean <- data_clean[which(data_clean$FinishingPosition != 24),]

#plotting the data in this density plot
#since so much of the data is integers, the scatterplot does not give a good image of the actual correlation
baseplot <- ggplot(data_clean, aes(x=StartingPosition, y=FinishingPosition) ) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", colour="white") +
  scale_x_continuous(n.breaks = 25) +
  scale_y_continuous(n.breaks = 25)

baseplot

#the starting position has a strong positive correlation of 0.74 to the finishing position
#the other variables were included as a check
#it seems that the two practice positions are also correlated to the actual starting position
cor(data_clean[, 10:14])

fitPos <- lm(FinishingPosition ~ StartingPosition, data = data_clean)
coeff <- coefficients(fitPos)
eq = paste0("y = ", round(coeff[2],1), "*x + ", round(coeff[1],1))
baseplot + geom_smooth(method = "lm", se = FALSE, colour="red")
