require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  attr_reader :idea

  def setup
    user = User.create(username: "Hilda", password: "password")
    @idea = user.ideas.create(title: "Dinosaurs", description: "On rollerskates")
  end

  test "an idea exists" do
    assert Idea.new
  end

  test "an idea is valid" do
    assert idea.valid?
  end

  test "an idea is not valid without a title" do
    bad_idea = Idea.new(description: "A lonely little description", user_id: 1)
    assert bad_idea.invalid?
  end

  test "an idea is not valid without a description" do
    bad_idea = Idea.new(title: "Idea without a soul", user_id: 1)
    assert bad_idea.invalid?
  end

  test "an idea is not valid without a user_id" do
    bad_idea = Idea.new(title: "An idea", description: "Without an owner")
    assert bad_idea.invalid?
  end

  test "an idea is associated with a user" do
    assert_respond_to(idea, :user)
  end
end
