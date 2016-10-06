# $Id: another_rdoc.rb 95 2016-04-06 20:35:25Z e0c2506 $

##
# This is more rdoc.
# Used in RDocTest#more_rdoc.
class AnotherRDoc
  ##
  # Just tell me something stup-- I mean amazing and I'll rdoc it for you.
  #
  # {Speaking of amazing...}[rdoc-ref:RDocTest@Amazing]
  # :args: something_amazing
  def rdoc_this(something_stupid)
    puts "##\n# Wow this is stupid.\n#{something_stupid}"
  end
end
