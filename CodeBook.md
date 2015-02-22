#Getting and Cleaning Data
##Code Book
###Week3 Course Project - Tidy Data 


Companies like FitBit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked are collected from the accelerometers from the Samsung Galaxy S smartphone.

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data is available at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

For this project, we are to create an R script called run_analysis.R that does the following. 
  1.  Merges the training and the test sets from the above URL to create one data set.
  2.  Extracts only the measurements on the mean and standard deviation for each measurement.
  3.  Uses descriptive activity names to name the activities in the data set
  4.  Appropriately labels the data set with descriptive activity names.
  5.  Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


###Data Set Information:
####Human Activity Recognition Using Smartphones
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a Samsung Galaxy S II smartphone on their waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

####Attribute Information:
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. Corresponding to (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).
- An identifier of the subject who carried out the experiment.


####The data files:
The dataset includes the following files:

    'README.txt': Consists of the Dataset Information listed above.

    'features_info.txt': Shows information about the variables used on the feature vector.

    'features.txt': List of all features.

    'activity_labels.txt': Links the class labels with their activity name.

    'train/X_train.txt': Training set.

    'train/y_train.txt': Training labels.

    'test/X_test.txt': Test set.

    'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

    'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

    'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

    'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

    'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

####Transformation details

#####There are 5 steps to the process:

  1.  Merges the training and the test sets to create one data set.
  2.  Extracts only the measurements on the mean and standard deviation for each measurement.
  3.  Uses descriptive activity names to name the activities in the data set
  4.  Appropriately labels the data set with descriptive activity names.
  5.  Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#####My version of run_analysis.R implements the above steps as follows:

  *  Require plyr R libraries.
  *  Checks to see if the **"UCI HAR Dataset"** folder is in current working directory.
    *  If not present, then download & unzip it.
  *  Read and load the features and activity labels into temporary datasets.
  *  Read and load test and train data into temporary datasets.
  *  Combine the test and train sets into one sensor data set.
  *  Extract the mean and standard deviation column names and data (using `grepl` pattern matching w/ df subsetting).
  *  Clean up variable names to make them human readable (using `make.names` and a series of `gsub` commands).
    *  This will remove parenthesis from the variables, replace dashes with dots and transform names like _tBodyAcc_, _tGravityAcc_, and _tBodyAccJerk_ into _TimeBodyAcceleration_, _TimeGravityAcceleration_, and _FrequencyBodyAngularAcceleration_.
  *  Use `ddply` to split and apply the `mean` function to return the average of each variable for each activity and each subject.
  *  Write the resulting tidy data set into a new file called **tidy_sensor_data.txt**.
	
	
    
