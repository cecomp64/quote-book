# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

quotes = [
    {text: 'That was a good one!', author: 'CE', attribution: 'CE', score: rand(100)},
    {text: 'Now I have 14,000 poop samples.', author: 'Leah', attribution: nil, score: rand(100)},
    {text: 'My friend had this quote book, and it was awesome.', author: 'CE', attribution: 'Kynan', score: rand(100)},
    {text: 'Four score, and seven years ago...', author: 'Anya', attribution: 'Abraham Lincoln', score: rand(100)},
    {text: "That's what she said!", author: 'CE', attribution: 'Michael Scott', score: rand(100)},
    {text: 'Time keeps on ticking... into the future.', author: 'Anya', attribution: nil, score: rand(100)},
    {text: 'How many roads must a man walk down?', author: 'Anya', attribution: 'Bob Dylan', score: rand(100)},
    {text: 'Giant lingham.', author: 'Anya', attribution: 'Shiva The Destroyer', score: rand(100)},
    {text: "Yo, I'll tell you what I want, what I really, really want.", author: 'CE', attribution: 'Spice Girl One', score: rand(100)},
    {text: 'So, tell me what you want, what you really, really want.', author: 'Anya', attribution: 'Spice Girl Two', score: rand(100)},
    {text: 'Ai-ya-ya-ya-ya, I keep on hoping there will be cake by the ocean - Hu!', author: 'Anya', attribution: 'Some Band', score: rand(100)},
    {text: "It's morphin' time!", author: 'Anya', attribution: 'Jason, the Red Ranger', score: rand(100)},
]

anonymous = Person.find_or_create_by(name: 'Anonymous')

quotes.each do |quote|
  author = quote[:author] ? Person.find_or_create_by(name: quote[:author]) : anonymous
  attribution = quote[:attribution] ? Person.find_or_create_by(name: quote[:attribution]) : anonymous
  Quote.create(text: quote[:text], author: author, attribution: attribution, score: quote[:score])
end
