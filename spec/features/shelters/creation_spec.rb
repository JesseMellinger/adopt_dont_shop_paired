require 'rails_helper'

describe "as a visitor" do
  describe "when I visit the Shelter Index page" do
    it "then I see a link named New Shelter to create a new Shelter" do
      visit "/shelters"

      expect(page).to have_link("New Shelter", :href=>"/shelters/new")
    end
  end
  describe "when I click this link" do
    it "I am taken to /shelters/new where I can see a form for a new shelter" do
      visit "/shelters"

      click_link("New Shelter")

      expect(current_path).to eq("/shelters/new")

      expect(page).to have_field("shelter[name]")
      expect(page).to have_field("shelter[address]")
      expect(page).to have_field("shelter[city]")
      expect(page).to have_field("shelter[state]")
      expect(page).to have_field("shelter[zip]")

      expect(page).to have_button("create_shelter")
    end
  end
  describe "when I fill out the form with new shelter information" do
    describe "and I click the button Create Shelter to submit the form" do
      it "I am redirected to the Shelter Index page where I see the Shelter listed" do
        visit "/shelters/new"

        fill_in("name", with: "Eagle County Animal Services")
        fill_in("address", with: "1400 Fairgrounds Road")
        fill_in("city", with: "Eagle")
        fill_in("state", with: "CO")
        fill_in("zip", with: "81631")

        click_button("create_shelter")

        expect(current_path).to eq("/shelters")

        expect(page).to have_content("Eagle County Animal Services")
      end
    end
  end
end
