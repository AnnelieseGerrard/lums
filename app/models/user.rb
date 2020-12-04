class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :courses_created, class_name: 'Course'
  has_many :enrollments
  has_many :courses_enrolled, through: :enrollments, source: 'course'
  has_many :submissions
  after_create :enroll

  validates :email, presence: true
  def is_creator?
    return self.is_creator
  end

def enroll
Enrollment.create(user: self, course: Course.all.sample)
end

end
