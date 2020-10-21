require 'rails_helper'

describe "when I visit a pet's application index page" do
  before :each do
    @user_1 = User.create!(name: "Testy",
                          street_address: "221B Baker St.",
                          city: "London",
                          state: "CO",
                          zip: "81650")

    @user_2 = User.create!(name: "Tyrion Lannister",
                          street_address: "282 Kevin Brook",
                          city: "Lannisport",
                          state: "CA",
                          zip: "58517")

    @shelter_1 = Shelter.create!(name: "Eagle County Animal Services",
                                address: "1400 Fairgrounds Road",
                                city: "Eagle",
                                state: "CO",
                                zip: "81631")

    @application_1 = Application.create!(description: "I love that journey for me.",
                                        status: "Pending",
                                        user_id: @user_1.id)

    @application_2 = Application.create!(description: "I'm worried Blue has already been adopted",
                                        status: "Pending",
                                        user_id: @user_2.id)

    @pet_1 = Pet.create!(image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                        name: "Bolt",
                        approximate_age: 5,
                        sex: "male",
                        name_of_shelter: "Animal Control and Shelter",
                        description: "White haired German Shepherd. Sounds like John Travolta.",
                        adoption_status: "NULL",
                        shelter_id: @shelter_1.id)
  end
  it "I can see a list of all the names of applicants for this pet
  each applicants name is a link to the application's show page" do

    pet_application_1 = PetApplication.create!(pet_id: @pet_1.id,
                                                application_id: @application_1.id)

    pet_application_2 = PetApplication.create!(pet_id: @pet_1.id,
                                                application_id: @application_2.id)

    visit("/pets/#{@pet_1.id}/applications")

    within("#applicant-#{@user_1.id}") do
      expect(page).to have_link(@user_1.name)
    end

    within("#applicant-#{@user_2.id}") do
      click_link(@user_2.name)
    end

    expect(current_path).to eq("/applications/#{@application_2.id}")
  end
  describe "when I visit a pet applications index page for a pet that has no applications on them" do
    it "I see a message saying that there are no applications for this pet yet" do

      visit("/pets/#{@pet_1.id}/applications")

      expect(page).to have_content("There are no applications for this pet yet")
    end
  end
end
