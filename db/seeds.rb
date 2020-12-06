# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(id: 1,email: 'fuu05160@gmail.com',username: 'fuki', password: 'password',created_at: "2020-09-17 06:44:16")
Target.create(id: 1, body: 'testdata', user_id: 1)
Point.create(sum: "100", target_id: 1, User_id:1)
Day.create(count: 2, target_id: 1, entryday: "2020-11-19")
Point.create(sum: "200", target_id: 1, User_id:1)
Day.create(count: 3, target_id: 1, entryday: "2020-11-21")