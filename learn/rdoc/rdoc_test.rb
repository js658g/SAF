# $Id: rdoc_test.rb 95 2016-04-06 20:35:25Z e0c2506 $
require_relative "another_rdoc.rb"

##
# We're going to be testing out RDoc today...
# Also see AnotherRDoc
class RDocTest
  # -----------------------------------------------------------
  # :section: Not Amazing
  # This is not an amazing section with un-amazing thing. Lame.
  # -----------------------------------------------------------
  
  ##
  # This is our initialize method. Apparently I can't link to RDocTest::new or RDocTest#initialize.
  def initialize(options)
  end
  
  ##
  # This little bugger doesn't do much.
  # You can call it like so
  #
  #   my_rdoc_test.run_something { |rdoc_test| assert_equal(my_rdoc_test, rdoc_test) }
  #
  # :yields: rdoc_test
  def run_something(&block)
    yield self
  end
  
  # -----------------------------------------------------------
  # :section: Amazing
  # This is an amazing section with amazing things. Wow.
  # -----------------------------------------------------------
  
  ##
  # This will tell you if you're right or not about the best character.
  # Values that return true are
  # [Bismarck] A personification of the Bismarck battleship from Kantai Collection.
  # [IA] A vocaloid.
  def best_character_is(my_character)
    return my_character =~ /\ABismarck|IA\Z/i
  end
  
  ##
  # This will utilize AnotherRDoc and its AnotherRDoc#rdoc_this method.
  # :category: Not Amazing
  def more_rdoc
    AnotherRDoc.rdoc_this("dude")
  end
end
