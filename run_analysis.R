#Down load zip file to current working directory and un zip content to a directory called UCI_Data
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,destfile="./data_archive.zip", method="curl")
unzip("./data_archive.zip", exdir = "./UCI_Data", junkpaths = TRUE, files = NULL, list=FALSE)

#install/load dplyr package
install.packages("dplyr")
library(dplyr)


#read the features.txt file for the listing of measurements
measures <- read.table("./UCI_data/features.txt")

#create a table containing only mean and standard deviation measurements
feature_table  <- rbind(measures[grep("mean",measures$V2),],measures[grep("std",measures$V2),])

#subsetting test & train data, extracting only the mean & standard dev measures
test_data <- read.table("./UCI_data/X_test.txt")[,feature_table[,1]]
train_data <- read.table("./UCI_data/X_train.txt")[,feature_table[,1]]

#read activity data for test and train  set
test_activity <- read.table("./UCI_data/Y_test.txt")
train_activity <- read.table("./UCI_data/Y_train.txt")

#rename activity label
test_activity <- rename(test_activity, activity=V1)
train_activity <- rename(train_activity, activity=V1)

#read subject data for test and train  set
test_subject <- read.table("./UCI_data/subject_test.txt")
train_subject <- read.table("./UCI_data/subject_train.txt")

#rename subject label
test_subject <- rename(test_subject, subject=V1)
train_subject <- rename(train_subject, subject=V1)

#bind the subject, activity and measures together
test_data <- cbind(test_subject, test_activity,test_data)
train_data <- cbind(train_subject, train_activity,train_data)

#combine test and train data
data_combined <- rbind(test_data,train_data)

#read & merge activity label into combined data for activity description
activity_label <- read.table("./UCI_data/activity_labels.txt",stringsAsFactors=FALSE)
activity_label <- rename(activity_label,activity=V1, activity_description=V2)
data_combined2 <- merge(data_combined,activity_label,by.x="activity",by.y="activity")

#label the data set with descriptive variable names
data_combined2 <- rename(data_combined2, 
                         tBodyAccel_mean_X=V1,
                         tBodyAccel_mean_Y=V2,
                         tBodyAccel_mean_Z=V3,
                         tGravityAccel_mean_X=V41,
                         tGravityAccel_mean_Y=V42,
                         tGravityAccel_mean_Z=V43,
                         tBodyAccelJerk_mean_X=V81,
                         tBodyAccelJerk_mean_Y=V82,
                         tBodyAccelJerk_mean_Z=V83,
                         tBodyGyro_mean_X=V121,
                         tBodyGyro_mean_Y=V122,
                         tBodyGyro_mean_Z=V123,
                         tBodyGyroJerk_mean_X=V161,
                         tBodyGyroJerk_mean_Y=V162,
                         tBodyGyroJerk_mean_Z=V163,
                         tBodyAccelMagnitude_mean=V201,
                         tGravityAccelMagnitude_mean=V214,
                         tBodyAccelJerkMagnitude_mean=V227,
                         tBodyGyroMagnitude_mean=V240,
                         tBodyGyroJerkMagnitude_mean=V253,
                         fwBodyAccel_mean_X=V266,
                         fBodyAccel_mean_Y=V267,
                         fBodyAccel_mean_Z=V268,
                         fBodyAccel_meanFreq_X=V294,
                         fBodyAccel_meanFreq_Y=V295,
                         fBodyAccel_meanFreq_Z=V296,
                         fBodyAccelJerk_mean_X=V345,
                         fBodyAccelJerk_mean_Y=V346,
                         fBodyAccelJerk_mean_Z=V347,
                         fBodyAccelJerk_meanFreq_X=V373,
                         fBodyAccelJerk_meanFreq_Y=V374,
                         fBodyAccelJerk_meanFreq_Z=V375,
                         fBodyGyro_mean_X=V424,
                         fBodyGyro_mean_Y=V425,
                         fBodyGyro_mean_Z=V426,
                         fBodyGyro_meanFreq_X=V452,
                         fBodyGyro_meanFreq_Y=V453,
                         fBodyGyro_meanFreq_Z=V454,
                         fBodyAccelMagnitude_mean=V503,
                         fBodyAccelMagnitude_meanFreq=V513,
                         fBodyBodyAccelJerkMagnitude_mean=V516,
                         fBodyBodyAccelJerkMagnitude_meanFreq=V526,
                         fBodyGyroMagnitude_mean=V529,
                         fBodyGyroMagnitude_meanFreq=V539,
                         fBodyGyroJerkMagnitude_mean=V542,
                         fBodyGyroJerkMag_meanFreq=V552,
                         tBodyAccel_stdev_X=V4,
                         tBodyAccel_stdev_Y=V5,
                         tBodyAccel_stdev_Z=V6,
                         tGravityAccel_stdev_X=V44,
                         tGravityAccel_stdev_Y=V45,
                         tGravityAccel_stdev_Z=V46,
                         tBodyAccelJerk_stdev_X=V84,
                         tBodyAccelJerk_stdev_Y=V85,
                         tBodyAccelJerk_stdev_Z=V86,
                         tBodyGyro_stdev_X=V124,
                         tBodyGyro_stdev_Y=V125,
                         tBodyGyro_stdev_Z=V126,
                         tBodyGyroJerk_stdev_X=V164,
                         tBodyGyroJerk_stdev_Y=V165,
                         tBodyGyroJerk_stdev_Z=V166,
                         tBodyAccelMagnitude_stdev=V202,
                         tGravityAccelMagnitude_stdev=V215,
                         tBodyAccelJerkMagnitude_stdev=V228,
                         tBodyGyroMagnitude_stdev=V241,
                         tBodyGyroJerkMagnitude_stdev=V254,
                         fBodyAccel_stdev_X=V269,
                         fBodyAccel_stdev_Y=V270,
                         fBodyAccel_stdev_Z=V271,
                         fBodyAccelJerk_stdev_X=V348,
                         fBodyAccelJerk_stdev_Y=V349,
                         fBodyAccelJerk_stdev_Z=V350,
                         fBodyGyro_stdev_X=V427,
                         fBodyGyro_stdev_Y=V428,
                         fBodyGyro_stdev_Z=V429,
                         fBodyAccelMagnitude_stdev=V504,
                         fBodyAccelJerkMagnitude_stdev=V517,
                         fBodyGyroMagnitude_stdev=V530,
                         fBodyGyroJerkMagnitude_stdev=V543)

#Create a tidy data set with the average of each variable for each activity and subject
t_data <- summarise(group_by(data_combined2,activity_description,subject), 
               tBodyAccel_mean_X=mean(tBodyAccel_mean_X),
               tBodyAccel_mean_Y=mean(tBodyAccel_mean_Y),
               tBodyAccel_mean_Z=mean(tBodyAccel_mean_Z),
               tGravityAccel_mean_X=mean(tGravityAccel_mean_X),
               tGravityAccel_mean_Y=mean(tGravityAccel_mean_Y),
               tGravityAccel_mean_Z=mean(tGravityAccel_mean_Z),
               tBodyAccelJerk_mean_X=mean(tBodyAccelJerk_mean_X),
               tBodyAccelJerk_mean_Y=mean(tBodyAccelJerk_mean_Y),
               tBodyAccelJerk_mean_Z=mean(tBodyAccelJerk_mean_Z),
               tBodyGyro_mean_X=mean(tBodyGyro_mean_X),
               tBodyGyro_mean_Y=mean(tBodyGyro_mean_Y),
               tBodyGyro_mean_Z=mean(tBodyGyro_mean_Z),
               tBodyGyroJerk_mean_X=mean(tBodyGyroJerk_mean_X),
               tBodyGyroJerk_mean_Y=mean(tBodyGyroJerk_mean_Y),
               tBodyGyroJerk_mean_Z=mean(tBodyGyroJerk_mean_Z),
               tBodyAccelMagnitude_mean=mean(tBodyAccelMagnitude_mean),
               tGravityAccelMagnitude_mean=mean(tGravityAccelMagnitude_mean),
               tBodyAccelJerkMagnitude_mean=mean(tBodyAccelJerkMagnitude_mean),
               tBodyGyroMagnitude_mean=mean(tBodyGyroMagnitude_mean),
               tBodyGyroJerkMagnitude_mean=mean(tBodyGyroJerkMagnitude_mean),
               fwBodyAccel_mean_X=mean(fwBodyAccel_mean_X),
               fBodyAccel_mean_Y=mean(fBodyAccel_mean_Y),
               fBodyAccel_mean_Z=mean(fBodyAccel_mean_Z),
               fBodyAccel_meanFreq_X=mean(fBodyAccel_meanFreq_X),
               fBodyAccel_meanFreq_Y=mean(fBodyAccel_meanFreq_Y),
               fBodyAccel_meanFreq_Z=mean(fBodyAccel_meanFreq_Z),
               fBodyAccelJerk_mean_X=mean(fBodyAccelJerk_mean_X),
               fBodyAccelJerk_mean_Y=mean(fBodyAccelJerk_mean_Y),
               fBodyAccelJerk_mean_Z=mean(fBodyAccelJerk_mean_Z),
               fBodyAccelJerk_meanFreq_X=mean(fBodyAccelJerk_meanFreq_X),
               fBodyAccelJerk_meanFreq_Y=mean(fBodyAccelJerk_meanFreq_Y),
               fBodyAccelJerk_meanFreq_Z=mean(fBodyAccelJerk_meanFreq_Z),
               fBodyGyro_mean_X=mean(fBodyGyro_mean_X),
               fBodyGyro_mean_Y=mean(fBodyGyro_mean_Y),
               fBodyGyro_mean_Z=mean(fBodyGyro_mean_Z),
               fBodyGyro_meanFreq_X=mean(fBodyGyro_meanFreq_X),
               fBodyGyro_meanFreq_Y=mean(fBodyGyro_meanFreq_Y),
               fBodyGyro_meanFreq_Z=mean(fBodyGyro_meanFreq_Z),
               fBodyAccelMagnitude_mean=mean(fBodyAccelMagnitude_mean),
               fBodyAccelMagnitude_meanFreq=mean(fBodyAccelMagnitude_meanFreq),
               fBodyBodyAccelJerkMagnitude_mean=mean(fBodyBodyAccelJerkMagnitude_mean),
               fBodyBodyAccelJerkMagnitude_meanFreq=mean(fBodyBodyAccelJerkMagnitude_meanFreq),
               fBodyGyroMagnitude_mean=mean(fBodyGyroMagnitude_mean),
               fBodyGyroMagnitude_meanFreq=mean(fBodyGyroMagnitude_meanFreq),
               fBodyGyroJerkMagnitude_mean=mean(fBodyGyroJerkMagnitude_mean),
               fBodyGyroJerkMag_meanFreq=mean(fBodyGyroJerkMag_meanFreq),
               tBodyAccel_stdev_X=mean(tBodyAccel_stdev_X),
               tBodyAccel_stdev_Y=mean(tBodyAccel_stdev_Y),
               tBodyAccel_stdev_Z=mean(tBodyAccel_stdev_Z),
               tGravityAccel_stdev_X=mean(tGravityAccel_stdev_X),
               tGravityAccel_stdev_Y=mean(tGravityAccel_stdev_Y),
               tGravityAccel_stdev_Z=mean(tGravityAccel_stdev_Z),
               tBodyAccelJerk_stdev_X=mean(tBodyAccelJerk_stdev_X),
               tBodyAccelJerk_stdev_Y=mean(tBodyAccelJerk_stdev_Y),
               tBodyAccelJerk_stdev_Z=mean(tBodyAccelJerk_stdev_Z),
               tBodyGyro_stdev_X=mean(tBodyGyro_stdev_X),
               tBodyGyro_stdev_Y=mean(tBodyGyro_stdev_Y),
               tBodyGyro_stdev_Z=mean(tBodyGyro_stdev_Z),
               tBodyGyroJerk_stdev_X=mean(tBodyGyroJerk_stdev_X),
               tBodyGyroJerk_stdev_Y=mean(tBodyGyroJerk_stdev_Y),
               tBodyGyroJerk_stdev_Z=mean(tBodyGyroJerk_stdev_Z),
               tBodyAccelMagnitude_stdev=mean(tBodyAccelMagnitude_stdev),
               tGravityAccelMagnitude_stdev=mean(tGravityAccelMagnitude_stdev),
               tBodyAccelJerkMagnitude_stdev=mean(tBodyAccelJerkMagnitude_stdev),
               tBodyGyroMagnitude_stdev=mean(tBodyGyroMagnitude_stdev),
               tBodyGyroJerkMagnitude_stdev=mean(tBodyGyroJerkMagnitude_stdev),
               fBodyAccel_stdev_X=mean(fBodyAccel_stdev_X),
               fBodyAccel_stdev_Y=mean(fBodyAccel_stdev_Y),
               fBodyAccel_stdev_Z=mean(fBodyAccel_stdev_Z),
               fBodyAccelJerk_stdev_X=mean(fBodyAccelJerk_stdev_X),
               fBodyAccelJerk_stdev_Y=mean(fBodyAccelJerk_stdev_Y),
               fBodyAccelJerk_stdev_Z=mean(fBodyAccelJerk_stdev_Z),
               fBodyGyro_stdev_X=mean(fBodyGyro_stdev_X),
               fBodyGyro_stdev_Y=mean(fBodyGyro_stdev_Y),
               fBodyGyro_stdev_Z=mean(fBodyGyro_stdev_Z),
               fBodyAccelMagnitude_stdev=mean(fBodyAccelMagnitude_stdev),
               fBodyAccelJerkMagnitude_stdev=mean(fBodyAccelJerkMagnitude_stdev),
               fBodyGyroMagnitude_stdev=mean(fBodyGyroMagnitude_stdev),
               fBodyGyroJerkMagnitude_stdev=mean(fBodyGyroJerkMagnitude_stdev))

#write the tidy data out to a file
write.table(t_data,file="./project_tidy_data.txt",row.names =FALSE, col.names=TRUE)




