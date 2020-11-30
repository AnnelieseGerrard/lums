class Exercise < ApplicationRecord
  belongs_to :lecture
  has_many :submissions

  validates :name, presence: true
  validates :rich_description, presence: true

  include PgSearch::Model
  multisearchable against: [:name, :rich_description]
end
