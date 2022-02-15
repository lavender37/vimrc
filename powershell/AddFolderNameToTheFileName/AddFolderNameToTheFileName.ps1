# AddFolderNameToTheFileName.ps1
# ********************************************
# add the folder name to the beginning filename of the files in the folder
# ********************************************

if ($args.Count -gt 2) {
    write-host "too many parameter"
    exit
}
elseif ($args.Count -lt 1) {
    write-host "missing parameter"
    exit
}

# 获取当前路径
$currentPath = $MyInvocation.MyCommand.Definition | Split-Path -Parent
# 获取备份日期
$dataFormat = Get-Date -format 'yyyyMMdd'
# 列出匹配的所有文件夹
$listFolder = Get-Item -Path $args[0]
if ($listFolder) {
    write-host "Script will operate following folder:"
    for ($i = 0; $i -lt $listFolder.Length; $i++) {
        # 检测路径是否存在，不存在则删除该路径
        if (Test-Path -Path $listFolder[$i].FullName -PathType Container) {
            Write-Host $listFolder[$i].FullName
        }
        else {
            $listFolder[$i].Delete()
        }
    }
}
else {
    Write-Host "No target found.\n"
    exit
}
# 获取确认
$ifCountinue = Read-Host "Are you continue? (Y/N) > "
if ($ifCountinue.ToLower() -match "y.*") {
    # 遍历路径
    for ($i = 0; $i -lt $listFolder.Length; $i++) {
        # 列出当前路径下所有文件
        $listfile = Get-ChildItem -Path $listFolder[$i] -Filter $args[1]
        if (-not $listfile) {
            if ($argc -eq 2) {
                write-host "Folder $($listFolder[$i]) contains no $($argv[1]) file.\n"
            }
            else {
                write-host "Folder $($listFolder[$i]) contains no file.\n"
            }
        }
        else {
            # 循环重命名文件
            for ($j = 0; $j -lt $listfile.Count; $j++) {
                $srcfile = $listfile[$j].FullName
                $desName = $listFolder.BaseName + "_" + $listfile[$j].BaseName + $listfile[$j].Extension
                $desfile = "$listFolder\$desName"
                if (-not $(Test-Path $desfile)) {
                    Rename-Item -Path $srcfile -NewName $desfile 
                    write-host "Successfully rename $srcfile to $desfile"
                }
                else {
                    write-host "File $desfile existed and skipped"
                }
                if (-not $?) {
                    write-host "Successfully moved $listfile[$j] to $desfile"
                }
            }
        }
    }
}
else {
    write-host "User abort and exit."
    exit
}