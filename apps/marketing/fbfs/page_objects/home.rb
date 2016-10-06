# encoding: utf-8
# $Id: $

module PageObjects
  ##
  # fbfs.com home page
  #   Inherits SitePrism::Page to show that this is a page
  class Home < SitePrism::Page
    # will load the Capybara.app_host and this relative path
    set_url '/'
    set_url_matcher %r{/}

    element :findAnAgent, '.button', text: 'Find an'
    element :menuNav, '.menu#nav'
    element :insuranceNav, '.menu#nav', text: 'Insurance'

    def insurance_nav_visible
      if has_insuranceNav? && insuranceNav.visible?
        puts 'Yeah! insuranceNav is visible on fbfs Home page!'
      end
    end

    def find_an_agent_visible
      if has_findAnAgent? && findAnAgent.visible?
        puts 'Yeah! Find an agent link is visible on fbfs Home page!'
      end
    end

  end
end
