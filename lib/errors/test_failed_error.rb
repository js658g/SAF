require_relative "result_codes"
module Errors
  class TestFailedError < WrapperError
    include ResultCodes::Fail
  end
end