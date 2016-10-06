#encoding: utf-8
# $Id: first.feature 95 2016-04-06 20:35:25Z e0c2506 $
Feature: Showcase the simplest possible Cucumber scenario
  In order to verify that cucumber is installed and configured correctly
  As an aspiring BDD fanatic 
  I should be able to run this scenario and see that the steps pass (green like a cuke)
 
  Scenario: Cutting vegetables
    Given a cucumber that is 30 cm long
    When I cut it in halves
    Then I have two cucumbers
    And both are 15 cm long

  Scenario: Search for something on Google
    Given I am on the Google homepage
    When I search for "Pickaxe"
    Then I should see "pick is a hand tool"
