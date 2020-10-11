require 'rails_helper'

describe "as a visitor" do
  describe "when I visit the shelter index page" do
    it "next to every shelter, I see a link to edit that shelters info" do
      shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                 address: "1400 Fairgrounds Road",
                                 city: "Eagle",
                                 state: "CO",
                                 zip: "81631")
      shelter_2 = Shelter.create!(name: "Animal Control and Shelter",
                                  address: "0058 Nancy's Place",
                                  city: "Frisco",
                                  state: "CO",
                                  zip: "80443")
      shelter_3 = Shelter.create!(name: "Eagle Valley Humane Society",
                                  address: "50 Chambers Ave",
                                  city: "Eagle",
                                  state: "CO",
                                  zip: "81631")
      shelter_4 = Shelter.create!(name: "Leadville/Lake County Animal Shelter",
                                  address: "428 E 12th St.",
                                  city: "Leadville",
                                  state: "CO",
                                  zip: "80461")
      shelter_5 = Shelter.create!(name: "Aspen Animal Shelter",
                                  address: "101 Animal Shelter Road",
                                  city: "Aspen",
                                  state: "CO",
                                  zip: "81611")

      visit("/shelters")

      expect(page).to have_link("Update Shelter", :href="/shelters/#{shelter_1.id}/edit")
      expect(page).to have_link("Update Shelter", :href="/shelters/#{shelter_2.id}/edit")
      expect(page).to have_link("Update Shelter", :href="/shelters/#{shelter_3.id}/edit")
      expect(page).to have_link("Update Shelter", :href="/shelters/#{shelter_4.id}/edit")
      expect(page).to have_link("Update Shelter", :href="/shelters/#{shelter_5.id}/edit")
    end
    describe "when I click the link" do
      it "then I should be taken to that shelters edit page where I can update its information" do
        shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                   address: "1400 Fairgrounds Road",
                                   city: "Eagle",
                                   state: "CO",
                                   zip: "81631")
        shelter_2 = Shelter.create!(name: "Animal Control and Shelter",
                                    address: "0058 Nancy's Place",
                                    city: "Frisco",
                                    state: "CO",
                                    zip: "80443")
        shelter_3 = Shelter.create!(name: "Eagle Valley Humane Society",
                                    address: "50 Chambers Ave",
                                    city: "Eagle",
                                    state: "CO",
                                    zip: "81631")
        shelter_4 = Shelter.create!(name: "Leadville/Lake County Animal Shelter",
                                    address: "428 E 12th St.",
                                    city: "Leadville",
                                    state: "CO",
                                    zip: "80461")
        shelter_5 = Shelter.create!(name: "Aspen Animal Shelter",
                                    address: "101 Animal Shelter Road",
                                    city: "Aspen",
                                    state: "CO",
                                    zip: "81611")

        visit("/shelters")

        find(:xpath, "//a[@href='/shelters/#{shelter_1.id}/edit']").click

        expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

        expect(page).to have_field("shelter[name]")
        expect(page).to have_field("shelter[address]")
        expect(page).to have_field("shelter[city]")
        expect(page).to have_field("shelter[state]")
        expect(page).to have_field("shelter[zip]")
        expect(page).to have_button("#submit")
      end
    end
  end
end
