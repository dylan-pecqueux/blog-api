# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'moi@moi.fr', password: 'azerty', password_confirmation: 'azerty')

30.times do
  Article.create(title: Faker::FunnyName.name, content: Faker::Quotes::Shakespeare.hamlet_quote, user_id: 1)
end