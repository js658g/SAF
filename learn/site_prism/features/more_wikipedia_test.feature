#encoding: utf-8
# $Id: more_wikipedia_test.feature 95 2016-04-06 20:35:25Z e0c2506 $
Feature: Do something with the Wikipedia site
 
  Scenario: Mess with Wikipedia in a bunch of steps
  	When I open Wikipedia
  	Then I am on Wikipedia
  	And the Wikipedia does not have crazy stuff
  	Then I enter "Stuff" to "searchbar"
  	Then I click "searchbutton"
  	Then I am on WikipediaEntry
  	Then "header" has text "Stuff"
  	And "body" has text "cloth"
  	And "body" has text "matter"
  	And "body" has text "Music"
  	
  Scenario: Check one thing on Wikipedia
  	When I search for the Wikipedia page "Stuff"
  	Then the article has a search bar
  	And the article includes "character"
  	And the article includes "Film"
  	And the article includes "children"