module SAFSubmodules
  ##
  # Basic test reporting methods. Only necessary when not using cucumber.
  module TestReporter
    def pass(msg = "A test passed")
      data = msg.is_a?(Hash) ? msg : { message: msg }
      data[:result_code] = Errors::ResultCodes::PASS_CODE
      SAF.info(data)
    end

    def xpass
      SAF.negative_test
      pass
    end

    def fail(msg = "A test failed.")
      raise Errors::TestFailedError.new(msg)
    end

    def xfail(msg = "A negative test failed.")
      SAF.negative_test
      raise Errors::TestFailedError.new(msg)
    end

    def unresolved(msg = "A test went unresolved.")
      raise Errors::UnresolvedError.new(msg)
    end

    def unsupported(msg = "A test was unsupported.")
      raise Errors::UnsupportedError.new(msg)
    end

    def untested(msg = "A test passed")
      data = msg.is_a?(Hash) ? msg : { message: msg }
      data[:result_code] = Errors::ResultCodes::UNTESTED_CODE
      SAF.warn(data)
      pending
    end
  end
end
