library(plyr)
library(dplyr)

## Specifc Data Collection
features <- tbl_df(read.table("UCI HAR Dataset/features.txt", as.is = TRUE, col.names = c("id", "feature")))
activities <- tbl_df(read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity")))

## Generic Data Collection Functions
getData <- function(path) 
{
  tbl_df(
    read.table(
      path, header = FALSE,col.names = features$feature,check.names = FALSE
    )
  )
}

getActivities <- function(path) 
{
  left_join(read.table(path, col.names = "id"), activities, by = "id")
}

getSubjects <- function(path) 
{
  tbl_df(
    read.table(
      path, col.names = "subject"
    )
  )
}

## collect all the data
trainingData <- getData("UCI HAR Dataset/train/X_train.txt")
trainingActivites <- getActivities("UCI HAR Dataset/train/y_train.txt")
trainingSubjects <- getSubjects("UCI HAR Dataset/train/subject_train.txt")

testData <- getData("UCI HAR Dataset/test/X_test.txt")
testActivities <- getActivities("UCI HAR Dataset/test/y_test.txt")
testSubjects <- getSubjects("UCI HAR Dataset/test/subject_test.txt")

## combine data and calculate
completedTraining <- cbind(activity = trainingActivites$activity,trainingSubjects, trainingData)
completedTest <- cbind(activity = testActivities$activity, testSubjects, testData)
combinedData <- rbind(completedTraining, completedTest)

summarizedData <- combinedData[, grep("mean\\(\\)|std\\(\\)|activity|subject",
                                          colnames(combinedData), 
                                          value = TRUE)] %>%
                                        group_by(activity, subject) %>% 
                                        summarize_each(funs(mean))

produceFile <- function(path = summarizedData){write.table(summarizedData,file="tidy_data.txt")}
