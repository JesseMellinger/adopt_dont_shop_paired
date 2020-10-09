require 'rails_helper'

describe "as a visitor" do
  describe "when I visit a pet show page" do
    it "then I see a link named Delete Pet to delete the pet" do
      pet_1 = Pet.create!(image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                         name: "Bolt",
                         approximate_age: 5,
                         sex: "male",
                         name_of_shelter: "Animal Control and Shelter",
                         description: "White haired German Shepherd. Sounds like John Travolta.",
                         adoption_status: "NULL")

      visit("/pets/#{pet_1.id}")

      expect(page).to have_link("Delete Pet")
    end
    describe "when I click the link" do
      it "then a DELETE request is sent to /pets/:id, the pet is deleted, and I am redirected to the pet index page where I no longer see this pet" do
        pet_1 = Pet.create!(image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                           name: "Bolt",
                           approximate_age: 5,
                           sex: "male",
                           name_of_shelter: "Animal Control and Shelter",
                           description: "White haired German Shepherd. Sounds like John Travolta.",
                           adoption_status: "NULL")

        visit "/pets"

        expect(page).to have_content("Bolt")
        expect(page).to have_content("https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")
        expect(page).to have_content(5)
        expect(page).to have_content("male")
        expect(page).to have_content("Animal Control and Shelter")

        visit "/pets/#{pet_1.id}"

        click_link("Delete Pet")

        expect(current_path).to eq("/pets")

        expect(page).to have_no_content("Bolt")
        expect(page).to have_no_content("https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")
        expect(page).to have_no_content(5)
        expect(page).to have_no_content("male")
        expect(page).to have_no_content("Animal Control and Shelter")
      end
    end
  end
end
