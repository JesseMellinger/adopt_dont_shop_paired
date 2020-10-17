require 'rails_helper'

# As a visitor
# When I visit the pet index page
# Then I see a link to "Start an Application"
# When I click this link
# Then I am taken to the new application page where I see a form
# When I fill in this form with my user name (assuming I have already created a user in the system)
# And I click submit
# Then I am taken to the new application's show page
# And I see my user listed along with all of my address information
# And I see an indicator that this application is "In Progress"

describe "as a visitor" do
  describe "when I'm on a new application page, I can complete a form" do
    describe "when I fill in this form with my user name and I click submit" do
      it "then I am taken to the new application's show page" do
        user_1 = User.create!(name: "Testy",
                              street_address: "221B Baker St.",
                              city: "London",
                              state: "CO",
                              zip: "81650"
                              )

        visit("/applications/new")

        fill_in("user_name", with: "Testy")

        click_link("Submit Application")

        application_1 = Application.create!(status: "In Progress",
                                            user_id: user_1.id)

        expect(current_path).to eq("/application/#{application_1.id}")

        expect(page).to have_content("User Name: #{user_1.name}")
        expect(page).to have_content("Street Address: #{user_1.street_address}")
        expect(page).to have_content("City: #{user_1.city}")
        expect(page).to have_content("State: #{user_1.state}")
        expect(page).to have_content("Zip: #{user_1.zip}")
        expect(page).to have_content("Status: #{application_1.status}")

      end
    end
  end
end
