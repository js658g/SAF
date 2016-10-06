# encoding: utf-8
# $Id: env.rb 376 2016-05-11 03:24:12Z e0c2425 $
# Load the global constants first.
require_relative File.join(File.dirname(__FILE__), "..", "..", "lib", "saf.rb")

SAF.init(ENV["PROJECT"])
  
require 'rubygems'
require 'java'
require 'cucumber/formatter/unicode'
require 'capybara/cucumber'

### TODO: to get Rakefile to see INSTALL_ENV
# When invoking cucumber you will need to specify the cucumber profile to
# use for your project within cucumber.yml if any. You may also need to specify
# a SAF_ENV environment variable, which determines configuration settings of
# SAF.
#
# For example, to execute all fbfs tests at the command line:
#   cucumber -p FBFS
#
# To execute tests with specific tags:
#   cucumber -p FBFS -t @FBFS_home
#
#   cucumber -p SAF -t @YAML
#
#   cucumber -p FAST -t @FAST_login SAF_ENV=test

Yml = Base::Yml.new

World(Capybara, SAFWorld)
