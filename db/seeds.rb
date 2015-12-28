# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
unless User.exists?(email: "linghan_xing@alumni.brown.edu")
  User.create!(email: "linghan_xing@alumni.brown.edu",
               password: "password",
               first_name: 'Linghan',
               last_name: 'Xing',
               admin: true,
               qb_id: "7591182", 
               description: %"Born in a southeast city in Zhejiang, China, I always have an insatiable desire to explore, to improve and to find a better self.

  I finished my college in England, UK and moved to Shanghai for a career in engineering consultant for a short period of time. Then i quickly find out thats not where my passion lies. and thats when i realize I need to change the way I live, and look for my true passion. What comes next was a very dramatical change in my life...I abandoned my career intop building consulting firm in China; switching my career path from building service engineering to general management and business route; Relocate to a completely strange country and a city that I've never heard of 1 year before; Reclaiming my identity as a graduate student in a small research University...

  So far i think I'm walking on a path that i truly am fond of. I love great design, and i enjoy being a developer while have a blend of entrepreneurship spirit. I am particularly interest in EdTech area.")
end

unless User.exists?(email: "meixing_dong@alumni.brown.edu")
  User.create!(email: "meixing_dong@alumni.brown.edu",
               password: "password",
               first_name: 'Meixing',
               last_name: 'Dong',
               admin: true,
               qb_id: "7591226")
end

unless User.exists?(email: "mike.nielsen15@outlook.com")
  User.create!(email: "mike.nielsen15@outlook.com",
               password: "admin123",
               first_name: 'Mike',
               last_name: 'Nielesen',
               admin: true,
               qb_id: "7590962" )
end

unless Institution.exists?(name: 'Brown university')
  # need a line of code to validate Brown institution.program.exists?
  institution_list = SmarterCSV.process('./lib/tasks/institution_list.csv')

  institution_list.each do |institution|
    Institution.create!(name: institution[:name],
                        description: institution[:description],
                        city: institution[:city],
                        state: institution[:state],
                        country: institution[:country]
                      )
  end

  program_input_list = SmarterCSV.process('./lib/tasks/program_list.csv')

  program_input_list.each do |program|
    Program.create!(title: program[:program],
                    institution: Institution.find_by(name: program[:institution])
                    )
  end
end

unless Category.exists?(name: 'UX')
  category_list = SmarterCSV.process('./lib/tasks/category_list.csv')
  category_list.each do |category|
    Category.create!(name: category[:name],
                     icons: category[:icons])
  end
end

# This skill seed is deactivated.
# unless Skill.exists?(name: 'Econ 1630')
#   brown_economics_skills = SmarterCSV.process(
#   './lib/tasks/brown_economics_skills.csv')
#   brown_economics_skills.each do |skill|
#     Skill.create!(
#       name: skill[:name],
#       description: skill[:description],
#       points: skill[:points],
#       program: Institution.find_by(name: 'Brown university').programs.select { |n|
#       n[:title] == 'Economics' }[0],
#       user: User.find_by(email: 'linghan_xing@alumni.brown.edu'),
#       category: Category.find_by(name: skill[:category])
#     )
#   end
# end

# 30.times do
#   User.create!(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     email: Faker::Internet.email,
#     password: "password",
#     description: Faker::Lorem.paragraph(10)
#   )
# end
#
# 3000.times do
#   Skill.create!(
#     name: Faker::Name.name,
#     description: Faker::Lorem.sentence,
#     points: rand(2)+1,
#     program: Program.all.sample,
#     user: User.all.sample,
#     category: Category.all.sample
#   )
# end
#
# 500.times do
#   Review.create!(
#     institution: Institution.all.sample,
#     user: User.all.sample,
#     title: Faker::Lorem.sentence,
#     rating: rand(11),
#     content: Faker::Lorem.paragraph,
#     program: Program.all.sample
#   )
# end
#
# 30.times do
#   Institution.create!(
#     name: Faker::University.name,
#     description: Faker::Lorem.paragraph,
#     city: Faker::Address.city,
#     country: Faker::Address.country,
#     state: Faker::Address.state
#   )
# end
#
# 400.times do
#   Program.create!(
#     title: Faker::Book.title,
#     description: Faker::Lorem.paragraph
#   )
# end
#
# 200.times do
#   UserProgramAttendancy.create!(
#     user: User.all.sample,
#     program: Program.all.sample,
#     start_date: Faker::Date.backward(1200),
#     end_date: Faker::Date.forward(1200),
#     url: Faker::Internet.url
#   )
# end
