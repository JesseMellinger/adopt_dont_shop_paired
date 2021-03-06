require 'rails_helper'

describe "as a visitor" do
  before :each do
    @user_1 = User.create!(
      name: "Testy",
      street_address: "221B Baker St.",
      city: "London",
      state: "CO",
      zip: "81650")

      @shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                   address: "1400 Fairgrounds Road",
                                   city: "Eagle",
                                   state: "CO",
                                   zip: "81631")

      @shelter_2 = Shelter.create!(name: "Animal Control and Shelter",
                                   address: "0058 Nancy's Place",
                                   city: "Frisco",
                                   state: "CO",
                                   zip: "80443")

      @shelter_3 = Shelter.create!(name: "Eagle Valley Humane Society",
                                   address: "50 Chambers Ave",
                                   city: "Eagle",
                                   state: "CO",
                                   zip: "81631")

      @shelter_4 = Shelter.create!(name: "Leadville/Lake County Animal Shelter",
                                   address: "428 E 12th St.",
                                   city: "Leadville",
                                   state: "CO",
                                   zip: "80461")

      @review_1 = Review.create!(title: "Friends don\'t lie",
                                 rating: 5,
                                 content: "Only the educated are free.",
                                 picture: "https://upload.wikimedia.org/wikipedia/commons/0/00/Epicteti_Enchiridion_Latinis_versibus_adumbratum_%28Oxford_1715%29_frontispiece.jpg",
                                 shelter_id: @shelter_1.id,
                                 user_id: @user_1.id)

      @review_3 = Review.create!(title: "Great food",
                                 rating: 3,
                                 content: "I thought this was a restaurant but I was wrong. The bone-shaped cookies were good though.",
                                 picture: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Ensaladang_Lato_%28Seaweed_Salad%29_-_Philippines_1.jpg/594px-Ensaladang_Lato_%28Seaweed_Salad%29_-_Philippines_1.jpg",
                                 shelter_id: @shelter_2.id,
                                 user_id: @user_1.id)


  end
  describe "when I visit a Users show page" do
    it "then I see all that Users information" do

      visit("/users/#{@user_1.id}")

      expect(page).to have_content(@user_1.name)
      expect(page).to have_content(@user_1.street_address)
      expect(page).to have_content(@user_1.city)
      expect(page).to have_content(@user_1.state)
      expect(page).to have_content(@user_1.zip)
    end

    it "then I see every review this user has written" do

      visit("/users/#{@user_1.id}")

        within "#review-#{@review_1.id}" do
          expect(page).to have_content(@review_1.title)
          expect(page).to have_content(@review_1.rating)
          expect(page).to have_content(@review_1.content)
        end

        within "#review-#{@review_3.id}" do
          expect(page).to have_content(@review_3.title)
          expect(page).to have_content(@review_3.rating)
          expect(page).to have_content(@review_3.content)
        end

    end
    it "then I see the average rating of all of their reviews" do

      visit("/users/#{@user_1.id}")

      expect(page).to have_content("Average Rating of Reviews: #{@user_1.average_review_rating}")
    end
    it "then I see a section for 'Highlighted Reviews' with the best and worst ratings" do

      review_2 = Review.create!(title: "Ohh yea, you gotta get schwifty.",
                                rating: 4,
                                content: "Hello, IT. Have you tried turning it off and on again?",
                                picture: "https://upload.wikimedia.org/wikipedia/en/3/33/Silicon_valley_title.png",
                                shelter_id: @shelter_2.id,
                                user_id: @user_1.id)

      review_4 = Review.create!(title: "Good atmosphere",
                                rating: 2,
                                content: "Give me liberty or give me death.",
                                picture: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Ensaladang_Lato_%28Seaweed_Salad%29_-_Philippines_1.jpg/594px-Ensaladang_Lato_%28Seaweed_Salad%29_-_Philippines_1.jpg",
                                shelter_id: @shelter_4.id,
                                user_id: @user_1.id)

      visit("/users/#{@user_1.id}")

      within "#best-review" do
        expect(page).to have_content(@review_1.title)
        expect(page).to have_content(@review_1.rating)
        expect(page).to have_content(@review_1.content)
      end

      within "#worst-review" do
        expect(page).to have_content(review_4.title)
        expect(page).to have_content(review_4.rating)
        expect(page).to have_content(review_4.content)
      end
    end
  end
end
