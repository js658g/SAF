#encoding: utf-8
# $Id: error.feature 114 2016-04-12 15:59:42Z e0c2506 $
Feature: Try out some weird error magicks.
 
  Scenario: Broke exceptions!
    When I fail the exception count increases
    And I throw an error and the exception count increases
    And I raise an error and the exception count increases
	  And the KERNEL is raising an error the exception count increases
	  And I call a non-method and the exception count increases
	  And I do something stupid and the exception count increases
	  And an assertion fails and the exception count increases
	  And the system exits... wait do I want to do that? and the exception count increases