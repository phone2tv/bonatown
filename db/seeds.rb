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
  admin = User.create!(username: 'admin', email: 'admin@example.com', password: 'password')
  admin.add_role :admin
  admin.profile = AdminProfile.create!(name: 'Adminstrator', aboutme: 'Aboutme')
  admin.save!
  print_content "user: #{admin.email}"

  # create moderator
  moderator = User.create!(username: 'moderator', email: 'moderator@example.com', password: 'password')
  moderator.add_role :moderator
  moderator.profile = ModeratorProfile.create!(name: 'Moderator')
  moderator.save!
  print_content "user: #{moderator.email}"

  # create manager
  manager = User.create!(username: 'manager', email: 'manager@example.com', password: 'password')
  manager.add_role :manager
  manager.profile = ManagerProfile.create!(name: 'Manager')
  manager.save!
  print_content "user: #{manager.email}"

  # create quoter
  quoter = User.create!(username: 'quoter', email: 'quoter@example.com', password: 'password')
  quoter.add_role :quoter
  quoter.profile = QuoterProfile.create!(name: 'Quoter')
  quoter.save!
  print_content "user: #{quoter.email}"

  # create park
  park = User.create!(username: 'park', email: 'park@example.com', password: 'password')
  park.add_role :park
  park.profile = ParkProfile.create!(name: 'ParkUser')
  park.save!
  print_content "user: #{park.email}"

  # create customer
  customer = User.create!(username: 'customer', email: 'customer@example.com', password: 'password')
  customer.add_role :customer
  customer.profile = CustomerProfile.create!(name: 'Customer')
  customer.save!
  print_content "user: #{customer.email}"
end

def create_insurances
  print_title('setting up insurances')

  company = Company.create!(name: 'Pacific', website: 'www.pacific.com', aboutme: 'about pacific')

  insur = Insurance.create!(title: 'Accident insurance title 1', synopsis: 'Accident insurance synopsis 1', price: '1.00', company: company)
  insur.profile = AccidentInsurance.create!(body: 'Accident insurance body');
  insur.save!
  print_content "insurance: #{insur.title}"

  insur = Insurance.create!(title: 'Health insurance title 1', synopsis: 'Health insurance synopsis 1', price: '1.00', company: company)
  insur.profile = HealthInsurance.create!(body: 'Health insurance body');
  insur.save!
  print_content "insurance: #{insur.title}"
end

def create_industries
  print_title('setting up insurances')

  industry = Industry.create(name: 'Computer')
  print_content "industry: #{industry.name}"

  industry = Industry.create(name: 'Band')
  print_content "industry: #{industry.name}"
end

def destroy_tables
  print_title('destroy tables')
  User.destroy_all
  print_content "destroy all users"
  Role.destroy_all
  print_content "destroy all roles"
  AccidentInsurance.destroy_all
  print_content "destroy all accident insurances"
  HealthInsurance.destroy_all
  print_content "destroy all health insurances"
end

destroy_tables
create_users
create_insurances
create_industries
