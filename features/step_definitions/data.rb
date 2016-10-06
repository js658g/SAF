# encoding: utf-8
# $Id: data.rb 349 2016-05-09 04:50:54Z e0c2425 $

Then(/^(?:I|user) search for data from ([^"]*) with key ([^"]*)$/) \
do |file_name, yml_key|
  Yml.yml_read_project_file_data_with_key(file_name, yml_key)
end

Given(/^I have test data in an excel file ([^"]*)$/) do |file_name|
  Excel.new.read_excel_file(file_name)
end

Then(/^yml file should be generated$/) do
  puts "Calling check yml files"
  Excel.new.check_yml_files
  puts "YML file generated..."
end

When(/^There is no excel file$/) do
  Excel.new.read_excel_file("")
end

Then(/^I should get an error file doesn't exist$/) do
  puts "----Then file doesn't exist----"
end

Then(/^([^"]*) must be in results from ([^"]*) using key ([^"]*)$/) \
do |search_str, file_name, yml_key|
  my_data = Yml.yml_read_project_file_data_with_key(file_name, yml_key)
  my_data.include? search_str
end

Then(/^([^"]*) must not be in results from ([^"]*) using key ([^"]*)$/) \
do |search_str, file_name, yml_key|
  my_data = Yml.yml_read_project_file_data_with_key(file_name, yml_key)
  !my_data.include? search_str
end
