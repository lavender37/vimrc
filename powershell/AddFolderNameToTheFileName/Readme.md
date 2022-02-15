##AddFolderNameToTheFileName

将文件所在文件夹名插入到文件名开头，文件名称为 文件夹名_原始文件名

将符合Tes*条件的文件夹名插入到该文件夹下的所有文件的开头
```
.\AddFolderNameToTheFileName.ps1 .\Tes*
```

将符合```Tes*```条件的文件夹名插入到该文件夹下的所有文件的开头，并只对过滤器```*.txt```有效
```
.\AddFolderNameToTheFileName.ps1 .\Tes* *.txt
```
