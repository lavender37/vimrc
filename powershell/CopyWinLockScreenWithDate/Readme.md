##CopyWinLockScreenWithDate

该脚本可以将锁屏壁纸复制到指定位置，位置需要在脚本中修改，默认位置```"D:\Pictures\$dateFormat"```

修改第二行以改变目标文件拓展名
```
$desExtension = ".jpg"
```

修改第九行以改变目标文件存储路径，默认为 D:\Pictures\脚本执行日期
```
$destinationPath = "D:\Pictures\$dateFormat"
```

修改第十四行帮助脚本确定锁屏图片位置
一般情况下，windows下载锁屏壁纸到
"C:\Users\<username>\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
```
$WindowsLockScreenPath = "C:\Users\$env:UserName\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"

```

直接执行该脚本
```
.\CopyWinLockScreenWithDate.ps1
```
