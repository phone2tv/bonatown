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

def print_summary(content)
  puts "== #{content}"
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
  company = Company.create!(name: 'Pingan', website: 'www.pingan.com', aboutme: 'about pingan')

  insur = AccidentInsurance.create!(title: 'Accident insurance title 1', synopsis: 'Accident insurance synopsis 1', price: '1.00', company: company)
  print_content "insurance: #{insur.title}"

  insur = HealthInsurance.create!(title: 'Health insurance title 1', synopsis: 'Health insurance synopsis 1', price: '1.00', company: company)
  print_content "insurance: #{insur.title}"

  insur = PublicLiabilityInsurance.create!(title: 'Public Liability insurance title 1', synopsis: 'Public Liability insurance synopsis 1', price: '1.00', company: company)
  print_content "insurance: #{insur.title}"

  insur = ProductLiabilityInsurance.create!(title: 'Product Liability insurance title 1', synopsis: 'Product Liability insurance synopsis 1', price: '1.00', company: company)
  print_content "insurance: #{insur.title}"

  insur = EmployerLiabilityInsurance.create!(title: 'Employer Liability insurance title 1', synopsis: 'Employer Liability insurance synopsis 1', price: '1.00', company: company)
  print_content "insurance: #{insur.title}"
end

def create_industries
  print_title('setting up insurances')

  industry = Industry.create(name: 'Computer')
  print_content "industry: #{industry.name}"

  industry = Industry.create(name: 'Band')
  print_content "industry: #{industry.name}"
end


# data line format:
#   insert Data_Province values(199,'110000','Beijing')
def import_provinces
  Province.destroy_all
  print_title('importing provinces')
  File.open 'db/1_sql_insert_province.sql', 'r' do |file|
    while row = file.gets
      row.strip!
      columns = /.+\(\d+,'(\d+)','(.+)'\)/.match(row)
      code = columns[1]
      name = columns[2]
      province = Province.create(code: code, name: name)
      print_content "imported province: #{province.id}, #{province.code}, #{province.name}"
    end
  end
  print_summary "total imported provinces count: #{Province.count}"
end

# data line format:
#   insert Data_City values(1,'110100','Beijing','110000')
#   insert Data_City values(3,'120100','Tianjing','120000')
def import_cities
  City.destroy_all
  print_title('importing cities')
  File.open 'db/2_sql_insert_city.sql', 'r' do |file|
    while row = file.gets
      row.strip!
      columns = /.+\(\d+,'(\d+)','(.+)','(\d+)'\)/.match(row)
      code = columns[1]
      name = columns[2]
      province_code = columns[3]
      city = City.create(code: code, name: name, province_code: province_code)
      print_content "imported city: #{city.id}, #{city.code}, #{city.name}, #{city.province_code}"
    end
  end
  print_summary "total imported cities count: #{City.count}"
end

# data line format:
#   insert Data_Area values(1,'110101','东城区','110100')
#   insert Data_Area values(2,'110102','西城区','110100')
def import_districts
  District.destroy_all
  print_title('importing districts')
  File.open 'db/3_sql_insert_area.sql', 'r' do |file|
    while row = file.gets
      row.strip!
      columns = /.+\(\d+,'(\d+)','(.+)','(\d+)'\)/.match(row)
      code = columns[1]
      name = columns[2]
      city_code = columns[3]
      district = District.create(code: code, name: name, city_code: city_code)
      print_content "imported district: #{district.id}, #{district.code}, #{district.name}, #{district.city_code}"
    end
  end
  print_summary "total imported districts count: #{District.count}"
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
import_provinces
import_cities
import_districts
