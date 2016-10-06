# encoding: UTF-8
# # $Id: 02_step_definitions.rb 267 2016-05-01 01:28:54Z e0c2425 $
#-------------------------------------------------------------#
# Let's review the implementation: In ruby, an identifier that
# begins with @ is an instance variable. You do not need to
# declare them up front, if you assign a value to it at
# runtime, the instance variable is defined on the fly. That's
# why @cucumber below is visible in all steps and can be used
# to keep some state across step boundaries. The expressions
# enclosed in curly braces are hashes (aka dictionaries or
# associative arrays, think java.util.Map if you're coming from
# the JVM) and the identifiers beginning with a colon are the
# keys (the colon makes them a symbol, but you don't need to
# worry about that for now).
#
# Also, we need to call the method to_i in two places because
# the argument that comes from the regex-match is always a
# string. We could get rid of this nuisance by using a step
# argument transformer if we wanted, see
# https://github.com/cucumber/cucumber/wiki/Step-Argument-Transforms.
#-------------------------------------------------------------#

Given(/^a cucumber that is (\d+) cm long$/) do |length|
  @cucumber = { color: 'green', length: length.to_i }
end

When(/^I (?:cut|chop) (?:it|the cucumber) in (?:halves|half|two)$/) do
  @chopped_cucumbers = [
    { color: @cucumber[:color], length: @cucumber[:length] / 2 },
    { color: @cucumber[:color], length: @cucumber[:length] / 2 }
  ]
end

#-------------------------------------------------------------#
# The following expressions require a bit of explanation:
#   expect(@choppedCucumbers.length).to eq(2)
# and
#   expect(cuke[:length]).to eq(length.to_i)
#
# They are using the RSpec module Spec::Expectations.
# In features/support/env.rb we have the line require
# 'rspec/expectations', thus we have the module at our disposal
# in all our step files. This expectations module gives us
# the ability to express what we expect on any object by adding
# methods to all objects (by monkey patching). We are using
# object expectations here, which provides methods like
# expect(object).to eq(something) and more, which are nothing
# more than syntactic sugar for saying that you expect one
# value to equal another value. Therefore, because the methods
# have been added to all objects and also because in Ruby
# everything is an object - even a numeric value like the
# length of an array - we can call the method to check that
# the length of the array @choppedCucumbers is the length we
# expect it to be.
#-------------------------------------------------------------#

Then(/^I have two cucumbers$/) do
  expect(@chopped_cucumbers.length).to eq(2)
end

Then(/^both are (\d+) cm long$/) do |length|
  @chopped_cucumbers.each do |cuke|
    expect(cuke[:length]).to eq(length.to_i)
  end
end

#-------------------------------------------------------------#
# The visit and fill_in methods are from Capybara
# Capybara calls itself an "acceptance test framework for web
# applications". Wait. Isn't Cucumber already an acceptance
# test framework? Why do we need another? First, Cucumber is
# all about Behaviour Driven Development and not per se an
# acceptance test framework. You can work with Cucumber on
# the unit test level, or on the acceptance test level or
# anywhere in between. Second, Cucumber knows nothing about
# web applications. Cucumber only gives you the ability to
# write your tests (or specs or scenarios, whatever you call
# them) in a very readable, non-technical form (Gherkin) and
# to execute them. Capybara now integrates nicely with Cucumber
# (see Using Capybara with Cucumber in the Capybara docs at
# https://github.com/jnicklas/capybara#using-capybara-with-cucumber)
# and hides the details of controlling a browser (via
# Selenium or Poltergeist) behind a nice API. It is just the
# right level of abstraction to make writing web application
# tests fun. Of course you could use something like Selenium
# directly in your Cucumber step definitions, but it is too
# low-level and too verbose.
#-------------------------------------------------------------#

Given(/^I am on the Google homepage$/) do
  visit 'http://www.google.com'
end

#-------------------------------------------------------------#
# The fill_in line uses Capybara's API to type a value into
# the text box
#-------------------------------------------------------------#
When(/^I search for "([^"]*)"$/) do |search_text|
  fill_in 'q', with: search_text
  click_button('Search')
end

#-------------------------------------------------------------#
# The Then step uses Capybara's page object (a representation
# of the current page, that is, the current DOM as presented to
# the browser) to verify that three pieces of text are there.
#-------------------------------------------------------------#

Then(/^I should see "([^"]*)"$/) do |expected_text|
  expect(page).to have_content(expected_text)
end
