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
                         shelter_id: @shelter_1.id)
  end
  describe "when I visit the pet index page" do
    it "I see each Pet in the system including the Pets image, name, approximate age, sex, and name of shelter where located" do

      visit("/pets")

      expect(page.find("#pet_#{@pet_1.id}_image")['src']).to have_content('https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg')
      expect(page).to have_content("Bolt")
      expect(page).to have_content("5")
      expect(page).to have_content("male")
      expect(page).to have_content("Animal Control and Shelter")
    end
    it "then I see a link to 'Start an Application'" do

      visit("/pets")

      click_link("Start an Application")

      expect(current_path).to eq("/applications/new")
    end
  end
end
