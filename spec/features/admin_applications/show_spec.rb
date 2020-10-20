require 'rails_helper'

# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved

describe "as a visitor" do
  describe "when I visit an admin application show page ('/admin/applications/:id')" do
    describe "when I click a button to approve the application for that specific pet" do
      it "then I'm taken back to the admin application show page, and next to the pet that I approved, I do not see a button to approve this pet, and instead I see an indicator next to the pet that they have been approved" do
        user_1 = User.create!(name: "Testy",
                              street_address: "221B Baker St.",
                              city: "London",
                              state: "CO",
                              zip: "81650"
                              )

        shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                   address: "1400 Fairgrounds Road",
                                   city: "Eagle",
                                   state: "CO",
                                   zip: "81631"
                                   )

        application_1 = Application.create!(description: "",
                                            status: "In Progress",
                                            user_id: user_1.id)

        pet_1 = Pet.create!(name: "Blue",
                            approximate_age: "2",
                            sex: "Female",
                            shelter_id: shelter_1.id)

        pet_2 = Pet.create!(name: "Mr. Blue",
                            approximate_age: "6",
                            sex: "Female",
                            shelter_id: shelter_1.id)

        visit("/applications/#{application_1.id}")

        within("#add-pets") do
          fill_in("search", with: "#{pet_1.name}")
          click_button("Search")
        end

        within("#pet-#{pet_1.id}") do
          click_button("Adopt this Pet")
        end

        within("#add-pets") do
          fill_in("search", with: "#{pet_1.name}")
          click_button("Search")
        end
        
        within("#pet-#{pet_2.id}") do
          click_button("Adopt this Pet")
        end

        fill_in("Why would you make a good owner for these pets?", with: "I love that journey for me.")

        click_button("Submit Application")

        visit("/admin/applications/#{application_1.id}")

        within("#pet-#{pet_1.id}") do
          expect(page).to have_content(pet_1.name)
          expect(page).to have_content(pet_1.approximate_age)
          expect(page).to have_content(pet_1.sex)
          expect(page).to have_content(pet_1.shelter.name)
          click_button("Approve Pet")
        end

        visit("/admin/applications/#{application_1.id}")

        within("#pet-#{pet_1.id}") do
          expect(page).to have_content(pet_1.name)
          expect(page).to have_content(pet_1.approximate_age)
          expect(page).to have_content(pet_1.sex)
          expect(page).to have_content(pet_1.shelter.name)
          expect(page).to have_no_button("Approve Pet")
          expect(page).to have_content("Approved")
        end

        within("#pet-#{pet_2.id}") do
          expect(page).to have_content(pet_2.name)
          expect(page).to have_content(pet_2.approximate_age)
          expect(page).to have_content(pet_2.sex)
          expect(page).to have_content(pet_2.shelter.name)
          expect(page).to have_button("Approve Pet")
        end
      end
    end
  end
end