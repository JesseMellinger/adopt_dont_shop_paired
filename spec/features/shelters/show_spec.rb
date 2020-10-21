require 'rails_helper'

describe "as a visitor" do
  describe "when I visit a shelters show page" do
    it "I see the shelter with that id including the shelters name, address, city, state, and zip" do
      shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                 address: "1400 Fairgrounds Road",
                                 city: "Eagle",
                                 state: "CO",
                                 zip: "81631")

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_1.address)
      expect(page).to have_content(shelter_1.city)
      expect(page).to have_content(shelter_1.state)
      expect(page).to have_content(shelter_1.zip)
    end
    it "then I see a list of reviews for that shelter" do
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

      user_2 = User.create!(name: "Tyrion Lannister",
                            street_address: "282 Kevin Brook",
                            city: "Lannisport",
                            state: "CA",
                            zip: "58517")

      review_1 = Review.create!(title: "Friends don\'t lie",
                                rating: 5,
                                content: "Only the educated are free.",
                                picture: "https://upload.wikimedia.org/wikipedia/commons/0/00/Epicteti_Enchiridion_Latinis_versibus_adumbratum_%28Oxford_1715%29_frontispiece.jpg",
                                shelter_id: shelter_1.id,
                                user_id: user_1.id)

      review_2 = Review.create!(title: "Ohh yea, you gotta get schwifty.",
                                rating: 4,
                                content: "Hello, IT. Have you tried turning it off and on again?",
                                picture: "https://upload.wikimedia.org/wikipedia/en/3/33/Silicon_valley_title.png",
                                shelter_id: shelter_1.id,
                                user_id: user_2.id)

      visit("/shelters/#{shelter_1.id}")

      expect(page).to have_content(review_1.title)
      expect(page).to have_content(review_1.rating)
      expect(page).to have_content(review_1.content)
      expect(page).to have_content(review_1.picture)
      expect(page).to have_content(user_1.name)

      expect(page).to have_content(review_2.title)
      expect(page).to have_content(review_2.rating)
      expect(page).to have_content(review_2.content)
      expect(page).to have_content(review_2.picture)
      expect(page).to have_content(user_2.name)
    end
    it "then I see a link to add a new review for this shelter" do
      shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                 address: "1400 Fairgrounds Road",
                                 city: "Eagle",
                                 state: "CO",
                                 zip: "81631")

      visit("/shelters/#{shelter_1.id}")

      click_on("New Review")

      expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")
    end
    it "then I see a link to edit the shelter review next to each review" do
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

      review_1 = Review.create!(title: "Friends don\'t lie",
                                rating: 5,
                                content: "Only the educated are free.",
                                picture: "https://upload.wikimedia.org/wikipedia/commons/0/00/Epicteti_Enchiridion_Latinis_versibus_adumbratum_%28Oxford_1715%29_frontispiece.jpg",
                                shelter_id: shelter_1.id,
                                user_id: user_1.id)

      review_2 = Review.create!(title: "Ohh yea, you gotta get schwifty.",
                                rating: 4,
                                content: "Hello, IT. Have you tried turning it off and on again?",
                                picture: "https://upload.wikimedia.org/wikipedia/en/3/33/Silicon_valley_title.png",
                                shelter_id: shelter_1.id,
                                user_id: user_1.id)

      visit("/shelters/#{shelter_1.id}")

      within "#review-#{review_1.id}" do
        page.find_link("Edit Review")
      end

      within "#review-#{review_2.id}" do
        click_link "Edit Review"
      end

      expect(current_path).to eq("/shelters/#{shelter_1.id}/#{review_2.id}/edit")
    end
    it "then I see a link to delete the shelter review next to each review and I can delete a review" do
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

      review_1 = Review.create!(title: "Friends don\'t lie",
                                rating: 5,
                                content: "Only the educated are free.",
                                picture: "https://upload.wikimedia.org/wikipedia/commons/0/00/Epicteti_Enchiridion_Latinis_versibus_adumbratum_%28Oxford_1715%29_frontispiece.jpg",
                                shelter_id: shelter_1.id,
                                user_id: user_1.id)

      review_2 = Review.create!(title: "Ohh yea, you gotta get schwifty.",
                                rating: 4,
                                content: "Hello, IT. Have you tried turning it off and on again?",
                                picture: "https://upload.wikimedia.org/wikipedia/en/3/33/Silicon_valley_title.png",
                                shelter_id: shelter_1.id,
                                user_id: user_1.id)

      visit("/shelters/#{shelter_1.id}")

        within "#review-#{review_1.id}" do
          page.find_link("Delete Review")
        end

        within "#review-#{review_2.id}" do
          click_link "Delete Review"
        end

      expect(current_path).to eq("/shelters/#{shelter_1.id}")
      expect(page).to have_no_content(review_2)
    end
    it "I see statistics for that shelter, including: count of pets that are at that shelter, average shelter review rating, number of applications on file for that shelter" do
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

      user_2 = User.create!(name: "Tyrion Lannister",
                            street_address: "282 Kevin Brook",
                            city: "Lannisport",
                            state: "CA",
                            zip: "58517")

      review_1 = Review.create!(title: "Friends don\'t lie",
                                rating: 5,
                                content: "Only the educated are free.",
                                picture: "https://upload.wikimedia.org/wikipedia/commons/0/00/Epicteti_Enchiridion_Latinis_versibus_adumbratum_%28Oxford_1715%29_frontispiece.jpg",
                                shelter_id: shelter_1.id,
                                user_id: user_1.id)

      review_2 = Review.create!(title: "Ohh yea, you gotta get schwifty.",
                                rating: 4,
                                content: "Hello, IT. Have you tried turning it off and on again?",
                                picture: "https://upload.wikimedia.org/wikipedia/en/3/33/Silicon_valley_title.png",
                                shelter_id: shelter_1.id,
                                user_id: user_1.id)

      review_3 = Review.create!(title: "Great food",
                                rating: 3,
                                content: "I thought this was a restaurant but I was wrong. The bone-shaped cookies were good though.",
                                picture: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Ensaladang_Lato_%28Seaweed_Salad%29_-_Philippines_1.jpg/594px-Ensaladang_Lato_%28Seaweed_Salad%29_-_Philippines_1.jpg",
                                shelter_id: shelter_1.id,
                                user_id: user_2.id)

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
                          name: "Blue",
                          approximate_age: "5",
                          sex: "Male",
                          shelter_id: shelter_1.id)

      pet_4 = Pet.create!(image: "https://upload.wikimedia.org/wikipedi8/87.jpg",
                          name: "BlueBird",
                          approximate_age: "6",
                          sex: "Female",
                          shelter_id: shelter_1.id)

      application_1 = Application.create!(description: "I love that journey for me.",
                                          status: "Pending",
                                          user_id: user_1.id)

      application_2 = Application.create!(description: "I'm worried Blue has already been adopted",
                                          status: "Pending",
                                          user_id: user_2.id)

      application_3 = Application.create!(description: "I'm worried Blue has already been adopted",
                                          status: "Pending",
                                          user_id: user_2.id)

      pet_application_1 = PetApplication.create!(pet_id: pet_1.id,
                                                 application_id: application_1.id)

      pet_application_2 = PetApplication.create!(pet_id: pet_2.id,
                                                 application_id: application_2.id)

      pet_application_3 = PetApplication.create!(pet_id: pet_4.id,
                                                 application_id: application_2.id)

      visit("/shelters/#{shelter_1.id}")

      within("#statistics") do
        expect(page).to have_content(4)
        expect(page).to have_content(4.0)
        expect(page).to have_content(3)
      end
    end
    describe "If a shelter has approved applications for any of their pets
    I can not delete that shelter" do
      it "there is no button visible for me to delete the shelter" do
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

        application_1 = Application.create!(description: "I love that journey for me.",
                                            status: "Pending",
                                            user_id: user_1.id)

        application_2 = Application.create!(description: "I'm worried Blue has already been adopted",
                                            status: "Approved",
                                            user_id: user_1.id)

        pet_application_1 = PetApplication.create!(pet_id: pet_1.id,
                                                   application_id: application_1.id)

        pet_application_2 = PetApplication.create!(pet_id: pet_2.id,
                                                   application_id: application_2.id)

        visit("/shelters/#{shelter_1.id}")

        expect(page).to have_no_link("Delete Shelter")
      end
    end
  end
end
