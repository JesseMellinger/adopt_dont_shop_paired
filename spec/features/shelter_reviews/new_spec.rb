require 'rails_helper'

describe "as a visitor" do
  describe "when I'm on a new review page, I can complete a form" do
    it "then I submit a form and return to that shelters show page where I see my review" do
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

      visit("/shelters/#{shelter_1.id}/reviews/new")

      fill_in("title", with: "Friends don\'t lie")
      fill_in("rating", with: "5")
      fill_in("picture", with: "https://upload.wikimedia.org/wikipedia/en/3/33/Silicon_valley_title.png")
      fill_in("content", with: "Only the educated are free.")
      fill_in("name", with: "Testy")

      click_on("Create Review")

      expect(current_path).to eq("/shelters/#{shelter_1.id}")

      expect(page).to have_content("Friends don\'t lie")
      expect(page).to have_content("5")
      expect(page.find("#image")['src']).to have_content("https://upload.wikimedia.org/wikipedia/en/3/33/Silicon_valley_title.png")
      expect(page).to have_content("Only the educated are free.")
      expect(page).to have_content("Testy")

    end
    describe "when I fail to enter a title, a rating, and/or content in the new shelter review form, but still try to submit the form" do
      it "I see a flash message indicating that I need to fill in a title, rating, and content in order to submit a shelter review" do
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


        visit("/shelters/#{shelter_1.id}/reviews/new")

        fill_in("title", with: "Friends don\'t lie")
        fill_in("rating", with: 5)
        fill_in("picture", with: "https://upload.wikimedia.org/wikipedia/en/3/33/Silicon_valley_title.png")
        fill_in("content", with: "")
        fill_in("name", with: "Testy")

        click_on("Create Review")

        expect(page).to have_content("Please fill in the 'Title', 'Rating', and 'Content' fields")

        expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")

        fill_in("title", with: "")
        fill_in("rating", with: "")
        fill_in("picture", with: "https://upload.wikimedia.org/wikipedia/en/3/33/Silicon_valley_title.png")
        fill_in("content", with: "Only the educated are free.")
        fill_in("name", with: "Testy")

        click_on("Create Review")

        expect(page).to have_content("Please fill in the 'Title', 'Rating', and 'Content' fields")

        expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")

      end
      describe "when I enter the name of a user that doesn't exist in the database, but still try to submit the form" do
        it "then I see a flash message indicating that the User couldn't be found" do
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


          visit("/shelters/#{shelter_1.id}/reviews/new")

          fill_in("title", with: "Friends don\'t lie")
          fill_in("rating", with: 5)
          fill_in("picture", with: "https://upload.wikimedia.org/wikipedia/en/3/33/Silicon_valley_title.png")
          fill_in("content", with: "Only the educated are free.")
          fill_in("name", with: "Legolas")

          click_on("Create Review")

          expect(page).to have_content("User could not be found")

          expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")

        end
      end
    end
  end
  describe "when I create a review for a shelter" do
    describe "and do not fill in the field for an image" do
      it "a default image is used and displayed for that review upon submission" do
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

        visit("/shelters/#{shelter_1.id}/reviews/new")

        fill_in("title", with: "Friends don\'t lie")
        fill_in("rating", with: "5")
        fill_in("content", with: "Only the educated are free.")
        fill_in("name", with: "Testy")

        click_on("Create Review")

        expect(page).to have_content("Friends don\'t lie")
        expect(page).to have_content("5")
        expect(page.find("#image")['src']).to have_content("https://i.kym-cdn.com/entries/icons/original/000/018/012/this_is_fine.jpeg")
        expect(page).to have_content("Only the educated are free.")
        expect(page).to have_content("Testy")

      end
    end
  end
end
