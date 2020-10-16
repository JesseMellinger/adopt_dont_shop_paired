require 'rails_helper'

describe User, type: :model do
  describe 'relationships' do
    it {should have_many :reviews}
  end

  describe 'instance methods' do
    it '#average_review_rating' do
      user_1 = User.create!(name: "Testy",
                            street_address: "221B Baker St.",
                            city: "London",
                            state: "CO",
                            zip: "81650")

      shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                 address: "1400 Fairgrounds Road",
                                 city: "Eagle",
                                 state: "CO",
                                 zip: "81631")

      shelter_2 = Shelter.create!(name: "Animal Control and Shelter",
                                  address: "0058 Nancy's Place",
                                  city: "Frisco",
                                  state: "CO",
                                  zip: "80443")

      review_1 = Review.create!(title: "Friends don\'t lie",
                                rating: 5,
                                content: "Only the educated are free.",
                                picture: "https://upload.wikimedia.org/wikipedia/commons/0/00/Epicteti_Enchiridion_Latinis_versibus_adumbratum_%28Oxford_1715%29_frontispiece.jpg",
                                shelter_id: shelter_1.id,
                                user_id: user_1.id)

      review_3 = Review.create!(title: "Great food",
                                rating: 3,
                                content: "I thought this was a restaurant but I was wrong. The bone-shaped cookies were good though.",
                                picture: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Ensaladang_Lato_%28Seaweed_Salad%29_-_Philippines_1.jpg/594px-Ensaladang_Lato_%28Seaweed_Salad%29_-_Philippines_1.jpg",
                                shelter_id: shelter_2.id,
                                user_id: user_1.id)

      expect(user_1.average_review_rating).to eq(4.0)
    end
  end
end
