#encoding: utf-8
# $Id: fbfs_website.feature 349 2016-05-09 04:50:54Z e0c2425 $
@FBFS
Feature: FBFS website available

  @FBFS_home @FBFS_smoke
  Scenario: FBFS_home_page
    When visiting environment prod
    Then page shall contain title Home | Farm Bureau Financial Services
    And "Find an Agent" shall be displayed

  @FBFS_important_links @FBFS_smoke
  Scenario Outline: FBFS_important_web_pages
    When visiting prod environment's relative link <relative_link>
    Then title shall contain <in_title>
    And "<search_text>" shall be displayed
    Examples:
      | relative_link                              | search_text                | in_title           |
      | insurance                                  | Insurance Products         | Insurance Products |
      | find-an-agent                              | SEARCH RESULTS FOR         | Find An Agent      |
      | find-an-agent/agent-detail?agentid=04790   | Office Location(s)         | Insurance Agent    |
      | learning-center-home                       | House & Home               | Learning Center    |
      | newsroom/news                              | TOP STORIES                | News               |

  @FBFS_find_agent_by_zip @FBFS_smoke
  Scenario Outline: FBFS_find_agent_by_zip
    When visiting prod environment's relative link <relative_link>
    Then agent name search results appears
    Examples:
      | relative_link                              |
      | find-an-agent/Search?t=zip&s=50061#zipcode |

  @te_FBFS_home @te_FBFS_smoke
  Scenario: te_FBFS_home_page
    When visiting environment t-public
    Then title shall contain Home | Farm Bureau Financial Services
    And "Find an Agent" shall be displayed

  @te_FBFS_important_links @te_FBFS_smoke
  Scenario Outline: te_FBFS_important_web_pages_by_title
    When visiting t-public environment's relative link <relative_link>
    Then title shall contain <in_title>
    And "<search_text>" shall be displayed
    Examples:
      | relative_link                              | search_text                | in_title           |
      | insurance                                  | Insurance Products         | Insurance Products |
      | find-an-agent                              | SEARCH RESULTS FOR         | Find An Agent      |
      | find-an-agent/agent-detail?agentid=04790   | Office Location(s)         | Insurance Agent    |
      | learning-center-home                       | House & Home               | Learning Center    |
      | newsroom/news                              | TOP STORIES                | News               |

  @te_FBFS_find_agent_by_zip @te_FBFS_smoke
  Scenario Outline: te_FBFS_find_agent_by_zip
    When visiting t-public environment's relative link <relative_link>
    Then agent name search results appears
    Examples:
      | relative_link                              |
      | find-an-agent/Search?t=zip&s=50061#zipcode |

