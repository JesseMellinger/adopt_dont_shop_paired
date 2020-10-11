require 'rails_helper'

describe "as a visitor" do
  describe "when I visit the pets index page or shelter pets index page" do
    it "next to every pet, I see a link to edit that pets info" do
      shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                 address: "1400 Fairgrounds Road",
                                 city: "Eagle",
                                 state: "CO",
                                 zip: "81631")

      pet_1 = Pet.create!(image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                          name: "Bolt",
                          approximate_age: 5,
                          sex: "male",
                          name_of_shelter: shelter_1.name,
                          description: "White haired German Shepherd. Sounds like John Travolta.",
                          adoption_status: "adoptable",
                          shelter_id: shelter_1.id)

      pet_2 = Pet.create!(image: "https://en.wikipedia.org/wiki/Rin_Tin_Tin#/media/File:Rin_Tin_Tin_1929.JPG",
                          name: "Rin Tin Tin",
                          approximate_age: 102,
                          sex: "male",
                          name_of_shelter: shelter_1.name,
                          description: "German Shepherd and international star in motion pictures.",
                          adoption_status: "adoptable",
                          shelter_id: shelter_1.id)

      visit("/pets")

      expect(page).to have_link("Update Pet", :href=>"/pets/#{pet_1.id}/edit")
      expect(page).to have_link("Update Pet", :href=>"/pets/#{pet_2.id}/edit")

      visit("/shelters/#{shelter_1.id}/pets")

      expect(page).to have_link("Update Pet", :href=>"/pets/#{pet_1.id}/edit")
      expect(page).to have_link("Update Pet", :href=>"/pets/#{pet_2.id}/edit")
    end
    describe "when I click the link" do
      it "then I should be taken to that pets edit page where I can update its information" do
        shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                   address: "1400 Fairgrounds Road",
                                   city: "Eagle",
                                   state: "CO",
                                   zip: "81631")

        pet_1 = Pet.create!(image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                            name: "Bolt",
                            approximate_age: 5,
                            sex: "male",
                            name_of_shelter: shelter_1.name,
                            description: "White haired German Shepherd. Sounds like John Travolta.",
                            adoption_status: "adoptable",
                            shelter_id: shelter_1.id)

        pet_2 = Pet.create!(image: "https://en.wikipedia.org/wiki/Rin_Tin_Tin#/media/File:Rin_Tin_Tin_1929.JPG",
                            name: "Rin Tin Tin",
                            approximate_age: 102,
                            sex: "male",
                            name_of_shelter: shelter_1.name,
                            description: "German Shepherd and international star in motion pictures.",
                            adoption_status: "adoptable",
                            shelter_id: shelter_1.id)

        visit("/pets")

        find(:xpath, "//a[@href='/pets/#{pet_1.id}/edit']").click

        expect(current_path).to eq("/pets/#{pet_1.id}/edit")

        expect(page).to have_field("pet[image]")
        expect(page).to have_field("pet[name]")
        expect(page).to have_field("pet[description]")
        expect(page).to have_field("pet[approximate_age]")
        expect(page).to have_field("pet[sex]")

        visit("/shelters/#{shelter_1.id}/pets")

        find(:xpath, "//a[@href='/pets/#{pet_2.id}/edit']").click

        expect(current_path).to eq("/pets/#{pet_2.id}/edit")

        expect(page).to have_field("pet[image]")
        expect(page).to have_field("pet[name]")
        expect(page).to have_field("pet[description]")
        expect(page).to have_field("pet[approximate_age]")
        expect(page).to have_field("pet[sex]")
      end
    end
  end
end
