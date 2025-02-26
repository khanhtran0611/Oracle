@echo off
REM #   DIP
REM #
REM # FILENAME
REM #   schemasync.bat
REM #
REM # DESCRIPTION
REM #   This script is used to synchronize schema on NT
REM #
REM # NOTE:


set ORACLE_HOME=C:\app09\oracle\base\product\21.0.0\clienthome_1
set JAVA_HOME=C:\app09\oracle\base\product\21.0.0\clienthome_1\jdk

set CLASSPATH="C:\app09\oracle\base\product\21.0.0\clienthome_1/ldap/odi/jlib/dmu.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1/jlib/ldapjclnt12.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1/ldap/odi/jlib/sync.jar"

%JAVA_HOME%\bin\java -classpath %CLASSPATH% oracle.ldap.dmu.SchemaMigrater C:\app09\oracle\base\product\21.0.0\clienthome_1 %*


