# Generating a new tidy data based on the exising data set:
# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names.
# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)

# read-in train and test data
train_X <- read.table("./UCI HAR Dataset/train/X_train.txt")
test_X <- read.table("./UCI HAR Dataset/test/X_test.txt")

# merge test and train data set
merge_data = rbind(train_X, test_X)

# Extracts only the measurements on the mean and standard deviation for each measurement.
feature_names   <- read.table("./UCI HAR Dataset/features.txt")
col_index_selected <- grep("mean()|std()", feature_names[[2]], value = FALSE ) # "mean()" or "std()" in the column name
merge_data_selected <- merge_data[, col_index_selected]
str(merge_data_selected); head(merge_data_selected)

# Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")
test_y <- read.table("./UCI HAR Dataset/test/y_test.txt")

merge_label =  rbind(train_y, test_y)
merge_activity_names <- data.frame(activity_labels[[2]][merge_label[[1]]])
str(merge_activity_names); head(merge_activity_names)

# Appropriately labels the data set with descriptive variable names.
col_selected_names <- grep("mean()|std()", feature_names[[2]], value = TRUE )
col_selected_names <- gsub("-", "_", col_selected_names)
col_selected_names <- gsub("\\(\\)", "", col_selected_names)
col_selected_names <- gsub("BodyB", "B", col_selected_names)
names(merge_data_selected) <- tolower(col_selected_names)
names(merge_activity_names) <- c("activity")
merge_data_selected <- cbind(merge_data_selected, merge_activity_names)
str(merge_data_selected); head(merge_data_selected)

# creates a second, independent tidy data set with the average of each variable for each activity and each subject.
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_all <- rbind(train_subject, test_subject)
names(subject_all) <- c("subject")

merge_data_selected <- cbind(merge_data_selected, subject_all)
str(merge_data_selected); head(merge_data_selected)

HAR_tidy_data <- merge_data_selected %>% 
                    group_by(activity, subject) %>% 
                    summarise_all(mean)
HAR_tidy_data

# write the new tidy data into a file
write.table(HAR_tidy_data, "HAR_tidy_data.txt", row.names = FALSE)
