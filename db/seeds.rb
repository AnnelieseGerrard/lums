require 'open-uri'

# Destroy all entries in database
puts
puts "##### Deleting All Records #####"

puts "Deleting all Courses"
Course.destroy_all
puts "Deleting all Enrollments"
Enrollment.destroy_all
puts "Deleting all Exercises"
Exercise.destroy_all
puts "Deleting all Lectures"
Lecture.destroy_all
puts "Deleting all Submissions"
Submission.destroy_all
puts "Deleting all Users"
User.destroy_all

# Create Users
puts
puts "##### Creating new Users #####"
puts "Creating Cody and Jess"
cody = User.create(email: "cody@gmail.com", password: "password", firstname: "Cody", lastname: "Cell", is_creator: true)
jess = User.create(email: "jess@gmail.com", password: "password", firstname: "Jess", lastname: "Smith")

puts "Creating 33 other Users"
33.times do 
  User.create(email: Faker::Internet.unique.email, password: Faker::Internet.password(min_length: 8, max_length: 12), 
              firstname: Faker::Name.first_name, lastname: Faker::Name.last_name)
end

# Create Courses
puts
puts "##### Creating Courses #####"
puts "Downloading Course Images from Cloudinary"
social_media_marketing_course_image = URI.open('https://res.cloudinary.com/dsogzo1mn/image/upload/v1606255217/lums/seed_originals/social_media_marketing_course_image_qkdcha.jpg')
direct_marketing_course_image = URI.open('https://res.cloudinary.com/dsogzo1mn/image/upload/v1606255629/lums/seed_originals/direct_marketing_course_image_uihgbw.jpg')

puts "Creating Social Media Marketing Course"
social_media_marketing_course = Course.create(title: "Social Media Superstar: Master Selling in the Digital Age", user: cody, 
                                              image: {io: File.open(social_media_marketing_course_image), filename: "social_media_marketing_course_image.jpeg", content_type: 'image/jpeg' })
puts "Creating Direct Marketing Course"
direct_marketing_course = Course.create(title: "Socially Acceptable Harassment: How to Never take No for an Answer", user: cody,
                                        image: {io: File.open(direct_marketing_course_image), filename: "direct_marketing_course_image.jpeg", content_type: 'image/jpeg' })

puts
puts "##### Enrolling Users in Courses #####"
# Enroll Jess in the social media marketing course
puts "Enrolling Jess in the social media marketing course"
Enrollment.create(user: jess, course: social_media_marketing_course)

# Enroll every other user into 1 or more courses.
puts "Enrolling other users randomly in courses"
User.where.not(id: jess.id).each do |user|
  number_of_courses = [1,2].sample # enroll the student in 1 or 2 courses
  if number_of_courses == 2
    user.courses_enrolled = [social_media_marketing_course, direct_marketing_course] # enroll the user in both
  else
    user.courses_enrolled << [social_media_marketing_course, direct_marketing_course].sample # enroll the user in one course at random
  end
end

puts
puts "##### Downloading Dummy Files from Cloudinary ##### "
# Create some lectures for marketing course
puts "Downloading Video File from Cloudinary"
video_file = URI.open('https://res.cloudinary.com/dsogzo1mn/video/upload/v1606250718/lums/seed_originals/intro_to_marketing_short_dlsl9w.mkv')
puts "Downloading Powerpoint File from Cloudinary"
ppt_file = URI.open('https://res.cloudinary.com/dsogzo1mn/raw/upload/v1606246928/lums/seed_originals/Lums_vunfrx.pptx')
puts "Downloading Word Doc from Cloudinary"
word_file = URI.open('https://res.cloudinary.com/dsogzo1mn/raw/upload/v1606248758/lums/seed_originals/quiz1_pi2mjq.docx')

possible_resources = [ppt_file, word_file]

puts
puts "##### Building Social Media Marketing Course ##### "

9.times do |i|
  puts "Creating Lecture #{i+1} for the Social Media Marketing Course"
  lecture = Lecture.create(title: "Social Marketing 10#{i+1}", course: social_media_marketing_course, 
                           video: {io: File.open(video_file), filename: "marketing_101.mp4", content_type: 'video/mkv' }, 
                           resources: [], position: i+1)
    
    puts "Attaching Lecture #{i+1} resources for the Social Media Marketing Course"
    n_resources = (0 .. possible_resources.length).to_a.sample
    lecture_resources = possible_resources.sample(n_resources)
    lecture_resources.each do |resource|
      if resource.object_id == ppt_file.object_id
        lecture.resources.attach(io: File.open(ppt_file), filename: "lecture_slides.pptx")
      else
        lecture.resources.attach(io: File.open(word_file), filename: "further_reading.docx")
      end
    end
    
    puts "Creating Exercise #{i+1} for the Social Media Marketing Course"
    Exercise.create(name: "Exercise 10#{i+1}", rich_description: Faker::Markdown.sandwich(sentences: 6, repeat: 5), lecture: lecture)
    puts 
  end 
  
puts
puts "##### Building Direct Marketing Course ##### "
9.times do |i|
  puts "Creating Lecture #{i+1} for the Direct Marketing Course"
  lecture = Lecture.create(title: "Direct Marketing 10#{i+1}", course: direct_marketing_course, 
                           video: {io: File.open(video_file), filename: "marketing_101.mp4", content_type: 'video/mp4' }, 
                           position: i+1)

  puts "Creating Exercise #{i+1} for the Direct Marketing Course"
  Exercise.create(name: "Exercise 10#{i+1}", rich_description: Faker::Markdown.sandwich(sentences: 6, repeat: 5), lecture: lecture)
  puts
end 

# Make it so the last lecture in each course accepts submissions
puts
puts "##### Making last lecture of each course accept submissions ##### "
[social_media_marketing_course, direct_marketing_course].each do |course|
  last_exercise = course.lectures.last.exercise
  last_exercise.is_assessed = true
  last_exercise.save
end

puts
puts "Database seeded successfully."