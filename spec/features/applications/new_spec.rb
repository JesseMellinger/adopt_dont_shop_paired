require 'rails_helper'

describe "as a visitor" do
  before :each do
    @user_1 = User.create!(name: "Testy",
                          street_address: "221B Baker St.",
                          city: "London",
                          state: "CO",
                          zip: "81650")
  end
  describe "when I'm on a new application page, I can complete a form" do
    describe "when I fill in this form with my user name and I click submit" do
      it "then I am taken to the new application's show page" do

        visit("/applications/new")

        fill_in("user_name", with: "Testy")

        click_button("Submit Application")

        application_1 = Application.find_by(user_id: @user_1.id)

        expect(current_path).to eq("/applications/#{application_1.id}")

        expect(page).to have_content("User Name: #{@user_1.name}")
        expect(page).to have_content("Street Address: #{@user_1.street_address}")
        expect(page).to have_content("City: #{@user_1.city}")
        expect(page).to have_content("State: #{@user_1.state}")
        expect(page).to have_content("Zip: #{@user_1.zip}")
        expect(page).to have_content("Status: #{application_1.status}")

      end
    end
    describe "when I fill in the form with the name of a User that doesn't exist in the database and I click submit" do
      it "then I am taken back to the new applications page and I see a message that the user could not be found" do

        visit("/applications/new")

        fill_in("user_name", with: "Legolas")

        click_button("Submit Application")

        expect(page).to have_content("User could not be found")

        expect(current_path).to eq("/applications/new")
      end
    end
  end
end
