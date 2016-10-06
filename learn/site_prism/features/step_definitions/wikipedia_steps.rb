require_relative '../../wikipedia.rb'

When /^I search for the Wikipedia page "([^"]+)"$/ do |page|
  # First we need to new up a page object
  home = Wikipedia.new
  # The load method opens a browser and navigates to that page.
  home.load
  # You'll notice you can just use Capybara's DSL for testing.
  fill_in home.searchbar, with: page
  # You can access any element on the page with Page#element_name
  home.searchbutton.click

  entry = WikipediaEntry.new
  # Just making sure the URL matches
  expect(entry).to be_displayed(page: page)
end

And /^the article includes "([^"]*)"$/ do |text|
  entry = WikipediaEntry.new
  expect(entry.body).to have_text(text)
end

And /^the article has a search bar$/ do
  entry = WikipediaEntry.new
  expect(entry).to have_searchbar
end

And /^the Wikipedia does not have crazy stuff$/ do
  home = Wikipedia.new
  expect(home).to have_no_crazystuff
end

When /^I open (\w+)$/ do |page|
  klass = Object.const_get(page)
  @page = klass.new
  @page.load
end

When /^I am on (\w+)$/ do |page|
  klass = Object.const_get(page)
  @page = klass.new
  expect(@page).to be_displayed
end

Then /^I enter "(\w+)" to "(\w+)"$/ do |text, field_name|
  widget = @page.send field_name
  fill_in widget, with: text
end

Then /^I click "(\w+)"$/ do |field_name|
  widget = @page.send field_name
  widget.click
end

Then /^"([^"]+)" has text "([^"]+)"$/ do |field_name, text|
  widget = @page.send field_name
  expect(widget).to have_text(text)
end

When /I pry/ do
  require 'pry'
  binding.pry
end
