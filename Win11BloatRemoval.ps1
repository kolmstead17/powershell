## Customise Taskbar
#Set variables for taskbar registry edits
$taskBar = @{
    path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    leftAlignKey = "TaskbarAl"
    taskViewKey = "ShowTaskViewButton"
    chatKey = "TaskbarMn"
    widgetKey = "TaskbarDa"
    value = "0"
}

# Set the chat icon to be hidden
Set-ItemProperty -Path $taskBar.path -Name $taskBar.chatKey -Value $taskBar.value
    
# Set the widget icon to be hidden
Set-ItemProperty -Path $taskBar.path -Name $taskBar.widgetKey -Value $taskBar.value
    
# Set the task view icon to be hidden
Set-ItemProperty -Path $taskBar.path -Name $taskBar.taskViewKey -Value $taskBar.value
    
# Moves the Taskbar to left
Set-ItemProperty -Path $taskBar.path -Name $taskBar.leftAlignKey -Value $taskBar.value
    
    
# Uninstall apps
$appList = @{
    $app1 = "MicrosoftTeams"
    #$app2
    #$app3
}

foreach ($app in $appList) {
    Get-AppxPackage -Name $app | Remove-AppPackage -ErrorAction SilentlyContinue
}

#Set variables for right click context menu registry edits
$rightClickMenu = @{
    path1 = "HKCU:\Software\Classes\CLSID"
    path2 = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}"
    path3 = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
    typeKey = "Key"
    key1 = "{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}"
    key2 = "InprocServer32"
    key3 = "(Default)"
}

# Remove Win11 right-click menu    
New-Item -Path $rightClickMenu.path1 -Name $rightClickMenu.key1 -ItemType $rightClickMenu.typeKey
New-Item -Path $rightClickMenu.path2 -Name $rightClickMenu.key2 -ItemType $rightClickMenu.typeKey
Set-ItemProperty -Path $rightClickMenu.path3 -Name $rightClickMenu.key3 -Value ""
