library(dplyr)

setwd(".")
activity_Labels_Url = "../UCI HAR Dataset/activity_labels.txt"
activity_Labels = read.table(activity_Labels_Url, header = FALSE)
names(activity_Labels) = c("activity_id", "activity")
activity_Labels$activity_id = factor(activity_Labels$activity_id)
rm(activity_Labels_Url)

featuresUrl = "../UCI HAR Dataset/features.txt"
features = read.table(featuresUrl, header = FALSE)
names(features) = c("feature_id", "feature_label")
rm(featuresUrl)


interestingFeaturesMean = "mean" 
interestingFeaturesStd = "std"
interestingFeaturesRegex = "mean|std"


foundMeanFeaturesIndices = grep(interestingFeaturesMean, features$feature_label)
foundStdFeaturesIndices = grep(interestingFeaturesStd, features$feature_label)
rm(interestingFeaturesMean)
rm(interestingFeaturesStd)
rm(interestingFeaturesRegex)

#foundinterestingFeaturesIndices = regexec(interestingFeaturesRegex, features$feature_label, ignore.case = TRUE)
interestingFeaturesIndices = c(foundMeanFeaturesIndices, foundStdFeaturesIndices)

rm(foundMeanFeaturesIndices, foundStdFeaturesIndices )
interestingFeaturesIndices = sort(interestingFeaturesIndices)
variablesLabels = features[interestingFeaturesIndices,2]
variablesLabels = as.character(variablesLabels)


subjectTrainUrl="../UCI HAR Dataset/subject_train.txt"
subjectTestUrl="../UCI HAR Dataset/subject_test.txt"

subjectTrain=read.table(subjectTrainUrl, header = FALSE)
subjectTest=read.table(subjectTestUrl, header = FALSE)
subject = rbind(subjectTrain, subjectTest)
names(subject) = c("subject")
subject$subject = factor(subject$subject)

rm(subjectTrainUrl)
rm(subjectTestUrl)
rm(subjectTrain)
rm(subjectTest)

X_train_Url = "../UCI HAR Dataset/X_train.txt"
X_test_Url = "../UCI HAR Dataset/X_test.txt"
X_train =read.table(X_train_Url, header = FALSE)
X_test =read.table(X_test_Url, header = FALSE)
X = rbind(X_train, X_test)

rm(X_train_Url)
rm(X_train)
rm(X_test_Url)
rm(X_test)

Y_train_Url = "../UCI HAR Dataset/Y_train.txt"
Y_test_Url = "../UCI HAR Dataset/Y_test.txt"
Y_train =read.table(Y_train_Url, header = FALSE)
Y_test =read.table(Y_test_Url, header = FALSE)
Y = rbind(Y_train, Y_test)
names(Y) = c("activity")
Y$activity = factor(Y$activity)

rm(Y_train_Url)
rm(Y_train)
rm(Y_test_Url)
rm(Y_test)

activitiesFeatures = cbind(subject, X)
activitiesFeatures = cbind(Y, activitiesFeatures)
interestingFeaturesIndices=interestingFeaturesIndices+2
interestingFeaturesIndices=c(1,2, interestingFeaturesIndices)
activitiesFeatures = activitiesFeatures[,interestingFeaturesIndices]
variablesLabels = c("activity_id", "subject_id", variablesLabels)
names(activitiesFeatures) = variablesLabels

temp=merge(activity_Labels, activitiesFeatures, by="activity_id")
activitiesComplete = temp[,-(1)]
rm(temp)

tidyDataUrl = "GettingCleaningData_Project.TXT"
write.table(activitiesComplete, tidyDataUrl, row.names=FALSE)

activitesTest = read.table(tidyDataUrl, header = TRUE)
all(activitesTest == activitiesComplete)

activitiesSummary= activitiesComplete %>%
  group_by(subject_id, activity) %>%
  summarise_each(funs(mean))
summaryNames = c(names(activitiesSummary)[1], names(activitiesSummary)[2], paste(rep_len("mean of",length.out= length(names(activitiesSummary))-2), names(activitiesSummary)[-(1:2)]))             
names(activitiesSummary) = summaryNames

tidyDataUrl2 = "GettingCleaningData_Project_Summary.TXT"
write.table(activitiesSummary, tidyDataUrl2, row.names=FALSE)
#glimpse(activitiesSummary)
 
activitesTest2 = read.table(tidyDataUrl2, header = TRUE)
all(activitesTest2 == activitiesSummary) 

# body_acc_x_train_url = "../UCI HAR Dataset/Inertial Signals/body_acc_x_train.txt"
# body_acc_x_test_url = "../UCI HAR Dataset/Inertial Signals/body_acc_x_test.txt"
# body_acc_x_train = read.table(body_acc_x_train_url, header=FALSE)
# body_acc_x_test = read.table(body_acc_x_test_url, header=FALSE)
# body_acc_x = rbind(body_acc_x_train, body_acc_x_test)
# 
# body_acc_y_train_url = "../UCI HAR Dataset/Inertial Signals/body_acc_y_train.txt"
# body_acc_y_test_url = "../UCI HAR Dataset/Inertial Signals/body_acc_y_test.txt"
# body_acc_y_train = read.table(body_acc_y_train_url, header=FALSE)
# body_acc_y_test = read.table(body_acc_y_test_url, header=FALSE)
# body_acc_y = rbind(body_acc_y_train, body_acc_y_test)
# 
# body_acc_z_train_url = "../UCI HAR Dataset/Inertial Signals/body_acc_z_train.txt"
# body_acc_z_test_url = "../UCI HAR Dataset/Inertial Signals/body_acc_z_test.txt"
# body_acc_z_train = read.table(body_acc_z_train_url, header=FALSE)
# body_acc_z_test = read.table(body_acc_z_test_url, header=FALSE)
# body_acc_z = rbind(body_acc_z_train, body_acc_z_test)