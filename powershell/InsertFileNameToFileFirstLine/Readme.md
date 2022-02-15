##AddModifiedTimeToTheFileName

将文件名插入到文件第一行作为注释，注释格式 /*文件名称withExtension*/

将指定文件的文件名插入到该文件的第一行作为注释
```
.\InsertFileNameToFileFirstLine.ps1 .\hello.cpp
```

将指定文件夹内的所有文件的文件名插入到对应文件的第一行作为注释
```
.\InsertFileNameToFileFirstLine.ps1 D:\Documents\ -r
.\InsertFileNameToFileFirstLine.ps1 D:\Documents\*.cpp
```
