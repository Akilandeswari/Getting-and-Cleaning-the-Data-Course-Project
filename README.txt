Getting and Cleaning Data Project


Overview

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.
The data can be found here : 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


Project Summary

The project is aiming to do the following:

Create a R script run_analysis.r that does the following:
1. Merges the training and the test sets to create one data set. 
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set 
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


Stepwise Description

Step 1. Merge the training and the test sets to create one data set.

	(i) The data is being read into the respective tables from txt files given below:

		features.txt
		activity_labels.txt
		subject_train.txt
		x_train.txt
		y_train.txt
		subject_test.txt
		x_test.txt
		y_test.txt

	(ii) Column names were assigned to each of the variables. 
	(iii) Using rbind one table was created combining training data and test data.

Step 2. Extract only the measurements on the mean and standard deviation for each measurement.
	(i) A vector is created which contains only the needed columns (means and standard deviations)
	(ii) The table created in step was subsetted to contain only those columns extracted from (i)



Step 3. Use descriptive activity names to name the activities in the data set
	(i) the table created from step 2 is merged with activity labels to include descriptive activity names.



Step 4. Appropriately label the data set with descriptive activity names.
	(i) gsub function is used to match for patterns and created a new name for each of the variables. 


Step 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
	(i) The table created from step 4 is modified to include the mean of every variable
	


Additional Information

Codebook.md will contain the descriptions of variables and choice of summary done on each of the observation. 