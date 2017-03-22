# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(first: "normal_user",email: "normal_user@gmail.com",password: "normal_user123")
User.create(first: "admin",email: "admin@gmail.com",password: "admin123")
user.roles << Role.create(name: "admin")