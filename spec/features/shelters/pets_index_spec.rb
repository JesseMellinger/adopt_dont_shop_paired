require 'rails_helper'

describe "as a visitor" do
  describe "when I visit /shelters/:shelter_id/pets" do
    it "then I see each Pet that can be adopted from that Shelter with that shelter_id including the Pets image, name, approximate age, and sex" do
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
      shelter_3 = Shelter.create!(name: "Eagle Valley Humane Society",
                                  address: "50 Chambers Ave",
                                  city: "Eagle",
                                  state: "CO",
                                  zip: "81631")
      shelter_4 = Shelter.create!(name: "Leadville/Lake County Animal Shelter",
                                  address: "428 E 12th St.",
                                  city: "Leadville",
                                  state: "CO",
                                  zip: "80461")
      shelter_5 = Shelter.create!(name: "Aspen Animal Shelter",
                                  address: "101 Animal Shelter Road",
                                  city: "Aspen",
                                  state: "CO",
                                  zip: "81611")

      pet_1 = Pet.create!(image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                          name: "Bolt",
                          approximate_age: 5,
                          sex: "male",
                          name_of_shelter: "Eagle County Animal Services",
                          description: "White haired German Shepherd. Sounds like John Travolta.",
                          adoption_status: "NULL",
                          shelter_id: shelter_1.id)

      pet_2 = Pet.create!(image: "https://en.wikipedia.org/wiki/Higgins_(dog)#/media/File:Higgins_the_Dog.jpg",
                          name: "Higgins",
                          approximate_age: 63,
                          sex: "male",
                          name_of_shelter: "Animal Control and Shelter",
                          description: "Most people remember him as the original Benji.",
                          adoption_status: "NULL",
                          shelter_id: shelter_2.id)

      pet_3 = Pet.create!(image: "https://en.wikipedia.org/wiki/Rin_Tin_Tin#/media/File:Rin_Tin_Tin_1929.JPG",
                          name: "Rin Tin Tin",
                          approximate_age: 102,
                          sex: "male",
                          name_of_shelter: "Eagle County Animal Services",
                          description: "White haired German Shepherd. Sounds like John Travolta.",
                          adoption_status: "NULL",
                          shelter_id: shelter_1.id)

      pet_4 = Pet.create!(image: "https://moviepaws.files.wordpress.com/2015/10/luhad-einstein.jpg",
                          name: "Einstein",
                          approximate_age: 50,
                          sex: "male",
                          name_of_shelter: "Eagle Valley Humane Society",
                          description: "Dr. Emmett Brown\'s pet sheepdog.",
                          adoption_status: "NULL",
                          shelter_id: shelter_3.id)

      pet_5 = Pet.create!(image: "https://en.wikipedia.org/wiki/Rin_Tin_Tin#/media/File:Rin_Tin_Tin_1929.JPG",
                          name: "Fly",
                          approximate_age: 25,
                          sex: "female",
                          name_of_shelter: "Leadville/Lake County Animal Shelter",
                          description: "Border collie from Babe.",
                          adoption_status: "NULL",
                          shelter_id: shelter_4.id)

      visit("/shelters/#{shelter_1.id}/pets")

      expect(page).to have_content(pet_1.image)
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.approximate_age)
      expect(page).to have_content(pet_1.sex)


      expect(page).to have_content(pet_3.image)
      expect(page).to have_content(pet_3.name)
      expect(page).to have_content(pet_3.approximate_age)
      expect(page).to have_content(pet_3.sex)
    end
  end
end
