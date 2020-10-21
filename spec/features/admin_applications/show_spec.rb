require 'rails_helper'

describe "as a visitor" do
  before :each do
    @user_1 = User.create!(name: "Testy",
                           street_address: "221B Baker St.",
                           city: "London",
                           state: "CO",
                           zip: "81650")

    @shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                               address: "1400 Fairgrounds Road",
                               city: "Eagle",
                               state: "CO",
                               zip: "81631")

    @application_1 = Application.create!(description: "",
                                        status: "In Progress",
                                        user_id: @user_1.id)

    @pet_1 = Pet.create!(name: "Blue",
                        approximate_age: "2",
                        sex: "Female",
                        shelter_id: @shelter_1.id)

    @pet_2 = Pet.create!(name: "Mr. Blue",
                        approximate_age: "6",
                        sex: "Female",
                        shelter_id: @shelter_1.id)
  end
  describe "when I visit an admin application show page ('/admin/applications/:id')" do
    describe "when I click a button to approve the application for that specific pet" do
      it "then I'm taken back to the admin application show page, and next to the pet that I approved, I do not see a button to approve this pet, and instead I see an indicator next to the pet that they have been approved" do

        visit("/applications/#{@application_1.id}")

        within("#add-pets") do
          fill_in("search", with: "#{@pet_1.name}")
          click_button("Search")
        end

        within("#pet-#{@pet_1.id}") do
          click_button("Adopt this Pet")
        end

        within("#add-pets") do
          fill_in("search", with: "#{@pet_1.name}")
          click_button("Search")
        end

        within("#pet-#{@pet_2.id}") do
          click_button("Adopt this Pet")
        end

        fill_in("Why would you make a good owner for these pets?", with: "I love that journey for me.")

        click_button("Submit Application")

        visit("/admin/applications/#{@application_1.id}")

        within("#pet-#{@pet_1.id}") do
          expect(page).to have_content(@pet_1.name)
          expect(page).to have_content(@pet_1.approximate_age)
          expect(page).to have_content(@pet_1.sex)
          expect(page).to have_content(@pet_1.shelter.name)
          click_button("Approve Pet")
        end

        visit("/admin/applications/#{@application_1.id}")

        within("#pet-#{@pet_1.id}") do
          expect(page).to have_content(@pet_1.name)
          expect(page).to have_content(@pet_1.approximate_age)
          expect(page).to have_content(@pet_1.sex)
          expect(page).to have_content(@pet_1.shelter.name)
          expect(page).to have_no_button("Approve Pet")
          expect(page).to have_content("Approved")
        end

        within("#pet-#{@pet_2.id}") do
          expect(page).to have_content(@pet_2.name)
          expect(page).to have_content(@pet_2.approximate_age)
          expect(page).to have_content(@pet_2.sex)
          expect(page).to have_content(@pet_2.shelter.name)
          expect(page).to have_button("Approve Pet")
        end
      end
    end
    describe "for every pet that the application is for, I see a button to reject the application for that specific pet" do
      describe "when I click that button" do
        it "then I'm taken back to the admin application show page
        and next to the pet that I rejected, I do not see a button to approve or reject this pet and instead I see an indicator next to the pet that they have been rejected" do
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

          within("#pet-#{pet_2.id}") do
            expect(page).to have_content(pet_2.name)
            expect(page).to have_content(pet_2.approximate_age)
            expect(page).to have_content(pet_2.sex)
            expect(page).to have_content(pet_2.shelter.name)
            expect(page).to have_button("Approve Pet")
            click_button("Reject Pet")
          end

          visit("/admin/applications/#{application_1.id}")

          within("#pet-#{pet_1.id}") do
            expect(page).to have_content(pet_1.name)
            expect(page).to have_content(pet_1.approximate_age)
            expect(page).to have_content(pet_1.sex)
            expect(page).to have_content(pet_1.shelter.name)
            expect(page).to have_button("Approve Pet")
            expect(page).to have_button("Reject Pet")
          end

          within("#pet-#{pet_2.id}") do
            expect(page).to have_content(pet_2.name)
            expect(page).to have_content(pet_2.approximate_age)
            expect(page).to have_content(pet_2.sex)
            expect(page).to have_content(pet_2.shelter.name)
            expect(page).to have_no_button("Reject Pet")
            expect(page).to have_content("Rejected")
          end
        end
      end
    end
    describe "and I approve all pets for an application" do
      it "then I am taken back to the admin application show page
      And I see the application's status has changed to 'Approved'" do
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

        within("#pet-#{pet_2.id}") do
          expect(page).to have_content(pet_2.name)
          expect(page).to have_content(pet_2.approximate_age)
          expect(page).to have_content(pet_2.sex)
          expect(page).to have_content(pet_2.shelter.name)
          click_button("Approve Pet")
        end

        visit("/admin/applications/#{application_1.id}")

        within("#status") do
          expect(page).to have_content("Approved")
        end
      end
    end
    describe "and I reject one or more pets for the application" do
      describe "and I approve all other pets on the application" do
        it "then I am taken back to the admin application show page
        and I see the application's status has changed to 'Rejected'" do
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

        pet_3 = Pet.create!(name: "Bluebie",
                            approximate_age: "4",
                            sex: "Female",
                            shelter_id: shelter_1.id)

         pet_application_1 = PetApplication.create!(pet_id: pet_1.id,
                                                    application_id: application_1.id)

         pet_application_2 = PetApplication.create!(pet_id: pet_2.id,
                                                    application_id: application_1.id)

         pet_application_3 = PetApplication.create!(pet_id: pet_3.id,
                                                    application_id: application_1.id)

         visit("/admin/applications/#{application_1.id}")

         within("#pet-#{pet_1.id}") do
           click_button("Approve Pet")
         end

         within("#pet-#{pet_2.id}") do
           click_button("Reject Pet")
         end

         within("#pet-#{pet_3.id}") do
           click_button("Reject Pet")
         end

         within("#status") do
           expect(page).to have_content("Rejected")
         end
        end
      end
    end
    describe "when a pet is on a fully 'Approved' application" do
      describe "and when that same pet is on a 'Pending' application
      and I visit the admin application show page for that pending application" do
        it "then next to the pet I do not see a button to approve or reject them
        and instead I see a message that this pet has been approved for adoption" do
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

          pet_1 = Pet.create!(name: "Blue",
                              approximate_age: "2",
                              sex: "Female",
                              shelter_id: shelter_1.id,
                              adoption_status: "adopted")

          pet_application_1 = PetApplication.create!(pet_id: pet_1.id,
                                                     application_id: application_1.id,
                                                     status: "Approved")

          pet_application_2 = PetApplication.create!(pet_id: pet_1.id,
                                                     application_id: application_2.id)

          visit("/admin/applications/#{application_2.id}")

          within("#pet-#{pet_1.id}") do
            expect(page).to have_no_button("Approve Pet")
            expect(page).to have_no_button("Reject Pet")
            expect(page).to have_content("This pet has been approved for adoption")
          end
        end
      end
    end
  end
end
