# encoding: UTF-8
# $Id: env.rb 135 2016-04-19 16:13:08Z e0c2506 $

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

require 'rspec'
require 'rspec/expectations'
require 'capybara'
require 'capybara/rspec'
require 'capybara/dsl'
require 'capybara/cucumber'
#require 'capybara/poltergeist'
require 'site_prism'

# Enables caching in the site prism page object. This can speed up tests by
# 15ms per widget hit.
#class ::SitePrism::Page
#  class <<self
#    # This code may need to be updated in future versions of site_prism. It is
#    # copied (then modified) from ::SitePrism::ElementContainer#element
#    def element(element_name, *find_args)
#      cache = nil
#      build element_name, *find_args do
#        define_method element_name.to_s do |*runtime_args, &element_block|
#          self.class.raise_if_block(self,
#                                    element_name.to_s,
#                                    !element_block.nil?)
#          return cache unless cache.nil?
#          cache = find_first(*find_args, *runtime_args)
#        end
#      end
#    end
#  end
#end

RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.configure do |config|
  config.run_server = false
  config.app_host = "http://www.wikipedia.org"
  # override default Firefox browser with Chrome
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :remote, 
                   :url => "http://showinpoc01.fbfs.com:4444/wd/hub",
                                         :desired_capabilities => :chrome)
  end
  Capybara.default_driver = :selenium
  #Capybara.javascript_driver = :poltergeist
  Capybara.server_port = 9887 + ENV['TEST_ENV_NUMBER'].to_i
end

SitePrism.configure do |config|
  config.use_implicit_waits = true
end
