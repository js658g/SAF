# $Id: passwords_steps.rb 340 2016-05-06 14:35:38Z e0c2506 $
Given(/^the passwords file has our test users$/) do
  passwords_creator = Utilities::Passwords::Creator.new
  
  passwords_creator.add_user(username: "saf_test_user",
                             password: "test_user_global",
                             override: true)
  passwords_creator.add_user(username: "saf_test_user",
                             password: "test_user_environment",
                             environment: "test_environment", override: true)
  passwords_creator.add_user(username: "saf_test_user_2",
                             password: "test_user_2",
                             environment: "test_environment", override: true)
end

When(/^I get the password for "([^"]*)"$/) do |user|
  @password = Utilities::Passwords.for(user)
end

Then(/^the password is "([^"]*)"$/) do |password|
  expect(@password).to eq(password)
end

When(/^I get the password for "([^"]*)" in "([^"]*)"$/) do |user, environment|
  @password = Utilities::Passwords.for(user, in_env: environment)
end

Then(/^the error explains that I have an invalid user$/) do
  expect(@error.message).to match(/invalid user/i)
end

Given(/^I get an error When (.*)$/) do |other_step|
  SAF.negative_test
  @error = nil
  begin
    step other_step
  rescue Exception => e
    @error = e
  end
  expect(@error).not_to be_nil
end

Then(/^the error explains that I have an invalid environment, but a valid user$/) do
  expect(@error.message).to match(/user \w+ exists/i)
  expect(@error.message).to match(/does not have a registered password for environment/)
end

Then(/^the error explains that I have no default password, but a valid user$/) do
  expect(@error.message).to match(/user \w+ exists/i)
  expect(@error.message).to match(/does not have a default password/)
end

Then(/^it is the same password as for "([^"]*)"$/) do |user|
  new_password = Utilities::Passwords.for(user)
  expect(new_password).to eq(@password)
end