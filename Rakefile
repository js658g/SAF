# encoding: utf-8
# $Id: $
require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
require 'rake'

Rake.application.options.trace = true
@projects = %w(FBFS FAST)

#
# rake testSAF[scenario_tag,saf_env,profile,local|remote,browser]
#    *** WARNING: There should be no spaces between comma separators
#
# EXAMPLE OF COMMAND LINE USAGE:
#
# rake testSAF['FBFS','test','FBFS',local','ie']
#   - will run tests with @FBFS tag,
#     using project env_variables.yml key for specific environment
#     using cucumber.yml FBFS profile
#     on local host machine (127.0.0.1),
#     on internet explorer browser
#
# rake testSAF['FAST','test','FAST_debug','local','chrome']
#   - will run tests with @FAST tag,
#     using project env_variables.yml key for specific environment
#     using cucumber.yml FAST_debug profile
#     on local host machine (127.0.0.1),
#     on chrome browser

desc 'Run all project scenarios with specified tag'
task :testSAF, [:project, :SAF_ENV, :profile, :target, :browser, :projects] do |t, args|
  puts "Arguments to rake task was #{t} #{args}"
  set_env('@' + args[:project], args[:SAF_ENV], args[:profile])
  execute_tests(args[:target], args[:browser], args[:projects])
end

def task_builder
  @projects.each do |project_name|
    Cucumber::Rake::Task.new(project_name.to_sym) do |t|
      t.cucumber_opts = "-t #{ENV['CUKE_TAGS']}"
      t.profile = ENV['CUKE_PROFILE']
    end
  end
end

def set_env(tag, saf_env, profile)
  ENV['CUKE_TAGS'] = tag
  ENV['CUKE_PROFILE'] = profile
  ENV['SAF_ENV'] = saf_env
end

def execute_tests(target, browser, projects)
  ENV['TARGET'] = target
  ENV['BROWSER'] = browser
  results = []
  if !projects.nil? && !projects.empty?
    @projects.clear
    @projects = projects.split '|'
  end
  task_builder
  @projects.each do |project_name|
    results << collate_results(project_name)
  end
  failure? results
end

def failure?(results)
  results.each do |result|
    puts "#{__FILE__}:#{__LINE__}: Scripts had failures" unless result
  end
end

def collate_results(project_name)
  begin
    Rake::Task[project_name].invoke
  rescue => err
    puts "#{__FILE__}:#{__LINE__}: Exception: #{err}"
    raise err
  end
  true
end
