
featuresUrl = "../UCI HAR Dataset/features.txt"
features = read.table(featuresUrl, header = FALSE)

subjectTrainUrl="../UCI HAR Dataset/subject_train.txt"
subjectTestUrl="../UCI HAR Dataset/subject_test.txt"

subjectTrain=read.table(subjectTrainUrl, header = FALSE)
subjectTest=read.table(subjectTestUrl, header = FALSE)
subject = rbind(subjectTrain, subjectTest)

X_train_Url = "../UCI HAR Dataset/X_train.txt"
X_test_Url = "../UCI HAR Dataset/X_test.txt"
X_train =read.table(X_train_Url, header = FALSE)
X_test =read.table(X_test_Url, header = FALSE)
X = rbind(X_train, X_test)

Y_train_Url = "../UCI HAR Dataset/Y_train.txt"
Y_test_Url = "../UCI HAR Dataset/Y_test.txt"
Y_train =read.table(Y_train_Url, header = FALSE)
Y_test =read.table(Y_test_Url, header = FALSE)
Y = rbind(Y_train, Y_test)

body_acc_x_train_url = "../UCI HAR Dataset/Inertial Signals/body_acc_x_train.txt"
body_acc_x_test_url = "../UCI HAR Dataset/Inertial Signals/body_acc_x_test.txt"
body_acc_x_train = read.table(body_acc_x_train_url, header=FALSE)
body_acc_x_test = read.table(body_acc_x_test_url, header=FALSE)
body_acc_x = rbind(body_acc_x_train, body_acc_x_test)

body_acc_y_train_url = "../UCI HAR Dataset/Inertial Signals/body_acc_y_train.txt"
body_acc_y_test_url = "../UCI HAR Dataset/Inertial Signals/body_acc_y_test.txt"
body_acc_y_train = read.table(body_acc_y_train_url, header=FALSE)
body_acc_y_test = read.table(body_acc_y_test_url, header=FALSE)
body_acc_y = rbind(body_acc_y_train, body_acc_y_test)

body_acc_z_train_url = "../UCI HAR Dataset/Inertial Signals/body_acc_z_train.txt"
body_acc_z_test_url = "../UCI HAR Dataset/Inertial Signals/body_acc_z_test.txt"
body_acc_z_train = read.table(body_acc_z_train_url, header=FALSE)
body_acc_z_test = read.table(body_acc_z_test_url, header=FALSE)
body_acc_z = rbind(body_acc_z_train, body_acc_z_test)