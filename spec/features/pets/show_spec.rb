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

      expect(page.find("#pet_#{pet_1.id}_image")['src']).to have_content('https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg')
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.description)
      expect(page).to have_content(pet_1.approximate_age)
      expect(page).to have_content(pet_1.sex)
      expect(page).to have_content(pet_1.adoption_status)
    end
    describe "I see a link to view all applications for this pet" do
      describe "when I click that link" do
        it "takes me to the pet applications index page" do
          user_1 = User.create!(name: "Testy",
                                street_address: "221B Baker St.",
                                city: "London",
                                state: "CO",
                                zip: "81650")

          user_2 = User.create!(name: "Tyrion Lannister",
                                street_address: "282 Kevin Brook",
                                city: "Lannisport",
                                state: "CA",
                                zip: "58517")

          shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                      address: "1400 Fairgrounds Road",
                                      city: "Eagle",
                                      state: "CO",
                                      zip: "81631")

          application_1 = Application.create!(description: "I love that journey for me.",
                                              status: "Pending",
                                              user_id: user_1.id)

          application_2 = Application.create!(description: "I'm worried Blue has already been adopted",
                                              status: "Pending",
                                              user_id: user_2.id)

          pet_1 = Pet.create!(image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                              name: "Bolt",
                              approximate_age: 5,
                              sex: "male",
                              name_of_shelter: "Animal Control and Shelter",
                              description: "White haired German Shepherd. Sounds like John Travolta.",
                              adoption_status: "NULL",
                              shelter_id: shelter_1.id)

          pet_application_1 = PetApplication.create!(pet_id: pet_1.id,
                                                     application_id: application_1.id)

          pet_application_2 = PetApplication.create!(pet_id: pet_1.id,
                                                     application_id: application_2.id)

          visit("/pets/#{pet_1.id}")

          click_link("View All Applications")

          expect(current_path).to eq("/pets/#{pet_1.id}/applications")
        end
      end
    end
    describe "if a pet has an approved application on them" do
      it "I can not delete that pet" do
        user_1 = User.create!(name: "Testy",
                              street_address: "221B Baker St.",
                              city: "London",
                              state: "CO",
                              zip: "81650")

        user_2 = User.create!(name: "Tyrion Lannister",
                              street_address: "282 Kevin Brook",
                              city: "Lannisport",
                              state: "CA",
                              zip: "58517")

        shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                    address: "1400 Fairgrounds Road",
                                    city: "Eagle",
                                    state: "CO",
                                    zip: "81631")

        application_1 = Application.create!(description: "I love that journey for me.",
                                            status: "Approved",
                                            user_id: user_1.id)

        application_2 = Application.create!(description: "I'm worried Blue has already been adopted",
                                            status: "Pending",
                                            user_id: user_2.id)

        pet_1 = Pet.create!(image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                            name: "Bolt",
                            approximate_age: 5,
                            sex: "male",
                            name_of_shelter: "Animal Control and Shelter",
                            description: "White haired German Shepherd. Sounds like John Travolta.",
                            adoption_status: "NULL",
                            shelter_id: shelter_1.id)

        pet_application_1 = PetApplication.create!(pet_id: pet_1.id,
                                                   application_id: application_1.id)

        pet_application_2 = PetApplication.create!(pet_id: pet_1.id,
                                                   application_id: application_2.id)

        visit("/pets/#{pet_1.id}")

        expect(page).to have_no_link("Delete Pet")
      end
    end
  end
end
