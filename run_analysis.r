


#geting the data
setwd("C:/Users/Abhishek/Desktop/UCI HAR Dataset/train")
ytrain<-read.table("y_train.txt",headers=F)
xtrain<-read.table("x_train.txt",header=F)
subjecttrain<-read.table("subject_train.txt",header=F)
setwd("C:/Users/Abhishek/Desktop/UCI HAR Dataset/test")
subjecttest<-read.table("subject_test.txt",header=F)
xtest<-read.table("X_test.txt",header=F)
ytest<-read.table("y_test.txt",header=F)
setwd("C:/Users/Abhishek/Desktop/UCI HAR Dataset")
features<-read.table("features.txt",header=F)
activity<-read.table("activity_labels.txt",header=F)

#setting column names

colnames(xtrain)=(features[,2])
colnames(xtest)=(features[,2])


colnames(ytest) = "activityId"
colnames(subjecttest) = "subjectId"
colnames(ytrain) = "activityId"
colnames(subjecttrain) = "subjectId"

colnames(activity) <- c('activityId','activityType')

colnames(features)<-c("No.","feature")

#merging the tables
merger1<-cbind(ytrain,subjecttrain,xtrain)
merger2<-cbind(ytest,subjecttest,xtest)
merger3<-rbind(merger1,merger2)


#getting the mean and standard deiation:
d<-colnames(merger3)
meansd <- grep(".*mean.*|.*std.*",d)
meansd<-c(1,2,meansd)
finalT<-merger3[,meansd]

#descriptive details
DescT = merge(finalT, activity, by='activityId', all.x=TRUE)

#final table
FinalTable <- aggregate(. ~subjectId + activityId, DescT, mean)

#writing final table
setwd("C:/Users/Abhishek/Desktop/UCI HAR Dataset")
write.table(FinalTable, "FinalTable.txt", row.name=FALSE)
