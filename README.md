# datacleaningcoursera

---
title:  "README.md"
author: "AaroC357"

created:  "September 23rd, 2015"
modified: "September 25th, 2015"

output: html_document

description: A markdown file created for the Coursera Data Cleaning Course Project
---

## This is a markdown file

### Intro

The purpose of this script is to read in data from the UCI Machine Learning
Repository for Human Activity Recognition Using Smartphones Data Set, located at: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

and perform various data cleaning activities.

This script creats three variables:
    1) fullData - The combined full training and test data sets.
    2) selectedData - A subset of fullData containing attributes that are
        related the mean and standard deviation.
    3) reducedData - A subset of selectedData containing the mean of each
        individual attribute as grouped by subject and activity.

### Tasks
The task for this assignment contains multiple parts:
    1) Take the data and transform it into a "tidy" data set.
    2) Link the elements of this task to a Github repository.
    3) Create a code book describing the variables, data, and transformations 
        regarding this data set.
    4) Include a README.md explaing how the scripts work and are connected.

### Goals
In support of the above, the following specific activities are to be performed:
    1) Merge the training and test set to create one data set.
    2) Extract only measurements on the mean and standard deviation for each 
        measurement.
    3) Use descriptive activity names to name the activities in the data set.
    4) Appropriately label data set with descriptive names.
    5) From (4), create a second independent tidy set with the average of each 
        variable for each activity and subject.
