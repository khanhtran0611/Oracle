@ echo off
Rem Copyright (c) 2006, 2020, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      eusm - Batch script to run Enterprise User Security admin tool
Rem
Rem    DESCRIPTION
Rem      Runs the enterprise user security admin tool
Rem
Rem    REVISION HISTORY
Rem    MODIFIED   (MM/DD/YY)
Rem    skayoor     02/17/20 - Bug 30786655:Add check for Trust Anchor
Rem                           Certificates to allow Non CA Certificate
Rem    srvakkal    10/27/17 - Correction of classpath
Rem    risgupta    09/28/17 - Bug 26734445 - Remove hardcoded reference
Rem    risgupta    08/07/17 - Bug 26539671 - Add classpath to support PKCS12 wallet

Rem External Directory Variables set by the Installer
SET OJDBC=ojdbc8.jar
SET RDBMSVER=

"C:\app09\oracle\base\product\21.0.0\clienthome_1/jdk/jre\bin\java" -classpath C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\oraclepki.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\osdt_cert.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\osdt_core.jar;"C:\app09\oracle\base\product\21.0.0\clienthome_1/jdk/jre\lib\rt.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\jdbc\lib\%OJDBC%;C:\app09\oracle\base\product\21.0.0\clienthome_1\rdbms\jlib\eusm.jar;C:\app09\oracle\base\product\21.0.0\clienthome_1\jlib\ldapjclnt%RDBMSVER%.jar" -Djdk.security.allowNonCaAnchor=true oracle.security.eus.util.ESMdriver %*


