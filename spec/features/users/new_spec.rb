require 'rails_helper'

# As a visitor
# When I visit '/users/new'
# I see a form to create a new user
# When I fill in the form with my
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip
# Then I am taken to my new user's show page
# And I see all of the information I entered in the form

describe "as a visitor" do
  describe "when I visit /users/new" do
    it "I see a form to create a new user" do
      visit("/users/new")

      fill_in("Name", with: "Testy")
      fill_in("Street Address", with: "221B Baker Street")
      fill_in("City", with: "London")
      fill_in("State", with: "CO")
      fill_in("Zip", with: "81650")

      click_on("Create New User")

      user_1 = User.find_by name: "Testy"

      expect(current_path).to eq("/users/#{user_1.id}")

      expect(page).to have_content("Testy")
      expect(page).to have_content("221B Baker Street")
      expect(page).to have_content("London")
      expect(page).to have_content("CO")
      expect(page).to have_content("81650")

    end
  end
end
