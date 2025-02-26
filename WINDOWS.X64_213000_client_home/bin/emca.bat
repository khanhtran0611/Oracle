@echo off

rem Jar file classpath changes should be made in this file as well as classes/manifestDbca

setlocal

@set OH=C:\app09\oracle\base\product\21.0.0\clienthome_1
@set EWT_CLASSPATH=%OH%\jlib\ewt3.jar;%OH%\jlib\ewtcompat-3_3_15.jar
@set BALISHARE_CLASSPATH=%OH%\jlib\share.jar
@set ICE_BROWSER_CLASSPATH=%OH%\jlib\oracle_ice.jar
@set HELP_CLASSPATH=%OH%\jlib\help4.jar;%OH%\jlib\jewt4.jar;%OH%\jlib\olaf2.jar
@set KODIAK_CLASSPATH=%OH%\jlib\kodiak.jar
@set XMLPARSER_CLASSPATH=%OH%\lib\xmlparserv2.jar
@set GDK_CLASSPATH=%OH%\jlib\orai18n.jar
@set JDBC_CLASSPATH=%OH%\jdbc\lib\ojdbc6.jar
@set NETCFG_CLASSPATH=%OH%\jlib\ldapjclnt.jar;%OH%\jlib\%cs_netAPIName%;%OH%\jlib\ojmisc.jar;%OH%\jlib\oraclepki.jar;%OH%\jlib\opm.jar
@set SRVM_CLASSPATH=%OH%\jlib\srvm.jar;%OH%\jlib\srvmhas.jar;%OH%\jlib\srvmasm.jar;%OH%\jlib\cvu.jar
@set ASSISTANTS_COMMON_CLASSPATH=%OH%\assistants\jlib\assistantsCommon.jar
@set DBCA_CLASSPATH=%OH%\assistants\dbca\jlib\dbca.jar
@set HELPJAR_CLASSPATH=%OH%\assistants\dbca\doc\dbcahelp.jar;%OH%\assistants\dbca\doc\dbcahelp_es.jar;%OH%\assistants\dbca\doc\dbcahelp_de.jar;%OH%\assistants\dbca\doc\dbcahelp_fr.jar;%OH%\assistants\dbca\doc\dbcahelp_it.jar;%OH%\assistants\dbca\doc\dbcahelp_ko.jar;%OH%\assistants\dbca\doc\dbcahelp_pt_BR.jar;%OH%\assistants\dbca\doc\dbcahelp_zh_CN.jar;%OH%\assistants\dbca\doc\dbcahelp_zh_TW.jar
@set INSTALLER_CLASSPATH=%OH%\oui\jlib\OraInstaller.jar;%OH%\oui\jlib\OraCheckPoint.jar
@set DVCA_CLASSPATH=%OH%\dv\jlib\dvca.jar
@set EMCA_PATH=%OH%/jlib/emca.jar;%OH%/jlib/adf-share-ca.jar;%OH%/jlib/entityManager_proxy.jar;%OH%/jlib/jmxspi.jar;%OH%/jlib/wsclient_extended.jar;%OH%/install/jlib/emCoreConsole.jar;%OH%/jlib/javax.security.jacc_1.0.0.0_1-1.jar;%OH%/jlib/oracle.classloader_11.1.1.jar;%BALISHARE_CLASSPATH%


@set CLASSPATH=%DBCA_CLASSPATH%;%ASSISTANTS_COMMON_CLASSPATH%;%EWT_CLASSPATH%;%BALISHARE_CLASSPATH%;%ICE_BROWSER_CLASSPATH%;%HELP_CLASSPATH%;%KODIAK_CLASSPATH%;%XMLPARSER_CLASSPATH%;%GDK_CLASSPATH%;%NETCFG_CLASSPATH%;%JDBC_CLASSPATH%;%SRVM_CLASSPATH%;%INSTALLER_CLASSPATH%;%HELPJAR_CLASSPATH%;%OH%\jlib\supercluster.jar;%OH%\jlib\supercluster-common.jar;%OH%\jlib\ohj.jar;%OH%\jlib\help-share.jar;%OH%\jlib\oracle_ice.jar;%EMCA_PATH%

@set PATH=%OH%\bin;%PATH%

@set TWO_TASK=
@set LOCAL=

"%OH%\JDK\BIN\JAVA" -DORACLE_HOME="%OH%" -DCV_HOME="%OH%" -Doracle.installer.not_bootstrap=true -DJDBC_PROTOCOL=thin -mx256m -XX:MaxPermSize=128M oracle.sysman.assistants.emca.sdkimpl.EMConfigAssistant  %*

exit /B %ERRORLEVEL%
