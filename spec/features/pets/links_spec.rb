require 'rails_helper'

describe "as a visitor" do
  describe "when I click on the name of a pet anywhere on the site" do
    it "then that link takes me to that Pets show page" do
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

      expect(page).to have_link("Bolt", :href=>"/pets/#{pet_1.id}")

      click_link("Bolt")

      expect(current_path).to eq("/pets/#{pet_1.id}")

      visit("/pets/#{pet_1.id}")

      expect(page).to have_link("Bolt", :href=>"/pets/#{pet_1.id}")

      click_link("Bolt")

      expect(current_path).to eq("/pets/#{pet_1.id}")

      visit("/shelters/#{shelter_1.id}/pets")

      expect(page).to have_link("Bolt", :href=>"/pets/#{pet_1.id}")

      click_link("Bolt")

      expect(current_path).to eq("/pets/#{pet_1.id}")
      
    end
  end
end
