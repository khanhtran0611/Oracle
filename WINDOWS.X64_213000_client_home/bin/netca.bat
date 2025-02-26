@echo off

rem Jar file classpath changes should be made in this file as well as classes/manifestNetca

@setlocal

@set OH=C:\app09\oracle\base\product\21.0.0\clienthome_1

@set JDK_DIR=%OH%\jdk
@set JLIB_DIR=%OH%\jlib

@set JRE=%JDK_DIR%\bin\java
@set JRE_JAR=%JDK_DIR%\lib\rt.jar;%JDK_DIR%\lib\i18n.jar

@set EWT3_JAR=%JLIB_DIR%\ewt3.jar
@set EWT_COMP_JAR=%JLIB_DIR%\ewtcompat.jar
@set HELP4_JAR=%JLIB_DIR%\help4.jar
@set JEWT4_JAR=%JLIB_DIR%\jewt4.jar
@set JNDI_JAR=%JLIB_DIR%\jndi.jar
@set NETCFG_JAR=%JLIB_DIR%\netcfg.jar
@set ICE_BROWSER_JAR=%JLIB_DIR%\oracle_ice.jar
@set ICE5_BROWSER_JAR=%JLIB_DIR%\oracle_ice5.jar
@set SHARE_JAR=%JLIB_DIR%\share.jar
@set ASSISTANTS_COMMON_JAR=%OH%\assistants\jlib\assistantsCommon.jar
@set NETCA_JAR=%OH%\assistants\netca\jlib\netca.jar
@set INSTALLER_JAR=%OH%\oui\jlib\OraInstaller.jar
@set PREREQ_JAR=%OH%\oui\jlib\OraPrereq.jar
@set PREREQ_CHECKS_JAR_1=%OH%\oui\jlib\OraPrereqChecks.jar
@set PREREQ_CHECKS_JAR_2=%OH%\inventory\prereq\oui\OraPrereqChecks.jar
@set SRVM_JAR=%JLIB_DIR%\srvm.jar
@set SRVMHAS_JAR=%JLIB_DIR%\srvmhas.jar
@set SRVMASM_JAR=%JLIB_DIR%\srvmasm.jar
@set SUPERCLUSTER_JAR=%OH%\opsm\jlib\supercluster.jar
@set SUPERCLUSTER_COMMON_JAR=%OH%\opsm\jlib\supercluster-common.jar
@set XMLPARSER2_JAR=%OH%\lib\xmlparserv2.jar
@set NET_TOOLS_DIR=%OH%\network\tools
@set NETCA_DOC_DIR=%OH%\assistants\netca\doc
@set CVU_JAR=%JLIB_DIR%\cvu.jar
@set DB_INSTALLER_FRAMEWORK=%OH%\install\jlib\installcommons_1.0.0b.jar

@set NETCA_HELP_JAR=%NETCA_DOC_DIR%\netcahelp.jar;%NETCA_DOC_DIR%\netcahelp_es.jar;%NETCA_DOC_DIR%\netcahelp_de.jar;%NETCA_DOC_DIR%\netcahelp_fr.jar;%NETCA_DOC_DIR%\netcahelp_ja.jar;%NETCA_DOC_DIR%\netcahelp_it.jar;%NETCA_DOC_DIR%\netcahelp_pt_BR.jar;%NETCA_DOC_DIR%\netcahelp_ko.jar;%NETCA_DOC_DIR%\netcahelp_zh_CN.jar;%NETCA_DOC_DIR%\netcahelp_zh_TW.jar

@set CLASSPATH=%DB_INSTALLER_FRAMEWORK%;%NETCA_JAR%;%ORACLE_OEM_CLASSPATH%

@set PWD=%CD%
cd %OH%\bin
@set PATH=%OH%\bin;%PATH%

REM @FOR /F "TOKENS=2 DELIMS=:." %%I IN ('chcp') DO SET cp=%%I
REM @set cp=%cp: =%
REM @set CODE_PAGE=Cp%cp%

"%JRE%" -Dsun.java2d.noddraw=true -DORACLE_HOME="%OH%" -Doracle.installer.not_bootstrap=true -XX:-OmitStackTraceInFastThrow -XX:CompileCommand=quiet -XX:CompileCommand=exclude,javax/swing/text/GlyphView,getBreakSpot -classpath "%CLASSPATH%" oracle.net.ca.NetCA %*
@set NETCA_EXIT_STATUS=%ERRORLEVEL%
cd %PWD%
exit /B %NETCA_EXIT_STATUS%
