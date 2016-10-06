REM $Id: jgemuninstalleverything.bat 90 2016-04-06 20:15:33Z e0c2506 $
jruby -e "`jgem list`.split(/$/).each { |line| puts `jgem uninstall -Iax #{line.split(' ')[0]} --force` unless line.strip.empty? }"
