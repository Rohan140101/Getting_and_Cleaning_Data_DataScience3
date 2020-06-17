1. Two Libraries were used for the project i.e plyr and data.table
2. Using fread the 3 tables for features,actiivity and subject were loaded into R for both train and test.
3. Feature names are then assigned to variables of feature table.
4. Using grep, only those features are extracted which correspond to mean and std
5. The 3 different data sets are combined into one using cbind.
6. Activity labels are changed from numbers to corresponding names.
7. Variables name were made more descriptive
8. A second data set was created using the given instructions.
9. Using write.file the second data set was exported.
