require_relative "spec_helper"

describe Utilities::Passwords::Creator do
  before :all do 
    @creator = Utilities::Passwords::Creator.new
  end
  
  it 'defaults override to false' do
    expect(@creator.send(:clean_args, username: "", password: "")[:override]).to be(false)
    expect(@creator.send(:clean_args, username: "", password: "", override: true)[:override]).to be(true)
    expect(@creator.send(:clean_args, username: "", password: "", override: false)[:override]).to be(false)
  end
  
  it 'requires username and password' do
    expect{@creator.send(:clean_args, username: "")}.to raise_error(ArgumentError)
    expect{@creator.send(:clean_args, password: "")}.to raise_error(ArgumentError)
    expect{@creator.send(:clean_args)}.to raise_error(ArgumentError)
    expect{@creator.send(:clean_args, username: "", password: "")}.not_to raise_error
  end
  
  it 'downcases username' do
    expect(@creator.send(:clean_args, username: "MYUSER", password: "")[:username]).to eq("myuser")
    expect(@creator.send(:clean_args, username: "myuser", password: "")[:username]).to eq("myuser")
    expect(@creator.send(:clean_args, username: "MyUser", password: "")[:username]).to eq("myuser")
    expect(@creator.send(:clean_args, username: "mYuSeR", password: "")[:username]).to eq("myuser")
  end
  
  it 'requires args' do
    expect{@creator.send(:require_arg, {}, :arg)}.to raise_error(ArgumentError)
    expect{@creator.send(:require_arg, {arg: nil}, :arg)}.not_to raise_error
  end
  
  it 'creates the passwords file' do
    File.delete("temppw.yml") if File.exist?("temppw.yml")
    @creator.add_user(file: "temppw.yml", username: "user", password: "pass",
                      environment: "env", override: false)
    expect(File.exist?("temppw.yml")).to be(true)
    
    result = YAML.load(File.read("temppw.yml"))
  end
  
  it 'does not clobber the passwords file' do
    File.open("temppw.yml", "w") do |out|
      out.puts({ test: "this is a test" }.to_yaml)
    end
    
    File.open("temppw.yml", "a+") do |file|
      @creator.send(:write_to_file, file, "user", "pass", "env", false)
    end
    
    result = YAML.load(File.read("temppw.yml"))
    expect(result.key?(:test)).to be(true)
    expect(result[:test]).to eq("this is a test")
      
    File.delete("temppw.yml")
  end
  
  it 'updates the passwords file' do
    File.open("temppw.yml", "w") do |out|
      out.puts({ test: "this is a test" }.to_yaml)
    end
    
    File.open("temppw.yml", "a+") do |file|
      @creator.send(:write_to_file, file, "user", "pass", "env", false)
    end
    
    result = YAML.load(File.read("temppw.yml"))
    expect(result.key?("user")).to be(true)
      
    File.delete("temppw.yml")
  end
  
it 'does not override when told not to' do
    File.open("temppw.yml", "w") do |out|
      out.puts({ "user" => { "env" => "pass" } }.to_yaml)
    end
    
    File.open("temppw.yml", "a+") do |file|
      expect(@creator.send(:write_to_file, file, "user", "pass", "env", false)).to be(false)
    end
    result = YAML.load(File.read("temppw.yml"))
    expect(result["user"]["env"]).to eq("pass")
    expect(result.size).to eq(1)
    expect(result["user"].size).to eq(1)
    
    File.delete("temppw.yml")
  end
  
it 'does override when told to' do
    File.open("temppw.yml", "w") do |out|
      out.puts({ "user" => { "env" => "pass" } }.to_yaml)
    end
    
    File.open("temppw.yml", "a+") do |file|
      expect(@creator.send(:write_to_file, file, "user", "pass", "env", true)).to be(true)
    end
    result = YAML.load(File.read("temppw.yml"))
    expect(result["user"]["env"]).not_to eq("pass")
    
    File.delete("temppw.yml")
  end
end