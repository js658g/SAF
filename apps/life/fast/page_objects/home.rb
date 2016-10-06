# encoding: utf-8
# $Id: home.rb 349 2016-05-09 04:50:54Z e0c2425 $
require 'capybara'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'site_prism'

module PageObjects
  ##
  # Fast home page
  #   Inherits SitePrism::Page to show that this is a page
  class Home < SitePrism::Page
    set_url_matcher %r{index}

    # When loaded? is called on an instance of page, the validations will be
    # performed in the following order:
    # 1. The SitePrism::Page default load validation will check displayed?
    # 2. Then if the class representing the page has load_validation, they
    # will be performed.
    # However, this does not mean that the page we intended to be loaded was
    # the one displayed, for example, the FAST application temporarily loads
    # page Fast8x then the Home page. Thus it is important that we have a
    # validation that the landingPageHeader element appears and that the
    # whomever loads the page calls page.loaded?

    load_validation { [has_mainMenu?, 'mainMenu not found'] }
    load_validation { [has_landingPageHeader?, 'landingPageHeader not found'] }
    load_validation { [has_tasksInQueue?, 'tasksInQueue not found'] }

    element :mainMenu, 'div[class="f8x-menu"]', text: 'Main Menu'
    element :newNBLifeApp, 'div[class="f8x-menu-link"]',
            text: 'New NB Life Application'
    element :history, 'div[class=" f8x-menu"]', text: 'History'
    element :landingPageHeader, '.landingPageHeader'
    element :tasksInQueue, 'label[class="landingPageHeader"]',
            text: 'Tasks In Queue'

    def main_menu(selection)
      # has_mainMenu? && mainMenu.visible?
      # mainMenu.send_keys(nil)
      mainMenu.click
      case selection
        when 'New NB Life Application'
          newNBLifeApp.click
        else
          puts 'TODO: more main menu selections'
      end
    end

  end
end
