class CreatePet < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.string :image
      t.string :name
      t.integer :approximate_age
      t.string :sex
      t.string :name_of_shelter
    end
  end
end
