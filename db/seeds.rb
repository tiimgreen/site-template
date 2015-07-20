# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Setting.create(
  key: 'company_name',
  pretty_name: 'Copmany Name',
  value: 'ABC Company'
)

Setting.create(
  key: 'contact_email',
  pretty_name: 'Contact Email',
  value: 'name@company.com'
)

puts "Settings created".green

User.create(
  first_name: 'Tim',
  last_name: 'Green',
  email: 'tiimgreen@gmail.com',
  password: 'password',
  password_confirmation: 'password'
)

puts "User created".green
