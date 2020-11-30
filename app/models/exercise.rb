class Exercise < ApplicationRecord
  belongs_to :lecture
  has_many :submissions
  has_rich_text :rich_description

  validates :name, presence: true
  validates :rich_description, presence: true
end
