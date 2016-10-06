require_relative "result_codes"
module Errors
  class UnresolvedError < WrapperError
    include ResultCodes::Unresolved
  end
end