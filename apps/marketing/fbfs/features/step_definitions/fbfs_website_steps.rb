# encoding: utf-8
# $Id: fbfs_website_steps.rb 349 2016-05-09 04:50:54Z e0c2425 $

Then(/^visiting environment ([^"]*)$/) do |env_id|
  @my_app_env_id    = env_id
  @my_fbfs_app_env  = SAF.aut_host(@my_app_env_id)
  # set Capybara app host to env_id's URL
  Capybara.app_host = @my_fbfs_app_env.to_s
  @home = visit_page('Home')
end

Then(/^new page ([^"]*) shall contain title ([^"]*)$/) \
do |landing_page, expected_title|
  @new_page = on_page(landing_page)
  expect(page.title).to include(expected_title)
end

Then(/^visiting ([^"]*) environment's relative link ([^"]*)$/) \
do |env_id, relative_url|
  @my_app_env_id    = env_id
  @my_fbfs_app_env  = SAF.aut_host(@my_app_env_id)
  # set Capybara app host to env_id's URL
  Capybara.app_host = @my_fbfs_app_env.to_s
  @home = visit_page('Home')
  if page.driver.browser.window_handles.length != 1
    accept_prompt(with: 'satisfaction survey') do
      click_link('No, thanks')
    end
  end
  full_url = "#{@my_fbfs_app_env}/#{relative_url}"
  visit(full_url)
end

Then(/^"([^"]*)" shall be displayed$/) do |expected_text|
  if page.driver.browser.window_handles.length != 1
    accept_prompt(with: 'satisfaction survey') do
      click_link('No, thanks')
    end
  end
  expect(page.text).to include(expected_text)
end

Then(/^SEARCH RESULTS FOR "([^"]*)" shall be displayed$/) do |expected_text|
  if page.driver.browser.window_handles.length != 1
    # <div class="fsrDeclineButtonContainer"><a tabindex="1"
    # class="fsrDeclineButton" href="javascript:void(0)">
    # No, thanks</a></div>
    accept_prompt(with: 'satisfaction survey') do
      click_link('No, thanks')
    end
    # <div class="fsrAcceptButtonContainer"><a tabindex="2"
    # class="fsrAcceptButton" href="javascript:void(0)">
    # Yes, I'll give feedback</a><span class="hidden-accessible">&nbsp;
    # (this will launch a new window)</span></div>
  end
  expect(page.text).to include(expected_text)
end

Then(/^agent name search results appears$/) do
  page.has_selector?(:css, 'div.mainContainer_C002_pnlAgents')
end
