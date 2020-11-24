class Course < ApplicationRecord
  belongs_to :user
  has_many :enrollments, dependent: :destroy
  has_many :lectures, dependent: :destroy
  
  validates :title, presence: true
  validates :user, presence: true
end
