require 'rails_helper'

# As a visitor
# When I visit a User's show page
# Then I see all that User's information
# Including the User's
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip

describe "as a visitor" do
  describe "when I visit a Users show page" do
    it "then I see all that Users information" do
      user_1 = User.create!(
        name: "Testy",
        street_address: "221B Baker St.",
        city: "London",
        state: "CO",
        zip: "81650"
      )

      visit("/users/#{user_1.id}")

      expect(page).to have_content(user_1.name)
      expect(page).to have_content(user_1.street_address)
      expect(page).to have_content(user_1.city)
      expect(page).to have_content(user_1.state)
      expect(page).to have_content(user_1.zip)
    end
  end
end
