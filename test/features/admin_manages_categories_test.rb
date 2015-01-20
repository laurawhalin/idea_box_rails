require 'test_helper'

class AdminLoginTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  attr_reader :admin_user

  def setup
    @admin_user = User.create(username: "Big Bertha", password: "password", role: "admin")
    visit root_url
  end

  test "admin can create a new category" do
    ApplicationController.any_instance.stubs(:current_user).returns(admin_user)
    visit user_path(admin_user)
    click_link "Add New Category"
    fill_in "category_name", with: "Super Idea"
    click_link_or_button "Save Category"
    within("#categories") do
      select "Super Idea", :from => "category_name"
    end
  end

  test "non-admin cannot create a new category" do

  end
end
