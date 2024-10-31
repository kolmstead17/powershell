$users = Get-ChildItem C:\Users
Start-Transcript -Path c:\temp\log.log -Append
foreach ($user in $users){
    $folder = "C:\users\" + $user + "\appdata\Local\Microsoft\Outlook"
    $folderPath = Test-Path -Path $folder
    $noFiles = "No files found that meet criteria for $user"

    if($folderPath){
        $files = Get-ChildItem $folder -Filter *.ost | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-182))} 
        
        if ($files.Length -ne 0){
            Write-Output "$($files.Name) file(s) found for $user. Last write time(s) = $($files.LastWriteTime)"
            $answer = Read-Host "Would you like to delete these files? (y/n)"

            try{
                if($answer -eq "y"){
                    foreach($file in $files){
                        Get-ChildItem $folder -Filter *.ost | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-182))} | Select-Object -ExpandProperty FullName | ForEach-Object {Remove-Item -Path $_ -Force -Recurse -Verbose}
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