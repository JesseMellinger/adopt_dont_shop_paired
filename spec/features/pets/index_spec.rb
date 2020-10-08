require 'rails_helper'

As a visitor
When I visit '/pets'
Then I see each Pet in the system including the Pet's:
- image
- name
- approximate age
- sex
- name of the shelter where the pet is currently located


describe "as a visitor" do
  describe "when I visit" do
    it "I see each Pet in the system including the Pets image, name, approximate age, sex, and name of shelter where located" do
      pet_1 = Pet.create(image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                         name: "Bolt",
                         approximate_age: 5,
                         sex: "male",
                         name_of_shelter: "Animal Control and Shelter")

      visit("/pets")

      expect(page).to have_content("https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")
      expect(page).to have_content("Bolt")
      expect(page).to have_content("5")
      expect(page).to have_content("male")
      expect(page).to have_content("Animal Control and Shelter")
    end
  end
end
