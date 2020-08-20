# Getting-and-Cleaning-Data-Course-Project

The purpose of this Readme is to explain how to collect, work and clean a data set. In addition, a tidy data set was prepared to be used in further analysis.
This repository submitted by Pabrício Lopes contains instructions on how to perform the analysis on the human activity recognition data set.

# The project Data set

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A complete description is available on the website where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Files

* `CodeBook.md` a code book that describes the variables, the data, and any transformations or work that I performed to clean up the data

* `run_analysis.R` performs the data preparation and then followed by the 5 steps required as described in the course project's definition:
    + Merges the training and the test sets to create one data set.
    + Extracts only the measurements on the mean and standard deviation for each measurement.
    + Uses descriptive activity names to name the activities in the data set
    + Appropriately labels the data set with descriptive variable names.
    + From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    
* `Final_Data.txt` is the exported final data after going through all the sequences described above.

