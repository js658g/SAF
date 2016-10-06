require_relative "result_codes"
module Errors
  class WrapperError < RuntimeError
    attr_reader :error
    
    def init(msg_or_error)
      if msg_or_error.is_a?(Exception) then
        @error = msg_or_error
        msg = @error.message
      else
        msg = msg_or_error
      end
      
      super(msg)
    end
  end
end