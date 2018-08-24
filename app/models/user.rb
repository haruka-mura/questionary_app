class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { minimum: 6 }

  has_many :questions
  has_many :answers

  has_secure_password
end
