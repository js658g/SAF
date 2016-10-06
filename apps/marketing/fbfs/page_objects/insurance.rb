# encoding: utf-8
# $Id: $

module PageObjects
  ##
  # fbfs.com home page
  #   Inherits SitePrism::Page to show that this is a page
  class Insurance < SitePrism::Page
    # will load the Capybara.app_host and this relative path
    set_url '/insurance'
    set_url_matcher %r{/insurance}

    element :insuranceProducts, '.sfContentBlock', \
            text: 'Insurance Products'
    element :findAnAgent, '.main-container no-padding-top', \
            text: 'Find an Agent'
    element :home, '.sfContentBlock', text: 'Home'
    element :careerCenter, '.sfContentBlock', text: 'Career Center'

    def insurance_products_visible
      if has_insuranceProducts? && insuranceProducts.visible?
        puts 'Yeah! insuranceProducts is visible on fbfs page!'
      end
    end
  end
end
