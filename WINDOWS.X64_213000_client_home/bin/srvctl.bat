@echo off
rem 
rem $Header: opsm/utl/srvctl.sbs /nt/33 2020/07/19 10:13:22 dgoddard Exp $
rem
rem Copyright (c) 2008, 2019, Oracle and/or its affiliates. 
rem All rights reserved.
rem
rem    NAME
rem    srvctl - Oracle Server Control Utility
rem
rem    DESCRIPTION
rem    Oracle Server Control Utility can be used to administer all Oracle
rem    entities such as node applications, databases, ASM etc. managed
rem    under Oracle Clusterware.
rem
rem    NOTES
rem
rem    MODIFIED   (MM/DD/YY)
rem    jorgepe     06/17/19 - Fix bug 29866585 - Removed ldap version
rem    pevilla     01/04/19 - Fix bug 23637855- Bug 12628715, use own PATH
rem    nidietri    11/08/16 - Fix bug 23637855- removed parsing for args
rem    rdesale     06/26/16 - Fix bug 23522607
rem    rdesale     03/24/16 - Fix bug 22983734- add jwc-cred.jar to classpath
rem    kamramas    05/11/15 - Fix Trace issue
rem    sidshank    11/26/13 - fix bug 17832159.
rem    satg        09/13/13 - Fix bug 17416709
rem    ccharits    03/07/13 - XbranchMerge ccharits_bug-16368497 from
rem                           st_has_12.1.0.1
rem    epineda     10/10/12 - Added ldapjclnt12.jar for listener.ora reading
rem    yizhang     10/01/12 - fix bug 14381919
rem    agridnev    06/20/11 - added clsce.jar to support snapshots
rem    yizhang     12/30/10 - add antlr jar to classpath
rem    yizhang     12/30/10 - fix bug 9256393
rem    sravindh    04/06/10 - Bug 9447018
rem    yizhang     09/25/09 - fix bug 8771500
rem    rxkumar     01/26/09 - fix bug7715235
rem    rwessman    08/22/08 - Added GNS jar file.
rem    rxkumar     07/18/08 - fix EONSJAR
rem    spavan      05/16/08 - fix bug6937911
rem    hkanchar    03/31/08 - Add EONS jar files to the classpath
rem    spavan      03/27/08 - fix bug6916030
rem    rxkumar     01/10/08 - fix bug6730574
rem 
setlocal

Rem Gather command-line arguments.
@set USER_ARGS=%*

@set JREDIR=C:\app09\oracle\base\product\21.0.0\clienthome_1\jdk
@set JRE="%JREDIR%\bin\java"
@set JREJAR=%JREDIR%\jre\lib\rt.jar
@set JLIB=C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib
set EONSJAR=C:\app09\oracle\base\product\21.0.0\clienthome_1\ons\lib\ons.jar
@set GNSJAR=%JLIB%\gns.jar
set ANTLRJAR=C:\app09\oracle\base\product\21.0.0\clienthome_1\srvm\jlib\antlr-3.3-complete.jar
REM Bug 12628715, set our PATH
set PATH=C:\app09\oracle\base\product\21.0.0\clienthome_1\bin;C:\app09\oracle\base\product\21.0.0\clienthome_1\jdk\jre\bin;C:\app09\oracle\base\product\21.0.0\clienthome_1\jdk\bin
set PATH=%PATH%;%SYSTEMROOT%\system32;%SYSTEMROOT%;
set CLSCEJAR=%JLIB%\clsce.jar
set CHACONFIGJAR=%JLIB%\chaconfig.jar
set JDBCJAR=C:\app09\oracle\base\product\21.0.0\clienthome_1\jdbc\lib\ojdbc6.jar
set LDAPJAR=%JLIB%\ldapjclnt.jar
@set JWCCREDJAR=%JLIB%\jwc-cred.jar
set JAVA_STACK_SIZE="-Xss2048k"

if (%ORATST_SRVCTL11%)==() (
   set CLASSPATH="C:\app09\oracle\base\product\21.0.0\clienthome_1\srvm\jlib\srvctl.jar;%JLIB%\srvm.jar;%JLIB%\srvmhas.jar;%JLIB%\srvmasm.jar;%JLIB%\supercluster-common.jar;%JLIB%\supercluster.jar;%LDAPJAR%;%JLIB%\netcfg.jar;%JREJAR%;%EONSJAR%;%GNSJAR%;%ANTLRJAR%";%CLSCEJAR%;%CHACONFIGJAR%;%JDBCJAR%;%JWCCREDJAR%;%JLIB%\jackson-databind.jar;%JLIB%\jackson-core.jar;%JLIB%\jackson-annotations.jar
) else (
   set CLASSPATH="%ORATST_SRVCTL11_JARS%;%JLIB%\srvmasm.jar;%JLIB%\supercluster-common.jar;%JLIB%\supercluster.jar;%LDAPJAR%;%JLIB%\netcfg.jar;%JREJAR%;%EONSJAR%;%GNSJAR%;%ANTLRJAR%";%CLSCEJAR%;%CHACONFIGJAR%;%JDBCJAR%;%JWCCREDJAR%;%JLIB%\jackson-databind.jar;%JLIB%\jackson-core.jar;%JLIB%\jackson-annotations.jar

)

set JRE_OPTIONS=%JAVA_STACK_SIZE%

set ORACLE_HOME_PROP=C:\app09\oracle\base\product\21.0.0\clienthome_1

Rem - If CRSHOME, unset ORACLE_HOME 
if exist C:\app09\oracle\base\product\21.0.0\clienthome_1\bin\crsctl.exe (
  set ORACLE_HOME=
)

Rem USING ANTLR
if not (%USING_ANTLR%)==() (
   set SRVM_PROPERTY_DEFS= %SRVM_PROPERTY_DEFS% -Dusing_antlr=%USING_ANTLR%
)

Rem NETWORK CHECK LEVEL
if not (%CHECK_LEVEL%)==() (
   set SRVM_PROPERTY_DEFS= %SRVM_PROPERTY_DEFS% -DNETWORK.CHECKLEVEL=%CHECK_LEVEL%
)

Rem SRVM TRACING
if (%SRVM_TRACE%)==() (
  goto runcmd
) else (
  if /I '%SRVM_TRACE%' == 'false' (
    set SRVM_PROPERTY_DEFS= %SRVM_PROPERTY_DEFS% -DTRACING.ENABLED=false
  ) else (
    if not '%SRVM_TRACE_LEVEL%' == '' (
      set SRVM_PROPERTY_DEFS= %SRVM_PROPERTY_DEFS% -DTRACING.ENABLED=true -DTRACING.LEVEL=%SRVM_TRACE_LEVEL%
    ) else (
      set SRVM_PROPERTY_DEFS= %SRVM_PROPERTY_DEFS% -DTRACING.ENABLED=true -DTRACING.LEVEL=2
    )
  )
)

Rem SRVCTL TRACEFILE
if not (%SRVCTL_TRACEFILE%)==() (
   set SRVM_PROPERTY_DEFS= %SRVM_PROPERTY_DEFS% -Dsrvm.srvctl.tracefile=%SRVCTL_TRACEFILE% 
)

Rem SRVM NATIVE TRACING
if not (%SRVM_NATIVE_TRACE%)==() (
   set SRVM_PROPERTY_DEFS= %SRVM_PROPERTY_DEFS% -DNATIVETRACING.ENABLED=true
)

Rem SRVM JNI TRACING
if not (%SRVM_JNI_TRACE%)==() (
   set SRVM_PROPERTY_DEFS= %SRVM_PROPERTY_DEFS% -DJNITRACING.ENABLED=true
)

:runcmd
rem Configuration file containing logging properties.
set SRVM_PROPERTY_DEFS= %SRVM_PROPERTY_DEFS% -Djava.util.logging.config.file=%ORA_CRS_HOME%\srvm\admin\logging.properties

set CMD=%JRE% %JRE_OPTIONS% -DORACLE_HOME=%ORACLE_HOME_PROP% -classpath %CLASSPATH% %SRVM_PROPERTY_DEFS% oracle.ops.opsctl.OPSCTLDriver %USER_ARGS% 

%CMD%

exit /b %ERRORLEVEL%

endlocal

