require 'rails_helper'

describe "when I click on the Edit Review link" do
  before :each do
    @shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                               address: "1400 Fairgrounds Road",
                               city: "Eagle",
                               state: "CO",
                               zip: "81631")

    @user_1 = User.create!(name: "Testy",
                          street_address: "221B Baker St.",
                          city: "London",
                          state: "CO",
                          zip: "81650")

    @review_1 = Review.create!(title: "Friends don\'t lie",
                              rating: 5,
                              content: "Only the educated are free.",
                              picture: "https://upload.wikimedia.org/wikipedia/commons/0/00/Epicteti_Enchiridion_Latinis_versibus_adumbratum_%28Oxford_1715%29_frontispiece.jpg",
                              shelter_id: @shelter_1.id,
                              user_id: @user_1.id)
  end
  it "then I am taken to an edit shelter review path where I see a form with that reviews pre populated data" do
    visit("/shelters/#{@shelter_1.id}/#{@review_1.id}/edit")

    expect(find_field(:title).value).to eq(@review_1.title)
    expect(find_field(:rating).value.to_i).to eq(@review_1.rating)
    expect(find_field(:content).value).to eq(@review_1.content)
    expect(find_field(:picture).value).to eq(@review_1.picture)
    expect(find_field(:name).value).to eq(@user_1.name)
    expect(page).to have_button("Update Review")
  end
  it "I can update any of these fields and submit the form" do
    visit("/shelters/#{@shelter_1.id}/#{@review_1.id}/edit")

    fill_in 'Title', with: "Ohh yea, you gotta get schwifty."
    fill_in 'Rating', with: 4
    fill_in 'Content', with: "Hello, IT. Have you tried turning it off and on again?"
    fill_in 'Picture', with: "https://upload.wikimedia.org/wikipedia/en/3/33/Silicon_valley_title.png"
    fill_in 'Name', with: "Legolas"
  end

  describe "when the form is submitted" do
    it "then I should return to that shelter's show page and I can see my update review" do
      visit("/shelters/#{@shelter_1.id}/#{@review_1.id}/edit")

      fill_in 'Title', with: "Ohh yea, you gotta get schwifty."
      fill_in 'Rating', with: 4
      fill_in 'Content', with: "Hello, IT. Have you tried turning it off and on again?"
      fill_in 'Picture', with: "https://upload.wikimedia.org/wikipedia/en/3/33/Silicon_valley_title.png"
      fill_in 'Name', with: "Testy"
      click_button("Update Review")

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      within("#review-#{@review_1.id}") do
        expect(page).to have_content("Ohh yea, you gotta get schwifty.")
        expect(page).to have_content(4)
        expect(page).to have_content("Hello, IT. Have you tried turning it off and on again?")
        expect(page.find("#image")['src']).to have_content("https://upload.wikimedia.org/wikipedia/en/3/33/Silicon_valley_title.png")
        expect(page).to have_content("Testy")
      end
    end
  end

  describe "when I visit the page to edit a review" do
    describe "and I fail to enter a title, a rating, and/or content but still try to submit" do
      it "I see a flash message indicating that I need to fill in a title, rating, and content in order to edit a shelter review" do

        visit("/shelters/#{@shelter_1.id}/#{@review_1.id}/edit")

        fill_in 'Title', with: "Ohh yea, you gotta get schwifty."
        fill_in 'Rating', with: 4
        fill_in 'Content', with: ""
        fill_in 'Picture', with: "https://upload.wikimedia.org/wikipedia/en/3/33/Silicon_valley_title.png"
        fill_in 'Name', with: "Testy"

        click_button("Update Review")

        expect(page).to have_content("Please fill in the 'Title', 'Rating', and 'Content' fields")
        expect(current_path).to eq("/shelters/#{@shelter_1.id}/#{@review_1.id}/edit")

        fill_in 'Title', with: ""
        fill_in 'Rating', with: ""
        fill_in 'Content', with: "Hello, IT. Have you tried turning it off and on again?"
        fill_in 'Picture', with: "https://upload.wikimedia.org/wikipedia/en/3/33/Silicon_valley_title.png"
        fill_in 'Name', with: "Testy"

        expect(page).to have_content("Please fill in the 'Title', 'Rating', and 'Content' fields")
        expect(current_path).to eq("/shelters/#{@shelter_1.id}/#{@review_1.id}/edit")
      end
    end

    describe "and the user doesn't exist in the database but I still try to submit" do
      it "I see a flash message indicating that the User couldn't be found" do

        visit("/shelters/#{@shelter_1.id}/#{@review_1.id}/edit")

        fill_in 'Title', with: "Ohh yea, you gotta get schwifty."
        fill_in 'Rating', with: 4
        fill_in 'Content', with: "Hello, IT. Have you tried turning it off and on again?"
        fill_in 'Picture', with: "https://upload.wikimedia.org/wikipedia/en/3/33/Silicon_valley_title.png"
        fill_in 'Name', with: "Legolas"

        click_button("Update Review")

        expect(page).to have_content("User could not be found")
        expect(current_path).to eq("/shelters/#{@shelter_1.id}/#{@review_1.id}/edit")
      end
    end
  end
end
