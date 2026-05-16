$env:JAVA_HOME="C:\GymPulse\tooling\jdk-17.0.10+7"
$env:PATH="$env:JAVA_HOME\bin;" + $env:PATH
cd C:\GymPulse
javac -cp "src\main\webapp\WEB-INF\classes;src\main\webapp\WEB-INF\lib\mysql-connector-j-8.3.0.jar" scratch\FixSpaces.java
java -cp "scratch;src\main\webapp\WEB-INF\classes;src\main\webapp\WEB-INF\lib\mysql-connector-j-8.3.0.jar" FixSpaces
