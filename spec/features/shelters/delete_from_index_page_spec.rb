require 'rails_helper'

describe "as a visitor" do
  describe "when I visit the shelter index page" do
    it "next to every shelter, I see a link to delete that shelter" do
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

      expect(page).to have_link("Delete Shelter", :href=>"/shelters/#{shelter_1.id}")
      expect(page).to have_link("Delete Shelter", :href=>"/shelters/#{shelter_2.id}")
      expect(page).to have_link("Delete Shelter", :href=>"/shelters/#{shelter_3.id}")
      expect(page).to have_link("Delete Shelter", :href=>"/shelters/#{shelter_4.id}")
      expect(page).to have_link("Delete Shelter", :href=>"/shelters/#{shelter_5.id}")
    end
    describe "when I click the link" do
      it "then I am returned to the Shelter Index Page where I no longer see that shelter" do
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

        visit("/shelters")

        find(:xpath, "//a[@href='/shelters/#{shelter_1.id}']").click

        expect(current_path).to eq("/shelters")

        expect(page).to have_no_content(shelter_1.name)
        expect(page).to have_no_content(shelter_1.address)
        expect(page).to have_no_content(shelter_1.city)
        expect(page).to have_no_content(shelter_1.state)
        expect(page).to have_no_content(shelter_1.zip)
      end
    end
  end
end
