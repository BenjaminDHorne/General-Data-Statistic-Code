mydata <- read.csv("",stringsAsFactors = F)

#create a side-by-side boxplot of data by type, change feature looking at if needed
boxplot(mydatawithtype$Tone~mydatawithtype$utype, notch=FALSE)

#anova, for balanced groups, if your data is normal
myova <- aov(mydatawithtype$compare ~ mydatawithtype$utype)
summary(myova)

#Tukey Test
TukeyHSD(myova)

#try a pairwise t test for comparision 
pairwise.t.test(mydatawithtype$compare, mydatawithtype$utype, p.adj = "none")

#correlations, dont need this all the time, just a check to see if any of the features are highly dependent
#this requires manual inspection and removal of highly correlated variables before proceeding
mydata2<-sapply(mydata, as.numeric)
cors<-cor(mydata2)


