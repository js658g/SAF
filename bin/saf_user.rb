# $Id: saf_user.rb 327 2016-05-04 16:02:40Z e0c2506 $
require "io/console"
require_relative File.join("..", "lib", "saf")
require_relative File.join("..", "lib", "utilities", "passwords.rb")

creator = Utilities::Passwords::Creator.new

commands = ["add", "update", "wipe"]
parameters = ["-e", "--environment"]

cmd_args = ARGV.dup

invoked = cmd_args.shift.to_s.downcase
# Default to "help" if they put an invalid command.
invoked = "help" unless commands.include?(invoked)

if invoked == "help" then
  puts "Adds or updates stored usernames and passwords for SAF.\n"\
       "\n"\
       "saf_user command [username] [-e environment]\n"\
       "\n"\
       "  command      One of (add, update, wipe).commands Specifies the\n"\
       "               command for saf_user to invoke.\n"\
       "       add     Adds a new user. Requires a username, will ask for a\n"\
       "               password. Accepts the optional environment argument.\n"\
       "       update  Updates an existing password. Same as add, except it\n"\
       "               will overwrite the password if one is already set\n"\
       "               for this user and environment.\n"\
       "       wipe    Wipes all users from SAF on this machine.\n"\
       "\n"\
       "  username     The username to add or update.\n"\
       "\n"\
       "  --environment / -e\n"\
       "               Optional parameter to specify the environment to add\n"\
       "               or update this user in. If left blank this will add\n"\
       "               a default password for the specified user.\n"
elsif invoked == "add" || invoked == "update" then
  args = {}
  args[:override] = (invoked == "update")

  # Parse command line arguments.
  until cmd_args.empty? do
    cur_arg = cmd_args.shift.downcase

    # Check to see if this is a parameter.
    if parameters.include?(cur_arg) then
      value = cmd_args.shift
      # Only param is environment. Will need to do something later if we add
      # more
      args[:environment] = value
    else
      # Not a parameter, must be a username (since we already removed the
      # command)
      args[:username] = cur_arg
    end
  end

  if args.key?(:environment) && args[:environment].nil? then
    raise ArgumentError.new("#{cur_arg} parameter must have a value!")
  end

  # Still need that password...
  if RUBY_PLATFORM =~ /java/i then
    # While this works fine in MinGW Ruby, JRuby has a glitch where IO#noecho
    # does not always properly function. As such we need to warn people.
    puts "WARNING - Your password may be visible on your console. Please\n"\
         "use cls and/or clear to clear your screen after entering it, or\n"\
         "preferably restart your console."
  end

  puts "Please enter the password for #{args[:username]}"
  # noecho causes what the user types not to be printed to the screen during
  # the gets call.
  args[:password] = STDIN.noecho(&:gets)

  if creator.add_user(args) then
    puts "User #{invoked}ed."
  else
    puts "FAILED to #{invoked} user. Does that user/environment already exist?"
  end
elsif invoked == "wipe" then
  puts "Really wipe passwords? This means I will delete the password and\n"\
       "key file completely. Are you really sure? (y/N) "
  response = STDIN.gets
  if response.strip.casecmp("y") == 0 then
    puts "Wiping passwords..."
    if File.exist?(Utilities::Passwords::PASSWORDS_FILE) then
      File.delete(Utilities::Passwords::PASSWORDS_FILE)
    end
    if File.exist?(Utilities::Passwords::KEY_FILE) then
      File.delete(Utilities::Passwords::KEY_FILE)
    end
    puts "Passwords and key wiped."
  else
    puts "Wipe cancelled."
  end
end
