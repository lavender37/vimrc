# InsertFileNameToFileFirstLine.ps1
# ********************************************
# add the file name into the first row of the file
# ********************************************

function function_help{
    Write-Host "Usage:"
    Write-Host "InsertFileNameToFileFirstLine.ps1 [Location] [Option]"
    Write-Host "InsertFileNameToFileFirstLine.ps1 .\hello.cpp"
    Write-Host "InsertFileNameToFileFirstLine.ps1 D:\Documents\*.cpp -r"
}

if ($args.Count -gt 2){
    write-host "too many parameter"
    function_help
    exit
}
elseif($args.Count -lt 1){
    write-host "missing parameter"
    function_help
    exit
}

# get the location

if(Test-Path($args[0])){
    if($args.Count -eq 2){
        if($args[1] -eq "-r"){
            $Files = Get-ChildItem -Path $args[0] -File -Recurse -Force
        }
        else {
            write-host "missing parameter"
            function_help
            exit
        }
    }
    else {
        $Files = Get-ChildItem -Path $args[0] -File
    }

    
    foreach($cur_file in $Files){
        $liner = Get-Content $cur_file.pspath -Encoding UTF8
        Clear-Content $cur_file.pspath
        $add_string = "/*"+$cur_file+"*/"
        Add-Content $cur_file.pspath -value $add_string -Encoding UTF8
        Add-Content $cur_file.pspath -Value $liner -Encoding UTF8
        write-host "Find file" $cur_file
    }
}
else {
    Write-Host "Error Location"
    function_help
    exit
}

# get file names
