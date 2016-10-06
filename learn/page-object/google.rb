# $Id: google.rb 95 2016-04-06 20:35:25Z e0c2506 $

# Require statement loads the page-object gem, which allows us to create page
# object quickly.
require "page-object"

# Each page-object is a class.
class Google
  # Include is a form of horizontal inheritence, pulling all methods and
  # variables from PageObject and injecting them into Google as if
  # Google < PageObject.
  include PageObject

  # This is a method inherited from PageObject. It lets the page object know
  # that there is a text field named "search_bar" which can be found with the
  # id "lst-ib" (wow Google great naming scheme). This will create methods on
  # the page which we will use later (see google_test.rb).
  text_field :search_bar, id: "lst-ib"

  # Similar to the above method, this tells the page there is a button named
  # "search" found by the html name "btnG". (Note: this is the magnifying glass
  # that appears after your first search).
  button :search, name: "btnG"
end
