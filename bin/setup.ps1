$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Push-Location $scriptDir\..
[Environment]::CurrentDirectory = $PWD

npm install

Pop-Location
[Environment]::CurrentDirectory = $PWD
