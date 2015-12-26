# READ ME
<br>

The R script in this repository is intended to be run as a single file.

For best results, put the run_analysis.R file in your working directory.

The script assumes that the reshape2 package has been installed in R. If you are not sure, run the following R function:

> install.packages("reshape2")

The script will load the package (using library(reshape2)) near the beginning of the run.

The script also assumes that you are connected to the internet, and will attempt to download the data from the UCI Machine Learning Repository.

To run the script from your working directory, execute the following R function:

> source("run_analysis.R")

In general, the script will perform the following tasks:

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


