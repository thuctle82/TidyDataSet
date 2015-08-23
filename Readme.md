#Getting and Cleaning Data - R script for generating a tidy data set.

###Script name: 
run_analysis.R

###Development environment:  
The script was developed using R studio (version 0.98.1103) running on Mac OS X version 10.9.5

###Script details:
1. Down load zip file to current working directory and un zip content to a directory called UCI_Data
2. Unzip the files into a single directory named UCI_Data to the current working directory in R
3. Install and load the "dplyr" package 
4. Read the features.txt file for the listing of measurements collected in the experiment
5. From the listing of measurements, create a table containing only mean and standard deviation measures.  This is done by subsetting the table, selecting only measures that has the word 'mean' and 'std'
  - feature_table  <- rbind(measures[grep("mean",measures$V2),],measures[grep("std",measures$V2),])

6. Read and subsetting test & train data, extracting only the mean & standard dev measures
  - test_data <- read.table("./UCI_data/X_test.txt")[,feature_table[,1]]
  - train_data <- read.table("./UCI_data/X_train.txt")[,feature_table[,1]]

7. Read activity data for test and train  set
  - test_activity <- read.table("./UCI_data/Y_test.txt")
  - train_activity <- read.table("./UCI_data/Y_train.txt")

8. Rename activity label for the subsequent merge step using the rname function
  - test_activity <- rename(test_activity, activity=V1)
  - train_activity <- rename(train_activity, activity=V1)

9. Read subject data for test and train  set
  - test_subject <- read.table("./UCI_data/subject_test.txt")
  - train_subject <- read.table("./UCI_data/subject_train.txt")

10. Rename subject label using the rename function
  - test_subject <- rename(test_subject, subject=V1)
  - train_subject <- rename(train_subject, subject=V1)

11. For the testing and training data set combine the subject, activity and measures data together using cbind
  - test_data <- cbind(test_subject, test_activity,test_data)
  - train_data <- cbind(train_subject, train_activity,train_data)

12. Combine the test and train data into one set using rbind
  - data_combined <- rbind(test_data,train_data)

13. Read and rename the activity label
  - activity_label <- read.table("./UCI_data/activity_labels.txt",stringsAsFactors=FALSE)
  - activity_label <- rename(activity_label,activity=V1, activity_description=V2)

14. Merge activity label into the combined data for activity description
  - data_combined2 <- merge(data_combined,activity_label,by.x="activity",by.y="activity")

15. Label the data set with descriptive variable names using the rename function
  - data_combined2 <- rename(data_combined2, tBodyAccel_mean_X=V1, tBodyAccel_mean_Y=V2,.....)

16. Create a tidy data set with the average of each variable for each activity and subject, using the summarise & group_by function
  - t_data <- summarise(group_by(data_combined2,activity_description,subject), 
               tBodyAccel_mean_X=mean(tBodyAccel_mean_X),
               tBodyAccel_mean_Y=mean(tBodyAccel_mean_Y),
               tBodyAccel_mean_Z=mean(tBodyAccel_mean_Z),
               tGravityAccel_mean_X=mean(tGravityAccel_mean_X),
               tGravityAccel_mean_Y=mean(tGravityAccel_mean_Y),
               tGravityAccel_mean_Z=mean(tGravityAccel_mean_Z),........)

17. write the tidy data out to a file via write.table.  Set the col.names parameter to TRUE to preserve the variable names in the data set.  Set the row.names to FALSE.
  - write.table(t_data,file="./project_tidy_data.txt",row.names =FALSE, col.names=TRUE)
  
###Note: 
To read the data from the tidy dataset, use the read.table function, set the header=TRUE to use the data set's column names instead of the default columnn name, i.e data <- read.table(file="./project_tidy_data.txt",header=TRUE)

