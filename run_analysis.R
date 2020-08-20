## Descrition of Getting and Cleaning Data Course Project
###  Submission: Pabrício Lopes

############################################################################################
### Load packages
#############################################################################################

library(dplyr)

#############################################################################################
### Download of the dataset
##############################################################################################

filename <- "Dataset.zip"

##############################################################################################
### Check if the archives exists
##############################################################################################

if (!file.exists(filename)){

  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
  
  
}  
###################################################################################################
### Check if the folder exists
#################################################################################################

if (!file.exists("UCI HAR Dataset")) { 

    unzip(filename) 
}

#########################################################################################
### Assigned all data frames
######################################################################################
### The read.table command reads each column of files that contains a 561-feature vector 
### with time and frequency domain variables. Then, salve in features. 
### View command invokes a spreadsheet-style data viewer on a matrix-like R object.
### Reading the list of all features.

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
View(features)
### Reading the links the class labels with their activity name.
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
View(activities)
### Reading the result of classification
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
View(subject_test) 
## Reading the test set.
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
View(x_test )
### Reading the test labels.
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
View(y_test)
### Reading the result of classification
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
View(subject_train)
### Reading the train labels
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
View(x_train)
### Reading the train labels
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
View(y_train)

#################################################################################################
### Step 1 - Merges the training and the test sets to create one data set
#################################################################################################

### The rbind command take x_train and x_test with arguments and combine by columns
X <- rbind(x_train, x_test)
View (X)
### The rbind command take y_train and y_test with arguments and combine by columns
Y <- rbind(y_train, y_test)
View(Y)
### The rbind command take subject_train and subject_test with arguments and combine by columns
Subject <- rbind(subject_train, subject_test)
## The cbind command combines Subject, Y and X by columms
Merged_Data <- cbind(Subject, Y, X)
View(Merged_Data)

####################################################################################################
### Step 2 - Extracts the mean and standard deviation for each measurement
###################################################################################################

#### The function %>% pass Merged_Data to the first argument of select().
#### The Select command select the variables subject and code. Then, the mean and standard deviation     
### The argument contains does the literal match of substring or full name match. 

TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))
View(TidyData)

####################################################################################################
### Step 3 - Uses descriptive activity names to name the activities in the data set
###################################################################################################

TidyData$code <- activities[TidyData$code, 2]
View(TidyData$code)

####################################################################################################
### Step 4 - Appropriately labels the data set with descriptive variable names
###################################################################################################

### The names functions change the column names of the TidyData 
### The gsub command return characters of vector with the same attributes. 
names(TidyData)[2] = "activity"
View(TidyData)
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
View(TidyData)
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
View(TidyData)
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
View(TidyData)
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
View(TidyData)
names(TidyData)<-gsub("^t", "Time", names(TidyData))
View(TidyData)
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
View(TidyData)
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
View(TidyData)
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
View(TidyData)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
View(TidyData)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
View(TidyData)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
View(TidyData)
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))
View(TidyData)

#####################################################################################################
 ### Step 5 - From the data set in step 4, creates a second, independent tidy data set with the average 
 ###          of each variable for each activity and each subject.
######################################################################################################

Final_Data <- TidyData %>%
  group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(Final_Data, "Final_Data.txt", row.name=FALSE)

#####################################################################################################
###  Check variable names
#####################################################################################################

### The str command display only one line for each ‘basic’ structure 
str(Final_Data)
### Display at final data
  Final_Data
######################################################################################################
