# Overview
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.

UCI HAR Dataset zip is downloaded and extracted if it is not present in the users work directory.  When unzipping the file, subdirectories "test" and "train" are created.  At completion of script, a text file "UCI HAR Tidy Data - Mean & Std.txt" file is created in the UCI HAR Dataset directory.

# UCI HAR Tidy Data - Mean & Std.txt
- contains 180 observations (rows) and 89 variables (columns)
- label_id column - Id for the activity type, 1:6
- label_activity column - Activity name (walking, walking upstairs, walking downstairs, sitting, standing, laying)
- subject_id column - Id for each subject, 1:30
Following columns have both mean and standard deviation:
- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag
