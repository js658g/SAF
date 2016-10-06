# encoding: utf-8
# $Id: $
require "site_prism"

class FastDropDownBox
  attr_reader :hidden_field_name
  
  def self.select(hidden_field_name, option)
    box = FastDropDownBox.new(hidden_field_name)
    box.select(option)
  end
  
  def initialize(hidden_field_name)
    @hidden_field_name = hidden_field_name
  end
  
  def disabled?
    down_arrow.disabled?
  end
  
  def hover
    down_arrow.hover
  end
  
  def right_click
    down_arrow.down_click
  end
  
  def set(option)
    select(option)
  end
  
  def visible?
    down_arrow.visible?
  end
  
  def down_arrow
    @down_arrow ||= Capybara.find(:xpath,
                                  "//input[@name='#{@hidden_field_name}']/../"\
                                  "img[@class='x-form-trigger "\
                                  "x-form-arrow-trigger']")
  end
  
  def select(option)
    # Click on down arrow
    down_arrow.send_keys(nil)
    down_arrow.click
    # Click on selection
    begin
      selection = Capybara.find(:xpath, "//div[contains(@class, 'x-combo-list')]"\
                                "[not(contains(@style, 'hidden'))]/"\
                                "div[@class='x-combo-list-inner']/"\
                                "div[contains(., '#{option}')]")
      selection.click
    rescue Capybara::Ambiguous => e
    # If no selection, close down arrow
      down_arrow.click
      raise e
    rescue Capybara::ElementNotFound => e
      down_arrow.click
      raise e
    end
  end
end

module SitePrism
  module ElementContainer
    ##
    # Defines a fast drop down box on the page.
    def fast_drop_down_box(element_name, hidden_field_name)
      fddb = FastDropDownBox.new(hidden_field_name)
      define_method(element_name) do
        fddb
      end
    end
  end
end
