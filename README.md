
This repository contains a R script **run_analysis.R** which runs several commands on the UCI HAR dataset.

**run_analysis** performs the following operations and outputs a tidy data set **tidy_data.txt**.



Reads the different attributes of the dataset into approproate variables

```{r}
subjectTest <- read.csv("~/UCI HAR Dataset/test/subject_test.txt")
featureTest<- read.table("~/UCI HAR Dataset/test/X_test.txt",header = FALSE)
activityTest <- read.csv("~/UCI HAR Dataset/test/y_test.txt")
subjectTrain <- read.csv("~/UCI HAR Dataset/train/subject_train.txt")
featureTrain <- read.table("~/UCI HAR Dataset/train/X_train.txt",header = FALSE)
activityTrain <- read.csv("~/UCI HAR Dataset/train/y_train.txt")
```

Row binds the attribute information from test and train datasets 

```{r}
subject <- rbind(subjectTest,subjectTrain)
activity <- rbind(activityTest,activityTrain)
feature <- rbind(featureTest,featureTrain)
```

Labels the data set with appropriate label names
```{r}
names(subject) <- "Subject"
names(activity) <- "Activity"
featureNames <- read.table("~/UCI HAR Dataset/features.txt",header = FALSE)
names(feature) <- featureNames$V2
```

Column binds the subject,activity and feature data frames
```{r}
data <- cbind(subject,activity,feature)
```

Uses descriptive activity names to name the activities in the data set

```{r}
activityNames <- read.table("~/UCI HAR Dataset/activity_labels.txt",header = FALSE)
data$Activity <- activityNames$V2[data$Activity]
```

Appropriately labels the data set with descriptive variable names

```{r}
names(data)<-gsub("^t", "time", names(data))
names(data)<-gsub("^f", "frequency", names(data))
names(data)<-gsub("Acc", "Accelerometer", names(data))
names(data)<-gsub("Gyro", "Gyroscope", names(data))
names(data)<-gsub("Mag", "Magnitude", names(data))
names(data)<-gsub("BodyBody", "Body", names(data))
```

Creates a second, independent tidy data set with the average of each variable for each activity and each subject

```{r}
tdata <- aggregate(.~Subject+Activity,data,mean)
tdata <- tdata[order(tdata$Subject,tdata$Activity),]
write.table(tdata,file = "~/tidy_data.txt",row.name = FALSE)
```