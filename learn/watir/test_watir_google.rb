# $Id: test_watir_google.rb 96 2016-04-06 20:35:52Z e0c2506 $
#-------------------------------------------------------------#
# Demo test for the Watir controller.
#
# Purpose: to demonstrate the following Watir functionality:
#   * entering text into a text field,
#   * clicking a button,
#   * checking to see if a page contains text.
# Test will search Google for the "pickaxe" Ruby book.
#
# Here are a few considerations and limitations to using the
# WATIR module for Ruby to test web based applications. The
# initial, most important consideration is that the module is
# limited to testing on the Internet Explorer 5.5 or greater
# platform. The WATIR module is not implemented to work with
# Netscape, Opera, Firefox, or any other type of browser. This
# means that cross browser testing of applications is not
# possible (nor was it the intention of the WATIR designers).
# Whilst Watir supports only Internet Explorer on Windows,
# Watir-WebDriver supports Chrome, Firefox, Internet Explorer,
# Opera and also running in headless mode (HTMLUnit).
# The second, more a limitation than consideration, is that
# there is no recorder for WATIR. Most automated testing tools
# come with a recorder to help produce the bulk of the automated
# test scripts. WATIR is solely a library of common IE Browser
# methods and objects to be used in the manual process of
# handwriting scripts. Another limitation of building automated
# test scripts with WATIR is that there are no external tools,
# no spies or object analyzers to help identify the types of
# objects in a page and the methods available to those objects.
# WATIR does provide methods to dump available links, images,
# URLs, forms, etc. during replay. This means that the scripting
# process becomes a trial by error process, which is not necessarily
# a bad thing.
#-------------------------------------------------------------#

#-------------------------------------------------------------#
# To use Watir, or any other library in our test case,
# requires us to tell the
# program where to find the library.
#-------------------------------------------------------------#
require "watir"

#-------------------------------------------------------------#
# If we are going to use something in our script more than
# once, or something that could change, we can declare it as
# a variable and reuse it throughout the script. Some objects
# we can use for testing tend to change, such as URLs for
# applications we are testing. In this script, we assign the
# test URL as a variable. If it changes, we only have to change
# it in one place. It may not be much of an issue in this test
# case, but using variables is often a good practice.
#-------------------------------------------------------------#
# assign the URL to a variable called test_site
test_site = "http://www.google.com"

#-------------------------------------------------------------#
# Send a message new to the IE (Internet Explorer) class that
# is inside Watir module, and assign it to a variable called
# browser. The browser variable is a local variable (like
# test_site). This means it can be accessed from our script,
# but not from other Ruby functions or methods
#-------------------------------------------------------------#
# open a browser
browser = Watir::Browser.new

#-------------------------------------------------------------#
# puts is a reserved word in the Ruby language that tells the
# Ruby Interpreter to print whatever comes after it contained
# in quotes to the screen. We could just as easily write this
# information to a file. These puts statements are in this
# test case to make it more self-explanatory. You can print
# to the screen as a "friendly message" (e.g. telling the user
# something is loading while they are waiting for results, or
# printing a result as "The answer is 5" instead of just "5")
# or as "flagging" and that is to print to the screen for
# debugging purposes. Printing what we are doing when we
# automate the test case is useful for debugging when
# developing test cases, and for quickly repeating failures
# for bug reports when the test case doesn't pass.
#-------------------------------------------------------------#
# print some comments
puts "Beginning of test: Google search."

#-------------------------------------------------------------#
# uses the Watir method goto to direct the test case to the
# test site: http://www.google.com (stored in the variable
# test_site). When we print out the variable, we concatenate
# it to the string (the part in quotes) by using the + sign.
#-------------------------------------------------------------#
puts " Step 1: go to the test site: " + test_site
browser.goto test_site

#-------------------------------------------------------------#
# enters the text pickaxe in the text field named q. The
# comment telling the user that q is the name of the text
# field is optional.
#
# This is the tag in the HTML source with the name attribute
# we used:
#   <input maxlength=2048 name=q size=55 title=
#   <span class="code-quote">"Google Search" value=""></span>
#
# The text field has a name attribute q, in other words, it is
# the HTML name of the search field, so we use that to tell
# Watir what object to interact with.
#-------------------------------------------------------------#
puts " Step 2: enter 'pickaxe' in the search text field."
browser.text_field(:name, "q").set "pickaxe"

#-------------------------------------------------------------#
# clicks the Google Search button
#
# This is the tag in the HTML source with the name attribute
# we used:
#   <input name=btnG type=submit value=
#   <span class="code-quote">"Google Search"></span>
#-------------------------------------------------------------#
puts " Step 3: click the 'Google Search' button."
browser.button(:name, "btnG").click # "btnG" is the name of the Search button

#-------------------------------------------------------------#
# The first line prints out the Actual Result heading to the
# screen. The second line gets the text of the page and then
# calls the include? method to determine whether Programming
# Ruby appears on the first page.
# Using an if statement, we evaluate whether the include?
# method was true or false.
#   If include? returns true (or actually anything but false),
#   the text Programming Ruby appears. The test case passes
#   and we print the Test Passed. message
#
#   Else, if include? returns false, the text Programming Ruby
#   does not appear. The test case fails and we print the
#   Test Failed! message.
# Then we end the if...else statement with an end statement
#-------------------------------------------------------------#
puts " Expected Result:"
puts "  A Google page with results should be shown."\
     "'pick is a hand tool' should be on the list of text displayed."

puts " Actual Result:"
expected_text = "pick is a hand tool"
# sleep a couple of seconds because google pages have a lot of ajax, taking
# some time to load text
sleep 5
if browser.text.include?(expected_text)
  puts "  Test Passed."
else
  puts "  Test Failed! Could not find: '#{expected_text}'."
end

puts "End of test: Google search."
