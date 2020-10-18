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

# As a visitor
# When I visit an application's show page
# And that application has not been submitted,
# Then I see a section on the page to "Add a Pet to this Application"
# In that section I see an input where I can search for Pets by name
# When I fill in this field with a Pet's name
# And I click submit,
# Then I am taken back to the application show page
# And under the search bar I see any Pet whose name matches my search

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
    describe "and that application has not been submitted" do
      it "then I see a section on the page to 'Add a Pet to this Application'" do
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

        application_1 = Application.create!(description: "Well let's get some dogs.",
                                            status: "In Progress",
                                            user_id: user_1.id)

        pet_1 = Pet.create!(image: "https://upload.wikimedia.org/wikipedia/commons/8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                            name: "Blue",
                            approximate_age: "2",
                            sex: "Female",
                            shelter_id: shelter_1.id
                            )

        visit("/applications/#{application_1.id}")

        within("#add-pets") do
          expect(page).to have_selector("#search-label")
          fill_in("search", with: "#{pet_1.name}")
        end
      end
      describe "when I click 'Search'" do
        it "then I am taken back to the application show page and under the search bar I see any Pet whose name matches my search" do
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
                                     zip: "81631")


          application_1 = Application.create!(description: "Well let's get some dogs.",
                                              status: "In Progress",
                                              user_id: user_1.id)

          pet_1 = Pet.create!(image: "https://upload.wikimedia.org/wikipedia/commons/8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                              name: "Blue",
                              approximate_age: "2",
                              sex: "Female",
                              shelter_id: shelter_1.id
                              )

          visit("/applications/#{application_1.id}")

          within("#add-pets") do
            expect(page).to have_selector("#search-label")
            fill_in("search", with: "#{pet_1.name}")
            click_button("Search")
          end

          expect(current_path).to eq("/applications/#{application_1.id}")

          within("#add-pets") do
            expect(page).to have_selector("#search-label")
            expect(page).to have_field("search")
          end

          expect(page).to have_content(pet_1.name)
          expect(page).to have_content(pet_1.approximate_age)
          expect(page).to have_content(pet_1.sex)
        end
        describe "when I see the names of Pets that matches my search" do
          it "then next to each Pet's name I see a button to 'Adopt this Pet' and I am taken back to the application show page when I click one of these buttons and see the Pet I want to adopt listed on this application" do
            user_1 = User.create!(name: "Testy",
                                  street_address: "221B Baker St.",
                                  city: "London",
                                  state: "CO",
                                  zip: "81650")

            shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                       address: "1400 Fairgrounds Road",
                                       city: "Eagle",
                                       state: "CO",
                                       zip: "81631")


            application_1 = Application.create!(description: "Well let's get some dogs.",
                                                status: "In Progress",
                                                user_id: user_1.id)

            pet_1 = Pet.create!(image: "https://upload.wikimedia.org/wikipedia/commons/8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                                name: "Blue",
                                approximate_age: "2",
                                sex: "Female",
                                shelter_id: shelter_1.id)

            pet_2 = Pet.create!(image: "https://upload.wikimedia.org/wikipedi8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                                name: "Blue",
                                approximate_age: "5",
                                sex: "Male",
                                shelter_id: shelter_1.id)

            visit("/applications/#{application_1.id}")

            within("#add-pets") do
              expect(page).to have_selector("#search-label")
              fill_in("search", with: "Blue")
              click_button("Search")
            end

            expect(current_path).to eq("/applications/#{application_1.id}")

            within("#add-pets") do
              expect(page).to have_selector("#search-label")
              expect(page).to have_field("search")
            end

            within("#pet-#{pet_1.id}") do
              expect(page).to have_content(pet_1.name)
              expect(page).to have_content(pet_1.approximate_age)
              expect(page).to have_content(pet_1.sex)
              expect(page).to have_button("Adopt this Pet")
            end

            within("#pet-#{pet_2.id}") do
              expect(page).to have_content(pet_2.name)
              expect(page).to have_content(pet_2.approximate_age)
              expect(page).to have_content(pet_2.sex)
              click_button("Adopt this Pet")
            end

            expect(current_path).to eq("/applications/#{application_1.id}")

            expect(page).to have_link("#{pet_2.name}")
          end
        end
        describe "when I have added one or more pets to my application" do
          describe "then I see a section to submit my application wherein I see an input to enter why I would make a good owner for these pet(s)" do
            it "I fill in the input and I click a button to submit this application which takes me back to the application's show page" do
              user_1 = User.create!(name: "Testy",
                                    street_address: "221B Baker St.",
                                    city: "London",
                                    state: "CO",
                                    zip: "81650")

              shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                         address: "1400 Fairgrounds Road",
                                         city: "Eagle",
                                         state: "CO",
                                         zip: "81631")


              application_1 = Application.create!(description: "Well let's get some dogs.",
                                                  status: "In Progress",
                                                  user_id: user_1.id)

              pet_1 = Pet.create!(image: "https://upload.wikimedia.org/wikipedia/commons/8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                                  name: "Blue",
                                  approximate_age: "2",
                                  sex: "Female",
                                  shelter_id: shelter_1.id)

              visit("/applications/#{application_1.id}")

              within("#add-pets") do
                expect(page).to have_selector("#search-label")
                fill_in("search", with: "Blue")
                click_button("Search")
              end

              within("#pet-#{pet_1.id}") do
                expect(page).to have_content(pet_1.name)
                expect(page).to have_content(pet_1.approximate_age)
                expect(page).to have_content(pet_1.sex)
                click_button("Adopt this Pet")
              end

              fill_in("Why would you make a good owner for these pets?", with: "I love that journey for me.")

              click_button("Submit Application")

              expect(current_path).to eq("/applications/#{application_1.id}")
            end
            it "I see an indicator that the application is 'Pending', I see all the pets that I want to adopt, and I do not see a section to add more pets to this application" do
              user_1 = User.create!(name: "Testy",
                                    street_address: "221B Baker St.",
                                    city: "London",
                                    state: "CO",
                                    zip: "81650")

              shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                         address: "1400 Fairgrounds Road",
                                         city: "Eagle",
                                         state: "CO",
                                         zip: "81631")


              application_1 = Application.create!(description: "Well let's get some dogs.",
                                                  status: "In Progress",
                                                  user_id: user_1.id)

              pet_1 = Pet.create!(image: "https://upload.wikimedia.org/wikipedia/commons/8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                                  name: "Blue",
                                  approximate_age: "2",
                                  sex: "Female",
                                  shelter_id: shelter_1.id)

              pet_2 = Pet.create!(image: "https://upload.wikimedia.org/wikGCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                                  name: "Blue",
                                  approximate_age: "5",
                                  sex: "Male",
                                  shelter_id: shelter_1.id)

              visit("/applications/#{application_1.id}")

              within("#add-pets") do
                expect(page).to have_selector("#search-label")
                fill_in("search", with: "Blue")
                click_button("Search")
              end

              within("#pet-#{pet_1.id}") do
                expect(page).to have_content(pet_1.name)
                expect(page).to have_content(pet_1.approximate_age)
                expect(page).to have_content(pet_1.sex)
                click_button("Adopt this Pet")
              end

              fill_in("Why would you make a good owner for these pets?", with: "I love that journey for me.")

              click_button("Submit Application")

              expect(current_path).to eq("/applications/#{application_1.id}")

              within("#status") do
                expect(page).to have_content("Pending")
              end

              expect(page).to have_link("#{pet_1.name}")

              expect(page).to have_no_selector("#add-pets")
            end
          end
        end
        describe "when I have not added any pets to the application" do
          it "then I do not see a section to submit my application" do
            user_1 = User.create!(name: "Testy",
                                  street_address: "221B Baker St.",
                                  city: "London",
                                  state: "CO",
                                  zip: "81650")

            shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                       address: "1400 Fairgrounds Road",
                                       city: "Eagle",
                                       state: "CO",
                                       zip: "81631")


            application_1 = Application.create!(status: "In Progress",
                                                user_id: user_1.id)

            pet_1 = Pet.create!(image: "https://upload.wikimedia.org/wikipedia/commons/8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                                name: "Blue",
                                approximate_age: "2",
                                sex: "Female",
                                shelter_id: shelter_1.id)

            pet_2 = Pet.create!(image: "https://upload.wikimedia.org/wikGCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                                name: "Blue",
                                approximate_age: "5",
                                sex: "Male",
                                shelter_id: shelter_1.id)

            visit("/applications/#{application_1.id}")
            
            expect(page).to have_no_selector("#description-area")

            within("#add-pets") do
              expect(page).to have_selector("#search-label")
              fill_in("search", with: "Blue")
              click_button("Search")
            end

            within("#pet-#{pet_1.id}") do
              expect(page).to have_content(pet_1.name)
              expect(page).to have_content(pet_1.approximate_age)
              expect(page).to have_content(pet_1.sex)
              click_button("Adopt this Pet")
            end

            expect(page).to have_selector("#description-area")
          end
        end
      end
    end
  end
end
