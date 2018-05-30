Generating a tidy data set
--------------------------

Main goal here is to practice generating a new tidy data based on the exising data set. To achieve this goal, "run\_analysis.R" has been written. It is a script that gets and cleans Human Activity Recognition data from [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) , and generates a separte second data set in [tidy format](http://vita.had.co.nz/papers/tidy-data.html). The detail steps of data processing are as follows:

1.  Merges the training and the test sets to create one data set.
    1.  Reads in train ("X\_train.txt") and test ("X\_test.txt") data, respectively.
    2.  Merge the two data sets into one data set using rbind() function
2.  Extracts only the measurements on the mean and standard deviation for each measurement.
    1.  Read-in the file of the feature names ("features.txt"), where a feature indicates the corresponding measurement
    2.  Selects only the column names that include the mean and standard deviation using grep() funtion.
    3.  Subsets the data set using the selected column names, and generates a new data set.
3.  Uses descriptive activity names to name the activities in the data set
    1.  Reads in the activity label file ("activity\_labels.txt") for the use of descriptive names of activities
    2.  Reads in the train and test data label files ("y\_train.txt" & "y\_test.txt") where the label indicates the class of the activities.
    3.  After merging the train and test label data using rbind(), assigns the decriptive activity names into the corresponding train/test labels using indexing, and creates a new "activity" column.
4.  Appropriately labels the data set with descriptive variable names.
    1.  Cleans the names of the columns selected in step *2.1* above such as the removal of "()", replacement of "-" by "\_", and lowercasing of the characters.
    2.  Assigns those cleaned names to the variable names of the data set generated in step *2.3* above.
    3.  Appends the new "activity" column via cbind() to the data set.
5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    1.  Reads in the files of train/test subject information ("subject\_train.txt" & "subject\_test.txt")
    2.  After creating a new "subject" column by merging the train/test subject data via rbind(), appends it via cbind() to the data set generated in step *4.3* above.
    3.  Now, applies group\_by() and summarize() function to get the average of each variable for each activity and each subject. It generates a new data set in tidy format: each variable is in its own column, and each observation is in its own row.

As a final note, you can find many useful general advice concernig this task in [David Hood's Blog](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/)
