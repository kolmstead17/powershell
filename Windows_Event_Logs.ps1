#Local script
#Example log to show formatting
Get-WinEvent -LogName 'Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational' -FilterXPath '*[System[EventID=1149]]' | Where-Object{$_.message -match 'putusernamehere'} | Format-List

#Remote script
Invoke-Command -ComputerName FQDNGoesHere -ScriptBlock {Get-WinEvent -LogName 'Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational' -FilterXPath '*[System[EventID=1149]]'} | Where-Object{$_.message -match 'putusernamehere'} | Format-List