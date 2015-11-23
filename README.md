# Coursera Data Science Specialization 

## Getting and Cleaning Data Project


* R script to complete Getting and Cleaning Data project for Week 3 - run_analysis.R
** Summary:
     a)  The variable names and activity level files are read and a set of 
         desired columns is determined
     b)  (i) The test files (test_X, test_Y, test_data) are read, renaming the columns
          in the data file to those from the variable names read above.
          (ii) The columns are combined into one dataframe, and those columns not desired
          are removed.
          (iii) The activity names are substituted for the activity indices (labels)
     c)  The steps in b) are repeated for the training data
     d)  The test and training dataframes are merged, melted and recast
         to result in a data set with the mean of each variable for each activity and 
		 each subject


* HARUSmeanSummary.txt
** was written with the R command 
write.table(HARUSmeanSummary, file = "HARUSmeanSummary.txt", sep = ",", 
           row.name = FALSE, qmethod = "double")
**an be read with the command
readdata <- read.table("HARUSmeanSummary.txt", header = TRUE, sep = ",")


