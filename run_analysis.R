##
##  R script to complete Getting and Cleaning Data project for Week 3
##
##  Summary:
##      a)  The variable names and activity level files are read and a set of 
##          desired columns is determined
##      b)  (i) The test files (test_X, test_Y, test_data) are read, renaming the columns
##          in the data file to those from the variable names read above.
##          (ii) The columns are combined into one dataframe, and those columns not desired
##          are removed.
##          (iii) The activity names are substituted for the activity indices (labels)
##      c)  The steps in b) are repeated for the training data
##      d)  The test and training dataframes are merged, melted and recast
##          to result in a data set with the mean of each variable for each activity and 
##          each subject
##  Assumptions:
##      The data set for the assignment has been downloaded an unzipped
##      The user has set the working directory to the directory that contains
##          the folder "UCI HAR Dataset"
##      The following libraries have been installed and loaded
##          dplyr, reshape, reshape2, data.table

# Save the current working director for setting the working directory below

current.wd = getwd()

## 
## Read variable names
##

# read in the variable names dataframe, naming the columns
setwd(paste(current.wd,"/UCI HAR Dataset", sep = ""))
var.names <- read.table("features.txt", stringsAsFactors = FALSE, 
                        col.names = c("var.index","variable"))


# find the indices for the variables that are means or standard deviations
# i.e., find the indices where the variable name includes mean() or std()
# in grep in R, the regular expression \( and \) must be escaped to \\( and \\)
# to include the parentheses in the search
# sort the column indices to be the same order that they were in the original data
desired.cols <- sort(  c(   grep("mean\\(\\)",var.names$variable), 
                            grep("std\\(\\)",var.names$variable)  )   )

##
## Read activity levels
##

# read in the activity levels and name the columns
setwd(paste(current.wd,"/UCI HAR Dataset", sep = ""))
activity.levels <- read.table("activity_labels.txt", stringsAsFactors = TRUE,
                              col.names = c("activity.index", "activity.level")) 


##
## Read the test data
##

# read subjectIDs and name the column 
setwd(paste(current.wd,"/UCI HAR Dataset/test", sep = ""))
test.subjects <- read.table("subject_test.txt", stringsAsFactors = TRUE,
                            col.names = "subjectID")

# read the variable data naming the variables that were found in features.txt
test.data <- read.table("X_test.txt", stringsAsFactors = TRUE, 
                        col.names = var.names$variable)

# read the activity levels for the training activities
test.activity <- read.table("Y_test.txt", stringsAsFactors = TRUE, 
                          col.names = "activity.index")

# select only desired columns from test.data
test.data <- select(test.data, desired.cols)

# combine the subjectID, activity indices and variable data
test <- cbind(test.subjects, test.activity, test.data)

# Add a column with the description of the activity and move it to the 2nd column
# omitting the column with the activity indices as they are not people-readable
test$activity <- activity.levels$activity.level[test$activity.index]
test <- select(test,c(1, 69, 3:68))

##
## Read the training data
##

# read subjectIDs and name the column
setwd(paste(current.wd,"/UCI HAR Dataset/train", sep = ""))
train.subjects <- read.table("subject_train.txt", stringsAsFactors = TRUE,
                            col.names = "subjectID")

# read the variable data naming the variables that were found in features.txt 
train.data <- read.table("X_train.txt", stringsAsFactors = TRUE, 
                        col.names = var.names$variable)

# read the activity indices and name the column
train.activity <- read.table("Y_train.txt", stringsAsFactors = TRUE, 
                          col.names = "activity.index")

# select only desired columns from train.data
train.data <- select(train.data, desired.cols)

# combine the subjectID, activity indices and variable data
train <- cbind(train.subjects, train.activity, train.data)

# Add a column with the description of the activity and move it to 2nd column and 
# omitting the column with the activity indices as they are not people-readable
train$activity <- activity.levels$activity.level[train$activity.index]
train <- select(train,c(1, 69, 3:68))

##
## Merging the data
## HARUS = Human Activity Recognition Using Smartphones
##

HARUS <- merge(x = train, y = test, all.x = TRUE, all.y = TRUE)

##
## Reshaping the data
##

# Melt the data so that there is a row for each activity and each subject
# with columns for the 66 other measure variables
HARUSmelt <- melt(HARUS, id=c("activity","subjectID"))

# reshape the melted data to give a mean of each of the 66 variables in columns
# for each row of (subject, activity).  For example, the row for 
# subject = 1 and activity =  WALKING contains the mean of each of the 66
# desired variables
HARUSmeanSummary <- dcast(HARUSmelt, subjectID+activity ~ variable, mean)

##
##  Writing the data 
##

# the file was written with the command
# write.table(HARUSmeanSummary, file = "HARUSmeanSummary.txt", sep = ",", 
#             row.name = FALSE, qmethod = "double")
# and can be read with the command
# readdata <- read.table("HARUSmeanSummary.txt", header = TRUE, sep = ",")

