require 'rails_helper'

describe "as a visitor" do
  describe "when I visit the pets index page or a shelter pets index page" do
    it "then next to every pet, I see a link to delete that pet" do
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

      expect(page).to have_link("Delete Pet", :href=>"/pets/#{pet_1.id}")
      expect(page).to have_link("Delete Pet", :href=>"/pets/#{pet_2.id}")

      visit("/shelters/#{shelter_1.id}/pets")

      expect(page).to have_link("Delete Pet", :href=>"/pets/#{pet_1.id}")
      expect(page).to have_link("Delete Pet", :href=>"/pets/#{pet_2.id}")
    end
    describe "when I click the link" do
      it "then I should be taken to the pets index page where I no longer see that pet" do
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

        expect(page).to have_content(pet_1.name)
        expect(page.find("#pet_#{pet_1.id}_image")['src']).to have_content('https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg')
        expect(page).to have_content(pet_1.approximate_age)
        expect(page).to have_content(pet_1.sex)
        expect(page).to have_content(pet_1.name_of_shelter)

        find(:xpath, "//a[@href='/pets/#{pet_1.id}']").click

        expect(current_path).to eq("/pets")

        expect(page).to have_no_content(pet_1.name)
        expect(page).to have_no_content(pet_1.approximate_age)
        expect(page).to have_no_content(pet_1.sex)
        expect(page).to have_no_content(pet_1.name_of_shelter)

        visit("/shelters/#{shelter_1.id}/pets")

        expect(page).to have_content(pet_2.name)
        expect(page.find("#pet_#{pet_2.id}_image")['src']).to have_content('https://en.wikipedia.org/wiki/Rin_Tin_Tin#/media/File:Rin_Tin_Tin_1929.JPG')
        expect(page).to have_content(pet_2.approximate_age)
        expect(page).to have_content(pet_2.sex)
        expect(page).to have_content(pet_2.name_of_shelter)

        find(:xpath, "//a[@href='/pets/#{pet_2.id}']").click

        expect(current_path).to eq("/pets")

        expect(page).to have_no_content(pet_2.name)
        expect(page).to have_no_content(pet_2.approximate_age)
        expect(page).to have_no_content(pet_2.sex)
        expect(page).to have_no_content(pet_2.name_of_shelter)
      end
    end
  end
end
