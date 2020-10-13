require 'rails_helper'

describe "as a visitor" do
  describe "when I visit /shelters/:id" do
    it "I see the shelter with that id including the shelters name, address, city, state, and zip" do
      shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                 address: "1400 Fairgrounds Road",
                                 city: "Eagle",
                                 state: "CO",
                                 zip: "81631")

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_1.address)
      expect(page).to have_content(shelter_1.city)
      expect(page).to have_content(shelter_1.state)
      expect(page).to have_content(shelter_1.zip)
    end
  end
  describe "when I visit a shelters show page" do
    it "then I see a list of reviews for that shelter" do
      shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                 address: "1400 Fairgrounds Road",
                                 city: "Eagle",
                                 state: "CO",
                                 zip: "81631")

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

      review_1 = Review.create!(title: "Friends don\'t lie",
                                rating: "5",
                                content: "Only the educated are free.",
                                picture: "https://upload.wikimedia.org/wikipedia/commons/0/00/Epicteti_Enchiridion_Latinis_versibus_adumbratum_%28Oxford_1715%29_frontispiece.jpg",
                                shelter_id: shelter_1.id,
                                user_id: user_1.id)

      review_2 = Review.create!(title: "Ohh yea, you gotta get schwifty.",
                                rating: "4",
                                content: "Hello, IT. Have you tried turning it off and on again?",
                                picture: "https://upload.wikimedia.org/wikipedia/en/3/33/Silicon_valley_title.png",
                                shelter_id: shelter_1.id,
                                user_id: user_2.id)

      visit("/shelters/#{shelter_1.id}")

      expect(page).to have_content(review_1.title)
      expect(page).to have_content(review_1.rating)
      expect(page).to have_content(review_1.content)
      expect(page).to have_content(review_1.picture)
      expect(page).to have_content(user_1.name)

      expect(page).to have_content(review_2.title)
      expect(page).to have_content(review_2.rating)
      expect(page).to have_content(review_2.content)
      expect(page).to have_content(review_2.picture)
      expect(page).to have_content(user_2.name)
    end
  end
end
