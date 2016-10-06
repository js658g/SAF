require "log4r"

##
# Using a custom formatter here so that when we pass a hash in, it still gets
# printed nicely to stdout.
class SAFSTDOUTFormatter < ::Log4r::DefaultFormatter
  def format(event)
    data = event.data.is_a?(Hash) ? event.data : { message: event.data }
    data[:caller_depth] = (data[:caller_depth] || 1) + 10
    # Copied this formatter from the Log4r BasicFormatter.
    data[:event_type] = Log4r::LNAMES[event.level]
    if data[:result_code] then
      data[:event_type] = Errors::ResultCodes::RCODES[data[:result_code]]
      translate_result_code(data)
    end
    data_to_s(data, event)
  end

  def translate_result_code(data)
    # This allows us to report negative testing nicely.
    if SAF.negative &&
       (data[:result_code] == Errors::ResultCodes::PASS_CODE ||
       data[:result_code] == Errors::ResultCodes::FAIL_CODE) then
      data[:event_type] = "X#{data[:event_type]}"
    end
  end

  ##
  # Takes the data and turns it into a friendly string.
  def data_to_s(data, event)
    tracer = event.tracer.nil? ? "" : "(#{event.tracer[0]})"
    prefix = Kernel.format(@@basicformat, [Log4r::MaxLevelLength, 10].max,
                           data[:event_type],
                           msg_prefix(data[:caller_depth] + 2))
    return "#{prefix}#{tracer}: #{format_object(data[:message])}\n"
  end

  def msg_prefix(caller_depth = 0)
    path_line = caller[caller_depth].match(/\A(?<path>.*):(?<line>\d+):/)
    # Note, converting to an abs path because some ruby interpreters return
    # an abs and some return a relative path. Pathname.relative_path_from
    # requires both paths to be either abs or relative, so we just default
    # to abs.
    abs_path = Pathname.new(File.absolute_path(path_line[:path]))
    relative_path = abs_path.relative_path_from(Pathname.new(SAF::ROOT)).to_s

    line_num = path_line[:line]

    return "#{relative_path}:#{line_num}"
  end
end
