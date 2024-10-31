#Import users csv that was exported from AD
$users = Import-Csv c:\path\to\csv

foreach ($user in $users){

    $updateSplat = @{
        Identity = $user.SamAccountName
        #Attributes that are going to be set for each user
        Replace = @{
            l = $user.Office
            Title = $user.Title
            Department = $user.Department
            Company = $user.Company
            Manager = $user.Manager
            TelephoneNumber = $user.OfficePhone
            c = $user.Country
            st = $user.State
            StreetAddress = $user.StreetAddress
        }
    }
    try {
        "Updating user: $($user.SamAccountName)"
        Set-ADUser @updateSplat
    }
    catch {
        "ERROR: Updating failed for $($user.SamAccountName). Check logs"
    }
}