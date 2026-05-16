$ErrorActionPreference = 'Stop'
$scratch = "C:\GymPulse\tooling"
$tomcatDir = "$scratch\apache-tomcat-10.1.20"
$jdkDir = "$scratch\jdk-17.0.10+7"

$env:JAVA_HOME = $jdkDir
$env:PATH = "$env:JAVA_HOME\bin;" + $env:PATH

Write-Host "Stopping Tomcat..."
Stop-Process -Name java -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

Write-Host "Cleaning build and deployment directories..."
$classesDir = "C:\GymPulse\src\main\webapp\WEB-INF\classes"
if (Test-Path $classesDir) {
    Remove-Item -Path $classesDir -Recurse -Force
}
New-Item -ItemType Directory -Path $classesDir

$webappsGymPulse = "$tomcatDir\webapps\GymPulse"
if (Test-Path $webappsGymPulse) {
    Remove-Item -Path $webappsGymPulse -Recurse -Force
}

$workDir = "$tomcatDir\work\Catalina\localhost\GymPulse"
if (Test-Path $workDir) {
    Remove-Item -Path $workDir -Recurse -Force
}

Write-Host "Compiling Java sources..."
$javaFiles = Get-ChildItem -Path "C:\GymPulse\src\main\java" -Filter *.java -Recurse | Select-Object -ExpandProperty FullName
$classpath = "C:\GymPulse\src\main\webapp\WEB-INF\lib\*;$tomcatDir\lib\*"
$argsFile = "$scratch\args.txt"
$javaFiles -join "`n" | Set-Content $argsFile

& javac -cp $classpath -d $classesDir "@$argsFile"

Write-Host "Deploying to Tomcat..."
Copy-Item -Path "C:\GymPulse\src\main\webapp" -Destination $webappsGymPulse -Recurse -Force

Write-Host "Starting Tomcat..."
Start-Process -FilePath "$tomcatDir\bin\startup.bat" -WorkingDirectory "$tomcatDir\bin"

Write-Host "Done! The application is deploying to http://localhost:8081/GymPulse"
