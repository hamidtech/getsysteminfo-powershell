# Display a formal welcome message in the console
Write-Host "
Hi,

Welcome to our Asset System Information Portal.

For trust in this file, you can contact our support team with the provided contact number.

"

# Prompt for the user's name
$UserName = Read-Host "Please enter your Email Address (Username)"

# Construct the file name
$FileName = "$UserName - SystemInfo.txt"

# Initialize the file with the user's name and computer name
$UserInfo = @"
User Name: $UserName
Computer Name: $env:COMPUTERNAME

"@

# Write the user's information to the file
$UserInfo | Out-File -FilePath $FileName

# Append a heading for Motherboard Model
"--- Motherboard Model ---" | Out-File -FilePath $FileName -Append
# Gather Motherboard Model
$Motherboard = Get-CimInstance -ClassName Win32_BaseBoard |
               Select-Object Manufacturer, Product
$Motherboard | Out-File -FilePath $FileName -Append

# Append a heading for Processor Information
"--- Processor Information ---" | Out-File -FilePath $FileName -Append
# Gather Processor Information
$Processor = Get-CimInstance -ClassName Win32_Processor |
             Select-Object Name, NumberOfCores, NumberOfLogicalProcessors
$Processor | Out-File -FilePath $FileName -Append

# Append a heading for Total RAM Capacity
"--- Total RAM Capacity ---" | Out-File -FilePath $FileName -Append
# Gather Total Physical Memory Capacity and convert to GB
$TotalMemoryCapacity = Get-CimInstance -ClassName Win32_PhysicalMemory |
                       Measure-Object -Property Capacity -Sum |
                       Select-Object @{Name="TotalCapacity(GB)"; Expression={[math]::Round($_.Sum / 1GB, 2)}}
$TotalMemoryCapacity | Out-File -FilePath $FileName -Append

# Append a heading for Storage Information
"--- Storage (Volume) Information ---" | Out-File -FilePath $FileName -Append
# Gather Volume Information along with storage model and manufacturer
$Volume = Get-CimInstance -ClassName Win32_DiskDrive |
          Select-Object Model, Manufacturer, @{Name="Capacity(GB)";Expression={[math]::Round($_.Size / 1GB, 2)}}
$Volume | Out-File -FilePath $FileName -Append

# Append a heading for Operating System Information
"--- Operating System Information ---" | Out-File -FilePath $FileName -Append
# Gather Operating System Information
$OS = Get-CimInstance -ClassName Win32_OperatingSystem |
      Select-Object Caption, Version, BuildNumber, OSArchitecture
$OS | Out-File -FilePath $FileName -Append

# Append a heading for Network MAC Addresses
"--- MAC Addresses ---" | Out-File -FilePath $FileName -Append
# Gather All Network MAC Addresses
$MACAddresses = Get-CimInstance -ClassName Win32_NetworkAdapter |
                Where-Object { $_.MACAddress -ne $null } |
                Select-Object Name, MACAddress
$MACAddresses | Out-File -FilePath $FileName -Append

Write-Host "Information exported to $FileName"

# Send the SystemInfo.txt file via Outlook
$Outlook = New-Object -ComObject Outlook.Application
$Mail = $Outlook.CreateItem(0)
$Mail.Subject = "System Information for $UserName"
$Mail.Body = "Attached is the system information."
$Mail.To = "support@example.com"
$Mail.Attachments.Add((Get-Location).Path + "\$FileName")
$Mail.Send()

Write-Host "Email sent to support@example.com"
