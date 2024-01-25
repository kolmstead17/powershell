
if(Get-Module -ListAvailable -Name ExchangeOnlineManagement) {
    Write-Host "Exchange Online Management already installed"
}
else {
    try {
        Install-Module -Name ExchangeOnlineManagement
    }
    catch [System.Exception] {
        $_.message
        exit
    }
}

#Imports .NET functions
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

#Builds form framework
$form = New-Object System.Windows.Forms.Form
$form.Text = "Exchange Online Connection Form"
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = "CenterScreen"

#Intercepts Enter and ESC keystrokes
#TODO: kill script on ESC press
$form.KeyPreview = $true
$form.Add_KeyDown({
    if ($_.KeyCode -eq "Enter" -or $_.KeyCode -eq "Escape") {
        $form.Close()
    }
})

#Creates the OK button and closes the form when clicked
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Size(75,120)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.Add_Click({$form.Close()})
$form.Controls.Add($OKButton)

#Creates the cancel button and closes the form when clicked
#TODO: kill script on cancel click
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Size(150,120)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.Add_Click({$form.Close()})
$form.Controls.Add($CancelButton)

#Text label for top textbox
$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Size(10,20)
$label1.Size = New-Object System.Drawing.Size(280,20)
$label1.Text = "Please enter your email:"
$form.Controls.Add($label1)

#Email address entry textbox
$textBox1 = New-Object System.Windows.Forms.TextBox
$textBox1.Location = New-Object System.Drawing.Size(10,40)
$textBox1.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox1)

#Text label for bottom textbox
$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Size(10,70)
$label2.Size = New-Object System.Drawing.Size(280,20)
$label2.Text = "Please enter target domain:"
$form.Controls.Add($label2)

#Domain entry textbox
$textBox2 = New-Object System.Windows.Forms.TextBox
$textBox2.Location = New-Object System.Drawing.Size(10,90)
$textBox2.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox2)

$form.Topmost = $True

$form.Add_Shown({$form.Activate()})
[void] $form.ShowDialog()

#Display variables in console
$textBox1.Text
$textBox2.Text

Connect-ExchangeOnline -UserPrincipalName $textBox1.Text -DelegatedOrganization $textBox2.Text


