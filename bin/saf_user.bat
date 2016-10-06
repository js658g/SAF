@echo off
REM $Id: saf_user.bat 305 2016-05-03 14:25:12Z e0c2506 $
WHERE ruby
IF %ERRORLEVEL% NEQ 0 (
  jruby %~dp0\saf_user.rb %*
) ELSE (
  ruby %~dp0\saf_user.rb %*
)