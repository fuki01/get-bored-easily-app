# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: 'fuu05160@gmail.com',username: 'fuki', password: 'password',created_at: "2020-09-17 06:44:16")
Target.create(body: '単語を覚える', user_id: 1)
Day.create(count: 1, target_id: 1, entryday: "2020-09-15")
Day.create(count: 2, target_id: 1, entryday: "2020-09-16")
Day.create(count: 3, target_id: 1, entryday: "2020-09-17")
