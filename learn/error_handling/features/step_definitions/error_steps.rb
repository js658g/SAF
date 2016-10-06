# encoding: utf-8
# $Id: error_steps.rb 121 2016-04-12 17:56:49Z e0c2506 $
Given /^I fail$/ do
  fail "Wow this didn't work."
end

Given /^I raise an error$/ do
  raise "Wow this didn't work."
end

Given /^I throw an error$/ do
  throw "Wow this didn't work"
end

Given /^the KERNEL is raising an error$/ do
  Kernel.raise "Please please throw the exception..."
end

Then /^I call a non-method$/ do
  this_isnt_a_method_i_hope
end

Then /^I do something stupid$/ do
  a = 1 / 0
end

Then /^an assertion fails$/ do
  expect(1 + 1).to eq(4)
end

Then /^the system exits... wait do I want to do that?$/ do
  exit
end

When /^(.*) (?:and )?the exception count increase[ds]$/ do |step_call|
  current = $exceptions_thrown

  exception = false
  begin
    step step_call
  rescue
    exception = true
  end

  expect(exception).to eq(true)
  expect($exceptions_thrown).to eq(current + 1)
end
