## run_analysis.R  Tidy Data script for Getting and Cleaning Data week 3 project
# PROJECT INSTRUCTIONS:
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average
#    of each variable for each activity and each subject.
#
#                       **need to source plyr for clean data functions
require(plyr)
#                       **check if the data set folder is in current working dir
#                       **if not, download & unzip it
# 
if(!file.exists("./UCI HAR Dataset")) {
    getFile <- TRUE
    fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl,destfile="myzip.zip")
    unzip("myzip.zip", overwrite = TRUE)
} else { getFile <- FALSE 
}
#                       **read in data
activity.labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("Activity_Id", "Activity"))
features.table  <- read.table("./UCI HAR Dataset/features.txt", colClasses = c("character"))
x.test  <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
y.test  <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
x.train <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
y.train <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
subject.test  <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
subject.train <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)
##Step 1 - Merge the training & the test data to create one data set.
##                      **bind combined training & test data into complete sensor data
training.data <- cbind(cbind(x.train, subject.train), y.train)
test.data     <- cbind(cbind(x.test, subject.test), y.test)
sensor.data   <- rbind(training.data, test.data)
##                      **add columns, labels
sensor.labels <- rbind(rbind(features.table, c(562, "Subject")), c(563, "Activity_Id"))[,2]
names(sensor.data) <- sensor.labels
##
##Step 2 - Extract only the measurements on the mean & standard deviation for each measurement.
##                      **subsetting df using grep to pattern match desired cols
sensor.data.mean_std <- sensor.data[,grepl("mean|std|Subject|Activity_Id", names(sensor.data))]
##
##Step 3 - Use descriptive activity names to name the activities in the dataset
sensor.data.mean_std <- join(sensor.data.mean_std, activity.labels, by = "Activity_Id", match = "first")
sensor.data.mean_std <- sensor.data.mean_std[,-1]
##
##Step 4 - Appropriately label the dataset with descriptive names.
##                      **using gsub() to clean out parens - replaced with ""
##                      **using make.names() to clean up Column.Names
##                      **using gsub() to replace abreviations w/ longer UserFriendly names
names(sensor.data.mean_std) <- gsub('\\(|\\)',"",names(sensor.data.mean_std), perl = TRUE)
names(sensor.data.mean_std) <- make.names(names(sensor.data.mean_std))
names(sensor.data.mean_std) <- gsub('^t',"Time.",names(sensor.data.mean_std))
names(sensor.data.mean_std) <- gsub('^f',"Frequency.",names(sensor.data.mean_std))
names(sensor.data.mean_std) <- gsub('Acc',"Acceleration",names(sensor.data.mean_std))
names(sensor.data.mean_std) <- gsub('GyroJerk',"AngularAcceleration",names(sensor.data.mean_std))
names(sensor.data.mean_std) <- gsub('BodyBody',"Body",names(sensor.data.mean_std))
names(sensor.data.mean_std) <- gsub('Gyro',"AngularSpeed",names(sensor.data.mean_std))
names(sensor.data.mean_std) <- gsub('Mag',"Magnitude",names(sensor.data.mean_std))
names(sensor.data.mean_std) <- gsub('Freq\\.',"Frequency.",names(sensor.data.mean_std))
names(sensor.data.mean_std) <- gsub('Freq$',"Frequency",names(sensor.data.mean_std))
names(sensor.data.mean_std) <- gsub('\\.mean',".Mean",names(sensor.data.mean_std))
names(sensor.data.mean_std) <- gsub('\\.std',".StandardDeviation",names(sensor.data.mean_std))
##
## 5. Create a 2nd, independent tidy dataset w/ the average of each variable for each activity & each subject.
##                      **...as a txt file created with write.table() using row.name=FALSE
sensor.avg.by.act.sub <- ddply(sensor.data.mean_std, c("Subject","Activity"), numcolwise(mean))
write.table(sensor.avg.by.act.sub, file = "tidy_sensor_data.txt", row.name=FALSE)
##
##                      **remove working files.
rm(activity.labels,features.table,x.test,y.test,x.train,y.train,subject.test,subject.train)
rm(training.data,test.data,sensor.data,sensor.labels,getFile)
