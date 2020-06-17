library(data.table)
library(plyr)

features_test <- fread("UCI HAR Dataset/test/X_test.txt")
features_train <- fread("UCI HAR Dataset/train/X_train.txt")
features_combined <- rbind(features_test,features_train)
feature_names <- fread("UCI HAR Dataset/features.txt")
names(features_combined) <- feature_names$V2

activity_test <- fread("UCI HAR Dataset/test/Y_test.txt")
activity_train <- fread("UCI HAR Dataset/train/Y_train.txt")
activity_combined <- rbind(activity_test,activity_train)
names(activity_combined) <- c("activity")

subject_test <- fread("UCI HAR Dataset/test/subject_test.txt")
subject_train <- fread("UCI HAR Dataset/train/subject_train.txt")
subject_combined <- rbind(subject_test,subject_train)
names(subject_combined) <- c("subject")

required_features<-feature_names$V2[grep("mean\\(\\)|std\\(\\)", feature_names$V2)]
features_combined<-subset(features_combined,select = required_features)

data_set <- cbind(features_combined,activity_combined,subject_combined)

activity_labels <- fread("UCI HAR Dataset/activity_labels.txt")

data_set$activity <- factor(data_set$activity
                                 , levels = activity_labels$V1
                                 , labels = activity_labels$V2)

names(data_set)<-gsub("^t", "time", names(data_set))
names(data_set)<-gsub("^f", "frequency", names(data_set))
names(data_set)<-gsub("Acc", "Accelerometer", names(data_set))
names(data_set)<-gsub("Gyro", "Gyroscope", names(data_set))
names(data_set)<-gsub("Mag", "Magnitude", names(data_set))
names(data_set)<-gsub("BodyBody", "Body", names(data_set))

data_set2 <- aggregate(. ~subject + activity, data_set, mean)
data_set2 <- data_set2[order(data_set2$subject,data_set2$activity),]

write.table(data_set2,"data_set2.txt",row.name = FALSE)
