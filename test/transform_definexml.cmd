@echo off

set project=..
set classpath=%classpath%;%project%\lib\SaxonHE12-9J\saxon-he-12.9.jar
set stylesheet=%project%\localization\define2-1.xsl
set log="%~n0.log"
echo.>%log%

call :transform adam-ja %project%\test\xml\definev21-adam.xml %stylesheet% %project%\test\html\definev21-adam_ja.html "interfaceLang=ja"
call :transform adam-zh %project%\test\xml\definev21-adam.xml %stylesheet% %project%\test\html\definev21-adam_zh.html "interfaceLang=zh"
call :transform adam-en %project%\test\xml\definev21-adam.xml %stylesheet% %project%\test\html\definev21-adam_en.html "interfaceLang=en"
call :transform adam    %project%\test\xml\definev21-adam.xml %stylesheet% %project%\test\html\definev21-adam_default.html

call :transform sdtm-ja %project%\test\xml\definev21-sdtm.xml %stylesheet% %project%\test\html\definev21-sdtm_ja.html "interfaceLang=ja"
call :transform sdtm-zh %project%\test\xml\definev21-sdtm.xml %stylesheet% %project%\test\html\definev21-sdtm_zh.html "interfaceLang=zh"
call :transform sdtm-en %project%\test\xml\definev21-sdtm.xml %stylesheet% %project%\test\html\definev21-sdtm_en.html "interfaceLang=en"
call :transform sdtm    %project%\test\xml\definev21-sdtm.xml %stylesheet% %project%\test\html\definev21-sdtm_default.html

call :transform_params adam-ja %project%\test\xml\definev21-adam.xml %stylesheet% %project%\test\html\definev21-adam.parameters_ja.html "interfaceLang=ja"
call :transform_params adam-zh %project%\test\xml\definev21-adam.xml %stylesheet% %project%\test\html\definev21-adam.parameters_zh.html "interfaceLang=zh"
call :transform_params adam-en %project%\test\xml\definev21-adam.xml %stylesheet% %project%\test\html\definev21-adam.parameters_en.html "interfaceLang=en"
call :transform_params adam    %project%\test\xml\definev21-adam.xml %stylesheet% %project%\test\html\definev21-adam.parameters_default.html

call :transform_params sdtm-ja %project%\test\xml\definev21-sdtm.xml %stylesheet% %project%\test\html\definev21-sdtm.parameters_ja.html "interfaceLang=ja"
call :transform_params sdtm-zh %project%\test\xml\definev21-sdtm.xml %stylesheet% %project%\test\html\definev21-sdtm.parameters_zh.html "interfaceLang=zh"
call :transform_params sdtm-en %project%\test\xml\definev21-sdtm.xml %stylesheet% %project%\test\html\definev21-sdtm.parameters_en.html "interfaceLang=en"
call :transform_params sdtm    %project%\test\xml\definev21-sdtm.xml %stylesheet% %project%\test\html\definev21-sdtm.parameters_default.html


call :transform adam    %project%\test\xml\definev21-adam_issue09.xml %stylesheet% %project%\test\html\issue09\definev21-adam_issue09.html

call :transform adam    %project%\test\xml\definev21-adam_issue15.xml %stylesheet% %project%\test\html\issue15\definev21-adam_issue15.html
call :transform adam    %project%\test\xml\definev21-adam_issue15.xml %stylesheet% %project%\test\html\issue15\definev21-adam_issue15_all_decodes.html "nCheckValueDisplay=999"
call :transform adam    %project%\test\xml\definev21-adam_issue15.xml %stylesheet% %project%\test\html\issue15\definev21-adam_issue15_no_decodes.html "nCheckValueDisplay=0"
call :transform sdtm    %project%\test\xml\definev21-sdtm.xml         %stylesheet% %project%\test\html\issue15\definev21-sdtm_issue15.html "nCheckValueDisplay=3"

goto :EOF

:transform

echo **** %1
echo **** xml:   %2
echo **** xsl:   %3
echo **** html:  %4
echo **** param: %5
echo.

echo Transform -s:%2 -xsl:%3 -o:%4  >> %log% 2>&1
set param1=%5
set param2=displayCommentsTable="0"
set param3=displayPrefix="0"
set param4=displayLengthDFormatSD="0"


if (%param1%)==() (
  echo java net.sf.saxon.Transform -t  -s:%2 -xsl:%3 -o:%4 -versionmsg:off %param2% %param3% %param4% >> %log%
  java net.sf.saxon.Transform -t -s:%2 -xsl:%3 -o:%4 -versionmsg:off %param2% %param3% %param4% >> %log% 2>&1
  ) else (
  echo java net.sf.saxon.Transform -t -s:%2 -xsl:%3 -o:%4 -versionmsg:off %param1:"=% %param2% %param3% %param4% >> %log%
  java net.sf.saxon.Transform -t -s:%2 -xsl:%3 -o:%4 -versionmsg:off %param1:"=% %param2% %param3% %param4% >> %log% 2>&1
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
  echo java net.sf.saxon.Transform -t -s:%2 -xsl:%3 -o:%4 -versionmsg:off %param2% %param3% %param4% >> %log%
  java net.sf.saxon.Transform -t -s:%2 -xsl:%3 -o:%4 -versionmsg:off %param2% %param3% %param4% >> %log% 2>&1
  ) else (
  echo java net.sf.saxon.Transform -t -s:%2 -xsl:%3 -o:%4 -versionmsg:off %param1:"=% %param2% %param3% %param4% >> %log%
  java net.sf.saxon.Transform -t -s:%2 -xsl:%3 -o:%4 -versionmsg:off %param1:"=% %param2% %param3% %param4% >> %log% 2>&1
  )
echo.>> %log%
goto :EOF
