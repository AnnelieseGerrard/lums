class Lecture < ApplicationRecord
  belongs_to :course
  has_one :exercise, dependent: :destroy
  has_one_attached :video, dependent: :destroy
  has_many_attached :resources, dependent: :destroy
  has_rich_text :description

  validates :title, presence: true
  validates :course, presence: true
end
