require 'rspec'
require 'site_prism'
# Suppose we tried on_page('Dashboard').do_something when we
#   were not on the dashboard. What error message would we get?
#   expected displayed? to return true, got false
#   (RSpec::Expectations::ExpectationNotMetError)
#   ./test_commons/page_objects/helpers.rb:11:in `block in on_page'
# Because SitePrism has a #current_path method to tell us what
#   page we are actually on, and Daniel Chang’s exploration, RSpec
#   Custom Matchers,
#   http://danielchangnyc.github.io/blog/2014/01/15/tdd2-RSpecMatchers/
#   we can write custom matcher to produce a more informative message.
RSpec::Matchers.define :be_displayed do |args|
  match do |actual|
    actual.displayed?(args)
  end

  failure_message_for_should do |actual|
    expected = actual.class.to_s.sub(/PageObjects::/, '')
    expected += " (args: #{args})" if args.count > 0
    "expected to be on page '#{expected}', but was on #{actual.current_path}"
  end
end