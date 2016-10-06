# encoding: utf-8
# $Id: $
@FAST
Feature: login to URLs

  @FAST_login
  Scenario Outline: user can login to website
    Given visiting environment <environment>
    When <user> credentials entered are valid on login page
    Then home page has environment expected title!
  Examples:
    | environment | user    |
    | dev1        | fstlnb1 |
    | qtools      | fstlnb1 |