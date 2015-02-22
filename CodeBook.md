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
    *  This will remove parenthesis from the variables, replace dashes with dots and transform names like _tBodyAcc_, _tGravityAcc_, and _tBodyAccJerk_ into _TimeBodyAcceleration_, _TimeGravityAcceleration_, and _FrequencyBodyAngularAcceleration_. See Variable transformations section below.
  *  Use `ddply` to split and apply the `mean` function to return the average of each variable for each activity and each subject.
  *  Write the resulting tidy data set into a new file called **tidy_sensor_data.txt**.
	
#####Variable transformations:

Prior to making human readble names, we have the following variable names after subsetting out just the columns that have mean and std in them (output of the `names()` function):

	 [1] "tBodyAcc-mean()-X"               "tBodyAcc-mean()-Y"               "tBodyAcc-mean()-Z"              
	 [4] "tBodyAcc-std()-X"                "tBodyAcc-std()-Y"                "tBodyAcc-std()-Z"               
	 [7] "tGravityAcc-mean()-X"            "tGravityAcc-mean()-Y"            "tGravityAcc-mean()-Z"           
	[10] "tGravityAcc-std()-X"             "tGravityAcc-std()-Y"             "tGravityAcc-std()-Z"            
	[13] "tBodyAccJerk-mean()-X"           "tBodyAccJerk-mean()-Y"           "tBodyAccJerk-mean()-Z"          
	[16] "tBodyAccJerk-std()-X"            "tBodyAccJerk-std()-Y"            "tBodyAccJerk-std()-Z"           
	[19] "tBodyGyro-mean()-X"              "tBodyGyro-mean()-Y"              "tBodyGyro-mean()-Z"             
	[22] "tBodyGyro-std()-X"               "tBodyGyro-std()-Y"               "tBodyGyro-std()-Z"              
	[25] "tBodyGyroJerk-mean()-X"          "tBodyGyroJerk-mean()-Y"          "tBodyGyroJerk-mean()-Z"         
	[28] "tBodyGyroJerk-std()-X"           "tBodyGyroJerk-std()-Y"           "tBodyGyroJerk-std()-Z"          
	[31] "tBodyAccMag-mean()"              "tBodyAccMag-std()"               "tGravityAccMag-mean()"          
	[34] "tGravityAccMag-std()"            "tBodyAccJerkMag-mean()"          "tBodyAccJerkMag-std()"          
	[37] "tBodyGyroMag-mean()"             "tBodyGyroMag-std()"              "tBodyGyroJerkMag-mean()"        
	[40] "tBodyGyroJerkMag-std()"          "fBodyAcc-mean()-X"               "fBodyAcc-mean()-Y"              
	[43] "fBodyAcc-mean()-Z"               "fBodyAcc-std()-X"                "fBodyAcc-std()-Y"               
	[46] "fBodyAcc-std()-Z"                "fBodyAcc-meanFreq()-X"           "fBodyAcc-meanFreq()-Y"          
	[49] "fBodyAcc-meanFreq()-Z"           "fBodyAccJerk-mean()-X"           "fBodyAccJerk-mean()-Y"          
	[52] "fBodyAccJerk-mean()-Z"           "fBodyAccJerk-std()-X"            "fBodyAccJerk-std()-Y"           
	[55] "fBodyAccJerk-std()-Z"            "fBodyAccJerk-meanFreq()-X"       "fBodyAccJerk-meanFreq()-Y"      
	[58] "fBodyAccJerk-meanFreq()-Z"       "fBodyGyro-mean()-X"              "fBodyGyro-mean()-Y"             
	[61] "fBodyGyro-mean()-Z"              "fBodyGyro-std()-X"               "fBodyGyro-std()-Y"              
	[64] "fBodyGyro-std()-Z"               "fBodyGyro-meanFreq()-X"          "fBodyGyro-meanFreq()-Y"         
	[67] "fBodyGyro-meanFreq()-Z"          "fBodyAccMag-mean()"              "fBodyAccMag-std()"              
	[70] "fBodyAccMag-meanFreq()"          "fBodyBodyAccJerkMag-mean()"      "fBodyBodyAccJerkMag-std()"      
	[73] "fBodyBodyAccJerkMag-meanFreq()"  "fBodyBodyGyroMag-mean()"         "fBodyBodyGyroMag-std()"         
	[76] "fBodyBodyGyroMag-meanFreq()"     "fBodyBodyGyroJerkMag-mean()"     "fBodyBodyGyroJerkMag-std()"     
	[79] "fBodyBodyGyroJerkMag-meanFreq()" "Subject"                         "Activity_Id"

From reading the information files that come with the data set, we can translate the above as follows to make them more readable variables (using `make.names` and `gsub`:
  *  Remove the parenthesis.
  *  Leading _f_'s becomes _Frequency_.
  *  Leading _t_'s becomes _Time_.
  *  _Acc_ expands to _Acceleraion_.
  *  _GyroJerk_ changes to _AngularAcceleration_.
  *  _Gyro_ becomes _AngularSpeed_.
  *  Replace double _BodyBody_ with just _Body_.
  *  _Mag_ expands to _Magnitude_.
  *  _Freq_ expands to _Frequency_.
  *  (LowerCase) _mean_ becomes _Mean_.
  *  Spell out _std_ as _StandardDeviation_. 

Post transformation we have (output of the `names()` function):

	[1] "Time.BodyAcceleration.Mean.X"                                
	 [2] "Time.BodyAcceleration.Mean.Y"                                
	 [3] "Time.BodyAcceleration.Mean.Z"                                
	 [4] "Time.BodyAcceleration.StandardDeviation.X"                   
	 [5] "Time.BodyAcceleration.StandardDeviation.Y"                   
	 [6] "Time.BodyAcceleration.StandardDeviation.Z"                   
	 [7] "Time.GravityAcceleration.Mean.X"                             
	 [8] "Time.GravityAcceleration.Mean.Y"                             
	 [9] "Time.GravityAcceleration.Mean.Z"                             
	[10] "Time.GravityAcceleration.StandardDeviation.X"                
	[11] "Time.GravityAcceleration.StandardDeviation.Y"                
	[12] "Time.GravityAcceleration.StandardDeviation.Z"                
	[13] "Time.BodyAccelerationJerk.Mean.X"                            
	[14] "Time.BodyAccelerationJerk.Mean.Y"                            
	[15] "Time.BodyAccelerationJerk.Mean.Z"                            
	[16] "Time.BodyAccelerationJerk.StandardDeviation.X"               
	[17] "Time.BodyAccelerationJerk.StandardDeviation.Y"               
	[18] "Time.BodyAccelerationJerk.StandardDeviation.Z"               
	[19] "Time.BodyAngularSpeed.Mean.X"                                
	[20] "Time.BodyAngularSpeed.Mean.Y"                                
	[21] "Time.BodyAngularSpeed.Mean.Z"                                
	[22] "Time.BodyAngularSpeed.StandardDeviation.X"                   
	[23] "Time.BodyAngularSpeed.StandardDeviation.Y"                   
	[24] "Time.BodyAngularSpeed.StandardDeviation.Z"                   
	[25] "Time.BodyAngularAcceleration.Mean.X"                         
	[26] "Time.BodyAngularAcceleration.Mean.Y"                         
	[27] "Time.BodyAngularAcceleration.Mean.Z"                         
	[28] "Time.BodyAngularAcceleration.StandardDeviation.X"            
	[29] "Time.BodyAngularAcceleration.StandardDeviation.Y"            
	[30] "Time.BodyAngularAcceleration.StandardDeviation.Z"            
	[31] "Time.BodyAccelerationMagnitude.Mean"                         
	[32] "Time.BodyAccelerationMagnitude.StandardDeviation"            
	[33] "Time.GravityAccelerationMagnitude.Mean"                      
	[34] "Time.GravityAccelerationMagnitude.StandardDeviation"         
	[35] "Time.BodyAccelerationJerkMagnitude.Mean"                     
	[36] "Time.BodyAccelerationJerkMagnitude.StandardDeviation"        
	[37] "Time.BodyAngularSpeedMagnitude.Mean"                         
	[38] "Time.BodyAngularSpeedMagnitude.StandardDeviation"            
	[39] "Time.BodyAngularAccelerationMagnitude.Mean"                  
	[40] "Time.BodyAngularAccelerationMagnitude.StandardDeviation"     
	[41] "Frequency.BodyAcceleration.Mean.X"                           
	[42] "Frequency.BodyAcceleration.Mean.Y"                           
	[43] "Frequency.BodyAcceleration.Mean.Z"                           
	[44] "Frequency.BodyAcceleration.StandardDeviation.X"              
	[45] "Frequency.BodyAcceleration.StandardDeviation.Y"              
	[46] "Frequency.BodyAcceleration.StandardDeviation.Z"              
	[47] "Frequency.BodyAcceleration.MeanFrequency.X"                  
	[48] "Frequency.BodyAcceleration.MeanFrequency.Y"                  
	[49] "Frequency.BodyAcceleration.MeanFrequency.Z"                  
	[50] "Frequency.BodyAccelerationJerk.Mean.X"                       
	[51] "Frequency.BodyAccelerationJerk.Mean.Y"                       
	[52] "Frequency.BodyAccelerationJerk.Mean.Z"                       
	[53] "Frequency.BodyAccelerationJerk.StandardDeviation.X"          
	[54] "Frequency.BodyAccelerationJerk.StandardDeviation.Y"          
	[55] "Frequency.BodyAccelerationJerk.StandardDeviation.Z"          
	[56] "Frequency.BodyAccelerationJerk.MeanFrequency.X"              
	[57] "Frequency.BodyAccelerationJerk.MeanFrequency.Y"              
	[58] "Frequency.BodyAccelerationJerk.MeanFrequency.Z"              
	[59] "Frequency.BodyAngularSpeed.Mean.X"                           
	[60] "Frequency.BodyAngularSpeed.Mean.Y"                           
	[61] "Frequency.BodyAngularSpeed.Mean.Z"                           
	[62] "Frequency.BodyAngularSpeed.StandardDeviation.X"              
	[63] "Frequency.BodyAngularSpeed.StandardDeviation.Y"              
	[64] "Frequency.BodyAngularSpeed.StandardDeviation.Z"              
	[65] "Frequency.BodyAngularSpeed.MeanFrequency.X"                  
	[66] "Frequency.BodyAngularSpeed.MeanFrequency.Y"                  
	[67] "Frequency.BodyAngularSpeed.MeanFrequency.Z"                  
	[68] "Frequency.BodyAccelerationMagnitude.Mean"                    
	[69] "Frequency.BodyAccelerationMagnitude.StandardDeviation"       
	[70] "Frequency.BodyAccelerationMagnitude.MeanFrequency"           
	[71] "Frequency.BodyAccelerationJerkMagnitude.Mean"                
	[72] "Frequency.BodyAccelerationJerkMagnitude.StandardDeviation"   
	[73] "Frequency.BodyAccelerationJerkMagnitude.MeanFrequency"       
	[74] "Frequency.BodyAngularSpeedMagnitude.Mean"                    
	[75] "Frequency.BodyAngularSpeedMagnitude.StandardDeviation"       
	[76] "Frequency.BodyAngularSpeedMagnitude.MeanFrequency"           
	[77] "Frequency.BodyAngularAccelerationMagnitude.Mean"             
	[78] "Frequency.BodyAngularAccelerationMagnitude.StandardDeviation"
	[79] "Frequency.BodyAngularAccelerationMagnitude.MeanFrequency"    
	[80] "Subject"                                                     
	[81] "Activity"


    
