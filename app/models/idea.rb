class Idea < ActiveRecord::Base
  validates :title, :description, :user_id, presence: true
  belongs_to :user
  belongs_to :category
end
