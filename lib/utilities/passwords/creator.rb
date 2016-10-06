# $Id: creator.rb 327 2016-05-04 16:02:40Z e0c2506 $
module Utilities
  module Passwords
    ##
    # Passwords private class.
    class Creator < Cipherer
      ##
      # See Utilities::Passwords::Cipherer#initialize
      def initialize(*args)
        super
        @cipher.encrypt
      end

      ##
      # Adds a user to the passwords file. Accepts a hash with the following
      # values:
      # [:username] REQUIRED. A string of the username to add. Will be
      #             downcased.
      # [:password] REQUIRED. The raw string password to add.
      # [:environment] A string representing the environment this
      #                username/password is for.
      # [:override] A boolean specifying if we should override an existing user
      #             and environment if it exists. Default is false.
      # [:file] A string of the passwords file to use. This is only for
      #         testing.
      def add_user(args = {})
        clean_args(args)
        success = true

        # Opening in read/write so that we can make the changes to the file
        # while under protection of the system r/w lock.
        File.open(args[:file] || PASSWORDS_FILE, "a+") do |file|
          success = write_to_file(file, args[:username], args[:password],
                                  args[:environment], args[:override])
        end

        return success
      end

      private

      ##
      # Cleans up arguments passed to add_user.
      def clean_args(args)
        require_arg(args, :username)
        require_arg(args, :password)
        args[:username] = args[:username].downcase
        args[:override] = false unless args.key?(:override)
        return args
      end

      ##
      # Makes sure that a required argument is in the args hash.
      def require_arg(args, name)
        unless args.key?(name) then
          raise ArgumentError.new("Missing argument #{name}.")
        end
      end

      ##
      # Actually does the meat of writing the user to the file once the file is
      # opened.
      def write_to_file(file, username, password, environment, override)
        # Load the entire file into our buffer so we can edit at will.
        buffer = YAML.load(file.read) || {}

        if !override && buffer.key?(username) &&
           buffer[username].key?(environment) then
          return false
        end

        # This is defaulting buffer[username] to an empty hash before using it.
        buffer[username] = {} unless buffer.key?(username)
        buffer[username][environment] = {
          iv: @cipher.random_iv, pw: @cipher.update(password) + @cipher.final }

        file.truncate(0)
        file.puts buffer.to_yaml

        return true
      end
    end
  end
end
