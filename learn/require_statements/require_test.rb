# $Id: require_test.rb 95 2016-04-06 20:35:25Z e0c2506 $
# This is a simple demonstration and test that no matter how many times you
# call "require" or "require_relative", a file will only be loaded once.

# Adds the current directory to Ruby's load path (don't do this unless you're
# making a gem)
$LOAD_PATH.unshift(File.dirname(__FILE__))

require_relative "to_require"
require_relative "to_require.rb"
require "to_require"
require "to_require.rb"
require_relative "../require_statements/to_require"
require_relative "../require_statements/to_require.rb"

# Using a global var as a dirty dirty hack. Don't do that.
puts "File loaded #{$require_var} times."
