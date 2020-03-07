class User < ApplicationRecord
  has_many :enrollments
  has_many :events, through: :enrollments, dependent: :destroy


  validates :username, presence: true, uniqueness: true
  validates :phone, presence: true
  # The Ruby standard library provides a regexp for email validation
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
