$ErrorActionPreference = 'Stop'
$scratch = "E:\GymPulse\tooling"
New-Item -ItemType Directory -Force -Path $scratch | Out-Null

$tomcatUrl = "https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.20/bin/apache-tomcat-10.1.20-windows-x64.zip"
$tomcatZip = "$scratch\tomcat.zip"
$tomcatDir = "$scratch\apache-tomcat-10.1.20"

$jdkUrl = "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.10%2B7/OpenJDK17U-jdk_x64_windows_hotspot_17.0.10_7.zip"
$jdkZip = "$scratch\jdk.zip"
$jdkDir = "$scratch\jdk-17.0.10+7"

Write-Host "Downloading Tomcat..."
if (-not (Test-Path $tomcatZip)) {
    Invoke-WebRequest -Uri $tomcatUrl -OutFile $tomcatZip
}
if (-not (Test-Path $tomcatDir)) {
    Write-Host "Extracting Tomcat..."
    Expand-Archive -Path $tomcatZip -DestinationPath $scratch -Force
    # Change port to 8081 to avoid conflict
    $serverXml = "$tomcatDir\conf\server.xml"
    (Get-Content -Path $serverXml) -replace 'port="8080"', 'port="8081"' | Set-Content -Path $serverXml
}

Write-Host "Downloading JDK..."
if (-not (Test-Path $jdkZip)) {
    Invoke-WebRequest -Uri $jdkUrl -OutFile $jdkZip
}
if (-not (Test-Path $jdkDir)) {
    Write-Host "Extracting JDK..."
    Expand-Archive -Path $jdkZip -DestinationPath $scratch -Force
}

$env:JAVA_HOME = $jdkDir
$env:PATH = "$env:JAVA_HOME\bin;" + $env:PATH

Write-Host "Compiling Java sources..."
$classesDir = "E:\GymPulse\src\main\webapp\WEB-INF\classes"
New-Item -ItemType Directory -Force -Path $classesDir | Out-Null
$javaFiles = Get-ChildItem -Path "E:\GymPulse\src\main\java" -Filter *.java -Recurse | Select-Object -ExpandProperty FullName

$classpath = "E:\GymPulse\src\main\webapp\WEB-INF\lib\*;$tomcatDir\lib\*"

$argsFile = "$scratch\args.txt"
$javaFiles -join "`n" | Set-Content $argsFile

# Execute javac using the args file
& javac -cp $classpath -d $classesDir "@$argsFile"

Write-Host "Deploying to Tomcat..."
$webappsGymPulse = "$tomcatDir\webapps\GymPulse"
if (Test-Path $webappsGymPulse) {
    Remove-Item -Path $webappsGymPulse -Recurse -Force
}
Copy-Item -Path "E:\GymPulse\src\main\webapp" -Destination $webappsGymPulse -Recurse -Force

Write-Host "Starting Tomcat..."
Start-Process -FilePath "$tomcatDir\bin\startup.bat" -WorkingDirectory "$tomcatDir\bin"

Write-Host "Done! The application is deploying to http://localhost:8081/GymPulse"
