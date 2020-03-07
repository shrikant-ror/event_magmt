class User < ApplicationRecord
  has_many :enrollments
  has_many :events, through: :enrollments, dependent: :destroy
end
