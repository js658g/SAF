# encoding: utf-8
# $Id: env.rb 122 2016-04-12 21:29:26Z e0c2425 $
require 'cucumber/formatter/unicode'
require 'capybara'
require 'capybara/cucumber'
require 'site_prism'
require 'selenium-webdriver'

# When invoking cucumber you will need to specify the cucumber profile to
# use for your project within cucumber.yml if any. For example, to execute all
# fast project tests - use cucumber profile labeled FAST and env_variables.yml
# configuration directive labeled test
#   cucumber -p FAST SAF_ENV=test
# To execute tests with specific tags:
#   cucumber -p FAST -t @FAST_login SAF_ENV=test

SitePrism.configure do |config|
  config.use_implicit_waits = true
end

# remote machine on network being used
remote_host = SAF.test_slave_host
# port to use with remote_host
remote_port = SAF.test_slave_port

# valid browser values: ie, internet_explorer, ie_rwin, chrome, chrome_rwin,
#   firefox, ff, ff_rwin, android, iphone, opera
# TODO: android, iphone, and opera needs to be tested
in_browser = SAF.in_browser
browser = SAF.browser

if in_browser != 'false' # test browser on screen, not headless
  # [default_max_wait_time = Numeric] # The maximum number of seconds to wait
  # for asynchronous processes to finish (Default: 2)
  Capybara.default_max_wait_time = 30
  Capybara.default_driver = :selenium
  Capybara.ignore_hidden_elements = false

  # TODO: set default to open browser large enough that FAST logo does not
  # hide MainMenu because it becomes not visible even to Selenium - error
  # was already opened with FAST project test lead, Shahana Bakre
  # see selenium.googlecode.com/svn/trunk/docs/api/rb/Selenium/WebDriver.html
  # rubocop:disable AlignHash
  case browser
  when 'chrome'
    # https://github.com/SeleniumHQ/selenium/wiki/Ruby-Bindings
    # https://src.chromium.org/svn/trunk/src/chrome/common/pref_names.cc
    prefs = { 'download' => { 'default_directory' => 'C:\Downloads',
                              'directory_upgrade' => true,
                              'extensions_to_open' => '' },
              'homepage' => 'http://www.fbfs.com',
              'browser.show_home_button' => true }
    # Browser hangs or the connection between it and the webdriver server gets
    # lost when FAST takes to long to load page (net/http default read_timeout
    # is 60 seconds). This is a stop-gap, let us set the http request to a
    # larger timeout duration in seconds.
    http_response_timeout = 1500
    Capybara.register_driver :selenium do |app|
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.timeout = http_response_timeout
      @session = Capybara::Selenium::Driver.new(app, browser: browser.to_sym,
                                                prefs: prefs,
                                                http_client: client)
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
    # Browser hangs or the connection between it and the webdriver server gets
    # lost when FAST takes to long to load page (net/http default read_timeout
    # is 60 seconds). This is a stop-gap, let us set the http request to a
    # larger timeout duration in seconds.
    http_response_timeout = 600
    Capybara.register_driver :selenium do |app|
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.timeout = http_response_timeout
      @session = Capybara::Selenium::Driver.new(app, browser: browser.to_sym,
                                                http_client: client)
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
    # Capybara.register_driver :selenium do |app|
    #   @session = \
    #     Capybara::Selenium::Driver.new(app,
    #                                    browser: :internet_explorer)
    # end
    http_response_timeout = 1500
    Capybara.register_driver :selenium do |app|
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.timeout = http_response_timeout
      @session = Capybara::Selenium::Driver.new(app, browser: browser.to_sym,
                                                http_client: client)
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
      debug:       true
    )
  end
  Capybara.default_driver    = :poltergeist
  Capybara.javascript_driver = :poltergeist
end

require 'capybara/node/finders'
# This is a monkey patch that will allow us to use the standard Capybara DSL
# with prism_site's page objects. All I'm doing is telling Capybara's find
# method to accept a found element as a parameter and simply return that
# element if it is passed.
module ::Capybara::Node::Finders
  alias_method :find_old, :find
  def find(*args)
    # If we already found something, don't find it again.
    args.each do |arg|
      return arg if arg.is_a? ::Capybara::Node::Element
    end

    find_old(*args)
  end
end

World(Capybara)

Before do |scenario|
  scenario_name = scenario.name
  if scenario.respond_to? :scenario_outline
    scenario_outline_name = scenario.scenario_outline.name
  else
    scenario_outline_name = scenario_name
  end
  scenario_tags = scenario.source_tag_names
  # set scenario_id to first name in scenario_tags if it exists or
  # when multiple tags exist
  if scenario_tags[0].nil? || scenario_tags[0].empty?
    scenario_id = ''
  else
    scenario_id = scenario_tags[0]
    scenario_id = scenario_id.delete('@', '')
  end

  # This regex changes all non alpha numeric characters to _ and all spaces
  # to _
  tmp_name_cleanup = scenario_name.gsub(/[^0-9a-zA-Z]/i, '_')\
                                  .gsub(/^_/, '').gsub(/\s/, '_')\
                                  .gsub(/([_]+)/, '_').gsub(/_$/, '')
  scenario_name = tmp_name_cleanup[0..40]
  tmp_name_cleanup = scenario_outline_name.gsub(/[^0-9a-zA-Z]/i, '_')\
                                          .gsub(/^_/, '').gsub(/\s/, '_')\
                                          .gsub(/([_]+)/, '_').gsub(/_$/, '')
  scenario_outline_name = tmp_name_cleanup[0..40]
  $scenario_name = scenario_name
  $scenario_id = scenario_id
  $scenario_outline_name = scenario_outline_name
end

After do |scenario|
  # If any scenario raises a Timeout::Error, will cause Capybara to forget
  # about the Selenium session and will not try to reset it at the end of
  # every test. If Cucumber runs across another Selenium test, Capybara will
  # fire up a new browser.
  if scenario.exception.is_a? Timeout::Error
    # restart Selenium driver
    Capybara.send(:session_pool).delete_if { |key, _| key =~ /selenium/i }
  end
  if scenario.respond_to? :scenario_outline
    scenario_outline_name = scenario.scenario_outline.name
    tmp_name = scenario_outline_name
  else
    # use first tag name if there is no outline
    scenario_tags = scenario.source_tag_names
    # use first scenario_tags if it exists or when multiple
    if scenario_tags[0] != ''
      scenario_id = scenario_tags[0]
      scenario_id = scenario_id.delete('@', '')
      tmp_name = scenario_id
    else
      tmp_name = scenario_name
    end
  end

  # This regex changes all non alpha numeric characters to _ and all spaces
  # to _ so it can write a file with the scenario name to a Windows OS
  tmp_name_cleanup = tmp_name.gsub(/[^0-9a-zA-Z]/i, '_')\
                             .gsub(/^_/, '').gsub(/\s/, '_')\
                             .gsub(/([_]+)/, '_').gsub(/_$/, '')
  use_this_name = tmp_name_cleanup
  my_dir = File.absolute_path(File.join(File.dirname(__FILE__))).to_s
  ss_dir = my_dir.to_s + '/../screenshots/scenarios'
  cur_time = Time.now.strftime('%Y%m%d_%H%M')
  screen_shot = ss_dir.to_s + '/' + "#{cur_time}_#{use_this_name}.png"
  if SAF.screenshots == 'true'
    save_screenshot(screen_shot)
    puts "Screenshot save in #{screen_shot}"
  end
end

