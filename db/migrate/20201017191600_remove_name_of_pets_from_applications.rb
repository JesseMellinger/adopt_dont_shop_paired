class RemoveNameOfPetsFromApplications < ActiveRecord::Migration[5.2]
  def change
    remove_column :applications, :name_of_pets, :string
  end
end
