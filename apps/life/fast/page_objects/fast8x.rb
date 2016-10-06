# encoding: utf-8
# $Id: fast8x.rb 349 2016-05-09 04:50:54Z e0c2425 $

module PageObjects
  ##
  # Fast 8x landing page
  #   Inherits SitePrism::Page to show that this is a page
  class Fast8x < SitePrism::Page
    set_url_matcher %r{index.aspx}
    load_validation { [has_homeLink?, 'ERROR:FAST8x: homeLink not found'] }

    element :homeLink, '.footer-navigation-links', text: 'Home'
    element :advancedSearch, \
            '.header-link noBorder headerToolbarLink', \
            text: 'Advanced Search'
    element :quickTools, '.header-link noBorder headerToolbarLink', \
            text: 'Quick Tools'

    def home_link_visible?
      # wait_for_homeLink
      puts 'ERROR:Fast8x: homeLink not visible' unless (has_homeLink? && homeLink.visible?)
    end
  end
end
