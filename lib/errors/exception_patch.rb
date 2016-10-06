require_relative "result_codes"
class Exception
  # Default errors to Unresolved.
  include Errors::ResultCodes::Unresolved
end