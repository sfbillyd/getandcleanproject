# getandcleanproject
Class Project for Johns Hopkins Getting and Cleaning Data MOOC

WEARABLE COMPUTING SMARTPHONE ACCELEROMETER DATA


The the tidy data set contained in this repo is derived from data in a study using
accelerometers in smartphones. There were 30 subjects who were asked to engage in 6
different activities while wearing a Samsung Galaxy S5 affixed to their waist. The focus
of the tidy data set was to focus on the average measures of the means and standard
deviations of each measurement grouped by subject and activity. The description of the
study and the underlying data can be obtained from the links below:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

As a part of the study, the observations were arbitrarily divided into "test" and
"train" categories with 30% of the observations identified as "test" and 70% of the
observations identified as "train." The format of the two datasets was identical. Since 
the focus of the tidy data set is meant to be the average measures of the means and
standard deviations of the measures of ALL observations grouped by subject and activity,
it was necessary to merge the datasets identified as "test" and "train" into one
complete dataset. Once that is accomplished we can then group the data by subject and
activity and then summarize it to find the average of the means and standard deviations
for each measurement based on said grouping.

In order for the enclosed .R script to work successfully, the following files from the
UCI HAR Dataset folder must be in the current working directory of your R implementation:
X_test.txt:			contains the observation data for the test group
X_train.txt:		contains the observation data for the train group
y_test.txt:			contains the activity indicators associated with the test observations
y_train.txt:		contains the activity indicators associated with the train observations
subject_train.txt:	contains the subject indicators associated with the train observations
subject_test.txt:	contains the subject indicators associated with the test observations
features.txt:		contains the variable names of the observations for column headings

There are data in the "Inertial Signals" folders for both test and train observations.
These files contain the granular data upon which the files listed above are based.
The Inertial Signals files were NOT used directly in the processing of creating the tidy
dataset.

Environment instructions:
The .R script was run on a Mac Powerbook running Mac OSX 10.10.2. It was run using R
Studio version 0.98.1091. In addition to the standard libraries included with R Studio,
it is necessary to have the dplyr package installed and loaded. The dplyr package is used
specifically near the end of the script with group_by and summarise_each commands. 

Script Part I
Part I of the script begins by reading in the test observation data from x_test.txt
file. It then reads in the corresponding column names from features.txt and converts the
column data to a vector. Make.names() is then run on the column vector to remove invalid
characters such as parenthesis, commas, etc. The now "clean" column names are then
associated with the test data observations using colnames(). The goal of the project was
to create a tidy dataset consisting of only mean and standard deviation values from the
original dataset. I opened the original features.txt file in Excel and identified the
variable names that had "mean()" or "std()". I noted the column numbers and used that to
create a new dataframe called testMean which consisted only of the columns associated with
the identified mean() and std() values. 

The next step was to bring in the Activity indicators from y_test.txt. The column
containing the activity numbers were then converted to a character vector where gsub() was
run a total of 6 times to convert activity numbers to english descriptions of the
activities per the project goals. Next I brought in the subject indicators from the
subject_test.txt file. Cbind() is then used to combine the subject indicators and activity
descriptions as columns with testMean to create the testDF dataframe. Colnames() is then used to add
"Subject" and "Activity" column headings to the appropriate columns. 

The exact same procedures are used with the train dataset to build a dataframe called
trainDF. The file x_train.txt is read in, column headings from features.txt are applied,
the resultant dataframe is pared down to only include the relevant columns, the activities
are brought in from the y_train.txt file, converted to english descriptions and then cbind
is used to combine the subject information from subject_train.txt with the intermediate
dataframe to create trainDF. trainDF is identical to testDF in every way except the rows
correspond to the observations that were arbitrarily grouped into either test or train as
per the study.

Script Part II
Part II of the script simply combines the two dataframes, trainDF and testDF created
in Part I to create a single dataframe called mergedDF. The script then builds a list of
data and values used earlier in the script that are no longer required. To free resources
rm() is used to remove the identified superfluous values and data from the global en-
vironment.

Script Part III
Part III of the script uses the power of the dplyr package to group the combined
dataframe from part II by Subject and Activity using group_by() to create the basis for
the final dataframe called tidyDF. The final transformation is to use summarise_each()
to meld the tidyDF into a summary of 180 rows (6 activities for each of the 30 subjects).
Each of the rows contains the subjectid, the activity description, and the average of each
of the 66 variables identified previously as mean() and std() of the underlying ob-
servations. In the last step, the script writes the tidyDF file to the current working
directory as tidyDF.txt. The file uses tabs as the separator and can be opened in Excel
or other spreadsheet application for viewing. The file can also be read into an R environ-
ment using read.table("tidyDF.txt", header = TRUE) assuming the file is in the current
working directory.