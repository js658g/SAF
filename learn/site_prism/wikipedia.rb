# $Id: wikipedia.rb 97 2016-04-07 14:20:31Z e0c2506 $
# An experiment on Wikipedia using site_prism as our page object model.

require 'capybara'
require 'selenium-webdriver'
require 'site_prism'
require 'capybara/cucumber'

##
# Wikipedia home page. Inherits from SitePrism::Page to show that this is a
# page.
class Wikipedia < SitePrism::Page
  # Since we set the application host in env.rb, we can just specify the
  # relative path here. This is used to navigate to the page via the URL and is
  # not required.
  set_url "/"

  # element is the generic add widget method. The first argument is the name of
  # the widget, all future arguments are passed directly on to
  # ::Capybara::Node::Finders#find when finding the element.
  element :searchbar, '#searchInput'
  element :searchbutton, 'button[type=submit]'
  element :crazystuff, '#thisisacrazyidthatireallyhopetheydonthave'
end

# A Wikipedia article page.
class WikipediaEntry < SitePrism::Page
  # site_prism supports parameterized URLs, we can use this to say "navigate to
  # the Walrus page" with something like this:
  #   page.load page: "Walrus"
  # This would take us to /wiki/Walrus
  set_url "/wiki{/page}"

  element :searchbar, '#searchInput'
  element :searchbutton, '#searchButton'

  element :header, '#firstHeading'
  element :body, '#bodyContent'
end
