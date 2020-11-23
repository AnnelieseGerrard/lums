class Exercise < ApplicationRecord
  belongs_to :lecture

  validates :name, presence: true
  validates :rich_description, presence: true
  validates :lecture, presence: true
  validates :is_assessed, presence: true
end
