$file=’name.exe’ 
$url=’https://www.dropbox.com/s/4poos0fgiwh1/name.exe?dl=1’ 
Invoke-WebRequest –Uri $url -OutFile $file 
 
$arguments = "/key="" /silent" 
if($arguments) 
{ 
$installProcess = (Start-Process $file -ArgumentList $arguments -PassThru -Wait) 
} 
else 
{ 
$installProcess = (Start-Process $file -PassThru -Wait) 
} 
 
if ($installProcess.ExitCode-ne 0){ 
Write-Host ‘Installation failed’ 
exit installProcess.ExitCode 
} 
else{ 
Write-Host ‘Installation successful’ 
}