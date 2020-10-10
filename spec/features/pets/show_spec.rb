require 'rails_helper'

describe "as a visitor" do
  describe "when I visit /pets/:id" do
    it "then I see the pet with that id including the pets image, name, description, approximate_age, sex, and adoption status" do
      shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                 address: "1400 Fairgrounds Road",
                                 city: "Eagle",
                                 state: "CO",
                                 zip: "81631")

      pet_1 = Pet.create!(image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                         name: "Bolt",
                         approximate_age: 5,
                         sex: "male",
                         name_of_shelter: "Animal Control and Shelter",
                         description: "White haired German Shepherd. Sounds like John Travolta.",
                         adoption_status: "NULL",
                         shelter_id: shelter_1.id)

      visit("/pets/#{pet_1.id}")

      expect(page).to have_content(pet_1.image)
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.description)
      expect(page).to have_content(pet_1.approximate_age)
      expect(page).to have_content(pet_1.sex)
      expect(page).to have_content(pet_1.adoption_status)
    end
  end
end
