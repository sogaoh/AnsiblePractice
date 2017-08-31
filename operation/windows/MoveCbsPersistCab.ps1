# MoveCbsPersistCab.ps1
#
# Usage:
# powershell -ExecutionPolicy RemoteSigned .\MoveCbsPersistCab.ps1
#

Set-ExecutionPolicy RemoteSigned -Scope Process 

$destDir = "C:\temp\CbsPersistCab_Recently"
if ( !(Test-Path $destDir) )
{
  ni -type directory $destDir
}
del /S /F /Q $destDir\*

ls C:\Windows\logs\CBS\CbsPersist_*.cab | mv -Destination $destDir\
