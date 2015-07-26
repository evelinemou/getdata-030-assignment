# getdata-030-assignment
the programming assignment for get data 030
This is the .R code to run the analysis for Coursea "Getting and Cleaning Data" getdata-030 Course Project
To run this analysis, 
1. download this code
2. download the Samsung data at <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
3. unzip the Samsung data to your working directory
4. rename the unzipped folder to "getdata-030_project_dataset"
5. run the code
The code will generate a output file called "twa.txt" in your working directory

About the script "run_analysis.R"

A. First the script reads and loads the tables under the folder "train", including activity and the result
Then it merges the tables together
B. Then it reads and loads the tables under the folder "test", including activity and the result
and merge the tables together
C. Then the script rbind the tables from A and B together to form one dataset

D. The script reads the features file which contains the name of each measurable variables
E. It selects the variables needed per Question 2
F. It selects the data columns from the data file from C per the list from E
G. It renames the column names for the selected data colunns

H. The script reads the activity link table
I. Per H, the script adds a column named "Activity_Name" based the activity  label for each observation

J. The script melts the data table to make it "skinny"
K. Then it summarizes the data table based on Subject and Activity Name to get the mean of each variable

L. Lastly, the script writes and output text file

For the description of the output file, please refer to "CodeBook.md"


