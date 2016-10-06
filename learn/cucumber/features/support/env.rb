# $Id: env.rb 122 2016-04-12 21:29:26Z e0c2425 $
require 'cucumber/formatter/unicode'
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'

# Before starting cucumber, you must set CUKE_ENV (to location of your
# environment configuration file), CUKE_FEATURE (to your features directory of
# your project), and the tag associated with your project, before starting
# cucumber tests. The execution of a profile simply requires the use of the
# flag --profile or -p . During execution you can also specify additional
# parameters alongside the profile. Examples:
#
# To execute all FAST tests at the command line, for example:
#       set CUKE_ENV=config/environments/env_saf.rb
#       set CUKE_FEATURE=features/saf/features
#       cucumber -p saf
#       cucumber -p saf --tags @YAML
#
# There are also other environment variables you can set such as
#   set HOST=https://www.google.com/search?q=unicorn # site you are testing
#   set BROWSER=ie    # valid values are ie, internet_explorer, ie_rwin,
#                     # chrome, chrome_rwin, firefox, ff, ff_rwin, android,
#                     # iphone, opera
#                     # TODO: android, iphone, and opera needs to be tested,
#                     # only firing on selenium driver in env.rb
#   set REMOTE_HOST='showinpoc01.fbfs.com' # remote machine on network being
#                                          # used with *_rwin browser
#   set REMOTE_PORT='4444' # port to use on REMOTE_HOST
#   set IN_BROWSER=false  # to test headless browser, by default is true

# website you're testing
app_host = ENV['HOST'] || 'https://www.google.com/search?q=unicorn'
# remote machine on network being used
remote_host = ENV['REMOTE_HOST'] || 'showinpoc01.fbfs.com'
# port to use with remote_host
remote_port = ENV['REMOTE_PORT'] || '4444'

# valid browser values: ie, internet_explorer, ie_rwin, chrome, chrome_rwin,
# firefox, ff, ff_rwin, android, iphone, opera
# TODO: android, iphone, and opera needs to be tested, only firing
# TODO: on driver in env.rb case statement
test_in_browser = ENV['IN_BROWSER'] || true
browser = ENV['BROWSER'] || 'firefox'

# DEBUG: print important environment variables
puts "#{__FILE__} app_host=#{app_host}"
puts "#{__FILE__} test_in_browser=#{test_in_browser}"
puts "#{__FILE__} browser=#{browser}"

Capybara.app_host = app_host

if test_in_browser                       # test browser on screen, not headless
  Capybara.default_selector = :css
  Capybara.default_max_wait_time = 600   # set a default wait time
  Capybara.run_server = false            # Whether to start server
  # Ignore hidden elements, helps testing hide/show elements use javascript
  Capybara.ignore_hidden_elements = true

  Capybara.default_driver = :selenium
  # http://selenium.googlecode.com/svn/trunk/docs/api/rb/Selenium/WebDriver.html
  # rubocop:disable AlignHash
  case browser
  when 'chrome'
    # https://github.com/SeleniumHQ/selenium/wiki/Ruby-Bindings
    # https://src.chromium.org/svn/trunk/src/chrome/common/pref_names.cc
    prefs = { 'download' => { 'default_directory' => 'C:\Downloads',
                              'directory_upgrade' => true,
                              'extensions_to_open' => '' },
              'homepage' => 'http://www.fbfs.com',
              'homepage_is_newtabpage' => true,
              'browser.show_home_button' => true }

    Capybara.register_driver :selenium do |app|
      @session = \
      Capybara::Selenium::Driver.new(app, browser: browser.to_sym,
                                     prefs: prefs,
                                     detach: :unspecified)
    end
  when 'chrome_rwin'
    prefs = { download: { prompt_for_download: false,
                          default_directory: 'C:\Downloads',
                          directory_upgrade: true,
                          extensions_to_open: '' },
              homepage: 'http://www.fbfs.com',
              homepage_is_newtabpage: true,
              show_home_button: true }
    Capybara.register_driver :selenium do |app|
      @session = \
      Capybara::Selenium::Driver.new(app, browser: :remote,
                                 url: "#{remote_host}:#{remote_port}/wd/hub",
                                 prefs: prefs,
                                 desired_capabilities: chrome)
    end
  when 'firefox', 'ff'
    prefs = { 'extensions.update.enabled' => false,
              'browser.download.dir' => 'C:\Downloads',
              'browser.helperApps.neverAsk.saveToDisk' => 'application/pdf',
              'pdfjs.disabled' => true
    }
    Capybara.register_driver :firefox do |app|
      @session = \
      Capybara::Selenium::Driver.new(app, browser: browser.to_sym,
                                     prefs: prefs,
                                     detach: :unspecified)
    end
  when 'ff_rwin'
    prefs = { 'extensions.update.enabled' => false,
              'browser.download.dir' => 'C:\Downloads',
              'browser.helperApps.neverAsk.saveToDisk' => 'application/pdf',
              'pdfjs.disabled' => true
    }
    Capybara.register_driver :firefox do |app|
      @session = \
      Capybara::Selenium::Driver.new(app, browser: :remote,
                                 url: "#{remote_host}:#{remote_port}/wd/hub",
                                 prefs: prefs,
                                 desired_capabilities: :firefox)
    end
  when 'ie', 'internet_explorer'
    Capybara.register_driver :selenium do |app|
      @session = \
      Capybara::Selenium::Driver.new(app,
                                     browser: :internet_explorer)
    end
  when 'ie_rwin'
    Capybara.register_driver :selenium do |app|
      @session = \
      Capybara::Selenium::Driver.new(app, browser: :remote,
                                     url: "#{remote_host}:#{remote_port}/wd/hub")
    end
  else
    Capybara.register_driver :selenium do |app|
      @session = \
      Capybara::Selenium::Driver.new(app, detach: :unspecified)
    end
  end
  # rubocop:enable AlignHash
else
  # TODO: headless tests with poltergeist/PhantomJS
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(
        app,
        window_size: [1280, 1024],
        debug: true
    )
  end
  Capybara.default_driver = :poltergeist
  Capybara.javascript_driver = :poltergeist
end

puts "#{__FILE__} Capybara.default_host=#{Capybara.default_host}"
puts "#{__FILE__} Capybara.app_host=#{Capybara.app_host}"
puts "#{__FILE__} Capybara.server_host=#{Capybara.server_host}"
puts "#{__FILE__} Capybara.server_port=#{Capybara.server_port}"
puts "#{__FILE__} Capybara.server_name=#{Capybara.session_name}"

# save_screenshot 'example_save_screenshot.png'

World(Capybara)

# require 'capybara-screenshot/cucumber'
# # requiring capybara-screenshot/cucumber is returning this error
# # C:/jruby-1.7.24/lib/ruby/shared/mkmf.rb:14: Use RbConfig instead of obsolete and deprecated Config.
# #     mkmf.rb can't find header files for ruby at C:/jruby-1.7.24/lib/native/include/ruby/ruby.h

#Capybara.save_and_open_page_path = "#{File.dirname(__FILE__)}/../../screenshots/failures"
#Capybara::Screenshot.prune_strategy = :keep_last_run
#
#Capybara::Screenshot.register_filename_prefix_formatter(:cucumber) do |scenario|
#  scenario_outline_name = ''
#  res = scenario.scenario_outline.name.nil? rescue true
#  unless res
#    scenario_outline_name = scenario.scenario_outline.name
#  end
#
#  scenario_tags = scenario.source_tag_names
#  if scenario_tags[0].nil? || scenario_tags[0].empty?
#    scenario_id = ''
#  else
#    scenario_id = scenario_tags[0] # first name in tags if it exists
#  end
#  if scenario_outline_name.empty?
#    if scenario_id.empty?
#      tmp_name = 'e_ol_id'
#    else
#      tmp_name = scenario_id
#    end
#  else
#    tmp_name = scenario_outline_name
#  end
# tmp_name_cleanup=tmp_name.gsub(/[^0-9a-zA-Z]/i, '_').gsub(/^_/, '').gsub(/\s/, '_').gsub(/([_]+)/, '_').gsub(/_$/, '')
# use_this_name = tmp_name_cleanup[0..39]
# use_this_name = tmp_name_cleanup
#end


#Capybara.save_and_open_page_path = "#{File.dirname(__FILE__)}/../../screenshots/failures"
##Capybara::Screenshot.prune_strategy = :keep_last_run
#
#Capybara::Screenshot.register_filename_prefix_formatter(:cucumber) do |scenario|
#  scenario_outline_name = ''
#  res = scenario.scenario_outline.name.nil? rescue true
#  unless res
#    scenario_outline_name = scenario.scenario_outline.name
#  end
#
#  scenario_tags = scenario.source_tag_names
#  if scenario_tags[0].nil? || scenario_tags[0].empty?
#    scenario_id = ''
#  else
#    scenario_id = scenario_tags[0] # first name in tags if it exists
#  end
#  if scenario_outline_name.empty?
#    if scenario_id.empty?
#      tmp_name = 'e_ol_id'
#    else
#      tmp_name = scenario_id
#    end
#  else
#    tmp_name = scenario_outline_name
#  end
# tmp_name_cleanup=tmp_name.gsub(/[^0-9a-zA-Z]/i, '_').gsub(/^_/, '').gsub(/\s/, '_').gsub(/([_]+)/, '_').gsub(/_$/, '')
# #use_this_name = tmp_name_cleanup[0..39]
# #use_this_name = tmp_name_cleanup
#end
