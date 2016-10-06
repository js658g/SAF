# encoding: utf-8
# $Id: saf.rb 418 2016-05-23 14:00:05Z e0c2506 $

# This is a global helper class for all parts of SAF.
# Please ensure that this has no dependencies on other files, as it should
# simply contain configuration settings and constants.
#
# This file must STAY in lib/saf.rb
module SAF
  # :section: Constants

  # This is the root/install directory of SAF. It is an absolute path.
  ROOT = File.absolute_path(File.join(File.dirname(__FILE__), ".."))
  puts ROOT

  # The lib directory, where all our code should be.
  LIB = File.join(ROOT, "lib")
  # The lib/base directory, where the core of the framework resides.
  LIB_BASE = File.join(LIB, "base")
  # A directory that holds generated files, should not be kept in SCM.
  GENERATED = File.join(ROOT, "generated")
  # TODO: What is this directory for???????
  POLICIES = File.join(ROOT, "Documents", "Policies")

  # Base directory for data
  SHARED_DATA = File.join(ROOT, "data")
  # Base directory for excel data
  SHARED_DATA_EXCEL = File.join(SHARED_DATA, "excel")
  # Base directory for yml data
  SHARED_DATA_YML = File.join(SHARED_DATA, "yml")

  # DEPRECATED
  # Base directory for configuration
  CONFIG = File.join(ROOT, "config", "environments")

  # Base directory for all projects
  PROJECTS = File.join(ROOT, "apps")
  # The path in a project folder to our environment variables yaml file.
  PROJECT_ENV_YAML = File.join("env_variables.yml")
  # The path in a project folder to our ruby environment.
  PROJECT_ENV_RB = File.join("env.rb")

  SUB_MODULES = File.join(LIB, "saf_submodules")

  ##
  # Initializes SAF to be used for the passed project. This loads the entirety
  # of SAF and its dependencies.
  def self.init(project)
    @project = project
    setup_project_constants
    self.test_path = "SAF_LOADING"

    load_minimal_gems
    load_env_variables(project)
    load_all_gems
    load_saf
  end

  ##
  # Sets up some project specific constants.
  def self.setup_project_constants
    # Root directory of our project
    project_const(:PROJECT_ROOT)
    # Data directory of our project
    project_const(:DATA, "data")
    # Excel directory of our project
    project_const(:DATA_EXCEL, "data", "excel")
    # Yaml directory of our project
    project_const(:DATA_YML, "data", "yml")
    # Log directory of our project
    project_const(:LOG, "log")
    # Page objects directory of our project
    project_const(:PAGE_OBJECTS, "page_objects")
  end

  ##
  # Sets up a project specific file constant. It will prepend post_project_path
  # with the path to our current project.
  def self.project_const(name, *post_project_path)
    const_set(name, File.join(PROJECTS, @project, *post_project_path))
  end

  require File.join(SUB_MODULES, "config_loader.rb")
  require File.join(SUB_MODULES, "logger.rb")
  require File.join(SUB_MODULES, "ruby_loader.rb")
  require File.join(SUB_MODULES, "test_reporter.rb")

  extend SAFSubmodules::Logger
  extend SAFSubmodules::ConfigLoader
  extend SAFSubmodules::RubyLoader
  extend SAFSubmodules::TestReporter
end
