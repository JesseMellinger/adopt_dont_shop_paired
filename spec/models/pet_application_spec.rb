require 'rails_helper'

describe PetApplication do
  describe "relationships" do
    it {should belong_to :pet}
    it {should belong_to :application}
  end

  describe "class methods" do
    it ".find_pet_application" do
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


      application_1 = Application.create!(description: "Well let's get some dogs.",
                                          status: "Pending",
                                          user_id: user_1.id)

      pet_1 = Pet.create!(image: "https://upload.wikimedia.org/wikipedia/commons/8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                          name: "Blue",
                          approximate_age: "2",
                          sex: "Female",
                          shelter_id: shelter_1.id)

      pet_2 = Pet.create!(image: "https://upload.wikimedia.org/wikGCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg",
                          name: "Blue",
                          approximate_age: "5",
                          sex: "Male",
                          shelter_id: shelter_1.id)

      pet_application_1 = PetApplication.create!(pet_id: pet_1.id,
                             application_id: application_1.id)

      expect(PetApplication.find_pet_application(pet_1.id, application_1.id).first).to eq(pet_application_1)
    end
  end
end
