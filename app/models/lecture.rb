class Lecture < ApplicationRecord
  belongs_to :course
  has_one :exercise, dependent: :destroy
  has_one_attached :video, dependent: :destroy
  has_many_attached :resources, dependent: :destroy
  has_rich_text :description

  acts_as_list scope: :course

  validates :title, presence: true
  validates :course, presence: true
  validates :video, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_title_and_description,
   against: [:title, :description],
   using: {
    tsearch: { prefix: true }
    }
end
