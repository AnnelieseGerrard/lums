class Submission < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  has_one_attached :file, dependent: :destroy

  validates :user, presence: true
  validates :exercise, presence: true
  validates :file, presence: true
end
