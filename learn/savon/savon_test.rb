# $Id: savon_test.rb 95 2016-04-06 20:35:25Z e0c2506 $
# Simple demo calling a webservice that converts between temperature units.

require 'savon'

# First we create the client.
client = Savon.client do
  # Tell em where the WSDL is
  wsdl "http://www.webservicex.net/ConvertTemperature.asmx?WSDL"
  # And this overrides the default behavior of sending XML keys in lower camel
  # case (myKeyHere) to use standard camel case (MyKeyHere) because this
  # particular webservice wants it that way.
  convert_request_keys_to :camelcase
end

# Just some fun letting the user enter their own values.
puts "Enter in Fahremheit or Celsius? (f/C) "
celsius = gets.strip.casecmp("C") == 0
puts "How many degrees #{celsius ? "C" : "F"}? "
degrees = gets.to_i

units = { true => "degreeCelsius", false => "degreeFahrenheit" }

# Now lets actually call the webservice. ConvertTemp is defined in the WSDL as
# an operation.
response = client.call(:convert_temp) do
  # And here we build the message contents, passing the temperature #, from
  # unit, and to unit.
  message(temperature: degrees,
          from_unit: units[celsius],
          to_unit: units[!celsius])
end

# We can check some http stuff too
throw Exception.new("Oh noes it wasn't OK!!") unless response.http.code == 200
# Grabbing the response body.
puts "That is #{response.body[:convert_temp_response][:convert_temp_result]} "\
     "#{celsius ? "F" : "C"}"
