# As a visitor
# When I visit an applications show page "/applications/:id"
# Then I can see the following:
# - Name of the User on the Application
# - Full Address of the User on the Application
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

# an Application belongs to ONE User
# a User can have MANY Applications
# an Application can have MANY Pets THROUGH Pet Applications
# a Pet can have MANY Applications THROUGH Pet Applications

require 'rails_helper'

RSpec.describe "as a visitor" do
  describe "when I visit an application's show page" do
    it "I see the application with that id including the application's name of user, address of user, applicant's description, names of all pets (as links), and app status" do
      shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                 address: "1400 Fairgrounds Road",
                                 city: "Eagle",
                                 state: "CO",
                                 zip: "81631"
                                 )

      pet_1 = Pet.create!(image: "https://upload.wikimedia.org/wikipedia/commons/8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                          name: "Blue",
                          approximate_age: "2",
                          sex: "Female",
                          shelter_id: shelter_1.id
                          )

      pet_2 = Pet.create!(image: "https://upload.wikimedia.org/wikipedia/commons/8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                          name: "John Cougar Mellencamp",
                          approximate_age: "4",
                          sex: "Male",
                          shelter_id: shelter_1.id
                          )

      user_1 = User.create!(name: "Testy",
                            street_address: "221B Baker St.",
                            city: "London",
                            state: "CO",
                            zip: "81650"
                            )

      application_1 = Application.create!(description: "Well let's get some dogs.",
                                          status: "In Progress",
                                          user_id: user_1.id)

      PetApplication.create!(pet_id: pet_1.id,
                             application_id: application_1.id)

      PetApplication.create!(pet_id: pet_2.id,
                             application_id: application_1.id)

      visit "/applications/#{application_1.id}"

      expect(page).to have_content(user_1.name)
      expect(page).to have_content(user_1.street_address)
      expect(page).to have_content(user_1.city)
      expect(page).to have_content(user_1.state)
      expect(page).to have_content(user_1.zip)
      expect(page).to have_content(application_1.description)
      expect(page).to have_content(application_1.status)
      expect(page).to have_link(pet_1.name, :href=>"/pets/#{pet_1.id}")
      expect(page).to have_link(pet_2.name, :href=>"/pets/#{pet_2.id}")
    end
  end
end
