require 'rails_helper'

describe "as a visitor" do
  describe "when I visit a Pet Show page" do
    it "then I see a link named Update Pet to update that Pet" do
      shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                 address: "1400 Fairgrounds Road",
                                 city: "Eagle",
                                 state: "CO",
                                 zip: "81631")

      pet_1 = Pet.create(image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                         name: "Bolt",
                         approximate_age: 5,
                         sex: "male",
                         name_of_shelter: "Animal Control and Shelter",
                         description: "White haired German Shepherd. Sounds like John Travolta.",
                         adoption_status: "NULL",
                         shelter_id: shelter_1.id)

      visit("/pets/#{pet_1.id}")

      expect(page).to have_link("Update Pet")
    end
    describe "when I click the link" do
      it "I am taken to /pets/:id/edit where I see a form to edit the pets data including image, name, description, approximate age, and sex" do
        shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                   address: "1400 Fairgrounds Road",
                                   city: "Eagle",
                                   state: "CO",
                                   zip: "81631")

        pet_1 = Pet.create(image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                           name: "Bolt",
                           approximate_age: 5,
                           sex: "male",
                           name_of_shelter: "Animal Control and Shelter",
                           description: "White haired German Shepherd. Sounds like John Travolta.",
                           adoption_status: "NULL",
                           shelter_id: shelter_1.id)

        visit("/pets/#{pet_1.id}")

        click_link("Update Pet")

        expect(current_path).to eq("/pets/#{pet_1.id}/edit")

        expect(page).to have_field("pet[image]")
        expect(page).to have_field("pet[name]")
        expect(page).to have_field("pet[description]")
        expect(page).to have_field("pet[approximate_age]")
        expect(page).to have_field("pet[sex]")
      end
      describe "when I click the button Update Pet" do
        it "then a PATCH request is sent to /pets/:id, the pets data is update, and I am redirected to the Pet Show page where I see the Pets updated information" do
          shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                     address: "1400 Fairgrounds Road",
                                     city: "Eagle",
                                     state: "CO",
                                     zip: "81631")

          pet_1 = Pet.create(image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                             name: "Bolt",
                             approximate_age: 5,
                             sex: "male",
                             name_of_shelter: "Animal Control and Shelter",
                             description: "White haired German Shepherd. Sounds like John Travolta.",
                             adoption_status: "NULL",
                             shelter_id: shelter_1.id)

          visit "/pets/#{pet_1.id}/edit"

          fill_in("pet[image]", with: "https://en.wikipedia.org/wiki/Rin_Tin_Tin#/media/File:Rin_Tin_Tin_1929.JPG")
          fill_in("pet[name]", with: "Rin Tin Tin")
          fill_in("pet[description]", with: "German Shepherd and international star.")
          fill_in("pet[approximate_age]", with: 102)
          fill_in("pet[sex]", with: "male")

          click_button("submit")

          expect(current_path).to eq("/pets/#{pet_1.id}")

          expect(page).to have_content("https://en.wikipedia.org/wiki/Rin_Tin_Tin#/media/File:Rin_Tin_Tin_1929.JPG")
          expect(page).to have_content("Rin Tin Tin")
          expect(page).to have_content("German Shepherd and international star.")
          expect(page).to have_content(102)
          expect(page).to have_content("male")
        end
      end
    end
  end
end
