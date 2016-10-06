# encoding: utf-8
# $Id: fast_create_data.feature 428 2016-05-24 16:24:21Z e0c2425 $
@FAST @FAST_create_data
Feature: agents information

  Scenario: convert FAST excel workbook into yml files
    Given I have test data in an excel file FAST_tests2.xlsx
    Then yml file should be generated