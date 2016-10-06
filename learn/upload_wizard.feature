# $Id: upload_wizard.feature 95 2016-04-06 20:35:25Z e0c2506 $
Feature: Wiki Commons Upload Wizard

  Scenario: Can access upload wizard when logged in
    Given I am logged into Commons
    When I visit the Upload Wizard
    Then I should see the Upload Wizard content

  Scenario: Can't access upload wizard when not logged in
    Given I am not logged into Commons
    When I visit the Upload Wizard
    Then I should not see the Upload Wizard content
