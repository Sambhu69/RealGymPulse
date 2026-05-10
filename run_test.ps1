$env:JAVA_HOME = 'C:\GymPulse\tooling\jdk-17.0.10+7'
$env:PATH = "$env:JAVA_HOME\bin;" + $env:PATH
$classes = 'C:\GymPulse\src\main\webapp\WEB-INF\classes'
$cp = "$classes;C:\GymPulse\src\main\webapp\WEB-INF\lib\*;C:\GymPulse\tooling\apache-tomcat-10.1.20\lib\*"
& javac -cp $cp -d $classes C:\GymPulse\src\main\java\com\gympulse\config\TestEncryption.java
& java -cp $cp com.gympulse.config.TestEncryption
