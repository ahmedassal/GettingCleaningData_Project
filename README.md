Getting AND Cleaning Data Course Project
===========================

### Description
The purpose of this project is to collect, work with, and clean the data set of the data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. The goal is to prepare tidy data that can be used for later analysis. 

A full description is available at the [site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) where the data was obtained. Here are [the data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) for the project.

### How does the script work?
The script merges the training and test sets of the features synthesized from the measured sensors data. Subsetting is performed on these features to include only features that represent the mean and standard deviation of the synthesized features. The features of interest are then merged with the activities and subjects who performed these activities.


### Project Files

* run_analysis.r    loads data, transform it, and prepare a tidy version of it.
* CodeBook.md   a code book that describes the variables, the data, and any transformations or work that is performed to clean up the data
* CodeBook.html   an html version of the code book
* GettingCleaningData_Project.TXT   the tidy dataset
* GettingCleaningData_Project_Summary.TXT   a summary of the tidy dataset 
* README.md   explains the files in the repo, summarizes how the scripts work


### The Code
Here is how you can run the code from your script:
```{r}
source("run_analysis.R")
run_analysis()
```
_Note:_   Please make sure that the data resides in a folder named `UCI HAR Dataset` which must be outside the project folder. That is to say, Its path should be `../UCI HAR Dataset`