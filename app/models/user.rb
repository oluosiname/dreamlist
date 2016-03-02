class User < ActiveRecord::Base
  has_many :bucketlists
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/,
    message: "invalid. Please use a different email"
  }

  before_create :format_params

  def generate_auth_token
    payload = { user_id: id }
    AuthToken.encode(payload)
  end

  private

  def format_params
    email.downcase!
    name.downcase!
  end
end
