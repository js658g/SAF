# encoding: utf-8
# $Id: hooks.rb 414 2016-05-21 21:23:00Z e0c2425 $
require 'rubygems'
require 'java'
require 'cucumber/formatter/unicode'
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'date'
require 'logger'
require 'pathname'

# Log for debugging temporarily until log4r is ready
#   set up screenshots
class MyLog
  def self.log
    if @logger.nil?
      log_file                = File.join(SAF::LOG, "saf_log.txt")
      @logger                 = Logger.new log_file
      @logger.level           = Logger::DEBUG
      @logger.datetime_format = '%Y%m%d %H:%M:%S'
    end
    @logger
  end
end