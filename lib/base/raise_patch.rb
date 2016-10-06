# $Id: raise_patch.rb 419 2016-05-23 14:01:32Z e0c2506 $
require_relative File.join(SAF::LIB, "errors", "exception_patch")

After do |scenario|
  if scenario.failed? then
    SAF.error(message: scenario.exception.message,
              result_code: scenario.exception.result_code)
  elsif scenario.passed? then
    SAF.pass(scenario.name)
  end
end
