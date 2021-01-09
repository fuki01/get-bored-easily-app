# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
user = User.create(email: 'fuu05160@gmail.com',username: 'fuki', password: 'password',created_at: "2020-09-17 06:44:16")
target = Target.create(body: "寝る", clear: false, user_id: user.id)
Day.create(count: 1, target_id: target.id, entryday: '2021-1-7', user_id: user.id)