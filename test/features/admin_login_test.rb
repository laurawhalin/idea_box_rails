require 'test_helper'

class AdminLoginTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  attr_reader :admin_user

  def setup
    @admin_user = User.create(username: "Big Bertha", password: "password", role: "admin")
    visit root_url
  end

  test "unregistered user cannot view a user's profile" do
    user = User.create(username: "Hilda", password: "password")
    ApplicationController.any_instance.stubs(:current_user).returns(nil)
    visit user_path(user)
    within("#flash_alert") do
      assert page.has_content?("Not authorized.")
    end
  end

  test "registered user cannot view other users' profile" do
    user = User.create(username: "Hilda", password: "password")
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    protected_user = User.create(username: "protected", password: "password")
    visit user_path(protected_user)
    within("#flash_alert") do
      assert page.has_content?("You are not authorized to access this page.")
    end
  end

  test "admin user can see another user's profile" do
    ApplicationController.any_instance.stubs(:current_user).returns(admin_user)
    user = User.create(username: "Hilda", password: "password")
    visit user_path(user)
    within("#banner") do
      assert page.has_content?("Welcome, Hilda")
    end
  end

end
