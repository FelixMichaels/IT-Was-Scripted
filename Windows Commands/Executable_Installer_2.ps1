try{
    $file='C:\folder\application.exe'
    $url='https://www.dropbox.com/s/4poos0fgiwh1/application.exe?dl=1'
    Invoke-WebRequest –Uri $url -OutFile $file

    $arguments = "/silent"
    $installProcess = Start-Process $file -ArgumentList $arguments -PassThru -Wait

    if ($installProcess.ExitCode-ne 0){
        Write-Host 'Installation failed'
        Write-Host $installProcess.ExitCode
    }
    else{
        Write-Host 'Installation successful'
    }
}
catch 
{
    Write-Host $_.Exception.Message
}