$users = Import-Csv c:\path\to\csv
Start-Transcript -Path C:\temp\log.log
foreach ($user in $users){
    $Identity = $user.SamAccountName
    try{
        Set-ADUser -Identity $Identity -ChangePasswordAtLogon $true
    }

    catch{
        "ERROR: Updating failed for $($user.SamAccountName). Check logs"
    }
}
Stop-Transcript

