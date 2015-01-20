require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  attr_reader :user, :category, :idea

  def setup
    @user = User.create(username: "example", password: "password")
    visit rool_url
  end

  def set_user_and_idea_and_category
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    @category = Category.create(name: "Good Idea")
    @idea = user.ideas.create(title: "Great Idea", description: "Grow tomatoes", category_id: category.id)
    visit user_path(user)
  end

  test "a user can create ideas" do
    set_user_and_idea_and_category
    fill_in "idea_title", with: "Dinosaurs"
    fill_in "idea_description", with: "On rollerskates"
    select "Good Idea", :from => "idea_category_id"
    click_link_or_button "Create"
    within("#idea_list") do
      assert page.has_content?("Dinosaurs")
      assert page.has_content?("On rollerskates")
    end
  end

  test "registered user sees a list of their ideas" do
    set_user_and_idea_and_category
    within("#idea_list") do
      assert page.has_content?("Great Idea")
      assert page.has_content?("Grow tomatoes")
    end
  end

  test "a user can edit an idea" do
    set_user_and_idea_and_category
    click_link "Edit"
    fill_in "idea_title", with: "Yummy Idea"
    page.click_button('Update Idea')
    within("#idea_list") do
      assert page.has_content?("Yummy Idea")
      refute page.has_content?("Great Idea")
    end
  end

end
