run_analysis <- function() {
    
    ## File:     run_analysis.R
    ## Author:   Aaron
    ## Date:     September 23rd, 2015
    ## Modified: September 25th, 2015
    ##
    ## Purpose: This function read in data from the UCI Machine Learning
    ##          Repository for Human Activity Recognition Using Smartphones 
    ##          Data Set, located at:
    ##          http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
    ##          and perform various data cleaning activities.
    ##
    ## Tasks:   The task for this assignment contains multiple parts:
    ##          1) Take the data and transform it into a "tidy" data set.
    ##          2) Link the elements of this task to a Github repository.
    ##          3) Create a code book describing the variables, data, and 
    ##              transformations regarding this data set.
    ##          4) Include a README.md explaing how the scripts work and are
    ##              connected.
    ##
    ## Goals:   In support of the above, the following specific activities are
    ##          to be performed:
    ##          1) Merge the training and test set to create one data set.
    ##          2) Extract only measurements on the mean and standard deviation
    ##              for each measurement.
    ##          3) Use descriptive activity names to name the activities in the
    ##              data set.
    ##          4) Appropriately label data set with descriptive names.
    ##          5) From (4), create a second independent tidy set with the 
    ##              average of each variable for each activity and subject.
    ##

    # Read in the feature set and create a header with unique identifiers
    features     <- read.table("features.txt", stringsAsFactors = FALSE)
    featuresDF   <- tbl_df(features)
    header       <- t(featuresDF$V2)
    headerUnique <- make.names(header, unique = TRUE) #

    # Read in the test set and apply the unique descriptive header names
    testData          <- read.table("./test/X_test.txt", stringsAsFactors = FALSE)
    testDataDF        <- tbl_df(testData)
    names(testDataDF) <- headerUnique

    # Read in the activity labels and create a descriptive header
    testLabel          <- read.table("./test/Y_test.txt", colClasses = "character", stringsAsFactors = FALSE)
    testLabelDF        <- tbl_df(testLabel)
    names(testLabelDF) <- "activityLabel"

    # Read in the subject identifiers and create a descriptive header
    testSubject          <- read.table("./test/subject_test.txt", stringsAsFactors = FALSE)
    testSubjectDF        <- tbl_df(testSubject)
    names(testSubjectDF) <- "subject"

    # Read in the training data set and apply the unique descriptive header
    trainData          <- read.table("./train/X_train.txt", stringsAsFactors = FALSE)
    trainDataDF        <- tbl_df(trainData)
    names(trainDataDF) <- headerUnique

    # Read in the activity labels and create a descriptive header
    trainLabel          <- read.table("./train/Y_train.txt", colClasses = "character", stringsAsFactors = FALSE)
    trainLabelDF        <- tbl_df(trainLabel)
    names(trainLabelDF) <- "activityLabel"

    # Read in the subject identifiers and create a descriptive header
    trainSubject          <- read.table("./train/subject_train.txt", stringsAsFactors = FALSE)
    trainSubjectDF        <- tbl_df(trainSubject)
    names(trainSubjectDF) <- "subject"

    # Remove data no longer required
    rm(features, featuresDF, header, testData, testLabel, testSubject, trainData, 
            trainLabel, trainSubject) #

    # Identify locations for each activity label in the test data set
    testWalkingLocation        <- which(testLabelDF == "1")
    testWalkUpstairsLocation   <- which(testLabelDF == "2")
    testWalkDownstairsLocation <- which(testLabelDF == "3")
    testSittingLocation        <- which(testLabelDF == "4")
    testStandingLocation       <- which(testLabelDF == "5")
    testLayingLocation         <- which(testLabelDF == "6")

    # Relabel each activity with a descriptive identifier
    testLabelDF$activityLabel[testWalkingLocation]        <- "WALKING"
    testLabelDF$activityLabel[testWalkUpstairsLocation]   <- "WALKING_UPSTAIRS"
    testLabelDF$activityLabel[testWalkDownstairsLocation] <- "WALKING_DOWNSTAIRS"
    testLabelDF$activityLabel[testSittingLocation]        <- "SITTING"
    testLabelDF$activityLabel[testStandingLocation]       <- "STANDING"
    testLabelDF$activityLabel[testLayingLocation]         <- "LAYING"

    # Identify locations for each activity label in the training data set
    trainWalkingLocation        <- which(trainLabelDF == "1")
    trainWalkUpstairsLocation   <- which(trainLabelDF == "2")
    trainWalkDownstairsLocation <- which(trainLabelDF == "3")
    trainSittingLocation        <- which(trainLabelDF == "4")
    trainStandingLocation       <- which(trainLabelDF == "5")
    trainLayingLocation         <- which(trainLabelDF == "6")

    # Relabel each activity with a descriptive identifier
    trainLabelDF$activityLabel[trainWalkingLocation]        <- "WALKING"
    trainLabelDF$activityLabel[trainWalkUpstairsLocation]   <- "WALKING_UPSTAIRS"
    trainLabelDF$activityLabel[trainWalkDownstairsLocation] <- "WALKING_DOWNSTAIRS"
    trainLabelDF$activityLabel[trainSittingLocation]        <- "SITTING"
    trainLabelDF$activityLabel[trainStandingLocation]       <- "STANDING"
    trainLabelDF$activityLabel[trainLayingLocation]         <- "LAYING"

    # Remove data no longer required
    rm(testWalkingLocation, testWalkUpstairsLocation, testWalkDownstairsLocation, 
            testSittingLocation, testStandingLocation, testLayingLocation)
    rm(trainWalkingLocation, trainWalkUpstairsLocation, trainWalkDownstairsLocation, 
            trainSittingLocation, trainStandingLocation, trainLayingLocation)

    # Create full training and test sets with respective activities and subjects
    fullTestData  <- bind_cols(testSubjectDF,  testLabelDF,  testDataDF)
    fullTrainData <- bind_cols(trainSubjectDF, trainLabelDF, trainDataDF)

    # Combine the training and test data into one data set
    fullData <- full_join(fullTestData, fullTrainData)

    # Remove data no longer required
    rm(testDataDF, testLabelDF, testSubjectDF, trainDataDF, trainLabelDF, 
            trainSubjectDF, fullTestData, fullTrainData, headerUnique)

    # Create a selected data set containing only the subject, activity, and 
    #   any variable that contains data regarding the mean or standard deviation
    selectedData <- select(fullData, contains("subject"), contains("activityLabel"), 
                                contains("mean"), contains("std"))

    # Create a reduced data set containing the mean of each individual variable
    #   for each subject and associated activity
    reducedData <-
        selectedData %>%
        group_by(subject, activityLabel) %>%
        summarise_each(funs(mean))
    
    # Write reduced data set to file
    write.table(reducedData, "reducedData.txt", row.names = FALSE)
    
    return(reducedData)
}