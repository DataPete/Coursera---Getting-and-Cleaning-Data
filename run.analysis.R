#------------------------------------------------------------------------------#
## Function checks if the required reshape2 and dplyr package is installed
## It will then install and load reshape2 and dplyr if necessary
#------------------------------------------------------------------------------#
check_package <- function() {
    if (!("reshape2" %in% rownames(installed.packages()))) {
        print("Required package reshape2 needs to be installed")
        print("Package will be installed for you.  Thank you.")
    }
    if ("reshape2" %in% rownames(installed.packages()))
        do.call("library", list("reshape2")) 
    else {
        install.packages("reshape2", repos = 
                             c("http://cran.revolutionanalytics.com/", "http://owi.usgs.gov/R/"),
                         dependencies = NA, type = getOption("pkgType"))
        do.call("library", list("reshape2"))           
    }   
    
    if (!("dplyr" %in% rownames(installed.packages()))) {
        print("Required package dplyr needs to be installed")
        print("Package will be installed for you.  Thank you.")
    }
    if ("dplyr" %in% rownames(installed.packages()))
        do.call("library", list("dplyr")) 
    else {
        install.packages("dplyr", repos = 
                             c("http://cran.revolutionanalytics.com/", "http://owi.usgs.gov/R/"),
                         dependencies = NA, type = getOption("pkgType"))
        do.call("library", list("dplyr"))           
    }
}

#------------------------------------------------------------------------------#
## Function to check to see if the data set is downloaded and unzipped
## If data is not present, function will download the data and unzip for the user
## in their current working directory
#------------------------------------------------------------------------------#
check_dataset <- function() {
    ## Checks to see if UCI HAR Dataset folder exists
    if (!file.exists("UCI HAR Dataset")) {
        dir.create("UCI HAR Dataset")
    }
    
    # Checks to see if UCI zip file is downloaded
    if (!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")) {
        #Downloads UCI HAR Dataset
        file_Url <- 
            "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(file_Url, 
                      dest = "getdata_projectfiles_UCI HAR Dataset.zip",
                      method = "internal")
        
        # Records date of download of file
        dateDownloaded <- date()
        dateDownloaded
        
        # Unzips downloaded file
        unzip("getdata_projectfiles_UCI HAR Dataset.zip")
    }
}

#------------------------------------------------------------------------------#
## Function reads the activity_labels and features files from extracted zip file
## Will then go to the subfolder for test and train and read subject, x, and y
## in each folder.  It will then create headers called "label_id" and
## "label_activity" and  label subject, x, and y files for both test and train.
## It will merge subject, x, and y test files into a dataframe. It will do the
## same for the train files.  It will merge both test and train dataframes.
## Next it will melt the the ids' and mean and std from the merged dataframe.
## It will calculate the mean and std.  Lastly, it will write a tidy data file.
#------------------------------------------------------------------------------#
analysis <- function() {
    # Sets working directory of dataset
    setwd("./UCI HAR Dataset")
    
    # Read activity_labels and create id and activty headers
    data_Act_Labels <- read.table("activity_labels.txt",
                                  col.names = c("label_id", "label_activity"))
    
    # Create headers from the features file
    data_Features <- read.table("features.txt")
    features_Headers <- tolower(data_Features[, 2])
    
    # Read subject, x, and y tests from test folder
    setwd("./test")
    data_Subject_Test <- read.table("subject_test.txt")
    data_X_Test <- read.table("x_test.txt")
    data_Y_Test <- read.table("y_test.txt")
    
    # Read subject, x, and y tests from train folder
    setwd("../train")
    data_Subject_Train <- read.table("subject_train.txt")
    data_X_Train <- read.table("x_train.txt")
    data_Y_Train <- read.table("y_train.txt")
    
    # Label id and activity headers to subject test/train and Y test/train
    colnames(data_Subject_Test) <- colnames(data_Subject_Train) <- "subject_id"
    colnames(data_Y_Test) <- colnames(data_Y_Train) <- "activity_id"
    
    # Label features_Headers to X test/train
    colnames(data_X_Test) <- colnames(data_X_Train) <- features_Headers
    
    # Merge Test files together
    merge_Test <- cbind(data_Subject_Test, data_Y_Test, data_X_Test)
    
    # Merge Train files together
    merge_Train <- cbind(data_Subject_Train, data_Y_Train, data_X_Train)

    # Merge both Test and Train merged files together
    merge_All <- rbind(merge_Test, merge_Train)
    
    # Extracts mean and standard deviation values from merged test/train file
    extract_Mean <- grep("mean", names(merge_All))
    extract_Std <- grep("std", names(merge_All))
    extract_Mean_Names <- names(merge_All)[extract_Mean]
    extract_Std_Names <- names(merge_All)[extract_Std]
    
    # Merges mean and standard deviation columns together
    data_Mean_Std <- merge_All[, c("subject_id", "activity_id", extract_Mean_Names, extract_Std_Names)]
    
    # Merges Activity_labels dataset to the mean/std dataset
    data_Act_MeanStd <- merge(data_Act_Labels, data_Mean_Std, by.x = "label_id",
                        by.y = "activity_id", all = TRUE)
    
    # Retrieves the activity label, name of activity, subject, and the mean and std values
    data_Melt <- melt(data_Act_MeanStd, id = c("label_id", "label_activity", "subject_id"))
    
    # Casts melted data to find the mean
    data_Mean <- dcast(data_Melt, label_id + label_activity + subject_id ~ variable, mean)

    # Sets directory back to UCI HAR Dataset folder and creates a copy of the tidy data
    setwd("..")
    write.table(data_Mean, "./UCI HAR Tidy Data - Mean & Std")
    print("A copy of the mean and standard deviation extracted from the UCI HAR Dataset has been created")
    print("The file name is UCI HAR Tidy Data - Mean & Std.  Thank you.")
}
