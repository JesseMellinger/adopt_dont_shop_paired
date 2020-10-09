require 'rails_helper'
As a visitor
When I visit a Pet Show page
Then I see a link to update that Pet "Update Pet"
When I click the link
I am taken to '/pets/:id/edit' where I see a form to edit the pet's data including:
- image
- name
- description
- approximate age
- sex
When I click the button to submit the form "Update Pet"
Then a `PATCH` request is sent to '/pets/:id',
the pet's data is updated,
and I am redirected to the Pet Show page where I see the Pet's updated information

describe "as a visitor" do
  describe "when I visit a Pet Show page" do
    it "then I see a link named Update Pet to update that Pet" do
      pet_1 = Pet.create(image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                         name: "Bolt",
                         approximate_age: 5,
                         sex: "male",
                         name_of_shelter: "Animal Control and Shelter",
                         description: "White haired German Shepherd. Sounds like John Travolta.",
                         adoption_status: "NULL")

      visit("/pets/#{pet_1.id}")

      expect(page).to have_link("Update Pet")
    end
    describe "when I click the link" do
      it "I am taken to /pets/:id/edit where I see a form to edit the pets data including image, name, description, approximate age, and sex" do
        pet_1 = Pet.create(image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                           name: "Bolt",
                           approximate_age: 5,
                           sex: "male",
                           name_of_shelter: "Animal Control and Shelter",
                           description: "White haired German Shepherd. Sounds like John Travolta.",
                           adoption_status: "NULL")

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
          pet_1 = Pet.create(image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                             name: "Bolt",
                             approximate_age: 5,
                             sex: "male",
                             name_of_shelter: "Animal Control and Shelter",
                             description: "White haired German Shepherd. Sounds like John Travolta.",
                             adoption_status: "NULL")

          visit "/pets/#{pet_1.id}/edit"

          fill_in("pet[image]", with: "https://en.wikipedia.org/wiki/Rin_Tin_Tin#/media/File:Rin_Tin_Tin_1929.JPG")
          fill_in("pet[name]", with: "Rin Tin Tin")
          fill_in("pet[description]", with: "German Shepherd and international star.")
          fill_in("pet[approximate_age]", with: 102)
          fill_in("pet[sex]", with: "male")

          click_button("Update Pet")

          expect(current_path).to eq("/pets/#{pet_1.id}")

          expect(page).to have_content(pet_1.image)
          expect(page).to have_content(pet_1.name)
          expect(page).to have_content(pet_1.description)
          expect(page).to have_content(pet_1.approximate_age)
          expect(page).to have_content(pet_1.sex)
        end
        end
      end
    end
  end
end
