# encoding: UTF-8
# $Id: yml.rb 376 2016-05-11 03:24:12Z e0c2425 $
module Base
  # contains methods to work with YAML file types, and methods which work
  # with SAF file structure and a project's name to locate yml data files
  # specific to that project
  class Yml
    # return full pathname of project's yml_file
    def obtain_in_project_file_name(yml_file)
      # get SAF install directory and project folders from environment
      File.join(SAF::DATA_YML, yml_file)
    end

    # append a hash containing YAML compliant sequence, mappings, or scalars
    # to end of a yaml file
    def yml_append_file(yml_file, hash)
      begin
        open(File.new(yml_file, 'w')) { |f| YAML.dump(hash, f) }
      rescue => err
        puts "#{__FILE__}:#{__LINE__}: Exception of type #{err.class} happened."
        raise err
      end
    end

    # append a hash containing YAML compliant sequence, mappings, or scalars
    # to end of a yaml file (the yaml file exists beneath the project folder)
    def yml_append_to_project_file(yml_file, hash)
      file_name = obtain_in_project_file_name(yml_file)
      yml_append_file(file_name, hash)
    end

    # return entire contents of a YAML file
    def yml_read_file(yml_file)
      begin
        YAML.load_file(yml_file)
      rescue => err
        puts "#{__FILE__}:#{__LINE__}: Exception of type #{err.class} happened."
        raise err
      end
    end

    # parses a YAML file for a certain key, then returns the sequence, mappings,
    # or scalars associated with that key
    def yml_read_file_data_with_key(yml_file, yml_key)
      key = yml_key
      data = yml_read_file(yml_file)
      yml_data = {}
      data[key].each { |k, v| yml_data[k.to_s] = v }
      return yml_data
    end

    # return entire contents of a YAML file which exists beneath project folder
    def yml_read_project_file_all(yml_file)
      file_name = obtain_in_project_file_name(yml_file)
      yml_read_file(file_name)
    end

    # parses a YAML file for a certain key, then returns the sequence, mappings,
    # or scalars associated with that key (yaml file exists beneath project)
    def yml_read_project_file_data_with_key(yml_file, yml_key)
      file_name = obtain_in_project_file_name(yml_file)
      yml_read_file_data_with_key(file_name, yml_key)
    end
  end
end
