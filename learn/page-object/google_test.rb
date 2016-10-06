# $Id: google_test.rb 95 2016-04-06 20:35:25Z e0c2506 $

# Load up our Google class...
require_relative "google.rb"
# Grabbing unit tests too so that I have assert.
require 'test/unit'

##
# This class is here to test our Google page object.
class GoogleTest < Test::Unit::TestCase
  def setup
    # Opens the chrome browser in Selenium (did not have to require Selenium
    # becuase page-object requires it for us).
    browser = Selenium::WebDriver.for :chrome
    # Creates our page object. We'll be using that to interact with the browser
    # while we're on this page.
    @google = Google.new(browser)
    # The browser doesn't navigate itself. We could directly tell the browser
    # to go to google.com, but what's the fun in that?
    @google.navigate_to("http://www.google.com")
  end

  def test_search
    setup

    # We're now on Google. Let's check the title to make sure.
    assert_equal("Google", @google.title)

    # Alright we really are on google, lets search for the page-object gem!
    # First we type "page-object gem" in the search bar...
    @google.search_bar = "page-object gem"
    # Now lets wait until Google's title updates to reflect the fact that we
    # have searched.
    @google.wait_until do
      @google.title == "page-object gem - Google Search"
    end

    # To show how cool this is, lets search a few more terms.
    search_for "some-other gem"
    search_for "so many gems"
    search_for "I'm using Google"
    search_for "Holy automated Google, Batman!"
  end

  def search_for(something)
    # Enter search term...
    @google.search_bar = something
    # Click on the magnifying class to search again...
    @google.search
    # Confirm that the search occurred...
    @google.wait_until do
      @google.title == "#{something} - Google Search"
    end
  end
end
