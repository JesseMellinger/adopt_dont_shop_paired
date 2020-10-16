class ChangeRatingToBeIntegerInReviews < ActiveRecord::Migration[5.2]
  def up
    change_column :reviews, :rating, :integer, using: 'rating::integer'
  end

  def down
    change_column :reviews, :rating, :string
  end
end
