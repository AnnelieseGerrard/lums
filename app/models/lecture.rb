class Lecture < ApplicationRecord
  belongs_to :course
  has_one :exercise, dependent: :destroy
  has_one_attached :video, dependent: :destroy
  has_many_attached :resources, dependent: :destroy

  acts_as_list scope: :course

  validates :title, presence: true
  validates :course, presence: true
end
