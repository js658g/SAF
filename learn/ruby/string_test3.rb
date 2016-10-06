# $Id: string_test3.rb 95 2016-04-06 20:35:25Z e0c2506 $
require 'test/unit'

##
# Testing a string again!
class StringTest < Test::Unit::TestCase
  def test_expression_substitution
    assert_equal("Hello! Hello! Hello! ", "Hello! " * 3)
  end
end

# Now, let's run the test, by typing the following at command prompt
# > ruby string_test3.rb

# Wait just a minute! What did we just do? We ran a test, knowing it would
# fail, and then we picked out the answer from the error and plugged it into
# the test so that it now passes. You wouldn't dare try this with code you
# were really testing!

# We have no idea if Ruby did what it should have done: we just know what it
# did. That is, we used the language as a tool to explore itself. In the same
# way that a test is better than a specification, the language is better than
# a description of the language. The test is definitive when we ask Ruby what
# the answer to 'Hello! ' * 3 is, we're going to the horse's mouth. It doesn't
# matter what the documentation says - what we're testing is what actually
# happens. And that's learning. So the test is both a learning test and a
# regression test.
