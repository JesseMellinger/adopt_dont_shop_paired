require 'rails_helper'

RSpec.describe "as a visitor" do
  before :each do
    @shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                               address: "1400 Fairgrounds Road",
                               city: "Eagle",
                               state: "CO",
                               zip: "81631")

    @pet_1 = Pet.create!(image: "https://upload.wikimedia.org/wikipedia/commons/8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                        name: "Blue",
                        approximate_age: "2",
                        sex: "Female",
                        shelter_id: @shelter_1.id)

    @pet_2 = Pet.create!(image: "https://upload.wikimedia.org/wikipedia/commons/8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                        name: "John Cougar Mellencamp",
                        approximate_age: "4",
                        sex: "Male",
                        shelter_id: @shelter_1.id)

    @user_1 = User.create!(name: "Testy",
                          street_address: "221B Baker St.",
                          city: "London",
                          state: "CO",
                          zip: "81650")

    @application_1 = Application.create!(description: "Well let's get some dogs.",
                                        status: "In Progress",
                                        user_id: @user_1.id)
  end
  describe "when I visit an application's show page" do
    it "I see the application with that id including the application's name of user, address of user, applicant's description, names of all pets (as links), and app status" do

      PetApplication.create!(pet_id: @pet_1.id,
                             application_id: @application_1.id)

      PetApplication.create!(pet_id: @pet_2.id,
                             application_id: @application_1.id)

      visit "/applications/#{@application_1.id}"

      expect(page).to have_content(@user_1.name)
      expect(page).to have_content(@user_1.street_address)
      expect(page).to have_content(@user_1.city)
      expect(page).to have_content(@user_1.state)
      expect(page).to have_content(@user_1.zip)
      expect(page).to have_content(@application_1.description)
      expect(page).to have_content(@application_1.status)
      expect(page).to have_link(@pet_1.name, :href=>"/pets/#{@pet_1.id}")
      expect(page).to have_link(@pet_2.name, :href=>"/pets/#{@pet_2.id}")
    end
    describe "and that application has not been submitted" do
      it "then I see a section on the page to 'Add a Pet to this Application'" do

        visit("/applications/#{@application_1.id}")

        within("#add-pets") do
          expect(page).to have_selector("#search-label")
          fill_in("search", with: "#{@pet_1.name}")
        end
      end
      describe "when I click 'Search'" do
        it "then I am taken back to the application show page and under the search bar I see any Pet whose name matches my search" do

          visit("/applications/#{@application_1.id}")

          within("#add-pets") do
            expect(page).to have_selector("#search-label")
            fill_in("search", with: "#{@pet_1.name}")
            click_button("Search")
          end

          expect(current_path).to eq("/applications/#{@application_1.id}")

          within("#add-pets") do
            expect(page).to have_selector("#search-label")
            expect(page).to have_field("search")
          end

          expect(page).to have_content(@pet_1.name)
          expect(page).to have_content(@pet_1.approximate_age)
          expect(page).to have_content(@pet_1.sex)
        end
        describe "when I see the names of Pets that matches my search" do
          it "then next to each Pet's name I see a button to 'Adopt this Pet' and I am taken back to the application show page when I click one of these buttons and see the Pet I want to adopt listed on this application" do

            pet_2 = Pet.create!(image: "https://upload.wikimedia.org/wikipedi8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                                name: "Blue",
                                approximate_age: "5",
                                sex: "Male",
                                shelter_id: @shelter_1.id)

            visit("/applications/#{@application_1.id}")

            within("#add-pets") do
              expect(page).to have_selector("#search-label")
              fill_in("search", with: "Blue")
              click_button("Search")
            end

            expect(current_path).to eq("/applications/#{@application_1.id}")

            within("#add-pets") do
              expect(page).to have_selector("#search-label")
              expect(page).to have_field("search")
            end

            within("#pet-#{@pet_1.id}") do
              expect(page).to have_content(@pet_1.name)
              expect(page).to have_content(@pet_1.approximate_age)
              expect(page).to have_content(@pet_1.sex)
              expect(page).to have_button("Adopt this Pet")
            end

            within("#pet-#{pet_2.id}") do
              expect(page).to have_content(pet_2.name)
              expect(page).to have_content(pet_2.approximate_age)
              expect(page).to have_content(pet_2.sex)
              click_button("Adopt this Pet")
            end

            expect(current_path).to eq("/applications/#{@application_1.id}")

            expect(page).to have_link("#{pet_2.name}")
          end
        end
        describe "when I have added one or more pets to my application" do
          describe "then I see a section to submit my application wherein I see an input to enter why I would make a good owner for these pet(s)" do
            it "I fill in the input and I click a button to submit this application which takes me back to the application's show page" do

              visit("/applications/#{@application_1.id}")

              within("#add-pets") do
                expect(page).to have_selector("#search-label")
                fill_in("search", with: "Blue")
                click_button("Search")
              end

              within("#pet-#{@pet_1.id}") do
                expect(page).to have_content(@pet_1.name)
                expect(page).to have_content(@pet_1.approximate_age)
                expect(page).to have_content(@pet_1.sex)
                click_button("Adopt this Pet")
              end

              fill_in("Why would you make a good owner for these pets?", with: "I love that journey for me.")

              click_button("Submit Application")

              expect(current_path).to eq("/applications/#{@application_1.id}")
            end
            it "I see an indicator that the application is 'Pending', I see all the pets that I want to adopt, and I do not see a section to add more pets to this application" do

              visit("/applications/#{@application_1.id}")

              within("#add-pets") do
                expect(page).to have_selector("#search-label")
                fill_in("search", with: "Blue")
                click_button("Search")
              end

              within("#pet-#{@pet_1.id}") do
                expect(page).to have_content(@pet_1.name)
                expect(page).to have_content(@pet_1.approximate_age)
                expect(page).to have_content(@pet_1.sex)
                click_button("Adopt this Pet")
              end

              fill_in("Why would you make a good owner for these pets?", with: "I love that journey for me.")

              click_button("Submit Application")

              expect(current_path).to eq("/applications/#{@application_1.id}")

              within("#status") do
                expect(page).to have_content("Pending")
              end

              expect(page).to have_link("#{@pet_1.name}")

              expect(page).to have_no_selector("#add-pets")
            end
          end
        end
        describe "when I have not added any pets to the application" do
          it "then I do not see a section to submit my application" do

            visit("/applications/#{@application_1.id}")

            expect(page).to have_no_selector("#description-area")

            within("#add-pets") do
              expect(page).to have_selector("#search-label")
              fill_in("search", with: "Blue")
              click_button("Search")
            end

            within("#pet-#{@pet_1.id}") do
              expect(page).to have_content(@pet_1.name)
              expect(page).to have_content(@pet_1.approximate_age)
              expect(page).to have_content(@pet_1.sex)
              click_button("Adopt this Pet")
            end

            expect(page).to have_selector("#description-area")
          end
        end
      end
      describe "when I fail to enter why I would make a good owner for these pet(s)" do
        it "then I am taken back to the application's show page, and I see a flash message that I need to fill out that field before I can submit the application, and I see my application is still 'In Progress'" do

          pet_2 = Pet.create!(image: "https://upload.wikimedia.org/wikipedi8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                              name: "Blue",
                              approximate_age: "5",
                              sex: "Male",
                              shelter_id: @shelter_1.id)

          visit("/applications/#{@application_1.id}")

          within("#add-pets") do
            expect(page).to have_selector("#search-label")
            fill_in("search", with: "Blue")
            click_button("Search")
          end

          within("#pet-#{pet_2.id}") do
            expect(page).to have_content(pet_2.name)
            expect(page).to have_content(pet_2.approximate_age)
            expect(page).to have_content(pet_2.sex)
            click_button("Adopt this Pet")
          end

          click_button("Submit Application")

          expect(current_path).to eq("/applications/#{@application_1.id}")

          expect(page).to have_content("Please tell us why you would make a good owner.")

          within("#status") do
            expect(page).to have_content("In Progress")
          end
        end
      end
      describe "when I search for Pets by name" do
        it "then I see any pet whose name PARTIALLY matches my search" do

          pet_2 = Pet.create!(image: "https://upload.wikimedia.org/wikipedia/commons/8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                              name: "Mr. Blue",
                              approximate_age: "6",
                              sex: "Female",
                              shelter_id: @shelter_1.id)

          pet_3 = Pet.create!(image: "https://upload.wikimedia.org/wikipedia/commons/8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                              name: "Bluebie",
                              approximate_age: "5",
                              sex: "Male",
                              shelter_id: @shelter_1.id)

          pet_4 = Pet.create!(image: "https://upload.wikimedia.org/wikipedia/commons/8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                              name: "Rudolph",
                              approximate_age: "2",
                              sex: "Female",
                              shelter_id: @shelter_1.id)

          visit("/applications/#{@application_1.id}")

          within("#add-pets") do
            expect(page).to have_selector("#search-label")
            fill_in("search", with: "#{@pet_1.name}")
            click_button("Search")
          end

          within("#pet-#{@pet_1.id}") do
            expect(page).to have_content("#{@pet_1.name}")
            expect(page).to have_content("#{@pet_1.approximate_age}")
            expect(page).to have_content("#{@pet_1.sex}")
          end

          within("#pet-#{pet_2.id}") do
            expect(page).to have_content("#{pet_2.name}")
            expect(page).to have_content("#{pet_2.approximate_age}")
            expect(page).to have_content("#{pet_2.sex}")
          end

          within("#pet-#{pet_3.id}") do
            expect(page).to have_content("#{pet_3.name}")
            expect(page).to have_content("#{pet_3.approximate_age}")
            expect(page).to have_content("#{pet_3.sex}")
          end

          expect(page).to have_no_content(pet_4)
        end
      end
      it "then my search is case insensitive" do

        pet_2 = Pet.create!(image: "https://upload.wikimedia.org/wikipedia/commons/8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                            name: "Mr. blUe",
                            approximate_age: "6",
                            sex: "Female",
                            shelter_id: @shelter_1.id)

        pet_3 = Pet.create!(image: "https://upload.wikimedia.org/wikipedia/commons/8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                            name: "bluebie",
                            approximate_age: "5",
                            sex: "Male",
                            shelter_id: @shelter_1.id)

        pet_4 = Pet.create!(image: "https://upload.wikimedia.org/wikipedia/commons/8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                            name: "Rudolph",
                            approximate_age: "2",
                            sex: "Female",
                            shelter_id: @shelter_1.id)

        visit("/applications/#{@application_1.id}")

        within("#add-pets") do
          expect(page).to have_selector("#search-label")
          fill_in("search", with: "#{@pet_1.name}")
          click_button("Search")
        end

        within("#pet-#{@pet_1.id}") do
          expect(page).to have_content("#{@pet_1.name}")
          expect(page).to have_content("#{@pet_1.approximate_age}")
          expect(page).to have_content("#{@pet_1.sex}")
        end

        within("#pet-#{pet_2.id}") do
          expect(page).to have_content("#{pet_2.name}")
          expect(page).to have_content("#{pet_2.approximate_age}")
          expect(page).to have_content("#{pet_2.sex}")
        end

        within("#pet-#{pet_3.id}") do
          expect(page).to have_content("#{pet_3.name}")
          expect(page).to have_content("#{pet_3.approximate_age}")
          expect(page).to have_content("#{pet_3.sex}")
        end

        expect(page).to have_no_content(pet_4)
      end
    end
  end
end
