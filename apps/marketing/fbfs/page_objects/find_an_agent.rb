# encoding: utf-8
# $Id: $

module PageObjects
  ##
  # fbfs.com home page
  #   Inherits SitePrism::Page to show that this is a page
  class FindAnAgent < SitePrism::Page
    # will load the Capybara.app_host and this relative path
    set_url '/find-an-agent'
    set_url_matcher %r{/find-an-agent}

    element :findAnAgent, '.main-container no-padding-top', \
            text: 'Find an Agent'
    element :home, '.sfContentBlock', text: 'Home'
    element :careerCenter, '.sfContentBlock', text: 'Career Center'

    def find_an_agent_visible
      if has_findAnAgent? && findAnAgent.visible?
        puts 'Yeah! findAnAgent is visible on fbfs page!'
      end
    end
  end
end
