# Coursera---Getting-and-Cleaning-Data
Course Project

# run_analysis.R
Peter Nguyen
May 24, 2015
version 1.0

This script utilizes data from the "Human Activity Recognition Using Smartphones" version 1.0.  

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The files in the dataset are:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

A full description of the dataset is available at the following link:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Manual download (.zip format) is possible here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


The run.analysis.R script does the following:
- There three functions: check_package, check_dataset, and analysis

# check_package
- Checks if reshape2 and dplyr packages are installed.
- If they are not, it will install and load automatically.

# check_dataset
- Checks if the UCI HAR Dataset is already downloaded and unzipped.
- If dataset is not unzipped, a new directory will be created.
- If file doesn't exist, the zip file will be downloaded, and unzipped automatically.

# anaylsis
- Reads activity_labels, and features files.
- Accesses test and train subfolders and reads subject, x, y files.
- Creates headers called "label_id", and "label_activity", and also labels subject, x, and y test and train files.
- Merges subject, x, and y test files together.
- Merges subject, x, and y train files together.
- Merges newly merged test and train files.
- Melts id, mean, and standard deviation from merged test/train files.
- Calculates mean and standard deviation of each activity.
- Writes a copy of the newly formed tidy data to base /UCI HAR Dataset folder.
