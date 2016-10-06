module SAFSubmodules
  ##
  # Loads all the ruby file for SAF
  module RubyLoader
    ##
    # Loads all gems required by SAF.
    # Note that other gems may be loaded in other files so that each file can
    # be loaded as seperately as possible, but this loads overarching common
    # gems.
    def load_all_gems
      load_minimal_gems

      require 'capybara'
      require 'capybara/dsl'
      require 'site_prism'
    end

    ##
    # Loads gems that are required for the config loading.
    def load_minimal_gems
    end

    ##
    # Loads all of SAF
    def load_saf
      # Load project specific environment
      require_relative File.join(SAF::PROJECTS, project, SAF::PROJECT_ENV_RB)
      load_saf_core
      load_project_ruby
    end

    ##
    # Loads the core files of SAF
    def load_saf_core
      # Load the ruby files for the SA Framework core (Should this be before we
      # load the project env.rb?
      load_directory(File.join(SAF::LIB, 'base'), false)
      require_relative(File.join(SAF::LIB, "utilities", "passwords.rb"))
      require_relative(File.join(SAF::LIB, "errors", "wrapper_error.rb"))
      load_directory(File.join(SAF::LIB, 'errors'), false)

      # Load rspec matchers
      load_directory(File.join(SAF::ROOT, "spec", "support", "matchers"))

      # Load gem config ruby
      require_relative(File.join(SAF::LIB, "config", "gem_configuration.rb"))
    end

    ##
    # Loads project specific files for SAF
    def load_project_ruby
      # Load up patches and the like for the project
      if File.exist?(File.join(SAF::PROJECTS, project, "lib")) then
        Dir.glob(File.join(SAF::PROJECTS, project,
                           "lib", "**", "*.rb")) do |f|
          require_relative(f)
        end
      end

      # Load up page objects and steps for this project
      load_directory(File.join(SAF::PROJECTS, project, "page_objects"))
      load_directory(File.join(SAF::PROJECTS, project, "features",
                               "step_definitions"))
    end

    private

    ##
    # Loads all files in a directory in a random order.
    def load_directory(dir, recursive = true)
      Dir.glob(File.join(dir, recursive ? "**/*.rb" : "*.rb")) do |f|
        require f
      end
    end
  end
end
