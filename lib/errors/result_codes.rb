module Errors
  module ResultCodes
    PASS_CODE = 0
    FAIL_CODE = 1
    UNRESOLVED_CODE = 2
    UNSUPPORTED_CODE = 4
    UNTESTED_CODE = 5
    
    RCODES = {
      PASS_CODE => "PASS",
      FAIL_CODE => "FAIL",
      UNRESOLVED_CODE => "UNRESOLVED",
      UNSUPPORTED_CODE => "UNSUPPORTED",
      UNTESTED_CODE => "UNTESTED"
    }
  end
end

require_relative File.join("result_codes", "fail")
require_relative File.join("result_codes", "unresolved")
require_relative File.join("result_codes", "unsupported")
