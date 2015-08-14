subjectTest <- read.csv("~/UCI HAR Dataset/test/subject_test.txt")
featureTest<- read.table("~/UCI HAR Dataset/test/X_test.txt",header = FALSE)
activityTest <- read.csv("~/UCI HAR Dataset/test/y_test.txt")
subjectTrain <- read.csv("~/UCI HAR Dataset/train/subject_train.txt")
featureTrain <- read.table("~/UCI HAR Dataset/train/X_train.txt",header = FALSE)
activityTrain <- read.csv("~/UCI HAR Dataset/train/y_train.txt")
subject <- rbind(subjectTest,subjectTrain)
activity <- rbind(activityTest,activityTrain)
feature <- rbind(featureTest,featureTrain)
names(subject) <- "Subject"
names(activity) <- "Activity"
featureNames <- read.table("~/UCI HAR Dataset/features.txt",header = FALSE)
names(feature) <- featureNames$V2
data <- cbind(subject,activity,feature)
activityNames <- read.table("~/UCI HAR Dataset/activity_labels.txt",header = FALSE)
data$Activity <- activityNames$V2[data$Activity]
names(data)<-gsub("^t", "time", names(data))
names(data)<-gsub("^f", "frequency", names(data))
names(data)<-gsub("Acc", "Accelerometer", names(data))
names(data)<-gsub("Gyro", "Gyroscope", names(data))
names(data)<-gsub("Mag", "Magnitude", names(data))
names(data)<-gsub("BodyBody", "Body", names(data))
tdata <- aggregate(.~Subject+Activity,data,mean)
tdata <- tdata[order(tdata$Subject,tdata$Activity),]
write.table(tdata,file = "~/Course Project/tidy_data.txt",row.name = FALSE)
