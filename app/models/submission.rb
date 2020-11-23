class Submission < ApplicationRecord
  belongs_to :user
  belongs_to :exercise

  validates :user, presence: true
  validates :exercise, presence: true
end
