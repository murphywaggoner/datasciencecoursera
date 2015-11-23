# Coursera Data Science Specialization 

## Getting and Cleaning Data Project


1. R script to complete Getting and Cleaning Data project for Week 3 - run_analysis.R
2. Summary:
1. The variable names and activity level files are read and a set of desired columns is determined
1. The test files (test_X, test_Y, test_data) are read, renaming the columns in the data file to those from the variable names read above.
2. The columns are combined into one dataframe, and those columns not desired  are removed.
3. The activity names are substituted for the activity indices (labels)
2. The steps in b) are repeated for the training data
3. The test and training dataframes are merged, melted and recast to result in a data set with the mean of each variable for each activity and each subject


2. HARUSmeanSummary.txt was written with the R command 

write.table(HARUSmeanSummary, file = "HARUSmeanSummary.txt", sep = ",", 
           row.name = FALSE, qmethod = "double")
an be read with the command
readdata <- read.table("HARUSmeanSummary.txt", header = TRUE, sep = ",")


