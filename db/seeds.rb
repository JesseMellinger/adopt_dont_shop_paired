# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Shelter.destroy_all
User.destroy_all
Review.destroy_all
Pet.destroy_all

# Shelters
shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                           address: "1400 Fairgrounds Road",
                           city: "Eagle",
                           state: "CO",
                           zip: "81631")

shelter_2 = Shelter.create!(name: "Animal Control and Shelter",
                            address: "0058 Nancy's Place",
                            city: "Frisco",
                            state: "CO",
                            zip: "80443")

shelter_3 = Shelter.create!(name: "Eagle Valley Humane Society",
                            address: "50 Chambers Ave",
                            city: "Eagle",
                            state: "CO",
                            zip: "81631")

shelter_4 = Shelter.create!(name: "Leadville/Lake County Animal Shelter",
                            address: "428 E 12th St.",
                            city: "Leadville",
                            state: "CO",
                            zip: "80461")

shelter_5 = Shelter.create!(name: "Aspen Animal Shelter",
                            address: "101 Animal Shelter Road",
                            city: "Aspen",
                            state: "CO",
                            zip: "81611")
# Users
user_1 = User.create!(name: "Testy",
                      street_address: "221B Baker St.",
                      city: "London",
                      state: "CO",
                      zip: "81650")

user_2 = User.create!(name: "Tyrion Lannister",
                      street_address: "282 Kevin Brook",
                      city: "Lannisport",
                      state: "CA",
                      zip: "58517")

user_3 = User.create!(name: "Legolas",
                      street_address: "PO Box 123",
                      city: "Lake Arrow",
                      state: "CA",
                      zip: "58516")
# Reviews
review_1 = Review.create!(title: "Friends don\'t lie",
                          rating: 5,
                          content: "Only the educated are free.",
                          picture: "https://upload.wikimedia.org/wikipedia/commons/0/00/Epicteti_Enchiridion_Latinis_versibus_adumbratum_%28Oxford_1715%29_frontispiece.jpg",
                          shelter_id: shelter_1.id,
                          user_id: user_1.id)

review_2 = Review.create!(title: "Ohh yea, you gotta get schwifty.",
                          rating: 4,
                          content: "Hello, IT. Have you tried turning it off and on again?",
                          picture: "https://upload.wikimedia.org/wikipedia/en/3/33/Silicon_valley_title.png",
                          shelter_id: shelter_1.id,
                          user_id: user_2.id)

review_3 = Review.create!(title: "Great food",
                          rating: 3,
                          content: "I thought this was a restaurant but I was wrong. The bone-shaped cookies were good though.",
                          picture: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Ensaladang_Lato_%28Seaweed_Salad%29_-_Philippines_1.jpg/594px-Ensaladang_Lato_%28Seaweed_Salad%29_-_Philippines_1.jpg",
                          shelter_id: shelter_2.id,
                          user_id: user_1.id)
