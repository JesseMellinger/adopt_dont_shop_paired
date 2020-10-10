require 'rails_helper'

describe "as a visitor" do
  describe "when I visit a Shelter Pets Index page" do
    it "then I see a link to add a new adoptable pet for that shelter named Create Pet" do
      shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                 address: "1400 Fairgrounds Road",
                                 city: "Eagle",
                                 state: "CO",
                                 zip: "81631")

      visit("/shelters/#{shelter_1.id}/pets")

      expect(page).to have_link("Create Pet")
    end
    describe "when I click the link" do
      it "then I am taken to /shelters/:shelter_id/pets/new where I can see a form to add a new adoptable pet" do
        shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                   address: "1400 Fairgrounds Road",
                                   city: "Eagle",
                                   state: "CO",
                                   zip: "81631")

        visit("/shelters/#{shelter_1.id}/pets")

        click_link("Create Pet")

        expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/new")

        expect(page).to have_field("image")
        expect(page).to have_field("name")
        expect(page).to have_field("description")
        expect(page).to have_field("approximate_age")
        expect(page).to have_field("sex")
      end
      describe "when I fill in the form with the pets image, name, description, approximate_age, and sex" do
        describe "and I click the button named Create Pet" do
          it "then a POST request is sent to /shelters/:shelter_id/pets, a new pet is created for that shelter, that pet has a status of adoptable, and I am redirected to the Shelter Pets Index page where I can see the new pet listed" do
            shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                       address: "1400 Fairgrounds Road",
                                       city: "Eagle",
                                       state: "CO",
                                       zip: "81631")

            visit("/shelters/#{shelter_1.id}/pets/new")

            fill_in("image", with: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")
            fill_in("name", with: "Bolt")
            fill_in("description", with: "White haired German Shepherd. Sounds like John Travolta.")
            fill_in("approximate_age", with: 5)
            fill_in("sex", with: "male")

            click_button("Create Pet")

            expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")

            pet_added = Pet.find_by name: 'Bolt'

            expect(page.find("#pet_#{pet_added.id}_image")['src']).to have_content('https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg')
            expect(page).to have_content("Bolt")
            expect(page).to have_content(5)
            expect(page).to have_content("male")
          end
        end
      end
    end
  end
end
