# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Users

User.destroy_all

cody = User.new(email: "cody@gmail.com", password: "password", firstname: "Cody", lastname: "Cell", is_creator: true)
jess = User.new(email: "jess@gmail.com", password: "password", firstname: "Jess", lastname: "Smith")

# Create Courses
marketing_course = Course.create(title: "Social Media Superstar: Master Selling in the Digital Age", user: cody)

# Enroll Jess in the course
Enrollments.create(user: jess, course: marketing_courses)