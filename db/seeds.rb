300.times do
  q = Question.create title:       Faker::Company.bs,
                      body:        Faker::Hipster.paragraph,
                      view_count:  rand(100)
  5.times { q.answers.create body: Faker::ChuckNorris.fact } if q.persisted?
end

["Sports", "Art", "Cats", "Technology", "News"]. each do |cat|
  Category.create name: cat
end

30.times { Tag.create(title: Faker::Hacker.adjective) }

puts Cowsay.say "Generated 300 questions!"
