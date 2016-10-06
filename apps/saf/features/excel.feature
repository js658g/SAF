#encoding: utf-8
# $Id: excel.feature 342 2016-05-06 18:59:00Z e0c2507 $
@SAF @Excel
Feature: Convert excel file into yml file
  Background: Given the test data in excel file

  Scenario: convert excel file into yml file
    Given I have test data in an excel file test.xlsx
    Then yml file should be generated

#  Scenario: convert excel file into yml file
#    Given I have test data in an excel file C:\devl\SAF_dev\apps\saf\data\excel\saf_excel_test_data.xlsx
#    Then yml file should be generated

#  Scenario: excel file does not exist
#    When There is no excel file
#    Then I should get an error file doesn't exist

