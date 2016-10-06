# $Id: passwords.rb 327 2016-05-04 16:02:40Z e0c2506 $
require "capybara"
require "openssl"
require "yaml"

module Utilities
  ##
  # For loading encrypted passwords from our passwords.yml file.
  module Passwords
    # The file to store our passwords in.
    PASSWORDS_FILE = File.join(SAF::GENERATED, ".passwords.yml")
    # The file to store our encryption key in.
    KEY_FILE = File.join(SAF::GENERATED, ".key")

    class <<self
      ##
      # Fills the passed element with the decrypted password for the passed
      # username and environment. If no username or environment are passed,
      # attempts to get them from the current test.
      #
      #   Passwords.for("my_user", in_env: "my_environment")
      def for(username, opts = {})
        # TODO: Load environment and username from... somewhere?
        environment = opts.delete(:in_env)

        raw_pass = loader.load_password(PASSWORDS_FILE, username, environment)
        return raw_pass
      end

      private

      # The Passwords::Loader we're using.
      def loader
        return @loader ||= Loader.new
      end
    end
  end
end

require_relative File.join("passwords", "cipherer")
require_relative File.join("passwords", "creator")
require_relative File.join("passwords", "loader")
