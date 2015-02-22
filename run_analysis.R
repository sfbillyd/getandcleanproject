## Script for Course Project: Getting and Cleaning Data

##
## PART I
## Build test and training dataframes, normalize them and prepare for merging
##

## Read in test data
testData <- read.table("x_test.txt")
## Read in column names from features.txt
testColumnNames <- read.table("features.txt")
## Convert testColumnNames to a vector
testColumnNames <- testColumnNames[['V2']]
## Clean up testColumnNames by removing invalid characters
testColumnNames <- make.names(testColumnNames)
## Attach testColumnNames to testData
colnames(testData) <- testColumnNames
## Create new data frame with only mean() and std() variables
testMean <- testData[c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543)]
## Read in test activity
testActivity <- read.table("y_test.txt")
## Change testActivity to character vector for manipulation with gsub
testActivity <- as.character(testActivity[['V1']])
## Change activities to descriptive names
testActivity <- gsub("1", "Walking", testActivity)
testActivity <- gsub("2", "Walking_Upstairs", testActivity)
testActivity <- gsub("3", "Walking_Downstairs", testActivity)
testActivity <- gsub("4", "Sitting", testActivity)
testActivity <- gsub("5", "Standing", testActivity)
testActivity <- gsub("6", "Laying", testActivity)
## Read in test subject data
testSubject <- read.table("subject_test.txt")
## Combine test mean, activity and subject data frames into 1 data frame
testDF <- cbind(testSubject, testActivity, testMean)
## Change first 2 column names to be descriptive
colnames(testDF)[1] <- "Subject"
colnames(testDF)[2] <- "Activity"

## Read in training data
trainData <- read.table("x_train.txt")
## Read in column names from features.txt
trainColumnNames <- read.table("features.txt")
## Convert testColumnNames to a vector
trainColumnNames <- trainColumnNames[['V2']]
## Clean up testColumnNames by removing invalid characters
trainColumnNames <- make.names(trainColumnNames)
## Attach testColumnNames to testData
colnames(trainData) <- trainColumnNames
## Create new data frame for training with only mean() and std() variables
trainMean <- trainData[c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543)]
## Read in train activity
trainActivity <- read.table("y_train.txt")
## Change trainActivity to character vector for manipulation with gsub
trainActivity <- as.character(trainActivity[['V1']])
## Change activities to descriptive names
trainActivity <- gsub("1", "Walking", trainActivity)
trainActivity <- gsub("2", "Walking_Upstairs", trainActivity)
trainActivity <- gsub("3", "Walking_Downstairs", trainActivity)
trainActivity <- gsub("4", "Sitting", trainActivity)
trainActivity <- gsub("5", "Standing", trainActivity)
trainActivity <- gsub("6", "Laying", trainActivity)
## Read in training subject data
trainSubject <- read.table("subject_train.txt")
## Combine train mean, activity and subject data frames into 1 data frame
trainDF <- cbind(trainSubject, trainActivity, trainMean)
## Change first 2 column names to be descriptive
colnames(trainDF)[1] <- "Subject"
colnames(trainDF)[2] <- "Activity"

##
## PART II
## Merge normalized train and test dataframes and clean global environment
##

## Create new merged data frame
mergedDF <- merge(testDF, trainDF, all = TRUE)
## Clear components that went into constructing mergedDF
toClearValues <- c("testData", "testMean", "testSubject", "testDF", "trainData", "trainMean", "trainSubject", "trainDF")
toClearData <- c("testActivity", "trainActivity", "testColumnNames", "trainColumnNames")
rm(list = toClearData)
rm(list = toClearValues)

##
## PART III
## Create final tidy dataframe by gouping and summarizing data by averages of measurements for each subject and activity
##

## Create final dataframe with grouping by subject and activity
tidyDF <- group_by(mergedDF, Subject, Activity)
## transform final dataframe into summarized dataframe containing averages of measurements for all activities for all subjects
tidyDF <- summarise_each(tidyDF, funs(mean))

## Write the file to the current working directory as a tab-delimited .txt file
write.table(tidyDF, "tidyDF.txt", sep="\t", row.name = FALSE)