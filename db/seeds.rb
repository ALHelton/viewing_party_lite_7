# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

axel = User.create(name:"Axel", email:"axel@gmail.com", admin:false)
hady = User.create(name:"Hady", email:"hady@gmail.com", admin:false)
caleb = User.create(name:"Caleb", email:"caleb@gmail.com", admin:true)


