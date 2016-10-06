# encoding: utf-8
# $Id: fast_agents.rb 275 2016-05-01 21:03:32Z e0c2425 $
require 'capybara'
require 'capybara/cucumber'

Then(/^I start a new NB life application$/) do
  @home = on_page('Home')
  @home.loaded? # wait for page to finish loading
  @home.when_loaded do
    @home.main_menu('New NB Life Application')
  end
  @life_app = on_page('NbLifeApplication')
  @life_app.loaded?
  Timeout.timeout(Capybara.default_max_wait_time) do
    loop until @life_app.evaluate_script('jQuery.active').zero?
  end
  @life_app.when_loaded do
    # verify that Application Signed and Dated section has loaded City element
    @life_app.app_sign_city_wait
  end
end

And(/^I enter the application information for ([^"]*)$/) do |application_key|
  yml_file = 'application.yml'
  # get application data from data/yaml directory
  @application_data = Yml.yml_read_project_file_data_with_key(yml_file, application_key)
  puts "DEBUG: #{@application_data}"
  @life_app.fill_application(@application_data)
end

Then(/^I enter the plan information for ([^"]*)$/) do |plan_key|
  yml_file = 'plan.yml'
  # get plan data from data/yaml directory
  @plan_data = Yml.yml_read_project_file_data_with_key(yml_file, plan_key)
  puts "DEBUG: #{@plan_data}"
  @life_app.fill_plan(@plan_data)
end

Then(/^I add agent id ([^"]*)$/) do |agent_key|
  yml_file = 'agent.yml'
  # get application data from data/yaml directory
  @agent_data = Yml.yml_read_project_file_data_with_key(yml_file, agent_key)
  puts "DEBUG: #{@agent_data}"
  @life_app.fill_agent(@agent_data)
end

Then(/ALL agent info displays correctly/) do
  # TODO: should we wait here and check that it came back with one row or in siteprism page?
  Timeout.timeout(Capybara.default_max_wait_time) do
    loop until @life_app.evaluate_script('jQuery.active').zero?
  end
end
