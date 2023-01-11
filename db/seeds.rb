# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.where(email: 'user1@example.com').first_or_create!(password: 123456, password_confirmation: 123456)

return unless Question.count.zero?

5.times do
  question = Question.find_or_create_by({ question_text: Faker::Lorem.paragraph(sentence_count: 3) })

  question.answers.create({ answer_text: Faker::Lorem.paragraph(sentence_count: 2), point: 3 })
  question.answers.create({ answer_text: Faker::Lorem.paragraph(sentence_count: 2), point: 2 })
  question.answers.create({ answer_text: Faker::Lorem.paragraph(sentence_count: 2), point: 1 })
  question.answers.create({ answer_text: Faker::Lorem.paragraph(sentence_count: 2), point: 0 })
end