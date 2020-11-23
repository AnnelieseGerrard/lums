class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :user, presence: true
  validates :course, presence: true
  validates :course, uniqueness: { scope: :user }
end
