# install_iis.ps1
# Install the Web-Server (IIS) Windows Feature
Install-WindowsFeature -Name Web-Server -IncludeManagementTools
# Start the service and ensure it starts automatically
Set-Service -Name W3SVC -StartupType Automatic
Start-Service W3SVC
# Optional: Add an index.html file to show it's working
"<h1>Hello from IIS on Terraform-Deployed Azure VM!</h1>" | Out-File C:\inetpub\wwwroot\index.html -Encoding ASCII