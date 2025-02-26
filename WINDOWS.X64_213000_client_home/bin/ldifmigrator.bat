@echo off

REM #
REM # Copyright (c) 2001, 2003 Oracle Corporation.  All rights reserved.
REM #
REM # PRODUCT
REM #   OID LDIF Migration to OID
REM #
REM # FILENAME
REM #   LDIFMigrator.bat
REM #
REM # DESCRIPTION
REM #   This script is used to launch the LIDF Migration.
REM #
REM # NOTE:
REM #
REM #   ldifmigrator -help prints usage
REM #
REM #   Note that parameters containing an '=' sign must be 
REM #   double-quoted when invoking this script, else they will 
REM #   be broken up into separate parameters at the = sign
REM #   and errors will result.
REM #

SETLOCAL

REM # Check ORACLE_HOME is defined
IF "C:\app09\oracle\base\product\21.0.0\clienthome_1x" == "x" GOTO NO_ORACLE_HOME
SET JAVAEXE=C:\app09\oracle\base\product\21.0.0\clienthome_1\jdk\bin\java

REM Set class path
SET LDAPJCLNT=C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\ldapjclnt.jar
SET NETCFG=C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\netcfg.jar

REM make sure ldapjclnt.jar is present
IF NOT EXIST %LDAPJCLNT% GOTO NO_LDAPJCLNTJAR_FILE

SET CLASSPATH=%LDAPJCLNT%;%NETCFG%;C:\app09\oracle\base\product\21.0.0\clienthome_1\j2ee\home\jps-api.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\j2ee\home\jps-internal.jar;

%JAVAEXE% -classpath %CLASSPATH% -DORACLE_HOME=C:\app09\oracle\base\product\21.0.0\clienthome_1 oracle.ldap.util.LDIFMigration %*

GOTO THE_END

:NO_LDAPJCLNTJAR_FILE
   ECHO Missing jar file
   ECHO %LDAPJCLNT% not found
   GOTO THE_END

:NO_ORACLE_HOME
  ECHO ORACLE_HOME is not defined

:THE_END
   ENDLOCAL
