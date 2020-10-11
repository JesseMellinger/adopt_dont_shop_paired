require 'rails_helper'

describe "as a visitor" do
  describe "when I visit any page on the site" do
    it "then I see a link at the top of the page that takes me to the Shelter Index" do
      shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                 address: "1400 Fairgrounds Road",
                                 city: "Eagle",
                                 state: "CO",
                                 zip: "81631")

      pet_1 = Pet.create!(image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                          name: "Bolt",
                          approximate_age: 5,
                          sex: "male",
                          name_of_shelter: shelter_1.name,
                          description: "White haired German Shepherd. Sounds like John Travolta.",
                          adoption_status: "adoptable",
                          shelter_id: shelter_1.id)

      visit("/pets/#{pet_1.id}/edit")

      expect(page).to have_link("Shelter Index", :href=>"/shelters")

      visit("/pets")

      expect(page).to have_link("Shelter Index", :href=>"/shelters")

      visit("/pets/#{pet_1.id}")

      expect(page).to have_link("Shelter Index", :href=>"/shelters")

      visit("/shelters/#{shelter_1.id}/edit")

      expect(page).to have_link("Shelter Index", :href=>"/shelters")

      visit("/shelters/#{shelter_1.id}/pets/new")

      expect(page).to have_link("Shelter Index", :href=>"/shelters")

      visit("/shelters/new")

      expect(page).to have_link("Shelter Index", :href=>"/shelters")

      visit("/shelters/#{shelter_1.id}/pets")

      expect(page).to have_link("Shelter Index", :href=>"/shelters")

      visit("/shelters/#{shelter_1.id}")

      expect(page).to have_link("Shelter Index", :href=>"/shelters")
    end
  end
end
