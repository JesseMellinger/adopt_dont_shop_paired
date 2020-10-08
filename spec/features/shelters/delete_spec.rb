require 'rails_helper'

describe "as a visitor" do
  describe "when I visit a shelter show page" do
    it "I see a link to delete the shelter" do
      shelter_1 = Shelter.create(name: "Eagle County Animal Services",
                                 address: "1400 Fairgrounds Road",
                                 city: "Eagle",
                                 state: "CO",
                                 zip: "81631")

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_link("Delete Shelter")
    end
  end
  describe "when I click the link Delete Shelter" do
    it "a DELETE request is sent to shelters/:id, the shelter is deleted, and I am redirected to the shelter index page where I no longer see this shelter" do
      shelter_1 = Shelter.create(name: "Eagle County Animal Services",
                                 address: "1400 Fairgrounds Road",
                                 city: "Eagle",
                                 state: "CO",
                                 zip: "81631")

      visit "/shelters"

      expect(page).to have_content("Eagle County Animal Services")

      visit "/shelters/#{shelter_1.id}"

      click_link("Delete Shelter")

      expect(current_path).to eq("/shelters")

      expect(page).to have_no_content("Eagle County Animal Services")
    end
  end
end
