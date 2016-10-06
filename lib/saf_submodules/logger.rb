require "log4r"
require "fileutils"
require_relative File.join("logger", "saf_stdout_formatter.rb")
require_relative File.join("logger", "json_formatter.rb")
require "tcp_outputter"

module SAFSubmodules
  ##
  # Module for SAF that controls the logging.
  module Logger
    attr_reader :test_path
    attr_accessor :negative

    # Log a debug message.
    def debug(msg)
      prelog
      logger.debug(msg)
    end

    # Log an error message.
    def error(msg)
      prelog
      logger.error(msg)
    end

    # Log a fatal error message.
    def fatal(msg)
      prelog
      logger.fatal(msg)
    end

    # Log an info message
    def info(msg)
      prelog
      logger.info(msg)
    end

    ##
    # Declare that this scenario is a negative test. This will change PASS and
    # FAIL to XPASS and XFAIL.
    def negative_test
      @negative = true
    end

    ##
    # Sets the path of our current test. This will be used to create the path
    # to the current log.
    def test_path=(value)
      @test_path = value
      # recreate outputter
      if @file_outputter then
        @file_outputter.flush
        logger.outputters.delete(@file_outputter)
        @file_outputter = nil
      end

      return test_path
    end

    # Log a warning message.
    def warn(msg)
      logger.warn(msg)
    end

    private

    ##
    # Creates our file outputter and ensures that the file exists.
    def create_file_outputter
      log_file = create_log_file_path

      unless File.exist?(File.dirname(log_file)) then
        FileUtils.mkdir_p(File.dirname(log_file))
      end

      @file_outputter = Log4r::FileOutputter.new(
        'saf_file_logger',
        filename: log_file, trunc: false)
      @file_outputter.formatter = SAFSTDOUTFormatter.new
      logger.outputters << @file_outputter
    end

    ##
    # Creates the underlying log4r instance.
    def create_logger
      new_logger = Log4r::Logger.new("SAF")
      new_logger.outputters = [Log4r::Outputter.stdout]
      Log4r::Outputter.stdout.formatter = SAFSTDOUTFormatter.new

      return new_logger
    end

    ##
    # Returns the full path to the current log file.
    def create_log_file_path
      log_dir = File.join(SAF::LOG, File.dirname(test_path))
      log_file_pre = File.join(log_dir,
                               File.basename(test_path, ".*"))
      "#{log_file_pre}_#{Time.now.strftime('%Y%m%d_%H%M%S')}.log"
    end

    def logger
      @logger ||= create_logger
    end

    ##
    # Any pre-logging events happen here. Ex. ensuring that the file outputter
    # is hooked up.
    def prelog
      create_file_outputter unless @file_outputter

      # Set up the remote logger here because we need the hostname and port to
      # have been loaded, and we'll have done a bit of logging before we load
      # those two (due to needing to load the project).
      if !@logstash_outputter && SAF.enable_remote_logging &&
         SAF.logstash_host && SAF.logstash_port then
        @logstash_outputter = log_stash_output = TCPOutputter.new(
          "LogstashOutputter",
          hostname: SAF.logstash_host,
          port: SAF.logstash_port)
        @logger.outputters << log_stash_output
        log_stash_output.formatter = JsonFormatter.new
      end
    end
  end
end

if defined? Cucumber then
  Before do |scenario|
    SAF.negative = false
    # Store relative path to feature in test_path
    SAF.test_path = scenario.feature.file.split("features/").last
  end
end
