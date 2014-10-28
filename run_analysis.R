run_analysis = function(){
  

  rm(list = ls())
  library(dplyr)
  setwd(".")
  # Loading the activities labels and converting them into factors
  activity_Labels_Url <- "../UCI HAR Dataset/activity_labels.txt"
  activity_Labels <<- read.table(activity_Labels_Url, header = FALSE)
  names(activity_Labels) <- c("activity_id", "activity")
  activity_Labels$activity_id <- factor(activity_Labels$activity_id)
  rm(activity_Labels_Url)
  
  # Loading the features labels and features columns indices
  featuresUrl <- "../UCI HAR Dataset/features.txt"
  features <<- read.table(featuresUrl, header = FALSE)
  names(features) <- c("feature_id", "feature_label")
  rm(featuresUrl)
  
  
  interestingFeaturesMean <- "mean" 
  interestingFeaturesStd <- "std"
  interestingFeaturesRegex <- "mean|std"
  
  # Searching for subset of features of interetst that represent the mean or standard deviations of the sensors measurements and getting the resepctive indices
  foundMeanFeaturesIndices <- grep(interestingFeaturesMean, features$feature_label)
  foundStdFeaturesIndices <- grep(interestingFeaturesStd, features$feature_label)
  rm(interestingFeaturesMean)
  rm(interestingFeaturesStd)
  rm(interestingFeaturesRegex)
  
  interestingFeaturesIndices <<- c(foundMeanFeaturesIndices, foundStdFeaturesIndices)
  
  rm(foundMeanFeaturesIndices, foundStdFeaturesIndices )
  interestingFeaturesIndices <<- sort(interestingFeaturesIndices)
  
  # extracting the labels for the subset of features of interest
  variablesLabels <<- features[interestingFeaturesIndices,2]
  variablesLabels <<- as.character(variablesLabels)
  
  # Loading the datasets of the subjects for both the training and testing sets
  subjectTrainUrl<-"../UCI HAR Dataset/subject_train.txt"
  subjectTestUrl<-"../UCI HAR Dataset/subject_test.txt"
  
  subjectTrain<-read.table(subjectTrainUrl, header = FALSE)
  subjectTest<-read.table(subjectTestUrl, header = FALSE)
  
  # mergintg the training the testing datasets of the subjects into one dataset
  subject <<- rbind(subjectTrain, subjectTest)
  names(subject) <- c("subject")
  subject$subject <- factor(subject$subject)
  
  rm(subjectTrainUrl)
  rm(subjectTestUrl)
  rm(subjectTrain)
  rm(subjectTest)
  
  # Loading the features training and testing datasets and merging them into one
  X_train_Url <- "../UCI HAR Dataset/X_train.txt"
  X_test_Url <- "../UCI HAR Dataset/X_test.txt"
  X_train <-read.table(X_train_Url, header = FALSE)
  X_test <-read.table(X_test_Url, header = FALSE)
  X <<- rbind(X_train, X_test)
  
  rm(X_train_Url)
  rm(X_train)
  rm(X_test_Url)
  rm(X_test)
  
  # Loading the activities training and testing datasets and merging them into one
  Y_train_Url <- "../UCI HAR Dataset/Y_train.txt"
  Y_test_Url <- "../UCI HAR Dataset/Y_test.txt"
  Y_train <-read.table(Y_train_Url, header = FALSE)
  Y_test <-read.table(Y_test_Url, header = FALSE)
  Y <<- rbind(Y_train, Y_test)
  names(Y) <- c("activity")
  Y$activity <- factor(Y$activity)
  
  rm(Y_train_Url)
  rm(Y_train)
  rm(Y_test_Url)
  rm(Y_test)
  
  # concatinating the subjects and the features data sets into an subjects/features dataset  
  activitiesFeatures <<- cbind(subject, X)
  # concatinating the activities and the subjects/features dataset data sets into an activities/subjects/features dataset  
  activitiesFeatures <<- cbind(Y, activitiesFeatures)
  interestingFeaturesIndices <<- interestingFeaturesIndices+2
  interestingFeaturesIndices <<- c(1,2, interestingFeaturesIndices)
  
  # extracting features of interest only from the activities/subjects/features dataset
  activitiesFeatures <<- activitiesFeatures[,interestingFeaturesIndices]
  
  # renaming the different features of ineterest variables to their proper names
  variablesLabels <<- c("activity_id", "subject_id", variablesLabels)
  names(activitiesFeatures) <- variablesLabels
  
  #merging the activties human-friendly labels with the activities/subjects/features of interest dataset
  temp<-merge(activity_Labels, activitiesFeatures, by="activity_id")
  activitiesComplete <<- temp[,-(1)]
  rm(temp)
  
  # Writing the dataset of activities/subjects/features to a file 
  tidyDataUrl <<- "GettingCleaningData_Project.TXT"
  write.table(activitiesComplete, tidyDataUrl, row.names=FALSE)
  
  # testing the written file 
  activitesTest <- read.table(tidyDataUrl, header = TRUE)
  all(activitesTest == activitiesComplete)
  rm(activitesTest)
  
  # Summarizing the features of interest, by taking their mean for every activity and subject
  activitiesSummary <<- activitiesComplete %>%
    group_by(subject_id, activity) %>%
    summarise_each(funs(mean))
  summaryNames <<- c(names(activitiesSummary)[1], names(activitiesSummary)[2], paste(rep_len("mean of",length.out= length(names(activitiesSummary))-2), names(activitiesSummary)[-(1:2)]))             
  names(activitiesSummary) <- summaryNames
  
  # writing the summary to a file
  tidyDataUrl2 <- "GettingCleaningData_Project_Summary.TXT"
  write.table(activitiesSummary, tidyDataUrl2, row.names=FALSE)
  #glimpse(activitiesSummary)
  
  
  

}