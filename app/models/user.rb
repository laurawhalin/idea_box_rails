class User < ActiveRecord::Base
  validates :username, :password, presence: true
  has_secure_password
  has_many :ideas

  enum role: %w(default admin)

  def admin
    role == "admin"
  end
end
