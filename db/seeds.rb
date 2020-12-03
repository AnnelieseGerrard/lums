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
puts "Creating Cody and Tom"
cody = User.create(email: "cody@gmail.com", password: "password", firstname: "Cody", lastname: "Cell", is_creator: true)
tom = User.create(email: "tom@gmail.com", password: "password", firstname: "Tom", lastname: "Jackson")

puts "Creating 350 other Users"
350.times do 
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
direct_marketing_course = Course.create(title: "Direct Marketing: How to Get the Deal", user: cody,
                                        image: {io: File.open(direct_marketing_course_image), filename: "direct_marketing_course_image.jpeg", content_type: 'image/jpeg' })

puts
puts "##### Enrolling Users in Courses #####"
# Enroll Tom in the social media marketing course
puts "Enrolling Tom in the social media marketing course"
Enrollment.create(user: tom, course: social_media_marketing_course)

# Enroll every other user into 1 or more courses.
puts "Enrolling other users randomly in courses"
User.where.not(id: tom.id).each do |user|
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
video_file = URI.open('https://res.cloudinary.com/dsogzo1mn/video/upload/v1606330186/lums/seed_originals/intro_to_marketing_short_ioorcw.webm')
puts "Downloading Powerpoint File from Cloudinary"
ppt_file = URI.open('https://res.cloudinary.com/dsogzo1mn/raw/upload/v1606246928/lums/seed_originals/Lums_vunfrx.pptx')

############# Social Media Marketing Course ###################

social_media_course_lecture_titles = ["Course Introduction", "Setup Your Accounts", "The Golden rule: Tailor, Tailor Tailor!", 
                                      "Facebook Ads - What works best?", "Creating Facebook Ads", "Managing Facebook campaigns", 
                                      "Youtube - What works best?", "Creating Youtube Ads", "Managing YouTube campaigns"]

social_media_course_lecture_descriptions = [
  "In this lecture, you will receive an overview of the course, and by the end you will have a clear understanding of what is coming",
  "In this lecture, you will setup all the accounts needed for the course, and by the end you will fully setup your Facebook, and Youtube marketing accounts",
  "In this lecture, you will learn the golden rule of online marketing -- Tailor, Tailor, Tailor!",
  "In this lecture, you will learn what works types of ads work best on the Facebook platform",
  "In this lecture, you will learn about the Facebook back panel, and by the end you be able to create your own Facebook ads",
  "In this lecture, you will learn about the Facebook campaign interface, and by the end you be able to track progress on your Facebook ads campaigns, and evaluate their performance",
  "In this lecture, you will learn what types of ads work best on the YouTube platform",
  "In this lecture, you will learn how to create ads in Youtube",
  "In this lecture, you will learn about the Youtube back panel, and by the end you be able to create your own Youtube ads",
  "In this lecture, you will learn about the Youtube campaign interface, and by the end you be able to track progress on your Youtube ads campaigns, and evaluate their performance"
  ]

social_media_course_exercise_titles = []
social_media_course_lecture_titles.each {|title| social_media_course_exercise_titles << "#{title} - Exercise"}

social_media_course_exercise_descriptions = [
  "Make a plan of your goals for the course",
  "Setup all your accounts following the steps in the lecture",
  "Make a list of the different platforms you are on, and the ways that you have noticed the platform culture differing",
  "Make a plan for how you can take advantage of the specific things that work on Facebook for your campaigns",
  "Create your first facebook ad using the Facebook back panel!",
  "Run different variations of your Facebook campaign, and run an analysis to find which version performed best",
  "Make a plan for how you can take advantage of the specific things that work on YouTube for your campaigns",
  "Create your first YouTube ad using the YouTube back panel!",
  "Run different variations of your YouTube campaign, and run an analysis to find which version performed best"
 ]

puts
puts "##### Building Social Media Marketing Course ##### "

social_media_course_curriculum_items = social_media_course_lecture_titles.zip(social_media_course_lecture_descriptions, 
                                                                              social_media_course_exercise_titles,
                                                                              social_media_course_exercise_descriptions)
                                                                              
social_media_course_curriculum_items.each_with_index do |data, index|
  title = data[0]
  lecture_description = data[1]
  exercise_title = data[2]
  exercise_description = data[3]
  
  puts "Creating Lecture #{index + 1} for the Social Media Marketing Course"
  lecture = Lecture.create(title: title, course: social_media_marketing_course, description: lecture_description,
    video: {io: File.open(video_file), filename: "marketing_101.mp4", content_type: 'video/mkv' }, 
    resources: [], position: index+1)
    
    puts "Attaching Lecture #{index + 1} resources for the Social Media Marketing Course"
  lecture.resources.attach(io: File.open(ppt_file), filename: "lecture_slides.pptx", content_type: ppt_file.content_type) 
  puts "Creating Exercise #{index + 1} for the Social Media Marketing Course"
  Exercise.create(name: exercise_title, rich_description: exercise_description, lecture: lecture)
end
 
############# Direct Marketing Course ###################

direct_marketing_course_lecture_titles = ["Course Introduction", "Setup Your Desk", "Crafting the Perfect Sales Script", "How to Get Over Nerves" ,
  "Tracking Progress", "Make the call!"]
  
direct_marketing_course_lecture_descriptions = [
  "In this lecture, you will receive an overview of the course, and by the end you will have a clear understanding of what is coming",
  "In this lecture, you will setup all the accounts needed for the course, and by the end you will fully setup your desk for making calls!",
  "In this lecture, you will learn the elements of a great sales script, and by the end you be able to craft one for yourself!",
  "In this lecture, you will learn some secrets that apply cutting edge neuroscience to overcome nerves!",
  "In this lecture, you will learn the importance of tracking the outcome of calls, and learn some common ways to do so",
  "Todays the day! Go get started on your calls!"
]
  
direct_marketing_course_exercise_titles = []
direct_marketing_course_lecture_titles.each {|title| direct_marketing_course_exercise_titles << "#{title} - Exercise"}

direct_marketing_course_exercise_descriptions = [
  "Make a plan of your goals for the course",
  "Setup your desk following the steps in the lecture",
  "Craft your own sales script for your product",
  "Try the exercises suggested in the lecture and reflect on your experience",
  "Generate your call-log spreadsheet",
  "Submit a reflection on how your calls are going, what is going well, and ways you might like to improve"
]

puts ""
puts "##### Building Direct Marketing Course ##### "
  
direct_marketing_course_curriculum_items = direct_marketing_course_lecture_titles.zip(direct_marketing_course_lecture_descriptions, 
                                                                                  direct_marketing_course_exercise_titles,
                                                                                  direct_marketing_course_exercise_descriptions)

direct_marketing_course_curriculum_items.each_with_index do |data, index|
  title = data[0]
  lecture_description = data[1]
  exercise_title = data[2]
  exercise_description = data[3]
  
  puts "Creating Lecture #{index + 1} for the Direct Marketing Course"
  lecture = Lecture.create(title: title, course: direct_marketing_course, description: lecture_description,
    video: {io: File.open(video_file), filename: "marketing_101.mp4", content_type: 'video/mkv' }, 
    resources: [], position: index+1)
    
    puts "Attaching Lecture #{index + 1} resources for the Direct Marketing Course"
    lecture.resources.attach(io: File.open(ppt_file), filename: "lecture_slides.pptx", content_type: ppt_file.content_type) 
    puts "Creating Exercise #{index + 1} for the Direct Marketing Course"
    Exercise.create(name: exercise_title, rich_description: exercise_description, lecture: lecture)
  end

# Make last lectures assessed
[social_media_marketing_course, direct_marketing_course].each do |course|
  last_exercise = course.lectures.last.exercise
  last_exercise.is_assessed = true
  last_exercise.save
end

puts
puts "Database seeded successfully."