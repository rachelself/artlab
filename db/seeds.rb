# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tag_list = [
  ["Fibers"],
  ["Painting"],
  ["Photography"],
  ["Pottery & Ceramics"],
  ["Sculpture"],
  ["Jewelry"],
  ["Metalworking"],
  ["Woodworking"],
  ["Textiles"],
  ["Calligraphy"]
]

tag_list.each do |name|
  Tag.create(name: name)
end
