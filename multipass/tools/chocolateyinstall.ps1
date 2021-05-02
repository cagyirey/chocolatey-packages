$ErrorActionPreference = 'Stop';
$pp = Get-PackageParameters

$packageArgs = @{ 
  PackageName = $env:ChocolateyPackageName
  FileType = 'exe'
  SilentArgs = '/S'
  Url64bit = 'https://github.com/canonical/multipass/releases/download/v1.6.2/multipass-1.6.2+win-win64.exe'
  Checksum64 = '133fef8642b5f21f153fe85799fe6e10d4d65d01ba1a111684b880474146f05242bf207b97e065ed170da68e0f5d4f57d018dca62eebf20bf347d534b7e66d6e'
  ChecksumType64 = 'sha512'
}

Install-ChocolateyPackage  @packageArgs
  

Install-BinFile `
  -Name $env:ChocolateyPackageName `
  -Path "$env:ProgramFiles\Multipass\bin\multipass.exe" `

if ($pp['HyperVisor'] -match 'Virtual\s*Box') {

  Write-Host "Virtual-Box must be installed to use this option"
  & "$env:ProgramFiles\Multipass\bin\multipass.exe" set local.driver=virtualbox
}
