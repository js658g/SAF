module SAFSubmodules
  ##
  # SAF module to load configuration values from environment variables and the
  # env_variables.yml files.
  module ConfigLoader
    # :section: Configuration Settings

    # The install key/environment for this system
    attr_reader :install_key
    # The cucumber env file for this run
    attr_reader :cucumber_env

    # The hostname of our test slave (if remote)
    attr_reader :test_slave_host
    # The port for our test slave (if remote)
    attr_reader :test_slave_port
    # Boolean determining if we want to run headless
    attr_reader :in_browser
    # The browser to run
    # TODO: Why have a seperate var for in browser? Why not specify
    # Poltergeist/PhantomJS here?
    attr_reader :browser

    # The log level for this system
    attr_reader :log_level
    # The project we're using
    attr_reader :project

    # TODO: What is this????
    attr_reader :screenshots
    # Boolean determining if we should take a screenshot when a test fails.
    attr_reader :screenshots_on_fail
    # Boolean determining if we should take a screenshot when a warning occurs.
    attr_reader :screenshots_on_warning

    attr_reader :enable_remote_logging
    attr_reader :logstash_host
    attr_reader :logstash_port

    ##
    # Retrieves the host URL for our AUT.
    # If multiple environments were specified in ENVIRONMENT_YAML, pass env to
    # decide which environment's URL you want.
    def aut_host(env = nil)
      return @aut_host unless @aut_host.is_a?(Hash)

      ensure_valid_aut_host_env(env)
      @aut_host[env]
    end

    # :section: Loading config settings

    ##
    # Loads all the environment variables from ENV and ENVIRONMENT_YAML
    # rubocop:disable Metrics/AbcSize
    def load_env_variables(project)
      @project = project
      puts("project = #{project}")

      if project.nil? then
        raise "#{msg_prefix} > No project defined.\n"\
              "Call SET PROJECT=prj, replacing prj with your project."
      elsif !File.exist?(File.join(SAF::PROJECTS, project)) then
        raise "#{msg_prefix} > Project not found: #{project}."
      end

      load_yml_config(project)

      @enable_remote_logging = load_boolean("ENABLE_REMOTE_LOGGING", true)
      @logstash_host = load_var("LOGSTASH_HOST", "showinpoc01.fbfs.com")
      @logstash_port = load_var("LOGSTASH_PORT", 5514).to_i

      @aut_host = load_var("HOST")
      @test_slave_host = load_var('REMOTE_HOST', 'showinpoc01.fbfs.com')
      @test_slave_port = load_var('REMOTE_PORT', 4444).to_i

      @in_browser = load_boolean("IN_BROWSER", true)

      @browser = load_var('BROWSER', 'ie')

      @log_level = load_var("LOG_LEVEL", "Logger::INFO")

      @screenshots = load_boolean("TAKE_SCREEN_SHOT", true) # Was ist das?
      @screenshots_on_fail = load_boolean("TAKE_SCREEN_SHOT_ON_FAIL", true)
      @screenshots_on_warning = load_boolean("TAKE_SCREEN_SHOT_ON_WARNING",
                                             true)

      @yml_config.delete("project")

      unless @yml_config.empty? then
        # TODO: Error class
        raise "#{msg_prefix} > Unknown keys in "\
          "#{project}'s #{SAF::PROJECT_ENV_YAML}:\n"\
          "  #{@yml_config.keys.join(', ')}"
      end
    end

    ##
    # Logs a message with the file and line prepended.
    def puts(msg, caller_depth = 0)
      SAF.info(message: msg, caller_depth: caller_depth)
    end

    private

    ##
    # Used in #aut_host, just makes sure env is being passed correctly when we
    # have multiple environments.
    def ensure_valid_aut_host_env(env)
      # Looks like they have multiple URLs for their environments. Make sure
      # the caller asked for a specific one.
      if env.nil? then
        raise ArgumentError.new(
          "#{msg_prefix} > \n"\
          "  AUT host has environments, but none were specified when asking "\
          "for an AUT host URL.")
      end
      # Make sure its a valid key too..
      unless @aut_host.key?(env) then
        raise ArgumentError.new(
          "#{msg_prefix} > \n"\
          "  Unknown AUT host #{env}.\n"\
          "  Available hosts are #{@aut_host.keys.join(', ')}")
      end
    end

    ##
    # Loads a single boolean environment variable. First checks ENV, then
    # ENVIRONMENT_YAML, then if it is not found in either, returns the default.
    # Automatically converts from String values to truthy/falsey
    def load_boolean(env_name, default)
      raw = load_var(env_name, default, 2)
      return raw if raw == true || raw == false
      return raw =~ /true|yes/i
    end

    ##
    # Loads a single environment variable. First checks ENV, then
    # ENVIRONMENT_YAML, then if it is not found in either, returns the default.
    def load_var(env_name, default = nil, puts_depth = 1)
      var = ENV[env_name] || @yml_config[env_name.downcase] ||
            @yml_config[env_name.upcase] || default

      # Delete values as we read them so that we can ensure there were no
      # unknown values.
      @yml_config.delete(env_name.downcase)
      @yml_config.delete(env_name.upcase)

      # TODO: Log this!
      puts("#{env_name.upcase} = #{var.inspect}", puts_depth)

      return var
    end

    ##
    # Loads ENVIRONMENT_YAML and the install key/env.
    def load_yml_config(project)
      @saf_env = ENV["SAF_ENV"] || "default"
      puts("SAF_ENV = #{@saf_env}")

      env_yml_path = File.join(SAF::PROJECTS, project, SAF::PROJECT_ENV_YAML)

      unless File.exist?(env_yml_path) then
        # TODO: File not found error class
        raise "#{msg_prefix} > Could not find #{env_yml_path}"
      end

      all_yml_config = YAML.load(File.read(env_yml_path))
      # Throw an error if they specified an illegal install key.
      unless all_yml_config.key?(@saf_env) then
        raise ArgumentError.new("#{caller.first}\n"\
                                "SAF env #{@saf_env} not found in project "\
                                "#{project}.")
      end
      @yml_config = all_yml_config[@saf_env]
    end
  end
end
