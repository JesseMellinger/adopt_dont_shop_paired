require 'rails_helper'

describe "as a visitor" do
  before :each do
    @shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                              address: "1400 Fairgrounds Road",
                              city: "Eagle",
                              state: "CO",
                              zip: "81631")


    @pet_1 = Pet.create!(image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                       name: "Bolt",
                       approximate_age: 5,
                       sex: "male",
                       name_of_shelter: "Animal Control and Shelter",
                       description: "White haired German Shepherd. Sounds like John Travolta.",
                       adoption_status: "NULL",
                       shelter_id: @shelter_1.id)
  end
  describe "when I visit a pet show page" do
    it "then I see a link named Delete Pet to delete the pet" do

      visit("/pets/#{@pet_1.id}")

      expect(page).to have_link("Delete Pet")
    end
  describe "when I click the link" do
    it "then a DELETE request is sent to /pets/:id, the pet is deleted, and I am redirected to the pet index page where I no longer see this pet" do

      visit "/pets"

      expect(page).to have_content("Bolt")
      expect(page.find("#pet_#{@pet_1.id}_image")['src']).to have_content('https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg')
      expect(page).to have_content(5)
      expect(page).to have_content("male")
      expect(page).to have_content("Animal Control and Shelter")

      visit "/pets/#{@pet_1.id}"

      click_link("Delete Pet")

      expect(current_path).to eq("/pets")

      expect(page).to have_no_content("Bolt")
      expect(page).to have_no_content(5)
      expect(page).to have_no_content("male")
      expect(page).to have_no_content("Animal Control and Shelter")
      expect(page).not_to have_selector("#pet_#{@pet_1.id}_image")
      end
    end
  end
end
