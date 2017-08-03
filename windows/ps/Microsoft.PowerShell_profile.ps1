sl D:\Users\andys\Projects
Import-Module D:\Users\andys\Documents\WindowsPowerShell\Modules\posh-git\0.7.1\posh-git.psd1

function Start-PreviousCommandAsAdministrator
{
    $cmd = (Get-History ((Get-History).Count))[0].CommandLine
    Write-Host "Running $cmd in $PWD"
    sudo powershell -NoExit -Command "pushd '$PWD'; Write-host 'cmd to run: $cmd'; $cmd"
}

function sudo  
{
	if($args[0] -eq '!!')
	{
		Start-PreviousCommandAsAdministrator;
	}
	else
	{

	    $file, [string]$arguments = $args;
	    $psi = new-object System.Diagnostics.ProcessStartInfo $file;
	    $psi.Arguments = $arguments;
	    $psi.Verb = "runas";
	    $psi.WorkingDirectory = get-location;
	    [System.Diagnostics.Process]::Start($psi);
	}
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
