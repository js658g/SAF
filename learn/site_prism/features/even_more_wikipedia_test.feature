#encoding: utf-8
# $Id: even_more_wikipedia_test.feature 95 2016-04-06 20:35:25Z e0c2506 $
Feature: Do something with the Wikipedia site
 
  Scenario: Mess with Wikipedia in a bunch of steps
  	When I open Wikipedia
  	Then I am on Wikipedia
  	And the Wikipedia does not have crazy stuff
  	Then I enter "Firebat" to "searchbar"
  	Then I click "searchbutton"
  	Then I am on WikipediaEntry
  	Then "header" has text "Races of StarCraft"
  	And "body" has text "Zerg"
  	And "body" has text "Protoss"
  	And "body" has text "Terran"
  	
  Scenario: Mess with Wikipedia in a bunch of steps
  	When I open Wikipedia
  	Then I am on Wikipedia
  	And the Wikipedia does not have crazy stuff
  	Then I enter "Sandworm" to "searchbar"
  	Then I click "searchbutton"
  	Then I am on WikipediaEntry
  	Then "header" has text "Sandworm"
  	And "body" has text "Mongolian death worm"
  	And "body" has text "Dune"
  	And "body" has text "Arenicola marina"
  	
  Scenario: Check one thing on Wikipedia
  	When I search for the Wikipedia page "Sandworm"
  	Then the article has a search bar
  	And the article includes "Mongolian death worm"
  	And the article includes "Dune"
  	And the article includes "Arenicola marina"