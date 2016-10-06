SitePrism.configure do |config|
  # By default, SitePrism requires explicit waits, so either
  #   wait_for_<element> or wait_until_<element>_visible.
  #   This configures SitePrism to use Capybara implicit
  #   waits for the has_ and has_no_ methods in SitePrism.
  config.use_implicit_waits = true
end