#encoding: utf-8
# $Id: wikipedia_test.feature 95 2016-04-06 20:35:25Z e0c2506 $
Feature: Do something with the Wikipedia site
  	
  Scenario: Check one thing on Wikipedia
  	When I search for the Wikipedia page "Whale"
  	Then the article has a search bar
  	And the article includes "sea"
  	And the article includes "mammal"
  	And the article includes "krill"
  	
  Scenario: Check one other thing on Wikipedia
  	When I search for the Wikipedia page "Dog"
  	Then the article has a search bar
  	And the article includes "canine"
  	And the article includes "pet"
  	And the article includes "bark"