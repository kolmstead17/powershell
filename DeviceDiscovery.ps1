#Used to take CSV of IP addresses, departments, DNS, etc. and create new computer inventory report

#Current path is just a placeholder. Replace with actual filepath 
$rows = Import-Csv -Path C:\IPAddresses.csv

foreach($row in $rows){
    try{
        $output = @{
            IPAddress = $row.IPAddress
            Department = $row.Department
            IsOnline = $false
            HostName = $null
            Error = $null
        }

        if(Test-Connection -ComputerName $row.IPAddress -Count 1 -Quiet){
            $output.IsOnline = $true
        }

        if($hostname = (Resolve-DnsName -Name $row.IPAddress -ErrorAction Stop).Name){
            $output.HostName = $hostname
        }
    }

    catch{
        $output.Error = $_.Exception.Message
    }

    finally{
        [pscustomobject]$output | Export-Csv -Path C:\DeviceDiscovery.csv -Append -NoTypeInformation
    }
}