# encoding: utf-8
# $Id: $

module PageObjects
  ##
  # fbfs.com home page
  #   Inherits SitePrism::Page to show that this is a page
  class News < SitePrism::Page
    # will load the Capybara.app_host and this relative path
    set_url '/newsroom/news'
    set_url_matcher %r{/news}

    element :insuranceProducts, '.sfContentBlock', \
            text: 'Insurance Products'
    element :findAnAgent, '.main-container no-padding-top', \
            text: 'Find an Agent'
    element :newsroom, '.main-container no-padding-top', \
            text: 'Newsroom'
    element :home, '.sfContentBlock', text: 'Home'
    element :careerCenter, '.sfContentBlock', \
            text: 'Career Center'

    def newsroom_visible
      if has_newsroom? && newsroom.visible?
        puts 'Yeah! newsroom is visible on fbfs page!'
      end
    end
  end
end
