# encoding: utf-8
# $Id: age_steps.rb 408 2016-05-20 14:29:25Z e0c2425 $

When(/^birth ([^"]*) is given$/) do |birth_date|
  @error = nil
  begin
    @my_age = Base::AgeCalculator.new(birth_date).age_calculate
    puts "Birth Date = #{birth_date}"
  rescue Exception => e
    @error = e
  end
end

Then(/^correct age is returned$/) do
  expect(@my_age).not_to be_nil
  expect(@my_age).to be_between(0, 120)
  puts "Age = #{@my_age}"
end

Then(/^an error is returned for age$/) do
  SAF.negative_test
  expect(@error.message).to match(/Invalid date/i)
  puts "Expected error message received was #{@error.message}"
end
