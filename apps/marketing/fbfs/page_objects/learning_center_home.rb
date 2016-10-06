# encoding: utf-8
# $Id: $

module PageObjects
  ##
  # fbfs.com home page
  #   Inherits SitePrism::Page to show that this is a page
  class LearningCenterHome < SitePrism::Page
    # will load the Capybara.app_host and this relative path
    set_url '/learning-center-home'
    set_url_matcher %r{/learning}

    element :insuranceProducts, '.sfContentBlock', text: 'Insurance Products'
    element :findAnAgent, '.main-container no-padding-top', text: 'Find an Agent'
    element :learningCenterHome, '.main-container no-padding-top', text: 'Learning Center'
    element :home, '.sfContentBlock', text: 'Home'
    element :careerCenter, '.sfContentBlock', text: 'Career Center'

    def learningCenterHome_visible
      if has_learningCenterHome? && learningCenterHome.visible?
        puts 'Yeah! learningCenterHome is visible on fbfs page!'
      end
    end
  end
end