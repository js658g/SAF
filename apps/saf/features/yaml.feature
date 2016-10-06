# encoding: utf-8
# $Id: $
@SAF @YAML
Feature: YAML file operations

  @YAML_search_project_file_1
  Scenario: Search for data from project directory yml file
    When I search for data from saf_yml_test_data.yml with key role1
    Then Volcano must be in results from saf_yml_test_data.yml using key role1
    And Peewee must not be in results from saf_yml_test_data.yml using key role1

  @YAML_search_project_file_2
  Scenario: Search for data from project directory yml file
    When I search for data from saf_yml_test_data.yml with key role2
    Then horse must be in results from saf_yml_test_data.yml using key role2
    And sailboat must not be in results from saf_yml_test_data.yml using key role2
