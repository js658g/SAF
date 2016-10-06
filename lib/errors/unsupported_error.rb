require_relative "result_codes"
module Errors
  class UnsupportedError < WrapperError
    include ResultCodes::Unsupported
  end
end