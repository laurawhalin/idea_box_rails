require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "a user has many ideas" do
    user = User.create(username: "barb", password: "something")
    idea = user.ideas.create(title: "A restaurant", description: "For dinosaurs")

    refute user.ideas.empty?
    assert_equal 1, user.ideas.count
    assert_equal idea, user.ideas[0]
  end
end
