# Install Hyper-V
Write-Host "Installing Hyper-V"
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
Write-Host

# Install apps using Chocolatey
Write-Host "Installing Chocolatey"
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
Write-Host

Write-Host "Installing applications from Chocolatey"
choco feature enable -n allowGlobalConfirmation

cinst slack -y
cinst GoogleChrome -y
cinst dropbox -y
cinst Evernote -y
cinst visualstudiocode -y
cinst micro -y
cinst 7zip.install -y
cinst docker-for-windows -y
cinst jdk8 -y
cinst windirstat -y
cinst paint.net -y
cinst visualstudio2013professional -y
cinst keyboard-layout-creator -y
cinst itunes -y
cinst unifying -y
cinst cmder -y
cinst spotify -y
cinst ilspy -y
cinst linqpad -y
cinst resharper -y
cinst jq -y
cinst zeal.install -y
cinst beyondcompare -y
cinst git -y
cinst sourcetree -y
cinst dotcover -y
cinst dottrace -y
cinst dotmemory -y
cinst nodejs -y
cinst phantomjs -y
cinst sqlserver-cmdlineutils -y

Write-Host

######################################################
# Set environment variables
######################################################
Write-Host "Setting home variable"
[Environment]::SetEnvironmentVariable("HOME", $HOME, "User")
[Environment]::SetEnvironmentVariable("CHROME_BIN", "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe", "User")
[Environment]::SetEnvironmentVariable("PHANTOMJS_BIN", "C:\tools\PhanomJS\phantomjs.exe", "User")
Write-Host

######################################################
# Install SQL Express 2014
######################################################
Write-Host
do {
    $createSiteData = Read-Host "Do you want to install SQLExpress? (Y/N)"
} while ($createSiteData -ne "Y" -and $createSiteData -ne "N")
if ($createSiteData -eq "Y") {
    cinst mssqlserver2014express
}
Write-Host

######################################################
# Add Git to the path
######################################################
Write-Host "Adding Git\bin to the path"
Add-Path "C:\Program Files (x86)\Git\bin"
Write-Host

######################################################
# Configure Git globals
######################################################
Write-Host "Configuring Git globals"
$userName = Read-Host 'Enter your name for git configuration'
$userEmail = Read-Host 'Enter your email for git configuration'

& 'C:\Program Files (x86)\Git\bin\git' config --global user.email $userEmail
& 'C:\Program Files (x86)\Git\bin\git' config --global user.name $userName

$gitConfig = $home + "\.gitconfig"
Add-Content $gitConfig ((new-object net.webclient).DownloadString('http://bit.ly/mygitconfig'))

$gitexcludes = $home + "\.gitexcludes"
Add-Content $gitexcludes ((new-object net.webclient).DownloadString('http://bit.ly/gitexcludes'))
Write-Host

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")

######################################################
# Install npm packages
######################################################
Write-Host "Install NPM packages"
npm install -g yo
Write-Host

######################################################
# Generate public/private rsa key pair
######################################################
Write-Host "Generating public/private rsa key pair"
Set-Location $home
$dirssh = "$home\.ssh"
mkdir $dirssh
$filersa = $dirssh + "\id_rsa"
ssh-keygen -t rsa -f $filersa -q -C $userEmail
Write-Host

######################################################
# Download custom PowerShell profile file
######################################################
Write-Host "Creating custom $profile for Powershell"
if (!(test-path $profile)) {
    New-Item -path $profile -type file -force
}
Add-Content $profile ((new-object net.webclient).DownloadString('http://bit.ly/profileps'))
Write-Host
