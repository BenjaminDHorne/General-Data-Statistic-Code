mydata <- read.csv("",stringsAsFactors = F)

#correlations, check if any features are highly correlated
#this requires manual inspection and removal of highly correlated variables before proceeding
mydata2<-sapply(mydata, as.numeric)
cors<-cor(mydata2)

#logistic model group1 vs. group2, assuming utype is the feature that distiguishes them
set.seed(123)
traindata<-subset(mydata[-1],utype<3)
traindata$utype[traindata$utype == 2]<-0
table(traindata$utype)
traindata[, c(1)] <- sapply(traindata[, c(1)], as.numeric) #just to make sure
trainmodel<-glm(utype~.,family=binomial, data=traindata)
summary(trainmodel)

#logistic model group1 vs. group3, assuming utype is the feature that distiguishes them
set.seed(123)
traindata<-subset(mydata[-1],(utype==1|utype==3))
traindata$utype[traindata$utype == 3]<-0
table(traindata$utype)
traindata[, c(1)] <- sapply(traindata[, c(1)], as.numeric) #just to make sure
trainmodel<-glm(utype~.,family=binomial, data=traindata)
summary(trainmodel)

#logistic model group2 vs. group5, assuming utype is the feature that distiguishes them
set.seed(123)
traindata<-subset(mydata[-1],(utype==2|utype==5))
traindata$utype[traindata$utype == 5]<-0
traindata$utype[traindata$utype == 2]<-1
table(traindata$utype)
traindata[, c(1)] <- sapply(traindata[, c(1)], as.numeric) #just to make sure
trainmodel<-glm(utype~.,family=binomial, data=traindata)
summary(trainmodel)

#logistic model group2 vs. group3, assuming utype is the feature that distiguishes them
set.seed(123)
traindata<-subset(mydata[-1],(utype==2|utype==3))
traindata$utype[traindata$utype == 3]<-0
traindata$utype[traindata$utype == 2]<-1
table(traindata$utype)
traindata[, c(1)] <- sapply(traindata[, c(1)], as.numeric) #just to make sure
trainmodel<-glm(utype~.,family=binomial, data=traindata)
summary(trainmodel)

#logistic model group1 vs. all groups
set.seed(123)
traindata<-subset(mydata,utype<6)
traindata$utype[traindata$utype > 1]<-0
table(traindata$utype)
traindata[, c(1)] <- sapply(traindata[, c(1)], as.numeric) #just to make sure
trainmodel<-glm(utype~.,family=binomial, data=traindata)
summary(trainmodel)

#logistic model group1+group3 vs. group5
set.seed(123)
traindata<-subset(mydata,(utype %in% c(1,3,5)))
traindata$utype[traindata$utype==5]<-0 
traindata$utype[traindata$utype %in% c(1,3)]<-1 
table(traindata$utype)
trainmodel<-glm(utype~.,family=binomial, data=traindata[-1],maxit=100)
summary(trainmodel)

#prediction on group4 subset
testdata2<-subset(mydata,utype==4)
nrow(testdata2)
testdata2$rankP <- predict(trainmodel, testdata2, type = "response")
write.csv(testdata2,file="pred2.csv")
