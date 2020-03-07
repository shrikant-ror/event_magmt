class Event < ApplicationRecord
  belongs_to :organizer, class_name: "User"
  has_many :enrollments
  has_many :users, through: :enrollments, dependent: :destroy
end
