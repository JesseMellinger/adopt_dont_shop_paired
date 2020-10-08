require 'rails_helper'

describe "as a visitor" do
  describe "when I visit a shelter show page" do
    it "I see a link to update the shelter Update Shelter" do
      shelter_1 = Shelter.create(name: "Eagle County Animal Services",
                                 address: "1400 Fairgrounds Road",
                                 city: "Eagle",
                                 state: "CO",
                                 zip: "81631")

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_link("Update Shelter")
    end
    describe "when I click the link Update Shelter" do
      it "I am taken to /shelters/:id/edit where I can see a form to edit the shelters data" do
        shelter_1 = Shelter.create(name: "Eagle County Animal Services",
                                   address: "1400 Fairgrounds Road",
                                   city: "Eagle",
                                   state: "CO",
                                   zip: "81631")

        visit "/shelters/#{shelter_1.id}"

        click_link("Update Shelter")

        expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

        expect(page).to have_field("shelter[name]")
        expect(page).to have_field("shelter[address]")
        expect(page).to have_field("shelter[city]")
        expect(page).to have_field("shelter[state]")
        expect(page).to have_field("shelter[zip]")
      end
    end
    describe "when I fill out the form with updated information" do
      describe "and I click the button to submit the form" do
        it "a PATCH request is sent to shelters/:id, the shelters information is updated, and I am redirected to the Shelters Show page where I see the shelters updated info" do
          shelter_1 = Shelter.create(name: "Eagle County Animal Services",
                                     address: "1400 Fairgrounds Road",
                                     city: "Eagle",
                                     state: "CO",
                                     zip: "81631")

          visit "/shelters/#{shelter_1.id}/edit"

          fill_in("shelter[name]", with: "Animal Control and Shelter")
          fill_in("shelter[address]", with: "0058 Nancy's Place")
          fill_in("shelter[city]", with: "Frisco")
          fill_in("shelter[state]", with: "CO")
          fill_in("shelter[zip]", with: "80443")

          click_button("submit")

          expect(current_path).to eq("/shelters/#{shelter_1.id}")

          expect(page).to have_content("Animal Control and Shelter")
          expect(page).to have_content("0058 Nancy's Place")
          expect(page).to have_content("Frisco")
          expect(page).to have_content("CO")
          expect(page).to have_content("80443")
        end
      end
    end
  end
end
