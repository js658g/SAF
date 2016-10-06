REM $Id: gemuninstalleverything.bat 90 2016-04-06 20:15:33Z e0c2506 $
ruby -e "`gem list`.split(/$/).each { |line| puts `gem uninstall -Iax #{line.split(' ')[0]} --force` unless line.strip.empty? }" 
