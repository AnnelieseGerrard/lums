class Lecture < ApplicationRecord
  belongs_to :course

  validates :title, presence: true
  validates :course, presence: true
end
