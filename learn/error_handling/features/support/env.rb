# $Id: env.rb 124 2016-04-13 15:02:41Z e0c2506 $
require "rspec"

$exceptions_thrown = 0

##
# We're overriding the raise method here to count each error as well as throw
# it.
#
# Note that there are a few ways to go about this.
#  1. Overriding the raise method in no scope.
#    This actually overrides the raise method on Kernel, but does not allow you
#    to alias raise, making it impossible for anything to throw exceptions (yes
#    I mean ANYTHING).
#  2. Overriding fail or throw.
#    While this could give us what we wanted locally by requesting that others
#    do not use raise, this will not allow us to log exceptions from other gems
#    or ruby systems.
#  3. Defining an error parent class and logging from there.
#    This has the same issue of not getting messages from other systems unless
#    the programmer specifically catches and rethrows errors. That said, it
#    also raises the issue of making sure that everyone is throwing errors from
#    our parent class, rather than something else.
#  4. Overriding the raise method in a specific scope (ex. PageObject)
#    This is probably the safest option, but it still won't capture Ruby
#    errors. It would also be a pain to maintain as we add more and more gems.
#
# Now that I've talked about all the other ways to do this... do NOT mess with
# this code! This is EXTREMELY dangerous.
module Kernel
  alias_method :__raise__, :raise

  def raise(*args)
    $exceptions_thrown += 1
    # Log the error here
    __raise__(*args)
  end
end


class SAFError < Exception
  def initialize()
    # Log here
  end
end

class MyError < SAFError
end

raise MyError.new()
fail SAFError

throw "I had a problem"