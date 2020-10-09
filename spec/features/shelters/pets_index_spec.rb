require 'rails_helper'

As a visitor
When I visit '/shelters/:shelter_id/pets'
Then I see each Pet that can be adopted from that Shelter with that shelter_id including the Pet's:
- image
- name
- approximate age
- sex

describe "as a visitor" do
  describe "when I visit /shelters/:shelter_id/pets" do
    it "then I see each Pet that can be adopted from that Shelter with that shelter_id including the Pets image, name, approximate age, and sex" do
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

      visit("/shelters/#{shelter_1.id}/pets")

      expect(page).to have_content(pet_1.image)
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.approximate_age)
      expect(page).to have_content(pet_1.sex)


      expect(page).to have_content(pet_3.image)
      expect(page).to have_content(pet_3.name)
      expect(page).to have_content(pet_3.approximate_age)
      expect(page).to have_content(pet_3.sex)
    end
  end
end
