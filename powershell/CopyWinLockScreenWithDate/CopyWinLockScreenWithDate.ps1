# 目标拓展名
$desExtension = ".jpg"
# 获取当前路径
$currentPath = $MyInvocation.MyCommand.Definition | Split-Path -Parent
# 获取备份日期
$dataFormat = Get-Date -format 'yyyyMMdd'
# 构建目标路径，这里可以修改目标保存路径
# $destinationPath = "$currentPath\$dataFormat"
$destinationPath = "D:\Pictures\$dataFormat"
if (-not $(Test-Path $destinationPath)) {
    New-Item -Path $destinationPath -ItemType Directory 
}
# 配置锁屏图片位置
# $WindowsLockScreenPath = Get-ChildItem -Path "C:\Users\$env:UserName\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_*\LocalState\Assets"
$WindowsLockScreenPath = "C:\Users\$env:UserName\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
# 列出锁屏位置所有图片
$listfile = Get-ChildItem -Path $WindowsLockScreenPath | Where-Object { $_.PsIsContainer -eq $false }
if (-not $listfile) {
    write-host "File did not exit in $listfile[$i]"
}
# 循环备份文件到目标路径
for ($i = 0; $i -lt $listfile.Count; $i++) {
    $desName = '{0}_{1}{2}' -f $dataFormat, $listfile[$i].BaseName, $desExtension
    $srcfile = $listfile[$i].FullName
    $desfile = "$destinationPath\$desName"
    if (-not $(Test-Path $desfile)) {
        Copy-Item -Path $srcfile -Destination $desfile 
        write-host "Successfully copied $listfile[$i] to $desfile"
    }
    else {
        write-host "File $desfile existed and skipped"
    }
    if (-not $?) {
        write-host "Successfully moved $listfile[$i] to $desfile"
    }
}
# 任意键退出
[System.Console]::ReadKey() | Out-Null;
Exit-PSSession;
