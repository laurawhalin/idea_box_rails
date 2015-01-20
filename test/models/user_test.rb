require 'test_helper'

class UserTest < ActiveSupport::TestCase
  attr_reader :user

  def setup
    @user = User.create(username: "barb", password: "something")
  end

  test "a user is valid" do
    assert user.valid?
  end

  test "a user without a password is invalid" do
    invalid_user = User.new(username: "barb")
    assert invalid_user.invalid?
  end

  test "a user without a username is invalid" do
    invalid_user = User.new(password: "password")
    assert invalid_user.invalid?
  end

  test "a user has many ideas" do
    idea = user.ideas.create(title: "A restaurant", description: "For dinosaurs")

    refute user.ideas.empty?
    assert_equal 1, user.ideas.count
    assert_equal idea, user.ideas[0]
  end
end
