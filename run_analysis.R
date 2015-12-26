## This script will perform these steps to produce a tidy data set:
##
## 1. Download the UCI HAR Dataset zip file and unzip to the working directory
## 2. Load the reshape2 R package
## 3. Read in the feature labels and determine desired features (mean()/std())
## 4. Read in the test/train data sets and subset by desired feature
## 5. Merge the subject, activity and test data by column (cbind)
## 6. Merge the subject, activity and train data by column (cbind)
## 7. Merge the above combined data into one data set by row (rbind)
## 8. Apply selected column names
## 9. Melt the data using subject and activity as variables (melt)
## 10. Cast the melted data using mean() as the function (dcast)
## 11. Write the tidy data out as a text file (tidy.txt)

## Download and unzip the dataset

fileName <- "getdata-projectfiles-UCI HAR Dataset.zip"
fileUrl <- paste0("https://d396qusza40orc.cloudfront.net/",
        "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
mainFolder <- "UCI HAR Dataset"

if (!file.exists(fileName)){
        download.file(url = fileUrl, destfile = fileName)
}  
if (!file.exists(mainFolder)) { 
        unzip(filename) 
}

## Load the reshape2 package

library(reshape2)

## Set up file names

activityLabelsFileName <- paste0(mainFolder, "/activity_labels.txt")
featureLabelsFileName <- paste0(mainFolder, "/features.txt")

xTestFileName <- paste0(mainFolder, "/test/X_test.txt")
yTestFileName <- paste0(mainFolder, "/test/y_test.txt")
subjectTestFileName <- paste0(mainFolder, "/test/subject_test.txt")

xTrainFileName <- paste0(mainFolder, "/train/X_train.txt")
yTrainFileName <- paste0(mainFolder, "/train/y_train.txt")
subjectTrainFileName <- paste0(mainFolder, "/train/subject_train.txt")

## Read the labels and construct a vector of desired features
## Get character vectors from factor vectors

activityLabels <- read.table(file = activityLabelsFileName)
activityLabelsVect <- as.character(activityLabels$V2)
featureLabels <- read.table(file = featureLabelsFileName)
featureLabelsVect <- as.character(featureLabels$V2)

## Desired features are those that contain "mean()" and "std()" in the name

desiredFeaturesMean <- grep("mean()", featureLabelsVect, fixed=TRUE)
desiredFeaturesStd <- grep("std()", featureLabelsVect, fixed=TRUE)
desiredFeatures <- c(desiredFeaturesMean, desiredFeaturesStd)
desiredFeaturesNames <- featureLabels[desiredFeatures,2]
desiredFeaturesNames <- as.character(desiredFeaturesNames)

## Read the test and train data (only the desired features columns)

xTest <- read.table(file = xTestFileName)[desiredFeatures]
yTest <- read.table(file = yTestFileName)
subjectTest <- read.table(file = subjectTestFileName)

xTrain <- read.table(file = xTrainFileName)[desiredFeatures]
yTrain <- read.table(file = yTrainFileName)
subjectTrain <- read.table(file = subjectTrainFileName)

## Column bind to single data sets

test <- cbind(subjectTest, yTest, xTest)
train <- cbind(subjectTrain, yTrain, xTrain)

## Combine the test and train sets into one data set

combined <- rbind(test,train)

## Set the column names

colnames(combined) <- c("Subject", "Activity", desiredFeaturesNames)

## "Factorize" the subject and activity columns

combined$Subject <- as.factor(combined$Subject)
combined$Activity <- factor(combined$Activity, levels = activityLabels$V1, 
        labels = activityLabelsVect)


## Melt the data using Subject and Activity as the variables

melted <- melt(combined, id = c("Subject", "Activity"))

## Cast the melted data as a dataframe. The function will be 
## the mean of the values for each.

means <- dcast(melted, Subject + Activity ~ variable, mean)

## Write the data frame out to a text file.  This is the tidy data.

write.table(means, "tidy.txt", row.names = FALSE, quote = FALSE)