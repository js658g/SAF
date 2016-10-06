# $Id: passwords.feature 340 2016-05-06 14:35:38Z e0c2506 $
@SAF @Passwords
Feature: Passwords correctly enters passwords in a field.

	Background:
		Given the passwords file has our test users

	Scenario: I can enter a password with just a username
		When I get the password for "saf_test_user"
		Then the password is "test_user_global"
		
	Scenario: I can enter a password with a username and environment
		When I get the password for "saf_test_user" in "test_environment"
		Then the password is "test_user_environment"
	
	Scenario: I can enter a password with a username and environment without a default
		When I get the password for "saf_test_user_2" in "test_environment"
		Then the password is "test_user_2"
		
	Scenario: If I don't pass an environment, I get a proper error when there is no default
		Given I get an error When I get the password for "saf_test_user_2"
		Then the error explains that I have no default password, but a valid user
		
	Scenario: If I give a crazy environment it will enter the default password for that user
		When I get the password for "saf_test_user" in "crazy_non_existant_environment_18941"
		Then the password is "test_user_global"
		
	Scenario: I get a proper error when entering a password with an invalid username
		Given I get an error When I get the password for "crazy_non_existant_guy_129318"
		Then the error explains that I have an invalid user
		
	Scenario: I get a proper error when entering a password with an invalid environment when there is no default password
		Given I get an error When I get the password for "saf_test_user_2" in "crazy_non_existant_environment_18941"
		Then the error explains that I have an invalid environment, but a valid user
	
	Scenario: I get a complaint about the user before the environment
		Given I get an error When I get the password for "crazy_non_existant_guy_129318" in "crazy_non_existant_environment_18941"
		Then the error explains that I have an invalid user
		
	Scenario: Usernames are case-insensitive
		When I get the password for "SAF_TEST_USER"
		Then it is the same password as for "SAF_test_USER"
		And it is the same password as for "saf_test_user"
		And it is the same password as for "Saf_Test_User"
		And it is the same password as for "SaF_tEsT_uSeR"