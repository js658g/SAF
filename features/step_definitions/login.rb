# encoding: utf-8
# $Id: login.rb 275 2016-05-01 21:03:32Z e0c2425 $

Then(/^visiting link ([^"]*)$/) do |link|
  visit(link)
end
