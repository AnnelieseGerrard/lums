class Course < ApplicationRecord
  belongs_to :user
  has_many :enrollments
  has_many :lectures
  
  validates :title, presence: true
  validates :user, presence: true
end
