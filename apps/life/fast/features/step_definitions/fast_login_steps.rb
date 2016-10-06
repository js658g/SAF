# encoding: utf-8
# $Id: fast_login.rb 349 2016-05-09 04:50:54Z e0c2425 $

Then(/^visiting environment ([^"]*)$/) do |env_id|
  @my_app_env_id = env_id
  @my_fast_app_env = SAF.aut_host(@my_app_env_id).to_s
  # set Capybara app host to env_id's URL
  Capybara.app_host = @my_fast_app_env
  # New up a page object for different FAST environments because
  #   they have different login page elements.
  case @my_app_env_id
  when 'dev1', 'dev2'
    @login = visit_page('Login')
  else
    @login = visit_page('LoginFBL')
  end
  @login.loaded? # wait for page to finish loading
end

Then(/^([^"]*) credentials entered are valid on login page$/) do |user_id|
  password = Utilities::Passwords.for(user_id, in_env: @my_app_env_id)
  @login.login_with(user_id, password)
  @fast8x = on_page('Fast8x')
  @fast8x.loaded? # wait for page to finish loading
  @fast8x.when_loaded do
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until @fast8x.evaluate_script('jQuery.active').zero?
    end
  end
  @home = on_page('Home')
  @home.loaded? # wait for page to finish loading, URL
  Timeout.timeout(Capybara.default_max_wait_time) do
    loop until @home.evaluate_script('jQuery.active').zero?
  end
  @home.when_loaded do
    expect(@home).to have_tasksInQueue
  end
end

Then(/^home page has environment specific title!$/) do
  case @my_app_env_id
    when 'dev1', 'dev2'
      expected_title = 'Home'
    else
      expected_title = 'Home'
  end
  expect(@home.title).to include(expected_title)
end

Then(/^page shall contain title ([^"]*)$/) do |expected_title|
  expect(@page.title).to include(expected_title)
end
