# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

fibers = Tag.create(name: "Fibers")
painting = Tag.create(name: "Painting")
photography = Tag.create(name: "Photography")
pottery = Tag.create(name: "Pottery & Ceramics")
sculpture = Tag.create(name: "Sculpture")
jewelry = Tag.create(name: "Jewelry")
metals = Tag.create(name: "Metalworking")
wood = Tag.create(name: "Woodworking")
textiles = Tag.create(name: "Textiles")
calligraphy = Tag.create(name: "Calligraphy")

user1 = User.create(first_name: "Sarah", last_name: "Jackson", email: "sjackson@example.com", password: "12345678")
user2 = User.create(first_name: "Mike", last_name: "Woods", email: "mwoods@example.com", password: "12345678")

ad1 = Ad.create(title: "Sculptor For Public Art", description: "I've been asked to design a centerpiece for the new Public Library opening in downtown Durham, NC. By trade, I am a bronze sculptor, but I could sure use all hands on deck for this project.", local_only: true, user_id: user2.id)

ad_tag = AdTag.create(ad_id: sculpture.id, tag_id: ad1.id)

artist_tag = ArtistTag.create(user_id: user2.id, tag_id: wood.id)

gallery = Gallery.create(title: "Sculptures", description: "My public works", user_id: user2.id)
