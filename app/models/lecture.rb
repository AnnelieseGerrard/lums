class Lecture < ApplicationRecord
  belongs_to :course
  has_one :exercise
  has_one_attached :video
  has_many_attached :resources

  validates :title, presence: true
  validates :course, presence: true
end
