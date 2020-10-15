require 'rails_helper'

# As a visitor,
# When I visit a shelter's show page
# I see a link to add a new review for this shelter.
# When I click on this link, I am taken to a new review path
# On this new page, I see a form where I must enter:
# - title
# - rating
# - content
# - the name of a user that exists in the database
# I also see a field where I can enter an optional image (web address)
# When the form is submitted, I should return to that shelter's show page
# and I can see my new review

# As a visitor,
# When I visit the new review page
# And I fail to enter a title, a rating, and/or content in the new shelter review form, but still try to submit the form
# I see a flash message indicating that I need to fill in a title, rating, and content in order to submit a shelter review
# And I'm returned to the new form to create a new review

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
      expect(page).to have_content("https://upload.wikimedia.org/wikipedia/en/3/33/Silicon_valley_title.png")
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
        fill_in("rating", with: "5")
        fill_in("picture", with: "https://upload.wikimedia.org/wikipedia/en/3/33/Silicon_valley_title.png")
        fill_in("content", with: "")
        fill_in("name", with: "Testy")

        click_on("Create Review")

        expect(flash[:notice]).to eq("Please fill in the 'Title', 'Rating', and 'Content' fields")

        expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")

      end
    end
  end
end
