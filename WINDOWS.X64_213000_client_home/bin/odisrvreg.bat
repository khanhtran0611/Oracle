REM #
REM # Copyright (c) 2001 , 2005 Oracle Corporation.  All rights reserved.
REM #
REM # PRODUCT
REM #   DIP
REM #
REM # FILENAME
REM #   odisrvreg.bat
REM #
REM # DESCRIPTION
REM #   This script is used to register the DIP Server on NT
REM #
REM # NOTE:

@echo off

set ORACLE_HOME=C:\app09\oracle\base\product\21.0.0\clienthome_1
set JAVA_HOME=C:\app09\oracle\base\product\21.0.0\clienthome_1\jdk

set PATH=C:\app09\oracle\base\product\21.0.0\clienthome_1\bin;%PATH%

SET CLASSPATH="C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\oraclepki103.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\ldap\odi\jlib\sync.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\ldapjclnt10.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\ojmisc.jar"

%JAVA_HOME%\bin\java -classpath %CLASSPATH% oracle.ldap.odip.engine.OdiReg C:\app09\oracle\base\product\21.0.0\clienthome_1 %*
