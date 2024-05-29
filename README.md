# System Information Exporter by Powershell

This PowerShell script automates the collection and export of system information for a given user's system. It extracts details like motherboard model, processor specifications, RAM capacity, storage details, operating system information, and network MAC addresses. This script is designed for administrators or support teams needing to compile system specifications quickly and efficiently.

## Features

- Extracts and exports detailed system information.
- Outputs data to a text file named after the user's input.
- Sends the information via email automatically.

## Prerequisites

Before running this script, make sure you have:
- PowerShell 5.1 or higher installed on your machine.
- Appropriate permissions to execute PowerShell scripts on your system.
- Outlook installed on the machine if you intend to use the email functionality.

## Setup

1. **Download the Script**  
   Download `getsystemInfo.ps1` from this repository.

2. **Configure Permissions**  
   Ensure your PowerShell session has the necessary permissions to execute the script. You may need to adjust the execution policy with the following command:
   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

## Usage

To run the script, open a PowerShell window and navigate to the directory containing `SystemInfo.ps1`. Execute the script by running:

```powershell
./SystemInfo.ps1
```

You will be prompted to enter your email address. After input, the script will proceed to gather system information and output it to a file. The file will also be sent to a predefined email address as configured within the script.

## Modifying the Script

You can modify the email recipient and other parameters by editing the script in a text editor. Ensure you do not change the structure of the PowerShell commands unless necessary.

## Convert Powershell script to EXE file
tou can use this script to convert script file to exe file
```powershell
ps2exe .\getsysteminfo.ps1 .\systeminfo.exe -iconFile .\favicon.ico
```
** Don't forget install " ps2exe " on powershell by admin privilege **

## Support

For any queries or issues, please open an issue in this repository or contact [hamid1375jamali@gmail](hamid1375jamali@gmail.com).

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details.

