# encoding: utf-8
# $Id: login.rb 349 2016-05-09 04:50:54Z e0c2425 $
module PageObjects
  ##
  # Fast login page using FBL standard user authentication form
  #   Inherits SitePrism::Page to show that this is a page
  class Login < SitePrism::Page
    # will load the Capybara.app_host and this relative path
    set_url '/login.html'
    set_url_matcher %r{/login}

    # When loaded? is called on an instance of page, the validations will be
    # performed in the following order:
    # 1. The SitePrism::Page default load validation will check displayed?
    # 2. Then if the class representing the page has load_validation, they will
    # be performed
    load_validation { [has_loginWrapper?, 'ERROR:Login: loginWrapper not found'] }

    element :loginWrapper, '.loginWrapper'
    element :username, 'input[name="txtUsername"]'
    element :password, 'input[name="txtPassword"]'
    element :loginSubmit, 'div[id="btnSubmit"]'

    def login_with(usr_name, usr_password)
      username.set usr_name
      password.set usr_password
      # loginSubmit.click
    end

  end

  ##
  # Fast login page. Inherits SitePrism::Page to show that this is a page
  class LoginFBL < SitePrism::Page
    # will load the Capybara.app_host and this relative path
    set_url '/index.aspx'
    set_url_matcher %r{/index}

    load_validation { [has_loginValue?, 'ERROR:LoginFBL: loginValue not found'] }

    element :username, 'input[name="username"]'
    element :password, 'input[name="password"]'
    element :loginValue, 'input[value="Login"]'

    def login_with(usr_name, usr_password)
      username.set usr_name
      password.set usr_password
      # loginValue.native.send_keys :enter
    end

  end
end
