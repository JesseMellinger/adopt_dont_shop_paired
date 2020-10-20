require 'rails_helper'

describe Pet do
  describe "relationships" do
    it {should belong_to :shelter}
    it {should have_many :pet_applications}
    it {should have_many(:applications).through(:pet_applications)}
  end

  describe "validations" do
    it {should validate_presence_of(:name)}
  end

  describe "class methods" do
    it ".find_all_pets_by_shelter_id" do
      shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                 address: "1400 Fairgrounds Road",
                                 city: "Eagle",
                                 state: "CO",
                                 zip: "81631")

      pet_1 = Pet.create!(image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                          name: "Bolt",
                          approximate_age: 5,
                          sex: "male",
                          name_of_shelter: shelter_1.name,
                          description: "White haired German Shepherd. Sounds like John Travolta.",
                          adoption_status: "adoptable",
                          shelter_id: shelter_1.id)

      pet_3 = Pet.create!(image: "https://en.wikipedia.org/wiki/Rin_Tin_Tin#/media/File:Rin_Tin_Tin_1929.JPG",
                          name: "Rin Tin Tin",
                          approximate_age: 102,
                          sex: "male",
                          name_of_shelter: shelter_1.name,
                          description: "German Shepherd and international star in motion pictures.",
                          adoption_status: "adoptable",
                          shelter_id: shelter_1.id)

      expect(Pet.find_all_pets_by_shelter_id(shelter_1.id).count).to eq(2)
    end
  end
end
