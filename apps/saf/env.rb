# encoding: utf-8
# $Id: env.rb 122 2016-04-12 21:29:26Z e0c2425 $
require 'cucumber/formatter/unicode'
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'

# When invoking cucumber you will need to specify the cucumber profile
# to use for your project within cucumber.yml if any.

# For example, to execute all SAF tests using env_variables.yml
# directive 'test'
#   cucumber -p SAF SAF_ENV=test
# To execute tests with specific tags:
#   cucumber -p SAF_debug -t @YAML

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
  Capybara.default_selector = :css
  Capybara.default_max_wait_time = 5     # set a default wait time
  Capybara.run_server = false            # Whether to start server
  # Ignore hidden elements, helps testing hide/show elements use javascript
  Capybara.ignore_hidden_elements = true

  # save_screenshot 'example_save_screenshot.png'
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

World(Capybara)
