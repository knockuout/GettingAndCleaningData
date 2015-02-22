#Getting and Cleaning Data
##Week 3 - Tidy Data Course Project

###Project Description:
  You should create one R script called **run_analysis.R** that does the following. 
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names. 
  5. From the data set in step 4, creates a second, independent tidy data set with the average 
  of each variable for each activity and each subject. Create the data set as a txt file 
  created with `write.table() using row.name=FALSE`.

###Run Instructions:
  Run `source("run_analysis.R")` from your working directory that contains the unzipped **"UCI HAR Dataset"** folder.
  Note: If the **"UCI HAR Dataset"** folder is not present in your current working directory, the script 
  will download it and unzip it, before extracting and processing the needed sensor data.  The script will create
  a new tidy data text file called **tidy_sensor_data.txt** in your working directory. 

###Dependencies:
  Script dependencies are taken care of *auto-magically*.  If the data is not present in the working directory, the script
  will fetch it.  Also sources `plyr` R libraries within the script in case it is not already loaded.
