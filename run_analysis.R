X<-rbind(x_test,x_train)
Y<-rbind(y_test,y_train)
subject_t<-rbind(subject_test,subject_train)
head(subject_t,10)
merged_Data<-cbind(subject_t,X,Y)

cleanData<-merged_Data %>% select(subject,code,contains("mean"),contains("std"))

#cleanData<-select(merged_Data,subject,code,contains("mean"),contains("std"))
#identical(cleanData,cleanData1)
#remove(cleanData,cleanData1)
cleanData

#Replace activity codes with their activity labels
cleanData$code<-activities[cleanData$code, 2]

names(cleanData)
names(cleanData)[1] <- "Subject"
names(cleanData)[2] <- "Activity"

names(cleanData)<-gsub("Acc", "Accelerometer", names(cleanData))
names(cleanData)<-gsub("Gyro", "Gyroscope", names(cleanData))
names(cleanData)<-gsub("BodyBody", "Body", names(cleanData))
names(cleanData)<-gsub("Mag", "Magnitude", names(cleanData))
names(cleanData)<-gsub("^t", "Time", names(cleanData))
names(cleanData)<-gsub("^f", "Frequency", names(cleanData))
names(cleanData)<-gsub("tBody", "TimeBody", names(cleanData))
names(cleanData)<-gsub("-mean()", "Mean", names(cleanData), ignore.case = TRUE)
names(cleanData)<-gsub("-std()", "STD", names(cleanData), ignore.case = TRUE)
names(cleanData)<-gsub("-freq()", "Frequency", names(cleanData), ignore.case = TRUE)
names(cleanData)<-gsub("angle", "Angle", names(cleanData))
names(cleanData)<-gsub("gravity", "Gravity", names(cleanData))

names(cleanData)


finalData <- cleanData %>%group_by(Subject, Activity) %>% summarise_all(funs(mean))
write.table(finalData, "./data/FinalData.txt", row.name=FALSE)
str(finalData)
