@echo off

REM #
REM # Copyright (c) 2001 Oracle Corporation.  All rights reserved.
REM #
REM # PRODUCT
REM #   OID Provisioning Tool
REM #
REM # FILENAME
REM #   oidprovtool.bat
REM #
REM # DESCRIPTION
REM #   This script is used to launch the provisioning tool
REM #
REM # NOTE:
REM #   This script is typically invoked as follows:
REM #
REM #

SETLOCAL

REM  Make sure that our JRE is used for this invocation.
IF Windows_NT == %OS% SET PATH=%s_JRE_LOCATION%\bin;C:\app09\oracle\base\product\21.0.0\clienthome_1\bin;%PATH%
IF not Windows_NT == %OS% SET PATH="%s_JRE_LOCATION%\bin;C:\app09\oracle\base\product\21.0.0\clienthome_1\bin;%PATH%"

REM Set class path
SET CLASSROOT=C:\app09\oracle\base\product\21.0.0\clienthome_1\classes
SET LDAPJCLNT=C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\ldapjclnt.jar
SET NETCFG=C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\netcfg.jar
SET JNDIJARS=C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\ldap.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\jndi.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\providerutil.jar

REM make sure ldapjclnt.jar is present
IF NOT EXIST %LDAPJCLNT% GOTO NO_LDAPJCLNTJAR_FILE

SET CLASSPATHADD=%LDAPJCLNT%;%JNDIJARS%;%CLASSROOT%;%NETCFG%;

SET JRE=jre -nojit
SET CLASSPATH_QUAL=cp

IF "%ORACLE_OEM_JAVARUNTIME%x" == "x" GOTO JRE_START
SET JRE=%ORACLE_OEM_JAVARUNTIME%\bin\java -nojit
SET CLASSPATH_QUAL=classpath
SET CLASSPATHADD=%CLASSPATHADD%;%ORACLE_OEM_JAVARUNTIME%\lib\classes.zip
SET CLASSPATHADD=%CLASSPATHADD%;C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\javax-ssl-1_2.jar
SET CLASSPATHADD=%CLASSPATHADD%;C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\jssl-1_2.jar
SET CLASSPATHADD=%CLASSPATHADD%;C:\app09\oracle\base\product\21.0.0\clienthome_1\j2ee\home\jps-api.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\j2ee\home\jps-internal.jar

:JRE_START

C:\app09\oracle\base\product\21.0.0\clienthome_1\jdk\bin\java -Xms48m -Xmx256m -%CLASSPATH_QUAL% %CLASSPATHADD% -DORACLE_HOME=C:\app09\oracle\base\product\21.0.0\clienthome_1  oracle.ldap.util.provisioning.ProvisioningProfile %*

GOTO THE_END

:NO_LDAPJCLNTJAR_FILE
   ECHO Missing jar file
   ECHO %LDAPJCLNT% not found
   GOTO THE_END

:THE_END
   ENDLOCAL
