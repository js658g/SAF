# encoding: utf-8
# $Id: page.rb 349 2016-05-09 04:50:54Z e0c2425 $

Then(/^title shall contain ([^"]*)$/) do |expected_title|
  expect(page.title).to include(expected_title)
end

Then(/^(?:|I )am on (.+)$/) do |page_name|
  visit(page_name)
end


