#Getting and Cleaning Data - Generating a Tidy Data Set for Analysis

##Data source:

Human Activity Recognition Using Smartphones Dataset:  

* Data gathered for a group of 30 volunteers within an age bracket of 19-48 years. 
* Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 
* The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
* The data was downloaded from the following site: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


##Process in generating the tidy data set

1. Download and extract the source data
2. From the features.txt file, create a vector that contain the column number for measurements with names containing the word 'mean' or 'std'.
3. using the vector from step 2, extracts only the measurements on the mean and standard deviation from the  x_test.txt and x_train.txt files.
4. Read and rename activity data for the test and train set.
5. Read and rename subject data for the test and train set.
6. Combine activity, subject and measure for test and train set.
7. Merge the data from training and testing sets into one data set
8. Use descriptive activity name to name the activity in the data set.  This is done by merging the measure data set with the activity label.
9. The measures in the data set data set is re-labeled with descriptive names
10. Create the resulting tidy data set by grouping and summarizing (calculating the average) the measurements by each activity and subject.  

## Tidy data set details

* number of observations = 180 (30 test subjects X 6 activities) and 81 variables
* Note:  variables with prefix='t' denotes time domain variable; variable with prefix='f' denotes frequency domain variable. 
* Variables: activity_description,
               subject,
               tBodyAccel_mean_X,
               tBodyAccel_mean_Y,
               tBodyAccel_mean_Z,
               tGravityAccel_mean_X,
               tGravityAccel_mean_Y,
               tGravityAccel_mean_Z,
               tBodyAccelJerk_mean_X,
               tBodyAccelJerk_mean_Y,
               tBodyAccelJerk_mean_Z,
               tBodyGyro_mean_X,
               tBodyGyro_mean_Y,
               tBodyGyro_mean_Z,
               tBodyGyroJerk_mean_X,
               tBodyGyroJerk_mean_Y,
               tBodyGyroJerk_mean_Z,
               tBodyAccelMagnitude_mean,
               tGravityAccelMagnitude_mean,
               tBodyAccelJerkMagnitude_mean,
               tBodyGyroMagnitude_mean,
               tBodyGyroJerkMagnitude_mean,
               fwBodyAccel_mean_X,
               fBodyAccel_mean_Y,
               fBodyAccel_mean_Z,
               fBodyAccel_meanFreq_X,
               fBodyAccel_meanFreq_Y,
               fBodyAccel_meanFreq_Z,
               fBodyAccelJerk_mean_X,
               fBodyAccelJerk_mean_Y,
               fBodyAccelJerk_mean_Z,
               fBodyAccelJerk_meanFreq_X,
               fBodyAccelJerk_meanFreq_Y,
               fBodyAccelJerk_meanFreq_Z,
               fBodyGyro_mean_X,
               fBodyGyro_mean_Y,
               fBodyGyro_mean_Z,
               fBodyGyro_meanFreq_X,
               fBodyGyro_meanFreq_Y,
               fBodyGyro_meanFreq_Z,
               fBodyAccelMagnitude_mean,
               fBodyAccelMagnitude_meanFreq,
               fBodyBodyAccelJerkMagnitude_mean,
               fBodyBodyAccelJerkMagnitude_meanFreq,
               fBodyGyroMagnitude_mean,
               fBodyGyroMagnitude_meanFreq,
               fBodyGyroJerkMagnitude_mean,
               fBodyGyroJerkMag_meanFreq,
               tBodyAccel_stdev_X,
               tBodyAccel_stdev_Y,
               tBodyAccel_stdev_Z,
               tGravityAccel_stdev_X,
               tGravityAccel_stdev_Y,
               tGravityAccel_stdev_Z,
               tBodyAccelJerk_stdev_X,
               tBodyAccelJerk_stdev_Y,
               tBodyAccelJerk_stdev_Z,
               tBodyGyro_stdev_X,
               tBodyGyro_stdev_Y,
               tBodyGyro_stdev_Z,
               tBodyGyroJerk_stdev_X,
               tBodyGyroJerk_stdev_Y,
               tBodyGyroJerk_stdev_Z,
               tBodyAccelMagnitude_stdev,
               tGravityAccelMagnitude_stdev,
               tBodyAccelJerkMagnitude_stdev,
               tBodyGyroMagnitude_stdev,
               tBodyGyroJerkMagnitude_stdev,
               fBodyAccel_stdev_X,
               fBodyAccel_stdev_Y,
               fBodyAccel_stdev_Z,
               fBodyAccelJerk_stdev_X,
               fBodyAccelJerk_stdev_Y,
               fBodyAccelJerk_stdev_Z,
               fBodyGyro_stdev_X,
               fBodyGyro_stdev_Y,
               fBodyGyro_stdev_Z,
               fBodyAccelMagnitude_stdev,
               fBodyAccelJerkMagnitude_stdev,
               fBodyGyroMagnitude_stdev,
               fBodyGyroJerkMagnitude_stdev

