#Get-ChildItem -Path 'C:\$Recycle.Bin' -Force | Remove-Item -Recurse -Force

$users = Get-ChildItem C:\Users
Start-Transcript -Path c:\temp\log.log -Append
foreach ($user in $users){
    $folder = "C:\users\" + $user + "\downloads"
    $folderPath = Test-Path -Path $folder
    $noFiles = "No files found that meet criteria for $user"

    if($folderPath){
        $files = Get-ChildItem $folder -Filter *.exe | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-365))}
        $totalSize = ( $files | Measure-Object -Sum Length).Sum/1GB
        
        if ($files.Length -ne 0){
            Write-Output "$($files.Length) file(s) found for $user. Total Size = $($totalSize)GB" #Last write time(s) = $($files.Length)"
            $answer = Read-Host "Would you like to delete these files? (y/n)"
            
            try{
                if($answer -eq "y"){
                    foreach($file in $files){
                        Get-ChildItem $folder -Filter *.exe | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-365))} | Select-Object -ExpandProperty FullName | ForEach-Object {Remove-Item -Path $_ -Force -Recurse -Verbose}
                }
                
                    Write-Output "File(s) deleted"
                }

                else{
                    Write-Output "File(s) not deleted"
                }
            }
            catch{
                Write-Output $Error
            }
        }
        else{
            Write-Output $noFiles
        }
    }

    else {
        Write-Output $noFiles
    }
}
Stop-Transcript