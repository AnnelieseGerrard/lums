class Lecture < ApplicationRecord
  belongs_to :course
  has_one :exercise

  validates :title, presence: true
  validates :course, presence: true
end
