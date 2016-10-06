# $Id: string_test2.rb 95 2016-04-06 20:35:25Z e0c2506 $
require 'test/unit'

##
# Testing a string!
class StringTest < Test::Unit::TestCase
  def test_expression_substitution
    assert_equal("", "Hello! " * 3)
  end
end

# Now, let's run the test, by typing the following at command prompt
# > ruby string_test2.rb

# Hmm... We're asserting that the result of the expression passed as the
# second parameter will equal an empty string. We may not be sure what the
# expression will do, but we're pretty sure it will evaluate to a non-empty
# string. So why use "" as the expected value?
