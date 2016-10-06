# $Id: string_test.rb 95 2016-04-06 20:35:25Z e0c2506 $
# A Ruby class! The require statement loads the Test::Unit module: Ruby's
# built-in unit testing framework.
require 'test/unit'

# declares a class called StringTest
# The < symbol on the class declaration line means that StringTest is a
# subclass of Test::Unit::TestCase. Classes that are test cases must extend
# Test::Unit::TestCase to enjoy the set of computer-checked assertion
# methods that are used later.
class StringTest < Test::Unit::TestCase
  # The StringTest class has one method: test_length. Test methods take no
  # parameters and they must be named with a "test" prefix so that Test::Unit
  # knows that they're tests we want to run.
  def test_length
    # create a variable called s that references an object of class String.
    # We don't have to declare the type of the variable because Ruby figures
    # out its type based on what the variable can do.
    s = "Hello, World!"
    # We then call the assert_equal method (inherited from TestCase) with two
    # parameters. What we're saying here is we expect the length of the string
    # s to be 13.
    assert_equal(13, s.length)
    # Then the method definition ends with the end keyword
  end

  # Then the class definition ends with the end keyword
end

# Now, let's run the test, by typing the following at command prompt
# > ruby string_test.rb
