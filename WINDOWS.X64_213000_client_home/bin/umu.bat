Rem    skayoor     02/17/20 - Bug 30786655:Add check for Trust Anchor
Rem                           Certificates
Rem    risgupta    03/26/18 - Bug 27637921 - Update classpath to support SEPS
Rem    risgupta    09/28/17 - Bug 26734447 - Remove hardcoded reference

@echo off
SET OJDBC=ojdbc8.jar

"C:\app09\oracle\base\product\21.0.0\clienthome_1/jdk/jre\bin\java" -DORACLE_HOME="C:\app09\oracle\base\product\21.0.0\clienthome_1" -classpath "C:\app09\oracle\base\product\21.0.0\clienthome_1/jdk/jre\lib\rt.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1/jdk/jre\lib\i18n.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1/jdk/jre\lib\jsse.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\jdbc\lib\%OJDBC%;C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\verifier8.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\jssl-1_1.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\ldapjclnt.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\oraclepki.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\osdt_core.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\rdbms\jlib\usermigrate-1_0.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\osdt_cert.jar" -Djdk.security.allowNonCaAnchor=true oracle.security.rdbms.server.UserMigrate.umu.UserMigrate %*


