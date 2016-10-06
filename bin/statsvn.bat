REM $Id: statsvn.bat 391 2016-05-15 20:32:07Z e0c2425 $

echo To build statistics for your SVN repository using
echo statsvn (see http://wiki.statsvn.org/). First time out, you
echo must install the statsvn by downloading from
echo http://sourceforge.net/project/showfiles.php?group_id=164845
echo into a folder in your PATH like C:\bin

echo Then from a command window prompt, change folder to your where
echo your SAF repository is located, then execute this batch file,
echo for example:
echo     cd C:\devl\SAF
echo     bin\statsvn.bat
echo Then you can view statistics via any browser, for example, open
echo     C:\devl\SAF_dev\metrics\statsvn\20161505_1435\index.html

set date_time=%date:~10,4%%date:~7,2%%date:~4,2%_%time:~0,2%%time:~3,2%
echo %mydate%

set wdir=metrics\statsvn\%mydate%
mkdir %wdir%


set statsvn_logfile=svn_logfile.log
svn log -v --xml > %wdir%\%statsvn_logfile%
cd %wdir%
java -jar C:\statsvn-0.7.0\statsvn.jar %statsvn_logfile% ..\..\..

