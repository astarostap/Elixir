# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


questions_list = [
  [ "Is it really a big problem if you eat organic/non-gmo or not?", "" ],
  [ "France", 65447374 ],
  [ "Belgium", 10839905 ],
  [ "Netherlands", 16680000 ]
]

questions_list.each do |title, text, option1, option2, created_at, updated_at, photo_link|
  Question.create( title: title, text: text, option1: option1, option2: option2, photo_link: photo_link)
end


