# $Id: loader.rb 340 2016-05-06 14:35:38Z e0c2506 $
module Utilities
  module Passwords
    ##
    # Passwords private class.
    class Loader < Cipherer
      # Error message to display when an invalid user is passed. #{username}
      # will be replaced with the username.
      INVALID_USER_ERROR_MESSAGE = "Invalid user.\n"\
        "User \#{username} does not appear to have any passwords.".freeze
      # Error message to display when an invalid environment is passed.
      # #{username} will be replaced with the username, and #{environment} will
      # be replaced with the environment.
      INVALID_ENV_ERROR_MESSAGE = "Valid user, invalid environment.\n"\
        "User \#{username} exists but does not have a registered "\
        "password for environment \#{environment}, and does not have "\
        "a default password registered.".freeze
      NO_DEFAULT_ENV_ERROR_MESSAGE = "Valid user, invalid environment.\n"\
        "User \#{username} exists but does not have a default password.".freeze

      ##
      # See Utilities::Passwords::Cipherer#initialize
      def initialize(*args)
        super
        @cipher.decrypt
      end

      ##
      # Loads the password from the passed file, for the passed username and
      # environment.
      def load_password(file, username, environment = nil)
        username = username.to_s.downcase

        buffer = YAML.load(File.read(file))

        # Make sure the user exists...
        unless buffer.key?(username) then
          raise ArgumentError.new(
            INVALID_USER_ERROR_MESSAGE.sub("\#{username}", username))
        end
        # If he doesn't have a password for THIS environment, use the default..
        unless buffer[username].key?(environment) then
          # But if he doesn't have a default key either, we have to stop
          # processing.
          unless buffer[username].key?(nil) then
            if environment.nil? then
              err = NO_DEFAULT_ENV_ERROR_MESSAGE.sub("\#{username}", username)
            else
              err = INVALID_ENV_ERROR_MESSAGE.sub(
                "\#{username}", username).sub("\#{environment}", environment)
            end
            
            raise ArgumentError.new(err)
          end
          # Needs to be on this side of the nil check so that we can print the
          # original environment.
          environment = nil
        end

        # Now lets decrypt that baby.
        return decrypt_password(buffer[username][environment])
      end

      private

      ##
      # Decrypts the passed password.
      def decrypt_password(password)
        @cipher.iv = password[:iv]
        return @cipher.update(password[:pw]) + @cipher.final
      end
    end
  end
end
