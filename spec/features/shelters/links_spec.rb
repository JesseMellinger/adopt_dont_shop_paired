require 'rails_helper'

describe "as a visitor" do
  describe "when I click on the name of a shelter anywhere on the site" do
    it "then that link takes me to that Shelters show page" do
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

      visit("/pets")

      expect(page).to have_link("Eagle County Animal Services", :href=>"/shelters/#{pet_1.shelter_id}")

      click_link("Eagle County Animal Services")

      expect(current_path).to eq("/shelters/#{shelter_1.id}")

      visit("/shelters")

      expect(page).to have_link("Eagle County Animal Services", :href=>"/shelters/#{shelter_1.id}")

      click_link("Eagle County Animal Services")

      expect(current_path).to eq("/shelters/#{shelter_1.id}")

      visit("/shelters/#{shelter_1.id}")

      expect(page).to have_link("Eagle County Animal Services", :href=>"/shelters/#{shelter_1.id}")

      click_link("Eagle County Animal Services")

      expect(current_path).to eq("/shelters/#{shelter_1.id}")
    end
  end
end
