# Goal
The goal of this assignment is to transform a given data set in to a tiny data set.

## The dataset
- The data for this assignment is provided by the Human Activity Recognition Using Smartphones Dataset. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 

Here are the data for the project:

 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zipincludes 

See the README.md file of this repository for information on this data set.

# R script 

The file run_analysis.R performs the following steps:

1 - Reads the files

2- Merges the training and the test sets to create one data set.

3- Extracts only the measurements on the mean and standard deviation for each measurement. 

4- Uses descriptive activity names to name the activities in the data set.

5- Appropriately labels the data set with descriptive variable names. 

6- Creating a second, independent tidy data set with the average of each variable for each activity and each subject

# Variables:
x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
x_data, y_data and subject_data merge the previous datasets to further analysis.
