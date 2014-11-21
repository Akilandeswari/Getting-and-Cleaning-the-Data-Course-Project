#####
# Course project run_analysis.r
# Operations
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation 
#        for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second,independent tidy data 
#       set with the average of each variable for each activity and each subject.
#####

# setting the working directory
setwd("g:/Coursera/GC Data/UCI HAR Dataset")

# 1. Merge the training and the test sets to create one data set.
# Reading data from files
features     = read.table('./features.txt',header=FALSE); 
activitylabels = read.table('./activity_labels.txt',header=FALSE); 
subjecttrain = read.table('./train/subject_train.txt',header=FALSE); 
xtrain       = read.table('./train/x_train.txt',header=FALSE); 
ytrain       = read.table('./train/y_train.txt',header=FALSE); 

# Assign column names to the data extracted above
colnames(activitylabels)  = c('activity_id','activity_type');
colnames(subjecttrain)  = "subject_id";
colnames(xtrain)        = features[,2]; 
colnames(ytrain)        = "activity_id";

# creating training set by merging ytrain, subjecttrain, and xtrain
trainingdata = cbind(ytrain,subjecttrain,xtrain);

# Reading the test data
subjecttest = read.table('./test/subject_test.txt',header=FALSE); 
xtest       = read.table('./test/x_test.txt',header=FALSE); 
ytest       = read.table('./test/y_test.txt',header=FALSE); 

# Assign column names to the test data extracted above
colnames(subjecttest) = "subject_id";
colnames(xtest)       = features[,2]; 
colnames(ytest)       = "activity_id";


# Creating the test set by merging the xtest, ytest and subjecttest data
testdata = cbind(ytest,subjecttest,xtest);


# Combining training and test data 
combineddata = rbind(trainingdata,testdata);

# Create a vector for the column names from the finaldata
col_names  = colnames(combineddata); 

# 2. Extract only the measurements on the mean and standard deviation for each measurement. 


needed_cols = (grepl("activity..",col_names) | grepl("subject..",col_names) | grepl("-mean..",col_names) & !grepl("-meanFreq..",col_names) & !grepl("mean..-",col_names) | grepl("-std..",col_names) & !grepl("-std()..-",col_names));

# Subset combineddata table 
combineddata = combineddata[needed_cols==TRUE];

# 3. Use descriptive activity names to name the activities in the data set

# Merge the combineddata set  to include descriptive activity names
combineddata = merge(combineddata,activitylabels,by='activity_id',all.x=TRUE);

# Updating the colNames vector to include the new column names after merge
col_names  = colnames(combineddata); 

# 4. Appropriately label the data set with descriptive activity names. 

# Giving appropriate names
for (i in 1:length(col_names)) 
{
  col_names[i] = gsub("\\()","",col_names[i])
  col_names[i] = gsub("-std$","Std_Deviation",col_names[i])
  col_names[i] = gsub("-mean","Mean",col_names[i])
  col_names[i] = gsub("^(t)","time",col_names[i])
  col_names[i] = gsub("^(f)","frequency",col_names[i])
  col_names[i] = gsub("([Gg]ravity)","Gravity",col_names[i])
  col_names[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",col_names[i])
  col_names[i] = gsub("[Gg]yro","Gyro",col_names[i])
  col_names[i] = gsub("AccMag","AccMagnitude",col_names[i])
  col_names[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",col_names[i])
  col_names[i] = gsub("JerkMag","JerkMagnitude",col_names[i])
  col_names[i] = gsub("GyroMag","GyroMagnitude",col_names[i])
};

# Reassigning the new descriptive column names to the combineddata set
colnames(combineddata) = col_names;

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

# combineddata without the activity_type column
combineddata1  = combineddata[,names(combineddata) != 'activity_type'];

# Summarizing combineddata1 to include the mean of each variable 
tidyData    = aggregate(combineddata1[,names(combineddata1) != c('activity_id','subject_id')],by=list(activity_id=combineddata1$activity_id,subject_id = combineddata1$subject_id),mean);

# Including descriptive activity names
tidyData    = merge(tidyData,activitylabels,by='activity_id',all.x=TRUE);

# write the file tidyData set 
write.table(tidyData, './tidyData.txt',row.names=FALSE,sep='\t');


