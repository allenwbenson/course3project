# Code Book for Tidy Data Set
<br>

## Summary
The tidy data set presented here (tidy.txt) has been constructed by loading data sets from a source, then merging and subsetting these data, and then transforming the data into the final format.

***

## Original Data Source
The original data is available from the page "Human Activity Recognition Using Smartphones Data Set" located at this url:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The original data set was downloaded from this site. It was then read, merged, subsetted, and transformed to produce the data described in the following section.

***

## Variables

The original data contains 561 variables. This description of the data was taken from the file "features_info.txt", which can be found in the downloaded zip file:

"The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions."

The variables found in the tidy data set are a result of merging, subsetting, and transforming the original data. There are 30 subjects for which data was generated (numbered 1..30). There are 6 activities that each subject performed:

* 1 WALKING
* 2 WALKING_UPSTAIRS
* 3 WALKING_DOWNSTAIRS
* 4 SITTING
* 5 STANDING
* 6 LAYING

The 561 variables were subsetted to 66, based on whether the feature was a calculated mean or standard deviation. This was done by selecting only the features for whom the name contained either "mean()" or "std()". These 66 features were merged with the subject and activity for each observation (row). This merged data was then transformed first by melting on the subject and activity variables, then casting to find the average (mean) of each value. The final tidy data set contains:

* Subject  -  integer, subject number (1..30)
* Activity  -  character, activity name as shown above

For each of the following 66 variables, the value in the tidy data set is the average (mean) of the original values by subject/activity. It should be noted that the original data features were normalized and bounded within [-1,1], which is why it shows negative standard deviations:

* tBodyAcc-mean()-X     
* tBodyAcc-mean()-Y 
* tBodyAcc-mean()-Z 
* tGravityAcc-mean()-X 
* tGravityAcc-mean()-Y 
* tGravityAcc-mean()-Z 
* tBodyAccJerk-mean()-X 
* tBodyAccJerk-mean()-Y 
* tBodyAccJerk-mean()-Z 
* tBodyGyro-mean()-X 
* tBodyGyro-mean()-Y 
* tBodyGyro-mean()-Z 
* tBodyGyroJerk-mean()-X 
* tBodyGyroJerk-mean()-Y 
* tBodyGyroJerk-mean()-Z 
* tBodyAccMag-mean() 
* tGravityAccMag-mean() 
* tBodyAccJerkMag-mean() 
* tBodyGyroMag-mean() 
* tBodyGyroJerkMag-mean() 
* fBodyAcc-mean()-X 
* fBodyAcc-mean()-Y 
* fBodyAcc-mean()-Z 
* fBodyAccJerk-mean()-X 
* fBodyAccJerk-mean()-Y 
* fBodyAccJerk-mean()-Z 
* fBodyGyro-mean()-X 
* fBodyGyro-mean()-Y 
* fBodyGyro-mean()-Z 
* fBodyAccMag-mean() 
* fBodyBodyAccJerkMag-mean() 
* fBodyBodyGyroMag-mean() 
* fBodyBodyGyroJerkMag-mean() 
* tBodyAcc-std()-X 
* tBodyAcc-std()-Y 
* tBodyAcc-std()-Z 
* tGravityAcc-std()-X 
* tGravityAcc-std()-Y 
* tGravityAcc-std()-Z 
* tBodyAccJerk-std()-X 
* tBodyAccJerk-std()-Y 
* tBodyAccJerk-std()-Z 
* tBodyGyro-std()-X 
* tBodyGyro-std()-Y 
* tBodyGyro-std()-Z 
* tBodyGyroJerk-std()-X 
* tBodyGyroJerk-std()-Y 
* tBodyGyroJerk-std()-Z 
* tBodyAccMag-std() 
* tGravityAccMag-std() 
* tBodyAccJerkMag-std() 
* tBodyGyroMag-std() 
* tBodyGyroJerkMag-std() 
* fBodyAcc-std()-X 
* fBodyAcc-std()-Y 
* fBodyAcc-std()-Z 
* fBodyAccJerk-std()-X 
* fBodyAccJerk-std()-Y 
* fBodyAccJerk-std()-Z 
* fBodyGyro-std()-X 
* fBodyGyro-std()-Y 
* fBodyGyro-std()-Z 
* fBodyAccMag-std() 
* fBodyBodyAccJerkMag-std() 
* fBodyBodyGyroMag-std() 
* fBodyBodyGyroJerkMag-std()

***

## Transformations

The script included with this tidy data set (run_analysis.R) is a set of R instructions that will do the following:

1. Download the UCI HAR Dataset zip file and unzip to the working directory
2. Load the reshape2 R package
3. Read in the feature labels and determine desired features (mean()/std())
4. Read in the test/train data sets and subset by desired feature
5. Merge the subject, activity and test data by column (cbind)
6. Merge the subject, activity and train data by column (cbind)
7. Merge the above combined data into one data set by row (rbind)
8. Apply selected column names
9. Melt the data using subject and activity as variables (melt)
10. Cast the melted data using mean() as the function (dcast)
11. Write the tidy data out as a text file (tidy.txt)

***
