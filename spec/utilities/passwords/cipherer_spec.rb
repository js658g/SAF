# $Id$
require_relative "spec_helper"

describe Utilities::Passwords::Cipherer do
  before :all do
    @cipherer = Utilities::Passwords::Cipherer.new
  end
  
  it 'creates a key file' do
    if File.exist?("tempkey") then
      File.delete("tempkey")
    end
    
    expect(@cipherer.create_key("tempkey")).to be(true)
    
    expect(File.exist?("tempkey")).to be(true)
    File.delete("tempkey")
  end
  
  it 'loads a key' do
    tcipher = OpenSSL::Cipher::AES.new(128, :CBC)
    key = tcipher.random_key
    iv = tcipher.random_iv
    tcipher.encrypt
    encrypted = tcipher.update("test") + tcipher.final
    
    File.open("tempkey", "wb") do |out|
      out.puts(key)
    end
    
    # end setup
    expect(@cipherer.load_key("tempkey")).to be(true)
    gcipher = @cipherer.instance_variable_get(:@cipher)
    gcipher.iv = iv
    gcipher.decrypt
    decrypted = gcipher.update(encrypted) + gcipher.final
    
    expect(decrypted).to eq("test")
    
    File.delete("tempkey")
  end
end