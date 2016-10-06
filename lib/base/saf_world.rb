# encoding: utf-8
# $Id: $

##
# collection of methods available for all tests
module SAFWorld
  ##
  # load the page (using the page object set_url value),
  # and if we have passed in a block it will yield to the
  # block, and either way it will return the page, so we can
  # call methods on the returned page. In other words:
  #   visit_page('Login').login(username, password)
  def visit_page(name, args = {}, &block)
    build_page(name).tap do |page|
      page.load(args)
      yield page if block
    end
  end

  ##
  # asserts that the app is on the page that the test claims
  # it will be on. and if we have passed in a block it will
  # yield to the block, and either way it will return the page,
  # so we can call methods on the returned page.
  def on_page(name, args = {}, &block)
    build_page(name).tap do |page|
      expect(page).to be_displayed(args)
      yield page if block
    end
  end

  ##
  # get class names for page objects pages (previously defined
  # within PageObjects modules, e.g. Home, FindAnAgent)
  def build_page(name)
    name = name.to_s.camelize if name.is_a? Symbol
    Object.const_get('PageObjects').const_get(name).new
  end

  ##
  # check for a collection of elements present on page, e.g.
  #   all_navigation_elements = %w{one two three four five}
  #   visit_page('Login').login(user1.username, user1.password)
  #   on_page('Dashboard') do |page|
  #     should_see = %w{one}
  #     has_these_elements(page.navigation, should_see, all_elements)
  #   end
  def collect_elements(page, has_these, all)
    has_these.each do |element|
      expect(page).to send("have_#{element}")
    end
    does_not_have = all - has_these
    does_not_have.each do |element|
      expect(page).to send("have_no_#{element}")
    end
  end
end