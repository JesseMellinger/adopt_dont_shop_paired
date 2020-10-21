require 'rails_helper'

describe "as a visitor" do
  describe "after an application has been approved for one or more pets" do
    describe "when I visit the favorites page" do
      it "I see a section on the page that has a list of all of the pets that have an approved application on them
      each pet's name is a link to their show page" do
        shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                   address: "1400 Fairgrounds Road",
                                   city: "Eagle",
                                   state: "CO",
                                   zip: "81631")

        user_1 = User.create!(name: "Testy",
                              street_address: "221B Baker St.",
                              city: "London",
                              state: "CO",
                              zip: "81650")

        pet_1 = Pet.create!(image: "https://upload.wikimedia.org/wikipedia/commons/8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                            name: "Blue",
                            approximate_age: "2",
                            sex: "Female",
                            shelter_id: shelter_1.id)

        pet_2 = Pet.create!(image: "https://upload.wikimedia.org/wikipedia/commons/8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                            name: "John Cougar Mellencamp",
                            approximate_age: "4",
                            sex: "Male",
                            shelter_id: shelter_1.id)

        pet_3 = Pet.create!(image: "https://upload.wikimedia.org/wikipedi8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                            name: "Bolt",
                            approximate_age: "5",
                            sex: "Male",
                            shelter_id: shelter_1.id)

        application_1 = Application.create!(description: "I love that journey for me.",
                                            status: "Approved",
                                            user_id: user_1.id)

        application_2 = Application.create!(description: "I'm worried Blue has already been adopted",
                                            status: "Pending",
                                            user_id: user_1.id)

        application_3 = Application.create!(description: "I'm worried Blue has already been adopted",
                                            status: "Approved",
                                            user_id: user_1.id)

        pet_application_1 = PetApplication.create!(pet_id: pet_1.id,
                                                   application_id: application_1.id)

        pet_application_2 = PetApplication.create!(pet_id: pet_2.id,
                                                   application_id: application_2.id)

        pet_application_3 = PetApplication.create!(pet_id: pet_3.id,
                                                   application_id: application_3.id)

        visit("/favorites")
        
        within("#pet-#{pet_1.id}") do
          expect(page).to have_link(pet_1.name)
        end

        within("#pet-#{pet_3.id}") do
          click_link(pet_3.name)
        end

        expect(current_path).to eq("/pets/#{pet_3.id}")
      end
    end
  end
end
