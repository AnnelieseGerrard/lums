class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :courses
  has_many :enrollments
  has_many :courses, through: :enrollments
  has_many :submissions

  validates :email, presence: true
  validates :is_creator, presence: true
end
