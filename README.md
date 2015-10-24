# Data-getting-Cleaning
course project for Coursera Getting and Cleaning data October 2015

all funcitons for project are contained in run_analysis.R
 - first section: Data Specifc Collection
    contains the asignment of 2 files: features and activities; used in later functions for combining the data sets
    
 - second section: Generic Data Collection
    contains 3 functions to collect specifc data sets for various directories:
      getData 
      getActivities
      getSubjects
      
 - third section:  collects all the data
    collects data from the the various failes and assigns to dataframes in order to use in final section
    
 - final section: combine and calculates
    combines the dataframes and then summarizes them pullingout the STD and MEAN values for each activity for each Subject
