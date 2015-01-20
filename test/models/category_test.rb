require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  attr_reader :category

  def setup
    @category = Category.create(name: "Superb Idea")
  end

  test "it creates a valid category" do
    assert category.valid?
  end

  test "a category without a name is invalid" do
    unnamed_category = Category.new()
    assert unnamed_category.invalid?
  end

  test "a category has many idea" do
    idea = category.ideas.create(title: "Dinosaurs", description: "In hot air balloons")

    refute category.ideas.empty?
    assert 1, category.ideas.count
    assert idea, category.ideas[0]
  end
end
