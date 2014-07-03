class User < ActiveRecord::Base
  has_secure_password

  # validations
  validates :password, confirmation: true
  validates :email,
            format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
            uniqueness: true
  validates :name,
            format: /\A(\w+)([-a-z0-9_]+)/i,
            uniqueness: true,
            exclusion: {in: %w(root admin webmaster)},
            length: {within: 3..100}

  # Has many
  has_many :agent_stats
end
