@echo off

set project=.

set classpath=%classpath%;..\lib\SaxonHE10-8J\saxon-he-10.8.jar

set stylesheet=%project%\stylesheets\define2-1.xsl

set log="%~n0.log"
echo.>%log%


call :transform adam-ja %project%\xml\definev21-adam.xml %stylesheet% %project%\html\definev21-adam_ja.html "interfaceLang=ja"
call :transform adam-zh %project%\xml\definev21-adam.xml %stylesheet% %project%\html\definev21-adam_zh.html "interfaceLang=zh"
call :transform adam-en %project%\xml\definev21-adam.xml %stylesheet% %project%\html\definev21-adam_en.html "interfaceLang=en"
call :transform adam    %project%\xml\definev21-adam.xml %stylesheet% %project%\html\definev21-adam_default.html

call :transform sdtm-ja %project%\xml\definev21-sdtm.xml %stylesheet% %project%\html\definev21-sdtm_ja.html "interfaceLang=ja"
call :transform sdtm-zh %project%\xml\definev21-sdtm.xml %stylesheet% %project%\html\definev21-sdtm_zh.html "interfaceLang=zh"
call :transform sdtm-en %project%\xml\definev21-sdtm.xml %stylesheet% %project%\html\definev21-sdtm_en.html "interfaceLang=en"
call :transform sdtm    %project%\xml\definev21-sdtm.xml %stylesheet% %project%\html\definev21-sdtm_default.html


call :transform_params adam-ja %project%\xml\definev21-adam.xml %stylesheet% %project%\html\definev21-adam.parameters_ja.html "interfaceLang=ja"
call :transform_params adam-zh %project%\xml\definev21-adam.xml %stylesheet% %project%\html\definev21-adam.parameters_zh.html "interfaceLang=zh"
call :transform_params adam-en %project%\xml\definev21-adam.xml %stylesheet% %project%\html\definev21-adam.parameters_en.html "interfaceLang=en"
call :transform_params adam    %project%\xml\definev21-adam.xml %stylesheet% %project%\html\definev21-adam.parameters_default.html

call :transform_params sdtm-ja %project%\xml\definev21-sdtm.xml %stylesheet% %project%\html\definev21-sdtm.parameters_ja.html "interfaceLang=ja"
call :transform_params sdtm-zh %project%\xml\definev21-sdtm.xml %stylesheet% %project%\html\definev21-sdtm.parameters_zh.html "interfaceLang=zh"
call :transform_params sdtm-en %project%\xml\definev21-sdtm.xml %stylesheet% %project%\html\definev21-sdtm.parameters_en.html "interfaceLang=en"
call :transform_params sdtm    %project%\xml\definev21-sdtm.xml %stylesheet% %project%\html\definev21-sdtm.parameters_default.html

type %log%

echo.
echo done!

PING localhost -n 3 >NUL

goto :EOF


:transform

echo **** %1 ****
echo **** xml:   %2 ****
echo **** xsl:   %3 ****
echo **** html:  %4 ****
echo **** param: %5 ****
echo.

echo Transform -s:%2 -xsl:%3 -o:%4  >> %log% 2>&1
set param1=%5
set param2=displayCommentsTable="0"
set param3=displayPrefix="0"
set param4=displayLengthDFormatSD="0"


if (%param1%)==() (
  echo java net.sf.saxon.Transform -s:%2 -xsl:%3 -o:%4 -versionmsg:off %param2% %param3% %param4% >> %log%
  java net.sf.saxon.Transform -s:%2 -xsl:%3 -o:%4 -versionmsg:off %param2% %param3% %param4% >> %log% 2>&1
  ) else (
  echo java net.sf.saxon.Transform -s:%2 -xsl:%3 -o:%4 -versionmsg:off %param1:"=% %param2% %param3% %param4% >> %log%
  java net.sf.saxon.Transform -s:%2 -xsl:%3 -o:%4 -versionmsg:off %param1:"=% %param2% %param3% %param4% >> %log% 2>&1
  )
echo.>> %log%
goto :EOF

:transform_params

echo **** %1 ****
echo **** xml:   %2 ****
echo **** xsl:   %3 ****
echo **** html:  %4 ****
echo **** param: %5 ****
echo.

echo Transform -s:%2 -xsl:%3 -o:%4  >> %log% 2>&1
set param1=%5
set param2=displayCommentsTable="1"
set param3=displayPrefix="1"
set param4=displayLengthDFormatSD="1"


if (%param1%)==() (
  echo java net.sf.saxon.Transform -s:%2 -xsl:%3 -o:%4 -versionmsg:off %param2% %param3% %param4% >> %log%
  java net.sf.saxon.Transform -s:%2 -xsl:%3 -o:%4 -versionmsg:off %param2% %param3% %param4% >> %log% 2>&1
  ) else (
  echo java net.sf.saxon.Transform -s:%2 -xsl:%3 -o:%4 -versionmsg:off %param1:"=% %param2% %param3% %param4% >> %log%
  java net.sf.saxon.Transform -s:%2 -xsl:%3 -o:%4 -versionmsg:off %param1:"=% %param2% %param3% %param4% >> %log% 2>&1
  )
echo.>> %log%
goto :EOF
