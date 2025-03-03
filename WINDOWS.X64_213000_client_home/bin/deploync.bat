@echo off
if "%OS%"=="Windows_NT" setlocal
REM all variables defined local
REM set DBG=echo to debug this script.
set DBG=REM
set JA_HOME=C:\app09\oracle\base\product\21.0.0\clienthome_1\javavm\jahome
set redirect_to_log_file=true
set args=
set nextarg=""
set jreclasspath="C:\app09\oracle\base\product\21.0.0\clienthome_1\lib\aurora_client.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\lib\jasper.zip;C:\app09\oracle\base\product\21.0.0\clienthome_1\lib\vbjtools.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\lib\vbjorb.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\lib\vbjapp.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\javavm\lib\aurora.zip;C:\app09\oracle\base\product\21.0.0\clienthome_1\lib\xmlparserv2.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\jdbc\lib\ojdbc8.jar"
pushd .
:LOOP
%DBG% LOOP-%CNT% (loop for args parsing)
  set/a CNT+=1
  if {%1} == {} goto MARK5
  if {%1} == {-classpath} goto MARK1
  if {%1} == {-addclasspath} goto MARK2
  if {%1} == {-verbose} goto MARK4
  if {%1} == {-d} goto change_dir
  if {%1} == {-projectDir} goto change_dir
    set args=%args% %1
    %DBG% %args%
    shift
    goto LOOP
:change_dir
%DBG% change_dir hit (-d)
   if exist %2 goto dirIsThere
   echo Fatal error: project directory %2 does not exist
   goto finish
:dirIsThere
%DBG% dirIsThere hit 
   cd /d %2
   shift
   shift
   goto LOOP
:MARK1
%DBG% MARK1 hit (-classpath)
  set classpath=%2
  set classpath=%classpath:"=%
  shift
  shift
  goto LOOP
:MARK2
%DBG% MARK2 hit (first -addclasspath)
  if not "%addclasspath%"=="" goto MARK3
    set addclasspath=%2
    set addclasspath="%addclasspath:"=%"
    shift
    shift
    goto LOOP
:MARK3
%DBG% MARK3 hit (additional -addclasspath)
  set nextarg=%2
  set addclasspath=%addclasspath%;%nextarg:"=%
  shift
  shift
  goto LOOP
:MARK4
%DBG% MARK4 hit (-verbose)
  set redirect_to_log_file=false
  shift
  goto LOOP
:MARK5
%DBG% MARK5 hit (append classpath)
  if "%CLASSPATH%"=="" goto MARK6
    set jreclasspath="%jreclasspath%;%CLASSPATH%"
    set jreclasspath="%jreclasspath:"=%"
:MARK6
%DBG% MARK6 hit (append addclasspath)
  if "%addclasspath%"=="" goto MARK7
    set jreclasspath="%jreclasspath%;%addclasspath%"
    set jreclasspath="%jreclasspath:"=%"
:MARK7
%DBG% MARK7 hit (invoke)
%DBG% *** ADDCLASSPATH=%addclasspath% ***
%DBG% *** CLASSPATH=%classpath% ***
%DBG% *** JRECLASSPATH=%jreclasspath% ***
%DBG% *** %args% ***
REM Adding quote creates problems later. Commented for now.
REM set ORACLE_HOME="%ORACLE_HOME:"=%"
REM set JA_HOME="%JA_HOME:"=%"
REM set JAVA_HOME="%JAVA_HOME:"=%"
set JAVA_HOME_CLASSPATH="%JAVA_HOME%\jre\lib\rt.jar;%JAVA_HOME%\lib\tools.jar;%JAVA_HOME%\lib\classes.zip;%CLASSPATH%"
set JAVA_HOME_CLASSPATH="%JAVA_HOME_CLASSPATH:"=%"
set JACLASSPATH="%JA_HOME%;C:\app09\oracle\base\product\21.0.0\clienthome_1\javavm\lib\jaccelerator.zip;C:\app09\oracle\base\product\21.0.0\clienthome_1\javavm\lib\ncomp.zip;%JAVA_HOME_CLASSPATH%"
set JACLASSPATH="%JACLASSPATH:"=%"

if (%redirect_to_log_file%)==(true) goto MARK8
@echo  "----------------------------------------------------------------------"
@echo on
%JAVA_HOME%\bin\java -Xint -DJA_HOME=%JA_HOME% -DORACLE_HOME=C:\app09\oracle\base\product\21.0.0\clienthome_1 -DJA_LIBS_HOME=C:\app09\oracle\base\product\21.0.0\clienthome_1 -DJAVA_HOME=%JAVA_HOME% -DJAVA_HOME_CLASSPATH=%JAVA_HOME_CLASSPATH% -classpath %JACLASSPATH% oracle.jaccelerator.Deploy %args% 
@echo off
goto finish

:MARK8
@echo  "----------------------------------------------------------------------" >> ncomp.log
%JAVA_HOME%\bin\java -Xint -DJA_HOME=%JA_HOME% -DORACLE_HOME=C:\app09\oracle\base\product\21.0.0\clienthome_1 -DJA_LIBS_HOME=C:\app09\oracle\base\product\21.0.0\clienthome_1 -DJAVA_HOME=%JAVA_HOME% -DJAVA_HOME_CLASSPATH=%JAVA_HOME_CLASSPATH% -classpath %JACLASSPATH% oracle.jaccelerator.Deploy %args% 

:finish
popd
if (%OS%) == (Windows_NT) endlocal
