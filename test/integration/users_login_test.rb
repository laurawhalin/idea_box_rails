require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  attr_reader :user

  def setup
    @user = User.create(username: "example", password: "password")
    visit root_url
  end

  test "registered user can log in" do
    fill_in "session[username]", with: "example"
    fill_in "session[password]", with: "password"
    click_link_or_button "Log In"
    within("#banner") do
      assert page.has_content?("Welcome, example")
    end
  end

  test "unregistered user sees error" do
    fill_in "session[username]", with: "rebecca"
    fill_in "session[password]", with: "password"
    click_link_or_button "Log In"
    within("#flash_errors") do
      assert page.has_content?("Unauthorized. Go away Rebecca.")
    end
  end

  test "registered user sees a list of their ideas" do
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    idea = user.ideas.create(title: "Great Idea", description: "Grow tomatoes")
    visit user_path(user)
    within("#idea_list") do
      assert page.has_content?("Great Idea")
      assert page.has_content?("Grow tomatoes")
    end
  end

  test "user sees successful logout message when they log out" do
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit user_path(user)
    click_link_or_button "Log Out"
    within("#flash_notice") do
      assert page.has_content?("You have been logged out.")
    end
  end

end
