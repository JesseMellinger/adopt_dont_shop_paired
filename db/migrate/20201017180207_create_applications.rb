class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :description
      t.string :name_of_pets
      t.string :status
    end
  end
end
