# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def print_title(title)
  puts "\n== #{title}"
end

def print_content(content, level = 1)
  indent = '   ' * level
  puts "#{indent}=> #{content}"
end

def create_users
  print_title('setting up users')

  # create admin
# admin = User.create!(username: 'admin', email: 'admin@example.com', password: 'password', terms_of_service: true)
  admin = User.create!(username: 'admin', email: 'admin@example.com', password: 'password')
  admin.add_role :admin
  admin.profile = AdminProfile.create!(nickname: 'Nickname', realname: 'Realname', aboutme: 'Aboutme')
  admin.save!
  print_content "user: #{admin.email}"

  # create moderator
  moderator = User.create!(username: 'moderator', email: 'moderator@example.com', password: 'password')
  moderator.add_role :moderator
  moderator.profile = ModeratorProfile.create!(realname: 'Realname')
  moderator.save!
  print_content "user: #{moderator.email}"
end

def destroy_tables
  print_title('destroy tables')
  User.destroy_all
  print_content "destroy all users"
  Role.destroy_all
  print_content "destroy all roles"
end

destroy_tables
create_users
