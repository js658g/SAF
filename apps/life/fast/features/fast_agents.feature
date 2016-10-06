# encoding: utf-8
# $Id: $
@FAST @FAST_agent @NB
Feature: agents information

  Background:
    Given visiting environment dev1
    And fstlnb1 credentials entered are valid on login page
    And home page has environment specific title!

  @FAST_agent @agent_valid_ALL
  Scenario Outline: valid agent information displayed for all agent related fields
    When I start a new NB life application
    And I enter the application information for <application>
    And I enter the plan information for <plan>
    And I add agent id <id_agent>
#    Then ALL agent info displays correctly
    Examples:
      | id_agent               | application      | plan                          |
      | agent_IA_Lewis         | UL_FullAppl_Mail | EIUL2015_dthOptB_GuiPrem_125K |
#      | agent_IA_Hampton       | UL_FullAppl_Mail | EIUL2015_dthOptB_GuiPrem_125K |
#      | agent_IA_Lueder        | UL_FullAppl_Mail | EIUL2015_dthOptB_GuiPrem_125K |
#      | agent_IA_Stafford      | UL_FullAppl_Mail | EIUL2015_dthOptB_GuiPrem_125K |
#      | agent_IA_James         | UL_FullAppl_Mail | EIUL2015_dthOptB_GuiPrem_125K |
#      | agent_IA_TeBockhorst   | UL_FullAppl_Mail | EIUL2015_dthOptB_GuiPrem_125K |
#      | agent_IA_Peter         | UL_FullAppl_Mail | EIUL2015_dthOptB_GuiPrem_125K |
#      | agent_IA_TeGrootenhuis | UL_FullAppl_Mail | EIUL2015_dthOptB_GuiPrem_125K |
#      | agent_NE_Fischer       | UL_FullAppl_Mail | EIUL2015_dthOptB_GuiPrem_125K |
    # need to add agent_valid_displayed_10 - agent_valid_displayed_38

