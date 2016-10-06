# $Id: log_some_tests_remotely.rb 132 2016-04-15 16:50:19Z e0c2506 $
require "log4r"
require "log4r/outputter/udpoutputter"
require "json"
require_relative "../../gems/tcp_outputter/lib/tcp_outputter.rb"

##
# A formatter to display JSON output instead of the usualy Log4* output.
class JsonFormatter < ::Log4r::Formatter
  def format(event)
    json_message = 
      {
        logger: event.fullname,
        level: ::Log4r::LNAMES[event.level],
        language: "Ruby"
      }

    # If we were passed a hash, then they pay want special fields in Logstash.
    # No reason not to let them do so.
    if event.data.is_a?(Hash) then
      json_message.merge!(event.data)
    else
      # Otherwise we'll put it as the message for them.
      json_message[:message] = event.data
    end  
    return json_message.to_json
  end
end

##
# Using a custom formatter here so that when we pass a hash in, it still gets
# printed nicely to stdout.
class SAFFormatter < ::Log4r::DefaultFormatter
  def format(event)
    # Copied this formatter from the Log4r BasicFormatter.
    buff = sprintf(@@basicformat, Log4r::MaxLevelLength, Log4r::LNAMES[event.level],
                   event.name)
    buff << (event.tracer.nil? ? "" : "(#{event.tracer[0]})") + ": "
    # This line was the only change, I'm just printing the message if they
    # passed a hash.
    buff << format_object(event.data.is_a?(Hash) ? event.data[:message] : event.data) + "\n"
    buff
  end
end

##
# This is a class to test out logging. It implements a log system that will
# send the log message over a different port each time (looping through 100
# ports, 5514-5613). The looping allows Logstash to keep up with a huge number
# off messages sent at once. I will experiment with the number of open ports to
# discover a safe number to use on Logstash.
class TestLogger
  NUM_PORTS = 1
  STARTING_PORT = 5514

  def self.log
    @log_num ||= 0
    initialize_logs unless @logs
    logger = @logs[@log_num]
    @log_num += 1
    @log_num = 0 if @log_num >= @logs.size
    return logger
  end
  def self.initialize_logs
    @logs = []
    NUM_PORTS.times do |n|
      @logs << initialize_log(n+STARTING_PORT)
    end
  end

  # Initializes a single logger to log to both UDP logstash, and stdout. If we
  # decide to go the multi-port way of doing things, we need to create our own
  # outputter that will automatically loop ports.
  def self.initialize_log(port)
    mylog = Log4r::Logger.new "mylog_#{port}"
    $lso = log_stash_ouput = TCPOutputter.new(
      "LogstashOutputter",
      hostname: "showinpoc01.fbfs.com",
      port: port)
    Log4r::Outputter.stdout.formatter = SAFFormatter.new
    mylog.outputters = [Log4r::Outputter.stdout, log_stash_ouput]
    log_stash_ouput.formatter = JsonFormatter.new
    return mylog
  end
  def log
    self.class.log
  end

  # For testing the stack trace in Log4r (didn't seem to work...)
  def log_stuff
    log.info("TestLogger is here to log stuff.")
    log.warn("TestLogger is finishged logging. Be careful.")
  end

  def test(result, id = "A test")
    log.debug(message: "#{id} has completed.", test_result: result)
  end
end

$a = TestLogger.new

def log_random_test_results
  results = ["PASS", "FAIL", "XPASS", "XFAIL", "UNRESOLVED", "UNTESTED", "UNSUPPORTED"]
  100.times do
    1000.times do |n|
      $a.test("PASS", "TC_#{n}")
    end
  
    n = 1000
    Random.srand
    results.each do |r|
      Random.rand(200).times do
        $a.test(r, "TC_#{n}")
        n += 1
      end
    end
  
    sleep 5
    end
end

def log_x_items(x, name="AOI")
  start = Time.now
  x.times do |n|
    $a.log.debug("#{name}_IS_TESTING")
  end
  _end = Time.now

  puts "Sent #{x} items from #{name} over #{_end - start} seconds."
end

#require "pry" ; binding.pry
log_x_items(50_000, "AOI")
$lso.close