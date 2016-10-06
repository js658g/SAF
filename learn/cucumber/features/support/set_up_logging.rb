# $Id: set_up_logging.rb 95 2016-04-06 20:35:25Z e0c2506 $

# A little test to try out logging test results as a preliminary test around
# using Logstash and Kibana as a all-in-one readout for system health.

log = Logger.new "test_log.log"
# Does cucumber expose this list somewhere? It's annoying to have to gather it
# myself.
passed = []
failed = []

log.add(Logger::Severity::INFO, "Starting tests.", "Cucumber Tests")

# Announce the start of each scenario
Before do |scenario|
  log.add(Logger::Severity::DEBUG,
          "Starting scenario \"#{scenario.name}\"",
          "Cucumber Tests")
end

After do |scenario|
  if scenario.failed? then
    # If a scenario failed, announce it loudly, and follow with info about the
    # failure. Also track which failed.
    failed << scenario.name
    log.add(Logger::Severity::ERROR,
            "SCENARIO FAILED: \"#{scenario.name}\"",
            "Cucumber Tests")
    log.add(Logger::Severity::DEBUG,
            "\n==========\n"\
            "Scenario \"#{scenario.name}\" failure info:\n"\
            "#{scenario.exception.message}\n"\
            "Stack trace:\n#{scenario.exception.backtrace.join("\n")}\n"\
            "==========",
            "Cucumber Tests")
  else
    # If a scenario passed, annouce it but don't raise a fuss. Also keep track
    # of which scenarios passed.
    passed << scenario.name
    log.add(Logger::Severity::DEBUG,
            "Scenario passed: \"#{scenario.name}\"",
            "Cucumber Tests")
  end
end

# At the end let's generate something of a report.
at_exit do
  unless passed.empty? then
    # First lets list all the passing tests.
    passed_msg = "#{passed.count} tests passed:\n"
    passed.each do |test|
      passed_msg.concat "#{test}\n"
    end
    log.add(Logger::Severity::INFO, passed_msg, "Cucumber Tests")
  end

  if failed.empty? then
    # If we didn't have any failing tests, awesome lets let people know.
    log.add(Logger::Severity::INFO, "No failures.", "Cucumber Tests")
  else
    # Otherwise lets list all the failing tests (loudly).
    failed_msg = "#{failed.count} tests failed:\n"
    failed.each do |test|
      failed_msg.concat "#{test}\n"
    end
    log.add(Logger::Severity::ERROR, failed_msg, "Cucumber Tests")
  end

  # Confirm that tests are complete.
  log.add(Logger::Severity::INFO, "Tests completed.", "Cucumber Tests")
end
