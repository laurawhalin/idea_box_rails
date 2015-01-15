require 'test_helper'

class IdeaTest < ActiveSupport::TestCase

  test "an idea exists" do
    assert Idea.new
  end

  test "an idea is associated with a user" do
    idea = Idea.create(title: "Dinosaurs", description: "On rollerskates", user_id: 1)
    assert_respond_to(idea, :user)
  end
end
