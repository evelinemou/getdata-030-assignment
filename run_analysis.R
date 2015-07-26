## question 1
## first read & load the data set under the folder "train", including  activity, and the results
path1 <-"./getdata-030_project_dataset/train/subject_train.txt"
data1 <-read.table(path1,header=FALSE)
## rename the column to "Subject"
names(data1)[1] <-"Subject"
path1 <-"./getdata-030_project_dataset/train/y_train.txt"
data2 <-read.table(path1,header=FALSE)
## rename the column to "Activity"
names(data2)[1] <-"Activity"
path1 <-"./getdata-030_project_dataset/train/X_train.txt"
data3 <-read.table(path1,header=FALSE)
## merge the subject, activity and result tables
alldata <-cbind(data1,data2)
alldata <-cbind(alldata,data3)
## first read & load the data set under the folder "test", including  activity, and the results
path1 <-"./getdata-030_project_dataset/test/subject_test.txt"
data1 <-read.table(path1,header=FALSE)
## rename the column to "Subject"
names(data1)[1] <-"Subject"
path1 <-"./getdata-030_project_dataset/test/y_test.txt"
data2 <-read.table(path1,header=FALSE)
## rename the column to "Activity"
names(data2)[1] <-"Activity"
path1 <-"./getdata-030_project_dataset/test/X_test.txt"
data3 <-read.table(path1,header=FALSE)
## merge the subject, activity and result tables
alldata1 <-cbind(data1,data2)
alldata1 <-cbind(alldata1,data3)

## merge the train and test table
alldata <-rbind(alldata,alldata1)

## question 2

## read the features table that describes the result columns
path1 <-"./getdata-030_project_dataset/features.txt"
features <-read.table(path1,sep=" ",header=FALSE)
library(dplyr)

n <-nrow(features)
z <-1
features1 <-data.frame()
for (i in 1:n) {
        var <-as.character(features[i,2])
        
        ## find all columns that contains text "mean" and "std"
        if (grepl(as.character("mean()"),var,fixed=TRUE) || (grepl(as.character("std()"),var,fixed=TRUE)) ) {
                features1[z,1] <-features[i,1]
                features1[z,2] <-var
                z<-z+1
        }
}

## put together the output table
alldata_selected <-select(alldata,1:2)
n<-nrow(features1)
for (i in 1:n) {
        ## select the columns needed
        ## create a new table with the selected columns
        z <-ncol(alldata_selected)+1
        var1 <-features1[i,1]+2
        var2 <-as.character(features1[i,2])
        alldata_selected <-cbind(alldata_selected,alldata[,var1])
        ## Question 4: rename the new columns by adding the corresponding variable name
        
        names(alldata_selected)[z] <-var2
        
}

## question 3
## read the activity link table
path1 <-"./getdata-030_project_dataset/activity_labels.txt"
activity_table <-read.table(path1,sep=" ",header=FALSE)

n<-nrow(alldata_selected)
n1 <-nrow(activity_table)
newcolnum <-ncol(alldata_selected)+1

## in the output file, indicate the activity name by matching the activty number with the activity table
for (i in 1:n) {
        activity_num <-alldata_selected[i,2]
        for (j in 1:n1) {
                if (activity_num==activity_table[j,1]){

                        activity_name <-as.character(activity_table[j,2])
                        alldata_selected[i,newcolnum] <-  activity_name
                        break
                }
                
        }
}

## name the new column
names(alldata_selected)[newcolnum] <-"Activity_Name"

## Question 5
## load the reshape2 library
library(reshape2)
n<-nrow(features1)+2
## find out how many variables are there
varnames <-c(names(alldata_selected)[3:n])
## melt the dataset and make it skinny by "Subject" and "Activity_Name"
melt_dataset <-melt(alldata_selected,id=c("Subject","Activity_Name"),measure.vars=varnames)
## dcast the dataset and get the mean of all variables
tidydata_with_averages <-dcast(melt_dataset,Subject + Activity_Name ~ variable,mean)
## write the result to a txt file with row.name set to FALSE for submittion
write.table(tidydata_with_averages,file="twa.txt",row.name=FALSE)
