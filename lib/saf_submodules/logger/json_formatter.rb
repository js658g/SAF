##
# A formatter to display JSON output instead of the usualy Log4* output.
class JsonFormatter < ::Log4r::Formatter
  def format(event)
    json_message = default_hash(event)

    # If we were passed a hash, then they pay want special fields in Logstash.
    # No reason not to let them do so.
    if event.data.is_a?(Hash) then
      merge_hash(json_message, event.data)
    else
      # Otherwise we'll put it as the message for them.
      json_message[:message] = event.data
    end

    return json_message.to_json
  end

  private

  def default_hash(event)
    {
      logger: event.fullname,
      level: ::Log4r::LNAMES[event.level],
      language: "Ruby",
      origin_machine: Socket.gethostname,
      test_path: SAF.test_path,
      project: SAF.project,
      # Turning it in to a boolean instead of possibly nil.
      negative_test: SAF.negative ? true : false
    }
  end

  def merge_hash(json_message, data)
    json_message.merge!(data)
    # Translate that result code to english so that we can all understand
    # what's going on
    if json_message.key?(:result_code) then
      json_message[:test_result] =
        Errors::ResultCodes::RCODES[json_message[:result_code]]
    end
  end
end
