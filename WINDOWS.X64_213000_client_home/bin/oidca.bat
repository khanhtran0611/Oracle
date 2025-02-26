@echo off

set ORACLE_HOME=C:\app09\oracle\base\product\21.0.0\clienthome_1
set JLIB_HOME=C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib
set PATH=C:\app09\oracle\base\product\21.0.0\clienthome_1\ldap\bin;C:\app09\oracle\base\product\21.0.0\clienthome_1\bin;C:\app09\oracle\base\product\21.0.0\clienthome_1\opmn\bin;%PATH%

set HELPJAR=help4.jar
set ICEJAR=oracle_ice.jar
set SHAREJAR=share.jar
set EWTJAR=ewt3.jar
set EWTCOMPAT=ewtcompat-3_3_15.jar
set NETCFGJAR=netcfg.jar
set DBUIJAR=dbui2.jar



set CLASSPATH="C:\app09\oracle\base\product\21.0.0\clienthome_1\ldap\lib\oidca.jar;%JLIB_HOME%\ldapjclnt11.jar;%JLIB_HOME%\%NETCFGJAR%;%JLIB_HOME%\%HELPJAR%;%JLIB_HOME%\%ICEJAR%%JLIB_HOME%\%SHAREJAR%;%JLIB_HOME%\%EWTJAR%;%JLIB_HOME%\%EWTCOMPAT%;%JLIB_HOME%\swingall-1_1_1.jar;%JLIB_HOME%\%DBUIJAR%;C:\app09\oracle\base\product\21.0.0\clienthome_1\ldap\odi\jlib\sync.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\ldap\oidadmin\dasnls.jar;%JLIB_HOME%\ojmisc.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\jdbc\lib\classes12.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\assistants\jlib\assistantsCommon.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\srvm.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\opmn\lib\optic.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\oraclepki.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\osdt_core.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\osdt_cert.jar"

C:\app09\oracle\base\product\21.0.0\clienthome_1\jdk\bin\java -Xms48m -Xmx128m -Djava.security.policy=%s_java2policyFile% -DORACLE_HOME=C:\app09\oracle\base\product\21.0.0\clienthome_1 -DLDAP_ADMIN=%LDAP_ADMIN% -classpath %CLASSPATH% oracle.ldap.oidinstall.OIDClientCA orahome=C:\app09\oracle\base\product\21.0.0\clienthome_1 %*

