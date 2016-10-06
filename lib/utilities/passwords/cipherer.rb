# $Id: cipherer.rb 319 2016-05-03 16:27:53Z e0c2506 $
require 'yaml'

module Utilities
  module Passwords
    ##
    # Parent class for Loader and Creator that has some helpers around using
    # OpenSSL::Cipher
    class Cipherer
      ##
      # Creates a new OpenSSL::Cipher and loads up or creates the key for it.
      def initialize
        @cipher = OpenSSL::Cipher::AES.new(128, :CBC)

        # Get the IV and Key loaded or stored.
        if File.exist?(KEY_FILE) then
          load_key
        else
          create_key
        end
      end

      ##
      # Creates an IV and Key for the cipher and stores it in the passed file.
      def create_key(file = KEY_FILE)
        File.open(file, "wb") do |out|
          out.puts @cipher.random_key
        end

        # Want to make sure we don't return the key and iv.
        return true
      end

      ##
      # Loads an IV and Key from the passed file.
      def load_key(file = KEY_FILE)
        File.open(file, "rb") do |inn|
          @cipher.key = inn.read
        end

        # Again, keep the key and iv in the cipher, not elsewhere.
        return true
      end
    end
  end
end
