---
title: "CodeBook for Getting and Cleanning Data - John Hopkins Project Course"
output: html_document
---

## The Data
The data used in this analysis is obtained from this [website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and [the link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) for the data used.

## The Transformations
  * Loading the activities labels and converting them into factors
  * Loading the features labels and features columns indices
  * Searching for the subset of features of interetst that represent the mean/standard deviations of the sensors measurements and getting their resepctive indices
  * extracting the labels for the subset of features of interest
  * Loading and merging the datasets of the subjects for both the training and testing sets
  * Loading the training features and testing features datasets and merging them into one
  * Loading the training activities and testing activities datasets and merging them into one
  * concatinating the subjects and the features datasets into one subjects/features dataset  
  * concatinating the activities and the subjects/features dataset into an activities/subjects/features dataset  
  * extracting features of interest only from the activities/subjects/features dataset
  * renaming the different features of ineterest variables to their proper names
  *merging the activties human-friendly labels with the activities/subjects/features of interest dataset
  * Writing the dataset of activities/subjects/features to a file 
  * testing the written file 
  * Summarizing the features of interest, by taking their mean for every activity and subject
  * writing the summary to a file 
  
  
## The Variables

**activitiesComplete** the dataset contains the data for the transformed measurements of 10299 time windows in which six activities were pertformed by 30 subjects. The transormations performed on the selected measurements are the mean and standard deviation of the sensors measurements. The resulting dataset is a 10299 x 81 dataframe of 10299 obsevations and 81 variables, includig 79 features

**activitiesSummary** the dataset contains a summary of the *activeComplete* dataset. The summary is performed by taking the mean of every feature in the *activeComplete* dataset for each of the six activities and each of the 30 subjects. The resulting dataset is a 180 x 81 dataframe of 180 means for 79 variables/features.

## The Code
Here is how you can run the code from your script:
```{r}
source("run_analysis.R")
run_analysis()
```