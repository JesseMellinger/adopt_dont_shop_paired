require 'rails_helper'

As a visitor
When I visit a shelter show page
Then I see a link to update the shelter "Update Shelter"
When I click the link "Update Shelter"
Then I am taken to '/shelters/:id/edit' where I  see a form to edit the shelter's data including:
- name
- address
- city
- state
- zip
When I fill out the form with updated information
And I click the button to submit the form
Then a `PATCH` request is sent to '/shelters/:id',
the shelter's info is updated,
and I am redirected to the Shelter's Show page where I see the shelter's updated info

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
    describe "when I fill out the form with update information" do
      describe "and I click the button to submit the form" do
        it "a PATCH request is sent to shelters/:id, the shelters information is updated, and I am redirected to the Shelters Show page where I see the shelters updated info" do
          shelter_1 = Shelter.create(name: "Eagle County Animal Services",
                                     address: "1400 Fairgrounds Road",
                                     city: "Eagle",
                                     state: "CO",
                                     zip: "81631")

          visit "/shelters/#{shelter_1.id}/edit"

          fill_in("name", with: "Animal Control and Shelter")
          fill_in("address", with: "0058 Nancy's Place")
          fill_in("city", with: "Frisco")
          fill_in("state", with: "CO")
          fill_in("zip", with: "80443")

          click_button("Submit")

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
