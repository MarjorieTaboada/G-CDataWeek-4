## Getting and Cleaning
#Assignment - Week 4


# Set the working directory
setwd("C:/Users/marjo/Desktop/RStudio/GettingandCleaning")

# Create a directory if it doesn't exist
if (!file.exists("./getcleandata")) {
  dir.create("./getcleandata")
}

# Specify the file URL
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download the file to the getcleandata directory
download.file(fileurl, destfile = "./getcleandata/projectdataset.zip")

# Unzip the dataset
unzip(zipfile = "./getcleandata/projectdataset.zip", exdir = "./getcleandata")


# Reading the files

# Set the working directory
setwd("C:/Users/marjo/Desktop/RStudio/GettingandCleaning/getcleandata/UCI HAR Dataset/")

# Load features
features <- read.table("features.txt")

# Load activity labels
activityLabels <- read.table("activity_labels.txt")

# Training datasets
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

# Test datasets
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# Adding variable names
colnames(x_train) <- features[,2]
colnames(y_train) <- "activity_id"
colnames(subject_train) <- "subject_id"

colnames(x_test) <- features[,2]
colnames(y_test) <- "activity_id"
colnames(subject_test) <- "subject_id"

colnames(activityLabels) <- c("activity_id", "activity_type")

# Merging the training and the test to create one data set

train <- cbind(x_train, y_train, subject_train)
test <- cbind(x_test, y_test, subject_test)
data1<- rbind(train, test)

# Calculating the mean and standard deviation for each measurement

colNames <- colnames(data1)

sum <- (grepl("activity_id", colNames) | grepl("subject_id", colNames) | grepl("mean..", colNames) | grepl("std...",colNames))

mean_sd <- data1 [ , sum == TRUE]

human_activity <- merge (mean_sd, activityLabels, by = "activity_id", all.x = TRUE)


# Labeling the data set with descriptive variable names

rename_humanactivity <- colnames(human_activity)

rename_humanactivity <- gsub("[\\(\\)-]", "", rename_humanactivity) #removing special characters

rename_humanactivity <- gsub("^f", "FrequencyDomain", rename_humanactivity)
rename_humanactivity <- gsub("^t", "TimeDomain", rename_humanactivity)
rename_humanactivity <- gsub("Acc", "Accelerometer", rename_humanactivity)
rename_humanactivity <- gsub("Gyro", "Gyroscope", rename_humanactivity)
rename_humanactivity <- gsub("Mag", "Magnitude", rename_humanactivity)
rename_humanactivity <- gsub("Freq", "Frequency", rename_humanactivity)
rename_humanactivity <- gsub("mean", "Mean", rename_humanactivity)
rename_humanactivity <- gsub("std", "StDeviation", rename_humanactivity) 

colnames(human_activity) <-  rename_humanactivity


# Creating a second and independent tidy data set with the average of each variable

mean_humanactivity <- human_activity %>% 
  group_by(subject_id, activity_id) %>%
  summarise(across(where(is.numeric), list(
    mean = ~ mean(.), 
    median = ~ median(., na.rm = TRUE)), 
    .names = "{.col}_{.fn}"
  ))

# output to file "tidy_data.txt"
write.table(mean_humanactivity, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)



