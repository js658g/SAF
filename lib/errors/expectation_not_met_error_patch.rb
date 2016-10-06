require_relative "result_codes"

module RSpec
  module Expectations
    class ExpectationNotMetError < Exception
      include Errors::ResultCodes::Fail
    end
  end
end